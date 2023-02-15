import 'package:flutter/material.dart';
import 'package:auto_route/auto_route.dart';

import '../../theme/bccm_colors.dart';
import '../../theme/bccm_typography.dart';
import '../../l10n/app_localizations.dart';

class FAQItem {
  final int id;
  final String question;
  final String answer;

  FAQItem({
    required this.id,
    required this.question,
    required this.answer,
  });
}

class FAQ extends StatefulWidget {
  const FAQ({super.key});

  @override
  State<FAQ> createState() => _FAQState();
}

class _FAQState extends State<FAQ> {
  var listOfList = [
    FAQItem(
      id: 1,
      question: 'Title 1 Title 1 Title 1 Title 1 Title 1 Title1',
      answer: 'title 2',
      // question: 'Hvorfor funker dette ikke som jeg forventer?',
      // answer: 'Fordi lorem ipsum dolor sit amet consectur osv.',
    ),
    FAQItem(
      id: 2,
      question: 'Hvorfor funker dette ikke som jeg forventer?',
      answer: 'Fordi lorem ipsum dolor sit amet consectur osv.',
    ),
    FAQItem(
      id: 3,
      question: 'Hvorfor funker dette ikke som jeg forventer?',
      answer: 'Fordi lorem ipsum dolor sit amet consectur osv.',
    ),
    FAQItem(
      id: 4,
      question: 'Hvorfor funker dette ikke som jeg forventer?',
      answer: 'Fordi lorem ipsum dolor sit amet consectur osv.',
    ),
    FAQItem(
      id: 5,
      question: 'Hvorfor funker dette ikke som jeg forventer?',
      answer: 'Fordi lorem ipsum dolor sit amet consectur osv.',
    ),
    FAQItem(
      id: 6,
      question: 'Hvorfor funker dette ikke som jeg forventer?',
      answer: 'Fordi lorem ipsum dolor sit amet consectur osv.',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: BccmColors.background1,
        leadingWidth: 90,
        leading: GestureDetector(
          behavior: HitTestBehavior.opaque,
          onTapDown: (details) {
            context.router.pop();
          },
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              const Icon(
                Icons.arrow_back_ios_new,
                color: BccmColors.tint1,
              ),
              Text(
                S.of(context).faq,
                overflow: TextOverflow.ellipsis,
                style: BccmTextStyles.button2,
              ),
            ],
          ),
        ),
        centerTitle: true,
        title: Text(
          S.of(context).faq,
          overflow: TextOverflow.ellipsis,
          textAlign: TextAlign.center,
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 17),
            child: Column(
              children: <Widget>[for (var i in listOfList) _ExpansionTileDropDown(i, listOfList.indexOf(i))],
            ),
          ),
        ),
      ),
    );
  }
}

class _ExpansionTileDropDown extends StatefulWidget {
  final FAQItem questionList;
  final int index;

  const _ExpansionTileDropDown(this.questionList, this.index);

  @override
  State<_ExpansionTileDropDown> createState() => _ExpansionTileDropDownState();
}

class _ExpansionTileDropDownState extends State<_ExpansionTileDropDown> {
  bool _customTileExpanded = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(
        left: 16,
        top: 18,
        right: 19,
        bottom: 16,
      ),
      margin: const EdgeInsets.symmetric(
        // vertical: MediaQuery.of(context).size.height * 0.006,
        vertical: 8,
      ),
      decoration: BoxDecoration(
        color: BccmColors.background2,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Theme(
        data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
        child: ListTileTheme(
          minVerticalPadding: 0.0,
          dense: true,
          contentPadding: const EdgeInsets.all(0),
          child: ExpansionTile(
            title: Text(
              widget.questionList.question,
              style: BccmTextStyles.title3,
            ),
            textColor: Colors.teal,
            trailing: !_customTileExpanded
                ? const Icon(
                    Icons.keyboard_arrow_down,
                    color: BccmColors.tint1,
                  )
                : const Icon(
                    Icons.keyboard_arrow_up,
                    color: BccmColors.tint2,
                  ),
            childrenPadding: const EdgeInsets.only(
              top: 12,
            ),
            expandedAlignment: Alignment.centerLeft,
            children: <Widget>[
              Text(
                widget.questionList.answer,
                style: BccmTextStyles.body2.copyWith(color: BccmColors.label3),
              )
            ],
            onExpansionChanged: (bool expanded) {
              setState(() => _customTileExpanded = expanded);
            },
          ),
        ),
      ),
    );
  }
}
