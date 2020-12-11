import 'package:flutter/material.dart';
import 'package:hackernews/core/hn_api.dart';
import 'package:hackernews/core/model/news_item.dart';
import 'package:hackernews/core/model/stories.dart';
import 'package:hackernews/view/widgets/custom_appbar.dart';

class Home extends StatefulWidget {
  Home({Key key, this.story}) : super(key: key);
  final Stories story;
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  HNapi hNapi = HNapi();
  List<dynamic> _id = [];
  Map<int, NewsItem> newsItems = Map();

  bool _isLoading = false;
  String errorTitle = "";

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  void fetchData() async {
    setState(() {
      _id = [];
      newsItems = Map();
      _isLoading = true;
    });
    try {
      var id = await hNapi.getNewsFeed(widget.story);
      setState(() {
        _isLoading = false;
        _id = id.toList();
      });
    } catch (e) {
      setState(() {
        this._isLoading = false;
        this.errorTitle =
            "Failed to load data, please check your internet connection";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFFFFCF5),
      appBar: CustomAppBar(
        categoryTitle: getCategoryAppBarTitle(),
      ),
      body: buildNewsBody(),
    );
  }

  Container buildNewsBody() {
    return Container(
      padding: EdgeInsets.all(8),
      child: this.errorTitle != null
          ? buildErrorTitle()
          : this._isLoading
              ? buildCircularProgressIndicator()
              : buildNewsList(),
    );
  }

  Container buildErrorTitle() {
    return Container(
      padding: EdgeInsets.all(32.0),
      child: Center(
        child: Text(
          this.errorTitle,
          textAlign: TextAlign.center,
          style: TextStyle(
            fontWeight: FontWeight.w700,
            fontSize: 20,
            color: Colors.black,
          ),
        ),
      ),
    );
  }

  Container buildCircularProgressIndicator() {
    return Container(
      child: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }

  ListView buildNewsList() {
    return ListView.builder(
      itemCount: this._id.length,
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 5),
        );
      },
    );
  }

  ///
  ///
  ///
  ///
  ///
  ///
  ///

  void refreshData() {
    fetchData();
  }

  String getCategoryAppBarTitle() {
    switch (widget.story) {
      case Stories.top:
        return "Top";
        break;
      case Stories.newest:
        return "Newest";
        break;
      case Stories.jobs:
        return "Jobs";
        break;
      case Stories.shows:
        return "Shows";
      case Stories.asks:
        return "Asks";
      default:
        return "";
    }
  }
}
