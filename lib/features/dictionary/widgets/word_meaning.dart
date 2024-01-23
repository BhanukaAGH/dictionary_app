import 'dart:io';

import 'package:audioplayers/audioplayers.dart';
import 'package:dictionary_app/core/core.dart';
import 'package:dictionary_app/core/extensions.dart';
import 'package:dictionary_app/features/dictionary/view/synonym_view.dart';
import 'package:dictionary_app/models/meaning_model.dart';
import 'package:dictionary_app/theme/theme.dart';
import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class WordMeaning extends ConsumerWidget {
  final Word word;
  const WordMeaning({super.key, required this.word});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Flex(
            direction: Axis.horizontal,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                word.word,
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              if (word.phonetics[0].audio.isNotEmpty)
                IconButton(
                  onPressed: () {
                    ref
                        .read(playerProvider)
                        .play(UrlSource(word.phonetics[0].audio));
                  },
                  icon: const Icon(FluentIcons.speaker_2_48_filled),
                ),
            ],
          ),
          Text(
            word.phonetic,
            style: const TextStyle(
              fontSize: 16,
              // color: Colors.black38,
            ),
          ),
          const SizedBox(height: 16),
          ListView.builder(
            shrinkWrap: true,
            itemCount: word.meanings.length,
            itemBuilder: (context, index) {
              final meaning = word.meanings[index];

              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    meaning.partOfSpeech.capitalize(),
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.blue[600],
                    ),
                  ),
                  const SizedBox(height: 6),

                  // definitions with Examples
                  ListView.builder(
                    shrinkWrap: true,
                    itemCount: meaning.definitions.length,
                    itemBuilder: (context, index) {
                      final definitions = meaning.definitions[index];

                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '${index + 1}. ${definitions.definition}',
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          if (definitions.example != null)
                            Text('"${definitions.example}"'),
                          const SizedBox(height: 12),
                        ],
                      );
                    },
                  ),
                  const SizedBox(height: 8),

                  // Synonyms
                  meaning.synonyms.isNotEmpty
                      ? Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Synonyms :',
                              style: TextStyle(
                                fontSize: 14,
                              ),
                            ),
                            const SizedBox(height: 8),
                            Wrap(
                              spacing: 6,
                              runSpacing: Platform.isWindows ? 6 : 0,
                              children: [
                                for (String synonym in meaning.synonyms)
                                  GestureDetector(
                                    onTap: () {
                                      Navigator.push(
                                        context,
                                        SynonymView.route(synonym),
                                      );
                                    },
                                    child: Chip(
                                      elevation: 0,
                                      labelPadding: EdgeInsets.zero,
                                      shape: const StadiumBorder(),
                                      side: BorderSide(
                                        color:
                                            Pallete.blueColor.withOpacity(0.5),
                                      ),
                                      label: Text(
                                        synonym,
                                        style: const TextStyle(
                                          fontSize: 12,
                                          color: Pallete.whiteColor,
                                          height: 0,
                                        ),
                                      ),
                                    ),
                                  ),
                              ],
                            ),
                            const SizedBox(height: 12),
                          ],
                        )
                      : const SizedBox.shrink(),
                  const SizedBox(height: 6),
                ],
              );
            },
          ),
        ],
      ),
    );
  }
}
