// Copyright 2016 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:flutter/material.dart';
import 'package:flutter_xftz/scoped_models/app_model.dart';
import 'package:flutter_xftz/utils/taskproviders.dart';
import 'package:flutter_xftz/widgets/main_tabs/all.dart';
import 'package:flutter_xftz/widgets/main_tabs/sub_tabs/all.dart';
import 'package:scoped_model/scoped_model.dart';

class HomePage extends StatefulWidget {
  static const String routeName = '/widgets/home_page';

  @override
  _BottomNavigationDemoState createState() => new _BottomNavigationDemoState();
}

class _BottomNavigationDemoState extends State<HomePage>
    with TickerProviderStateMixin {
  int _currentIndex = 0;
  List<MainTab> _navigationViews;
  List<_Page> _allPages;

  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  final PriceTaskProvider takeProvider = new PriceTaskProvider();

  Decoration _getIndicator() {
    return const UnderlineTabIndicator();
  }

  @override
  void initState() {
    super.initState();

    _allPages = <_Page>[
      _Page(
          text: '最新',
          widget: SubTabRecentPage(
            takeProvider,
          )),
      _Page(text: '路演', widget: SubTabTextLivePage()),
      _Page(text: '问答', widget: SubTabQA(takeProvider)),
      _Page(text: '金评', widget: SubTabPingLun(takeProvider)),
    ];

    _navigationViews = <MainTab>[
      new TabIndexPage(
        subTabPages: _allPages.map((_Page page) {
          return page.widget;
        }).toList(),
        icon: Icon(Icons.home),
        title: '首页',
        vsync: this,
      ),
      new TabSubscribePage(
        icon: Icon(Icons.featured_play_list),
        title: '订阅',
        vsync: this,
      ),
      new TabLivePage(
        icon: const Icon(Icons.live_tv),
        title: '直播',
        vsync: this,
      ),
      new TabZonePage(
        icon: const Icon(Icons.group),
        title: '圈子',
        vsync: this,
      ),
      new TabMePage(
        icon: const Icon(Icons.person),
        title: '我的',
        vsync: this,
      )
    ];

    for (MainTab view in _navigationViews)
      view.controller.addListener(_rebuild);

    _navigationViews[_currentIndex].controller.value = 1.0;
  }

  @override
  void dispose() {
    for (MainTab view in _navigationViews) view.controller.dispose();
    super.dispose();
  }

  void _rebuild() {
    setState(() {});
  }

  Widget _buildTransitionsStack() {
    final List<FadeTransition> transitions = <FadeTransition>[];

    for (MainTab view in _navigationViews)
      transitions.add(view.transition(context));

    transitions.sort((FadeTransition a, FadeTransition b) {
      final Animation<double> aAnimation = a.opacity;
      final Animation<double> bAnimation = b.opacity;
      final double aValue = aAnimation.value;
      final double bValue = bAnimation.value;
      return aValue.compareTo(bValue);
    });

    return new Stack(children: transitions);
  }

  @override
  Widget build(BuildContext context) {
    final BottomNavigationBar botNavBar = new BottomNavigationBar(
      items: _navigationViews
          .map((MainTab navigationView) => navigationView.item)
          .toList(),
      type: BottomNavigationBarType.fixed,
      currentIndex: _currentIndex,
      onTap: (int index) {
        setState(() {
          _navigationViews[_currentIndex].controller.reverse();
          _currentIndex = index;
          _navigationViews[_currentIndex].controller.forward();
        });
      },
    );

    return new Scaffold(
      key: _scaffoldKey,
      body: DefaultTabController(
        length: _allPages.length,
        child: NestedScrollView(
          headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
            return [
              SliverAppBar(
                pinned: true,
                floating: true,
                actions: <Widget>[
                  new ScopedModelDescendant<AppModel>(
                    builder: (context, child, model) => new IconButton(
                        icon: new Icon(
                          Icons.color_lens,
                          color: Colors.white,
                        ),
                        onPressed: () => model.toggleTheme()),
                  ),
                  IconButton(
                      icon: Icon(Icons.history),
                      onPressed: () => print("file_download")),
                  IconButton(
                    icon: Icon(Icons.file_download),
                    onPressed: () => print("file_download"),
                  )
                ],
                title: Text("幸福黄金"),
                centerTitle: true,
                leading: IconButton(
                  icon: Icon(Icons.message),
                  onPressed: () => print("Icons.message"),
                ),
                bottom: _currentIndex == 0
                    ? TabBar(
                        isScrollable: false,
                        indicator: _getIndicator(),
                        tabs: _allPages.map((_Page page) {
                          print("22");
                          return Tab(text: page.text);
                        }).toList(),
                      )
                    : null,
              )
            ];
          },
          body: _buildTransitionsStack(),
        ),
      ),
      bottomNavigationBar: botNavBar,
    );
  }
}

class _Page {
  _Page({this.text, this.widget});
  final String text;
  final Widget widget;
}
