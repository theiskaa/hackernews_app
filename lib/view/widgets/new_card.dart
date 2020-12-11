import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomNewCard extends StatelessWidget {
  final int id;
  final String storyTitle;
  final int storyVotes;
  final int storyCommentCount;

  const CustomNewCard({
    Key key,
    this.id,
    this.storyTitle,
    this.storyVotes,
    this.storyCommentCount,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: buildID(),
      title: buildTitle(),
      subtitle: buildSubtitle(),
    );
  }

  Padding buildSubtitle() {
    return Padding(
      padding: const EdgeInsets.only(top: 5),
      child: Text(
        "$storyVotes points  |  $storyCommentCount comments ",
        style: GoogleFonts.roboto(fontSize: 16),
      ),
    );
  }

  Text buildTitle() {
    return Text(
      storyTitle,
      style: GoogleFonts.roboto(fontSize: 20, color: Colors.black),
    );
  }

  Widget buildID() {
    return Opacity(
      opacity: .5,
      child: Text(
        "$id. ▲",
        style: GoogleFonts.roboto(
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
