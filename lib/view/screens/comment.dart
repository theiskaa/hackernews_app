import 'package:flutter/material.dart';
import 'package:hackernews/core/hn_api.dart';
import 'package:hackernews/core/model/news_item.dart';
import 'package:hackernews/view/widgets/comment_card.dart';
import 'package:hackernews/view/widgets/comment_header.dart';

class Comment extends StatefulWidget {
  final NewsItem newsItem;
  Comment({Key key, this.newsItem}) : super(key: key);

  @override
  _CommentState createState() => _CommentState();
}

class _CommentState extends State<Comment> {
  HNapi hNapi = HNapi();
  Map<int, NewsItem> comments = Map();

  Future<NewsItem> getComments(int id) async {
    var item = await hNapi.getNewsItem(id);
    item.comments = await hNapi.getNewsComments(item);
    return item;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFFFFCF5),
      appBar: buildAppBar(),
      body: (widget.newsItem.kids.length == 0)
          ? buildHasnotCommentTitle()
          : buildBody(),
    );
  }

  ListView buildBody() {
    return ListView.builder(
      itemCount: 1 + widget.newsItem.kids.length,
      itemBuilder: (context, index) {
        if (index == 0) {
          return CommentHeader(widget.newsItem);
        }

        return FutureBuilder(
          future: getComments(widget.newsItem.kids[index - 1]),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (comments[index - 1] != null) {
              var newsItem = comments[index - 1];
              return CommentModeler(
                newsItem: newsItem,
                key: Key(newsItem.id.toString()),
              );
            }
            if (snapshot.hasData && snapshot.data != null) {
              var newsItem = snapshot.data;
              comments[index - 1] = newsItem;
              return CommentModeler(
                newsItem: newsItem,
                key: Key(
                  newsItem.id.toString(),
                ),
              );
            } else if (snapshot.hasError) {
              return Container(
                padding: EdgeInsets.all(16.0),
                child: Center(child: Text("Error Loading Item")),
              );
            } else {
              return Container(
                padding: EdgeInsets.all(32.0),
                child: Center(
                  child: CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation<Color>(
                      Colors.transparent,
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

  Container buildHasnotCommentTitle() {
    return Container(
      child: Center(
        child: Text(
          "These content hasn't any comment!",
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Colors.black,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  AppBar buildAppBar() {
    return AppBar(
      centerTitle: true,
      backgroundColor: Color(0xFFFF6600),
      elevation: 0,
      title: Text("Comments (${widget.newsItem.descendants})"),
    );
  }
}
