import 'package:flutter/material.dart';

const double _kTextAndIconTabHeight = 73.0; // 导航高度
const double _kIconTabSize = 48.0; // 图标size
const double _kMarginBottom = 3.0; // 图标与文字的间隔


typedef void OnClickListener(String title);

class MenuButton extends StatefulWidget {

  const MenuButton({
    Key key,
    this.text,
    this.icons,
    this.colors,
    this.onClickListener

  })
      :
        super(key: key);

  final String text;
  final IconData icons;
  final Color colors;
  final OnClickListener onClickListener;


  @override
  State<StatefulWidget> createState() {
    return new MenuButtonState();
  }
}

class MenuButtonState extends State<MenuButton> {

  Widget _buildLabelText() {
    return new Text(widget.text,
      softWrap: false,
      overflow: TextOverflow.fade,
    );
  }
  @override
  Widget build(BuildContext context) {
    assert(debugCheckHasMaterial(context));

    double height = _kTextAndIconTabHeight;
    Widget label = MaterialButton(
        onPressed: ()=>widget.onClickListener(widget.text),
        child: new Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
        new Container(
          child: Icon(widget.icons,color:widget.colors,size: _kIconTabSize),
          margin: const EdgeInsets.only(bottom: _kMarginBottom),
        ),
        _buildLabelText()
      ],)
    );

    return new SizedBox(
      height: height,
      child: new Center(
        child: label,
        widthFactor: 1.0,
      ),
    );
  }

}