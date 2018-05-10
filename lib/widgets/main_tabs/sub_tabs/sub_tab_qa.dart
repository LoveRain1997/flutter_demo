import 'package:flutter/material.dart';
import 'package:flutter_xftz/model/news_live.dart';
import 'package:flutter_xftz/utils/expansion_menu.dart';
import 'package:flutter_xftz/utils/taskproviders.dart';
import 'package:flutter_xftz/utils/utils.dart';
import 'package:flutter_xftz/widgets/main_tabs/sub_tabs/pinglun_card.dart';


class SubTabQA extends StatefulWidget {
  SubTabQA(this.provider, {Key key}) : super(key: key);

  final PriceTaskProvider provider;


  @override
  SubTabQAState createState() => new SubTabQAState();
}





class SubTabQAState extends State<SubTabQA> {
  List<NewsLive> _movies = new List();
  int _pageNumber = 1;
  LoadingState _loadingState = LoadingState.LOADING;
  bool _isLoading = false;

  List<ExpansionMemu> menus;
  ExpansionMemu currentMenus;

  _OnChangeMenu(ExpansionMemu menu) {
       if(menu==null){
           return;
       }
       setState(() {
        currentMenus =menu ;
       });
  }

  _loadNextPage() async {

    _isLoading = true;

    try {
      var nextMovies =
      await widget.provider.loadLiveNews();
      if(mounted){
        setState(() {
          _loadingState = LoadingState.DONE;
          _movies.addAll(nextMovies);
          _isLoading = false;
          _pageNumber++;
        });
      }
      ;
    } catch (e) {

      _isLoading = false;
      if (_loadingState == LoadingState.LOADING) {
        if(mounted) {
          setState(() => _loadingState = LoadingState.ERROR);
        }
      }
    }
  }

  @override
  void initState() {
    super.initState();

     menus = <ExpansionMemu>[ExpansionMemu("最新"),ExpansionMemu("互动"),ExpansionMemu("个人")];

     currentMenus  = menus[0];

     print("1"+currentMenus.toString());

    _loadNextPage();


  }

  @override
  Widget build(BuildContext context) {

    print("2"+currentMenus.toString());
    return new Center(child: _getContentSection());
  }

  Widget _getContentSection() {
    switch (_loadingState) {
      case LoadingState.DONE:
        return new ListView.builder(
            padding: EdgeInsets.all(0.0),

            itemCount: _movies.length+1,
            itemBuilder: (BuildContext context, int index) {

              if(index==0){
               return  new ExpansionMenuTile(
                     title:   Text(currentMenus.name),
                     onMenuChanged:(ExpansionMemu menu)=>_OnChangeMenu(menu) ,
                     menus:menus,
                     backgroundColor: Theme.of(context).accentColor.withOpacity(0.025),

                );
              }

              if (!_isLoading && index-1 > (_movies.length * 0.7)) {
                _loadNextPage();
              }

              return new PingLunCard(_movies[index-1 ]);
            });
      case LoadingState.ERROR:
        return new Text(' error');
      case LoadingState.LOADING:
        return new CircularProgressIndicator();
      default:
        return new Container();
    }
  }




}