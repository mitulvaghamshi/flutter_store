import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_store/ajson_app/models/gita_new.dart';
import 'package:flutter_store/ajson_app/widgets/page_builder.dart';

@immutable
class GitaScreenNew extends StatelessWidget {
  const GitaScreenNew({super.key});

  @override
  Widget build(BuildContext context) => PageBuilder(
    future: GitaNew.queryEn,
    builder: (chapters) => CustomScrollView(
      slivers: [
        const CupertinoSliverNavigationBar(largeTitle: Text('Bhagwad Gita')),
        SliverSafeArea(
          minimum: const .all(16),
          sliver: SliverList.builder(
            itemCount: chapters.length,
            itemBuilder: (_, index) =>
                _ChapterListItem(chapter: chapters.elementAt(index)),
          ),
        ),
      ],
    ),
  );
}

@immutable
class _ChapterListItem extends StatelessWidget {
  const _ChapterListItem({required this.chapter});

  final Snippet chapter;

  @override
  Widget build(BuildContext context) => CupertinoListTile(
    onTap: () async {
      // final page = _ChapterScreen(chapter: chapter);
      // final route = CupertinoPageRoute(builder: (_) => page);
      // await Navigator.of(context).push(route);
    },
    leadingSize: 50,
    leadingToTitle: 4,
    padding: const .all(4),
    title: Text(chapter.title),
    trailing: const CupertinoListTileChevron(),
    leading: CircleAvatar(child: Text(chapter.id.toString())),
  );
}
