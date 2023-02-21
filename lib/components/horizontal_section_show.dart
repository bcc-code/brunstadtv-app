import 'package:flutter/material.dart';

import '../graphql/queries/page.graphql.dart';
import '../l10n/app_localizations.dart';

import '../theme/bccm_colors.dart';
import '../theme/bccm_typography.dart';
import '../helpers/utils.dart';
import 'section_show_thumbnail.dart';

class HorizontalSectionShow extends StatelessWidget {
  final Fragment$ItemSectionItem sectionItem;
  final Fragment$ItemSectionItem$item$$Show show;
  final Size imageSize;
  final bool showEpisodeCounts;

  // TODO: Remove this
  final bool hasNewEpisodes = false;

  const HorizontalSectionShow({
    super.key,
    required this.sectionItem,
    required this.show,
    required this.imageSize,
    required this.showEpisodeCounts,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: imageSize.width,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SectionShowThumbnail(
            imageSize: imageSize,
            sectionItem: sectionItem,
            hasNewEpisodes: hasNewEpisodes,
          ),
          Container(
            margin: const EdgeInsets.only(bottom: 2),
            child: Text(
              sectionItem.title,
              style: BccmTextStyles.caption1.copyWith(color: BccmColors.label1),
            ),
          ),
          if (showEpisodeCounts)
            Text(
              '${show.seasonCount} ${S.of(context).seasons} - ${show.episodeCount} ${S.of(context).episodes}',
              style: BccmTextStyles.caption2,
            )
        ],
      ),
    );
  }
}
