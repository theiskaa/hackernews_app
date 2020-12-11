import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:timeago/timeago.dart' as timeago;
import 'package:hackernews/core/model/news_item.dart';

class CustomNewCard extends StatelessWidget {
  // final int id;
  // final String storyTitle;
  // final int storyVotes;
  // final int storyCommentCount;

  final NewsItem newsItem;

  const CustomNewCard({
    Key key,
    this.newsItem,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var date = DateTime.fromMillisecondsSinceEpoch(newsItem.time * 1000);
    return ListTile(
      leading: buildID(),
      title: buildTitle(),
      subtitle: buildSubtitle(date),
    );
  }

  Padding buildSubtitle(var date) {
    return Padding(
      padding: const EdgeInsets.only(top: 5),
      child: Text(
        "${newsItem.score} points  |  ${newsItem.comments.length} comments | ${timeago.format(date)}",
        style: GoogleFonts.roboto(fontSize: 16),
      ),
    );
  }

  Text buildTitle() {
    return Text(
      "${newsItem.title}",
      style: GoogleFonts.roboto(fontSize: 20, color: Colors.black),
    );
  }

  Widget buildID() {
    return Opacity(
      opacity: .5,
      child: Text(
        "${newsItem.id}. ▲",
        style: GoogleFonts.roboto(
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
