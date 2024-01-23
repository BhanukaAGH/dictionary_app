import 'dart:io';

import 'package:dictionary_app/features/home/view/home_view.dart';
import 'package:dictionary_app/models/meaning_model.dart';
import 'package:dictionary_app/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:path_provider/path_provider.dart';
import 'package:window_manager/window_manager.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  if (Platform.isWindows) {
    await windowManager.ensureInitialized();
    WindowOptions windowOptions = const WindowOptions(
      size: Size(600, 800),
      minimumSize: Size(460, 600),
      maximumSize: Size(600, 800),
      backgroundColor: Colors.transparent,
      skipTaskbar: false,
      titleBarStyle: TitleBarStyle.normal,
      title: 'English Dictionary',
    );
    windowManager.waitUntilReadyToShow(windowOptions, () async {
      await windowManager.show();
      await windowManager.setMaximizable(false);
      await windowManager.focus();
    });

    final appDir = await getApplicationDocumentsDirectory();
    await Hive.initFlutter(Directory('${appDir.path}/dictionary').path);
  } else {
    await Hive.initFlutter();
  }

  Hive.registerAdapter(WordAdapter());
  Hive.registerAdapter(MeaningAdapter());
  Hive.registerAdapter(DefinitionAdapter());
  Hive.registerAdapter(PhoneticAdapter());
  await Hive.openBox<Word>('dictionary');
  await Hive.openBox<Word>('bookmarks');

  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Dictionary',
      theme: AppTheme.theme,
      home: const HomeView(),
    );
  }
}
