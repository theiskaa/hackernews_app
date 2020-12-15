import 'dart:async';

import 'package:flutter/material.dart';
import 'package:hackernews/core/hn_api.dart';
import 'package:hackernews/core/model/news_item.dart';
import 'package:hackernews/core/model/stories.dart';
import 'package:hackernews/view/widgets/custom_appbar.dart';
import 'package:hackernews/view/widgets/new_card.dart';

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
        onTap: refreshData,
      ),
      body: _isLoading ? buildLoadingAnimation() : buildBody(),
    );
  }

  Container buildLoadingAnimation() {
    return Container(
      child: Center(
        child: CircularProgressIndicator(
          valueColor: AlwaysStoppedAnimation<Color>(
            Color(0xFFFF6600),
          ),
        ),
      ),
    );
  }

  ListView buildBody() {
    return ListView.builder(
      itemCount: this._id.length,
      itemBuilder: (BuildContext context, int index) {
        return FutureBuilder(
          future: hNapi.getNewsItem(this._id[index]),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (newsItems[index] != null) {
              var item = newsItems[index];
              return CustomNewCard(
                newsItem: item,
                numIndex: "${index + 1}",
                key: Key(item.id.toString()),
              );
            }
            //? ======================
            //? ======================
            if (snapshot.hasData && snapshot.data != null) {
              var item = snapshot.data;
              newsItems[index] = item;
              return CustomNewCard(
                newsItem: item,
                numIndex: "${index + 1}",
                key: Key(item.id.toString()),
              );
            }
            //! ======================
            //! ======================
            else if (snapshot.hasError) {
              return Container(
                padding: EdgeInsets.all(32.0),
                child: Center(
                  child: Text(
                    "Error loading story ${this._id[index]}",
                    style: TextStyle(
                      color: Colors.orange,
                      fontSize: 18,
                    ),
                  ),
                ),
              );
            }
            //  ======================
            //  ======================
            else {
              return Container(
                padding: EdgeInsets.all(32.0),
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation<Color>(
                        Colors.transparent,
                      ),
                    ),
                  ),
                ),
              );
            }
          },
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
