import 'package:audioplayers/audioplayers.dart';
import 'package:dictionary_app/core/core.dart';
import 'package:dictionary_app/features/dictionary/controller/dictionary_controller.dart';
import 'package:dictionary_app/features/dictionary/view/synonym_view.dart';
import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/adapters.dart';

class BookmarksView extends ConsumerWidget {
  const BookmarksView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ValueListenableBuilder(
      valueListenable: ref.watch(bookmarksBoxProvider).listenable(),
      builder: (context, box, child) {
        return ListView.builder(
          itemCount: box.values.length,
          itemBuilder: (context, index) {
            final bookmark = box.values.toList()[index];

            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 2),
              child: Card(
                elevation: 0.5,
                child: ListTile(
                  onTap: () {
                    Navigator.push(context, SynonymView.route(bookmark.word));
                  },
                  title: Text(bookmark.word),
                  subtitle: Text(bookmark.phonetic),
                  trailing: Wrap(
                    children: [
                      if (bookmark.phonetics[0].audio.isNotEmpty)
                        IconButton(
                            onPressed: () {
                              ref
                                  .read(playerProvider)
                                  .play(UrlSource(bookmark.phonetics[0].audio));
                            },
                            icon: const Icon(FluentIcons.speaker_2_48_filled)),
                      IconButton(
                        onPressed: () {
                          ref
                              .read(dictionaryControllerProvider.notifier)
                              .createBookmark(bookmark);
                        },
                        icon: Icon(
                          box.containsKey(bookmark.word)
                              ? FluentIcons.bookmark_32_filled
                              : FluentIcons.bookmark_32_regular,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }
}
