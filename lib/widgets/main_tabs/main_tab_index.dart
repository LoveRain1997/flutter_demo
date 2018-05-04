import 'package:flutter/material.dart';


class TabIndexPage extends StatefulWidget {

    TabIndexPage(this.subTabPages,this.subController,this.mainTapIndex,{ Key key }) : super(key: key);
    TabController  subController;
    List<Widget> subTabPages;
    int mainTapIndex;
  @override
  _TabIndexPageState createState() => new _TabIndexPageState();
}

class _TabIndexPageState extends State<TabIndexPage>
    with SingleTickerProviderStateMixin {

  @override
  Widget build(BuildContext context) {
    //final Color iconColor = Theme.of(context).accentColor;

    return widget.mainTapIndex==0?new TabBarView(
      children: widget.subTabPages,
      controller: widget.subController,
    ):new Container();
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }


}
