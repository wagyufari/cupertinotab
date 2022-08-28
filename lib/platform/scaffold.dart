import 'package:cupertinotab/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/rendering.dart';
import 'dart:io';

class PlatformScaffold extends StatelessWidget {
  const PlatformScaffold(
      {Key? key, required this.body, this.title, this.leading})
      : super(key: key);

  final Widget? body;
  final String? title;
  final Widget? leading;

  @override
  Widget build(BuildContext context) {
    return _DefaultScaffold(
      title: title,
      leading: leading,
      body: body ?? Container(),
    );
  }
}

class PlatformTabScaffold extends StatelessWidget {
  const PlatformTabScaffold({Key? key, required this.title, this.leading, this.tab, required this.tabPages, required this.onPageSelected, required this.pageController}) : super(key: key);

  final String title;
  final Widget? leading;
  final Widget? tab;
  final List<Widget> tabPages;
  final ValueChanged<int> onPageSelected;
  final PageController pageController;

  @override
  Widget build(BuildContext context) {
    return _TabScaffold(title: title, leading: leading, tab: tab ?? Container(), tabPages: tabPages, onPageSelected: onPageSelected, pageController: pageController,);
  }
}


class _DefaultScaffold extends StatelessWidget {
  const _DefaultScaffold({
    Key? key,
    required this.title,
    required this.leading,
    required this.body,
  }) : super(key: key);

  final String? title;
  final Widget? leading;
  final Widget body;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Platform.isAndroid
          ? Scaffold(
              backgroundColor: Colors.white,
              body: Column(
                children: [
                  (title != null)
                      ? _AppBar(
                          title: title!,
                          leading: leading,
                        )
                      : Container(),
                  Expanded(child: body),
                ],
              ),
            )
          : CupertinoPageScaffold(
              backgroundColor: Colors.white,
              navigationBar: (title != null)
                  ? CupertinoNavigationBar(
                      padding: EdgeInsetsDirectional.fromSTEB(8, 8, 8, 8),
                      leading: leading != null ? leading : Text(""),
                      middle: Text(title!),
                    )
                  : null,
              child: Expanded(
                child: body,
              ),),
    );
  }
}

class _TabScaffold extends StatefulWidget {
  _TabScaffold({
    Key? key,
    required this.title,
    required this.leading,
    required this.tab, required this.tabPages, required this.onPageSelected, required this.pageController
  }) : super(key: key);

  final String? title;
  final Widget? leading;
  final Widget tab;
  final List<Widget> tabPages;
  final ValueChanged<int> onPageSelected;
  final PageController pageController;

  @override
  State<_TabScaffold> createState() => _TabScaffoldState();
}

class _TabScaffoldState extends State<_TabScaffold> {


  @override
  Widget build(BuildContext context) {
    return Container(
      child: Platform.isAndroid
          ? Scaffold(
              backgroundColor: Colors.white,
              body: Column(
                children: [
                  _AppBar(
                    title: "${widget.title}",
                    leading: widget.leading,
                    tab: widget.tab,
                  ),
                  Expanded(child: TabBarView(children: widget.tabPages))
                ],
              ),
            )
          : CupertinoPageScaffold(
              backgroundColor: Colors.white,
              child: Column(
                children: [
                  _CupertinoAppBar(
                    title: "${widget.title}",
                    leading: widget.leading,
                    tab: widget.tab,
                  ),
                  Expanded(
                    child: PageView(
                      controller: widget.pageController,
                      onPageChanged: widget.onPageSelected,
                      children: widget.tabPages,),
                  ),
                ],
              )),
    );
  }
}

class _AppBar extends StatelessWidget {
  const _AppBar(
      {Key? key, required this.title, this.leading, this.tab})
      : super(key: key);

  final String title;
  final Widget? leading;
  final Widget? tab;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(color: Colors.white),
      child: SafeArea(
        bottom: false,
        child: Card(
          elevation: 2,
          margin: EdgeInsets.zero,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(0),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                child: Stack(
                  children: [
                    Row(
                      children: [
                        Container(
                          child: leading,
                        ),
                        SizedBox(
                          width: leading == null ? 0 : 32,
                        ),
                        Text(
                          title,
                          style: TextStyle(
                              fontWeight: FontWeight.w700, fontSize: 21),
                        )
                      ],
                    )
                  ],
                ),
              ),
              tab ?? Container()
            ],
          ),
        ),
      ),
    );
  }
}

class _CupertinoAppBar extends StatelessWidget {
  const _CupertinoAppBar(
      {Key? key, required this.title, this.leading, required this.tab})
      : super(key: key);

  final String title;
  final Widget? leading;
  final Widget? tab;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(color: AppColors.cupertinoGray),
      child: SafeArea(
        bottom: false,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              child: Stack(
                children: [
                  leading != null
                      ? Align(
                          alignment: AlignmentDirectional.centerStart,
                          child: Icon(Icons.arrow_back_ios))
                      : Container(),
                  Align(
                      alignment: AlignmentDirectional.center,
                      child: Text(
                        title,
                        style: TextStyle(fontWeight: FontWeight.w600),
                      ))
                ],
              ),
            ),
            tab ?? Container(),
            Container(
                decoration: BoxDecoration(color: AppColors.cupertinoDivider),
                child: SizedBox(
                  height: 0.6,
                ))
          ],
        ),
      ),
    );
  }
}

