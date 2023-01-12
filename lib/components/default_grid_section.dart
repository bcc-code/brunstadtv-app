import 'package:brunstadtv_app/components/section_item_click_wrapper.dart';
import 'package:brunstadtv_app/models/analytics/sections.dart';
import 'package:brunstadtv_app/providers/inherited_data.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../graphql/queries/calendar_episode_entries.graphql.dart';
import '../graphql/queries/page.graphql.dart';
import '../graphql/schema/pages.graphql.dart';
import '../helpers/btv_colors.dart';
import '../l10n/app_localizations.dart';
import '../providers/todays_calendar_entries.dart';
import '../services/utils.dart';
import '../helpers/btv_typography.dart';
import '../helpers/utils.dart';
import 'feature_badge.dart';
import 'episode_duration.dart';
import 'grid_row.dart';
import 'watch_progress_indicator.dart';
import 'watched_badge.dart';
import 'bordered_image_container.dart';

const Map<Enum$GridSectionSize, int> _columnSize = {
  Enum$GridSectionSize.half: 2,
};

class DefaultGridSection extends StatelessWidget {
  final Fragment$Section$$DefaultGridSection data;

  const DefaultGridSection(this.data, {super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      child: GridSectionList(
        size: data.gridSize,
        sectionItems: data.items.items,
        showSecondaryTitle: data.metadata?.secondaryTitles ?? true,
      ),
    );
  }
}

class GridSectionList extends ConsumerStatefulWidget {
  const GridSectionList({
    super.key,
    required this.size,
    required this.sectionItems,
    this.showSecondaryTitle = true,
  });

  final Enum$GridSectionSize size;
  final List<Fragment$GridSectionItem> sectionItems;
  final bool showSecondaryTitle;

  @override
  ConsumerState<GridSectionList> createState() => _GridSectionListState();
}

class _GridSectionListState extends ConsumerState<GridSectionList> {
  Fragment$Episode? curLiveEpisode;

  Widget getItemWidget(Fragment$GridSectionItem sectionItem) {
    var episode = sectionItem.item.asOrNull<Fragment$GridSectionItem$item$$Episode>();
    if (episode != null) {
      return _GridEpisodeItem(
        sectionItem: sectionItem,
        episode: episode,
        showSecondaryTitle: widget.showSecondaryTitle,
        isLive: sectionItem.id == curLiveEpisode?.id,
      );
    }
    var show = sectionItem.item.asOrNull<Fragment$GridSectionItem$item$$Show>();
    if (show != null) {
      return _GridShowItem(sectionItem: sectionItem, show: show);
    }
    return const SizedBox();
  }

  @override
  Widget build(BuildContext context) {
    ref.listen<AsyncValue<Fragment$CalendarDayEntries$entries$$EpisodeCalendarEntry?>>(currentLiveEpisodeProvider, (prevEntry, curEntry) {
      curEntry.whenData((episodeEntry) {
        if (episodeEntry?.episode != curLiveEpisode) {
          setState(() => curLiveEpisode = episodeEntry?.episode);
        }
      });
    });

    final colSize = _columnSize[widget.size] ?? _columnSize[Enum$GridSectionSize.half]!;
    final items = widget.sectionItems
        .where((element) => element.item is Fragment$GridSectionItem$item$$Episode || element.item is Fragment$GridSectionItem$item$$Show)
        .toList();
    final rowSize = (items.length / colSize).ceil();

    final rows = List<GridRow>.generate(rowSize, (rowIndex) {
      final firstIndex = rowIndex * colSize;
      final subList = firstIndex + colSize <= items.length ? items.sublist(firstIndex, firstIndex + colSize) : items.sublist(firstIndex);
      return GridRow(
        margin: const EdgeInsets.symmetric(vertical: 12),
        items: subList.asMap().entries.map<Widget>((kv) {
          return SectionItemClickWrapper(
            item: kv.value.item,
            analytics: SectionItemAnalytics(id: kv.value.id, position: kv.key, type: kv.value.$__typename, name: kv.value.title),
            child: getItemWidget(kv.value),
          );
        }).toList(),
        colSize: colSize,
      );
    });
    return ListView.builder(
        primary: true,
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: rows.length,
        itemBuilder: (context, index) => rows[index]);
  }
}

class _GridEpisodeItem extends StatelessWidget {
  final Fragment$GridSectionItem sectionItem;
  final Fragment$GridSectionItem$item$$Episode episode;
  final bool showSecondaryTitle;
  final bool isLive;

  _GridEpisodeItem({required this.sectionItem, required this.episode, required this.showSecondaryTitle, this.isLive = false});

  // TODO: Remove these temp variables
  bool get watched => episode.progress != null && episode.progress! > episode.duration * 0.9;
  bool isNewItem = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        sectionItemImage(),
        if (showSecondaryTitle)
          Row(
            children: [
              if (episode.season != null)
                Flexible(
                  child: Container(
                    margin: const EdgeInsets.only(right: 4),
                    child: Text(
                      episode.season!.$show.title.replaceAll(' ', '\u{000A0}'),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: BtvTextStyles.caption2.copyWith(color: BtvColors.tint1),
                    ),
                  ),
                ),
              if (episode.season != null)
                Text(
                  '${S.of(context).seasonLetter}${episode.season!.number}:${S.of(context).episodeLetter}${episode.number}',
                  style: BtvTextStyles.caption2,
                ),
            ],
          ),
        Container(
          margin: const EdgeInsets.only(bottom: 2),
          child: Text(
            sectionItem.title,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: BtvTextStyles.caption1.copyWith(color: BtvColors.label1),
          ),
        ),
      ],
    );
  }

  Widget sectionItemImage() {
    return Container(
      margin: const EdgeInsets.only(bottom: 4),
      width: double.infinity,
      child: AspectRatio(
        aspectRatio: 16 / 9,
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            isUnavailable(episode.publishDate)
                ? Opacity(
                    opacity: 0.5,
                    child: BorderedImageContainer(imageUrl: sectionItem.image),
                  )
                : BorderedImageContainer(imageUrl: sectionItem.image),
            if (isUnavailable(episode.publishDate))
              Container(
                width: double.infinity,
                height: double.infinity,
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('assets/icons/Wait.png'),
                  ),
                ),
              ),
            if (episode.progress != null && !watched)
              Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  margin: const EdgeInsets.only(left: 4, bottom: 4, right: 4),
                  child: WatchProgressIndicator(totalDuration: episode.duration, watchedDuration: episode.progress!),
                ),
              )
            else if (!isUnavailable(episode.publishDate))
              Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  height: 12,
                  margin: const EdgeInsets.only(right: 4, bottom: 4, left: 4),
                  child: Row(
                    children: [
                      if (watched) const WatchedBadge(),
                      const Spacer(),
                      EpisodeDuration(duration: getFormattedDuration(episode.duration)),
                    ],
                  ),
                ),
              ),
            if (getFeaturedTag(publishDate: episode.publishDate, isLive: isLive) != null)
              Positioned(
                top: -4,
                right: -4,
                child: getFeaturedTag(publishDate: episode.publishDate, isLive: isLive)!,
              ),
          ],
        ),
      ),
    );
  }
}

class _GridShowItem extends StatelessWidget {
  final Fragment$GridSectionItem sectionItem;
  final Fragment$GridSectionItem$item$$Show show;
  _GridShowItem({required this.sectionItem, required this.show});

  // TODO: Remove this
  bool hasNewEpisodes = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        sectionItemImage(),
        Container(
          margin: const EdgeInsets.only(bottom: 2),
          child: Text(
            sectionItem.title,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: BtvTextStyles.caption1.copyWith(color: BtvColors.label1),
          ),
        ),
        Text(
          '${show.seasonCount} ${S.of(context).seasons} - ${show.episodeCount} ${S.of(context).episodes}',
          style: BtvTextStyles.caption2,
        )
      ],
    );
  }

  Widget sectionItemImage() {
    return Container(
      margin: const EdgeInsets.only(bottom: 4),
      width: double.infinity,
      child: AspectRatio(
        aspectRatio: 16 / 9,
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            BorderedImageContainer(imageUrl: sectionItem.image),
            if (hasNewEpisodes)
              const Positioned(
                top: -4,
                right: -4,
                child: FeatureBadge(
                  label: 'New Episodes',
                  color: BtvColors.tint2,
                ),
              ),
          ],
        ),
      ),
    );
  }
}
