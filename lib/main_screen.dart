import 'package:cupertinotab/platform/scaffold.dart';
import 'package:cupertinotab/platform/tabbar.dart';
import 'package:cupertinotab/theme.dart';
import 'package:cupertinotab/theme.dart';
import 'package:cupertinotab/theme.dart';
import 'package:cupertinotab/theme.dart';
import 'package:cupertinotab/theme.dart';
import 'package:flutter/material.dart';

class MainScreen extends StatelessWidget {
  MainScreen({Key? key}) : super(key: key);

  var tabTitles = [
    "My Goals",
    "Need Response",
    "Company Goals",
    "Direct Reports",
    "Others"
  ];

  final ValueNotifier<int> tabIndex = ValueNotifier(0);
  late PageController _pageController = PageController(initialPage: 0);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: tabTitles.length,
        child:

        ValueListenableBuilder(
          valueListenable: tabIndex,
          builder: (context, int index, _) {
            return PlatformTabScaffold(
              title: "Home",
              tab: PlatformTabBar(
                tabTitles: tabTitles,
                onItemSelected: _OnTapItemSelected,
                selectedIndex: index,
              ),
              tabPages: tabTitles.map((e) => Center(child: Text(e))).toList(),
              onPageSelected: (page) {
                tabIndex.value = page;
              },
              pageController: _pageController,
            );
          },
        ));
  }

  void _OnTapItemSelected(index) {
    Future.delayed(Duration(milliseconds: 100),(){
      tabIndex.value = index;
    });
    _pageController.animateToPage(index, duration: Duration(milliseconds: 100), curve: Curves.linear);
  }
}

class TabItem extends StatelessWidget {
  const TabItem({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  Widget build(BuildContext context) {
    return Tab(
      child: Text(
        title,
        style: TextStyle(fontSize: 14),
      ),
    );
  }
}
