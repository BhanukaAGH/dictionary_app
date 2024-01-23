import 'package:audioplayers/audioplayers.dart';
import 'package:dictionary_app/core/core.dart';
import 'package:dictionary_app/features/dictionary/controller/dictionary_controller.dart';
import 'package:dictionary_app/features/dictionary/view/synonym_view.dart';
import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/adapters.dart';

class HistoryView extends ConsumerWidget {
  const HistoryView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ValueListenableBuilder(
      valueListenable: ref.watch(dictionaryBoxProvider).listenable(),
      builder: (context, dictionaryBox, child) {
        return ListView.builder(
          itemCount: dictionaryBox.values.length,
          itemBuilder: (context, index) {
            final history = dictionaryBox.values.toList()[index];

            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 2),
              child: Card(
                elevation: 0.5,
                child: ListTile(
                  onTap: () {
                    Navigator.push(context, SynonymView.route(history.word));
                  },
                  title: Text(history.word),
                  subtitle: Text(history.phonetic),
                  trailing: Wrap(
                    children: [
                      if (history.phonetics[0].audio.isNotEmpty)
                        IconButton(
                          onPressed: () {
                            ref
                                .read(playerProvider)
                                .play(UrlSource(history.phonetics[0].audio));
                          },
                          icon: const Icon(FluentIcons.speaker_2_48_filled),
                        ),
                      ValueListenableBuilder(
                        valueListenable:
                            ref.watch(bookmarksBoxProvider).listenable(),
                        builder: (context, bookmarkBox, child) {
                          return IconButton(
                            onPressed: () {
                              ref
                                  .read(dictionaryControllerProvider.notifier)
                                  .createBookmark(history);
                            },
                            icon: Icon(
                              bookmarkBox.containsKey(history.word)
                                  ? FluentIcons.bookmark_32_filled
                                  : FluentIcons.bookmark_32_regular,
                            ),
                          );
                        },
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
