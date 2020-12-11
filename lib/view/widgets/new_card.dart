import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hackernews/view/screens/comment.dart';
import 'package:hackernews/view/screens/content_screen.dart';
import 'package:timeago/timeago.dart' as timeago;
import 'package:hackernews/core/model/news_item.dart';

class CustomNewCard extends StatefulWidget {
  final NewsItem newsItem;

  CustomNewCard({
    Key key,
    this.newsItem,
  }) : super(key: key);

  @override
  _CustomNewCardState createState() => _CustomNewCardState();
}

class _CustomNewCardState extends State<CustomNewCard> {
  bool isOpened = false;
  @override
  Widget build(BuildContext context) {
    var date = DateTime.fromMillisecondsSinceEpoch(widget.newsItem.time * 1000);
    return InkWell(
      splashColor: Colors.orange,
      ///
      ///
      ///
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ContentScreen(
              url: widget.newsItem.url,
            ),
          ),
        );
        setState(() {
          isOpened = true;
        });
      },
      ///
      ///
      ///
      child: Slidable(
        actionPane: SlidableDrawerActionPane(),
        actionExtentRatio: 0.25,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 5),
          child: Opacity(
            opacity: isOpened ? .4 : 1,
            child: ListTile(
              leading: buildID(),
              title: buildTitle(),
              subtitle: buildSubtitle(date),
            ),
          ),
        ),

        //
        //
        //
        secondaryActions: [
          IconSlideAction(
            caption: 'Comments',
            icon: Icons.comment,
            color: Color(0xFFFF6600),
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => Comment(newsItem: widget.newsItem),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Padding buildSubtitle(var date) {
    return Padding(
      padding: const EdgeInsets.only(top: 5),
      child: Text(
        "${widget.newsItem.score} points  |  ${widget.newsItem.descendants} comments | ${timeago.format(date)}",
        style: GoogleFonts.roboto(fontSize: 16),
      ),
    );
  }

  Text buildTitle() {
    return Text(
      "${widget.newsItem.title}",
      style: GoogleFonts.roboto(fontSize: 20, color: Colors.black),
    );
  }

  Widget buildID() {
    return Opacity(
      opacity: .5,
      child: Text(
        "${widget.newsItem.by}-▲",
        style: GoogleFonts.roboto(
          fontSize: 15,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
