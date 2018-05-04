import 'package:flutter/material.dart';
import 'package:flutter_xftz/widgets/main_tabs/all.dart';
import 'package:flutter_xftz/widgets/main_tabs/sub_tabs/all.dart';

class _Page {
  _Page({this.text, this.widget});
  final String text;
  final Widget widget;
}

class HomePage extends StatefulWidget {
  @override
  HomePageState createState() => new HomePageState();
}

class HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  PageController _pageController;
  TabController _subController;

  int _page = 0;

  List<_Page> _allPages = <_Page>[
    _Page(text: '最新', widget: SubTabRecentPage()),
    _Page(text: '路演', widget: SubTabTextLivePage()),
    _Page(text: '金评', widget: SubTabRecentPage()),
    _Page(text: '直播', widget: SubTabRecentPage()),
    _Page(text: '问答', widget: SubTabRecentPage()),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: <Widget>[
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
        bottom: _page == 0
            ? TabBar(
                controller: _subController,
                isScrollable: false,
                indicator: _getIndicator(),

                tabs: _allPages.map((_Page page) {
                  return Tab(text: page.text);
                }).toList(),
              )
            : null,

      ),
      body: PageView(
        children: <Widget>[
          TabIndexPage(
              _allPages.map((_Page page) {
                return page.widget;
              }).toList(),
              _subController,
              _page),
          TabSubscribePage(),
          TabLivePage(),
          TabZonePage(),
          TabMePage()
        ],
        controller: _pageController,
        pageSnapping: true,
        onPageChanged: (int index) {
          setState(() {
            _page = index;
          });
        },
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: _getNavBarItems(),
        onTap: _navigationTapped,
        currentIndex: _page,
        type: BottomNavigationBarType.fixed,
      ),
    );
  }

  List<BottomNavigationBarItem> _getNavBarItems() {
    return [
      BottomNavigationBarItem(icon: Icon(Icons.home), title: new Text('首页')),
      BottomNavigationBarItem(
          icon: Icon(Icons.featured_play_list), title: new Text('订阅')),
      BottomNavigationBarItem(icon: Icon(Icons.live_tv), title: new Text('直播')),
      BottomNavigationBarItem(icon: Icon(Icons.group), title: new Text('圈子')),
      BottomNavigationBarItem(icon: Icon(Icons.person), title: new Text('我的')),
    ];
  }

  Decoration _getIndicator() {
    return const UnderlineTabIndicator();
  }

  void _navigationTapped(int page) {
    _pageController.animateToPage(page,
        duration: const Duration(milliseconds: 300), curve: Curves.ease);
  }

  @override
  void initState() {
    super.initState();
    _pageController = new PageController();
    _subController = new TabController(vsync: this, length: _allPages.length);
  }

  @override
  void dispose() {
    super.dispose();
    _pageController.dispose();
    _subController.dispose();
  }
}
