import 'package:flutter/material.dart';
import 'package:flutter_xftz/model/news_live.dart';
import 'package:flutter_xftz/utils/taskproviders.dart';
import 'package:flutter_xftz/utils/utils.dart';
import 'package:flutter_xftz/widgets/main_tabs/sub_tabs/pinglun_card.dart';


class SubTabPingLun extends StatefulWidget {
  SubTabPingLun(this.provider, {Key key}) : super(key: key);

  final PriceTaskProvider provider;
  final String category;

  @override
  SubTabPingLunState createState() => new SubTabPingLunState();
}

class SubTabPingLunState extends State<SubTabPingLun> {
  List<NewsLive> _movies = new List();
  int _pageNumber = 1;
  LoadingState _loadingState = LoadingState.LOADING;
  bool _isLoading = false;

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
    _loadNextPage();
  }

  @override
  Widget build(BuildContext context) {
    return new Center(child: _getContentSection());
  }

  Widget _getContentSection() {
    switch (_loadingState) {
      case LoadingState.DONE:
        return new ListView.builder(
            itemCount: _movies.length,
            itemBuilder: (BuildContext context, int index) {
              if (!_isLoading && index > (_movies.length * 0.7)) {
                _loadNextPage();
              }

              return new PingLunCard(_movies[index]);
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