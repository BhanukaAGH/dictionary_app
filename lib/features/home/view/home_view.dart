import 'package:dictionary_app/features/dictionary/view/bookmarks_view.dart';
import 'package:dictionary_app/features/dictionary/view/dictionary_view.dart';
import 'package:dictionary_app/features/dictionary/view/history_view.dart';
import 'package:dictionary_app/theme/theme.dart';
import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  final _searchController = TextEditingController();
  bool isSearchWord = false;
  int _page = 0;

  @override
  void dispose() {
    super.dispose();
    _searchController.dispose();
  }

  void onPageChanged(int index) {
    setState(() {
      _page = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: _page == 0
            ? SizedBox(
                width: double.infinity,
                height: 40,
                child: SearchBar(
                  controller: _searchController,
                  hintText: 'Search',
                  elevation: MaterialStateProperty.all(0),
                  onSubmitted: (value) {
                    if (value.isNotEmpty) {
                      setState(() {
                        isSearchWord = true;
                      });
                    }
                  },
                  shape: MaterialStatePropertyAll(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  trailing: [
                    IconButton(
                      icon: const Icon(FluentIcons.search_48_regular),
                      onPressed: () {
                        if (_searchController.text.isNotEmpty) {
                          setState(() {
                            isSearchWord = true;
                          });
                        }
                      },
                    )
                  ],
                ),
              )
            : _page == 1
                ? const Text(
                    'Bookmarks',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  )
                : const Text(
                    'History',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
        centerTitle: true,
      ),
      body: IndexedStack(
        index: _page,
        children: [
          DictionaryView(
            keyword: _searchController.text,
            isSearchWord: isSearchWord,
          ),
          const BookmarksView(),
          const HistoryView(),
        ],
      ),
      bottomNavigationBar: CupertinoTabBar(
        currentIndex: _page,
        onTap: onPageChanged,
        activeColor: Pallete.blueColor,
        border: const Border(top: BorderSide(color: Pallete.searchBarColor)),
        items: const [
          BottomNavigationBarItem(
            icon: Icon(
              FluentIcons.book_open_28_filled,
              size: 25,
            ),
          ),
          BottomNavigationBarItem(
            icon: Icon(
              FluentIcons.bookmark_multiple_28_regular,
              size: 25,
            ),
          ),
          BottomNavigationBarItem(
            icon: Icon(
              FluentIcons.history_48_regular,
              size: 25,
            ),
          ),
        ],
      ),
    );
  }
}
