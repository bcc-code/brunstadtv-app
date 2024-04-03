import 'dart:async';
import 'dart:math';

import 'package:bccm_player/bccm_player.dart';
import 'package:bccm_core/platform.dart';
import 'package:brunstadtv_app/helpers/constants.dart';
import 'package:bccm_core/bccm_core.dart';
import 'package:brunstadtv_app/helpers/shorts/short_analytics.dart';
import 'package:brunstadtv_app/l10n/app_localizations.dart';
import 'package:brunstadtv_app/providers/feature_flags.dart';
import 'package:brunstadtv_app/providers/playback_service.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:universal_io/io.dart';

class ShortController {
  late final BccmPlayerController player;
  late final ShortAnalyticsListener _analyticsListener;
  final WidgetRef ref;
  final _progressDebouncer = Debouncer(milliseconds: 1000);
  int previousSeconds = 0;

  late Future<void> playerInitFuture;
  Completer<void>? currentSetupCompleter;
  Fragment$Short? _short;
  Fragment$Short? get currentShort => _short;
  BccmTexture? _texture;
  bool _disposed = false;
  bool muted = false;
  int retries = 0;
  bool isCurrent = false;

  ShortController(this.ref) {
    final disableNpaw = ref.read(featureFlagsProvider).disableNpawShorts;
    debugPrint('SHRT: disableNpaw: $disableNpaw');
    player = BccmPlayerController.empty(bufferMode: BufferMode.fastStartShortForm, disableNpaw: disableNpaw);
    playerInitFuture = player.initialize();
    playerInitFuture.then((_) {
      player.setMixWithOthers(true);
      player.setRepeatMode(RepeatMode.one);
      if (!Platform.isAndroid) return;
      player.switchToVideoTexture().then((t) {
        _texture = t;
      });
    });
    _analyticsListener = ShortAnalyticsListener(this, ref);
    player.addListener(onPlayerStateChanged);
  }

  bool expired(String? expiresAt) {
    if (expiresAt == null) return true;
    final expiresAtDateTime = DateTime.tryParse(expiresAt);
    if (expiresAtDateTime == null) return false;
    return expiresAtDateTime.isBefore(DateTime.now().add(const Duration(seconds: 30)));
  }

  Future<void> setupShort(Fragment$Short newShort, {bool? forceReload}) async {
    final expiresAt = player.value.currentMediaItem?.metadata?.extras?['expires_at'];
    if (newShort.id == _short?.id && currentSetupCompleter != null) {
      if ((forceReload == true || expired(expiresAt)) && currentSetupCompleter!.isCompleted) {
        debugPrint('SHRT: forcing reload of ${newShort.id}');
        currentSetupCompleter = wrapInCompleter(_setupShort(newShort, forceNewFromBackend: true));
      }
      debugPrint('SHRT: stream already initialized for ${newShort.id}');
      return currentSetupCompleter!.future;
    } else if (newShort.id != _short?.id) {
      debugPrint('SHRT: resetting retries for ${newShort.id}');
      retries = 0;
    }
    debugPrint('SHRT: setting up for ${newShort.id}');
    _short = newShort;
    currentSetupCompleter = wrapInCompleter(_setupShort(newShort));
    return currentSetupCompleter!.future;
  }

  Future<void> _setupShort(Fragment$Short newShort, {bool? forceNewFromBackend}) async {
    await playerInitFuture;
    debugPrint('SHRT: setting up for ${newShort.id}');

    final stream = await getFreshStream(newShort, forceNewFromBackend: forceNewFromBackend);
    if (stream == null) {
      debugPrint('SHRT: failed to get stream for ${newShort.id}');
      return;
    }

    final context = ref.context;
    if (!context.mounted) return;
    final user = ref.read(authStateProvider).user;
    final ageGroup = user?.let((u) => getAgeGroupFromUser(u));
    await player.replaceCurrentMediaItem(
      MediaItem(
        url: stream.url,
        metadata: MediaMetadata(
          title: newShort.title,
          artist: S.of(context).shortsTab,
          extras: {
            MetadataExtraConstants.shortId: newShort.id,
            'npaw.content.id': newShort.id,
            'npaw.content.type': 'short',
            'expires_at': stream.expiresAt,
            if (ageGroup != null) 'npaw.content.customDimension2': ageGroup.name,
          },
        ),
      ),
      autoplay: false,
    );
    debugPrint('${player.value.playerId} done with replaceCurrentMediaItem');
    if (_disposed) return;
    player.setVolume(muted ? 0 : 1);
  }

  Fragment$BasicStream? _getBestStreamUri(List<Fragment$BasicStream> streams) {
    final stream = streams.getBestStream();
    final uri = Uri.tryParse(stream.url);
    if (uri == null) {
      debugPrint('SHRT: invalid url: ${stream.url}');
      return null;
    }
    return stream;
  }

  Future<Fragment$BasicStream?> getFreshStream(Fragment$Short newShort, {bool? forceNewFromBackend}) async {
    var stream = _getBestStreamUri(newShort.streams);
    if (stream == null) return null;
    if (forceNewFromBackend == true || expired(stream.expiresAt)) {
      final result = await ref
          .read(bccmGraphQLProvider)
          .query$getShortStreams(Options$Query$getShortStreams(variables: Variables$Query$getShortStreams(id: newShort.id)));
      final streams = result.parsedData?.short.streams;
      if (streams != null) {
        stream = _getBestStreamUri(streams);
      }
    }
    if (stream == null) return null;
    return stream;
  }

  onPlayerStateChanged() {
    final s = currentShort;
    if (s == null) return;
    final progressSeconds = (player.value.playbackPositionMs ?? 0) ~/ 1000;
    if (progressSeconds != previousSeconds && progressSeconds > 0) {
      _progressDebouncer.run(() {
        debugPrint('SHRT: setting progress: ${progressSeconds}s for ${s.id}');
        ref.read(bccmGraphQLProvider).mutate$setShortProgress(
              Options$Mutation$setShortProgress(
                variables: Variables$Mutation$setShortProgress(
                  id: s.id,
                  progress: progressSeconds.toDouble(),
                ),
              ),
            );
      });
      ref.read(analyticsProvider).heyJustHereToTellYouIBelieveTheSessionIsStillAlive();
    }

    previousSeconds = progressSeconds;

    if (player.value.error != null && (currentSetupCompleter == null || currentSetupCompleter!.isCompleted)) {
      debugPrint('SHRT: player error: ${player.value.error}, retries: $retries');
      if (retries > 3) {
        debugPrint('SHRT: failed to play short ${s.id} after 3 retries. Player error: ${player.value.error}');
        return;
      }
      final currentMs = player.value.playbackPositionMs;
      setupShort(s, forceReload: true).then((_) async {
        if (isCurrent) {
          if (currentMs != null) {
            final safelyEarlier = max(0, currentMs - 5000);
            await player.seekTo(Duration(milliseconds: safelyEarlier));
          }
          player.play();
        }
      });
      retries++;
    }
  }

  void dispose() {
    _disposed = true;
    player.removeListener(onPlayerStateChanged);
    player.dispose();
    _texture?.dispose();
    _analyticsListener.dispose();
  }
}
