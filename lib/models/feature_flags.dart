import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:unleash_proxy_client_flutter/toggle_config.dart';

part 'feature_flags.freezed.dart';

@freezed
class FeatureFlags with _$FeatureFlags {
  const FeatureFlags._();

  const factory FeatureFlags({
    @Default({}) Map<String, ToggleConfig> toggles,
    @Default(true) bool auth,
    @Default(false) bool publicSignup,
    @Default(false) bool socialSignup,
    @Default(false) bool autoplayNext,
    @Default(false) bool autoFullscreenOnPlay,
    @Default(true) bool shareVideoButton,
    @Default(false) bool gamesTab,
    @Default(false) bool flutterPlayerControls,
    @Default(false) bool playNextButton,
    @Default(false) bool chapters,
    @Default(false) bool download,
  }) = _FeatureFlags;
}
