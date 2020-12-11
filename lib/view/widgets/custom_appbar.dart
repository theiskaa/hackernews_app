import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomAppBar extends StatelessWidget with PreferredSizeWidget {
  const CustomAppBar({Key key}) : super(key: key);

  @override
  Size get preferredSize => Size.fromHeight(55);
  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Color(0xffFE6601),
      elevation: 0,
      title: buildAppBarTitle(),
      
    );
  }

  Row buildAppBarTitle() {
    return Row(
      children: [buildHNlogo(), SizedBox(width: 10), buildHNTitle()],
    );
  }

  Text buildHNTitle() {
    return Text(
      "Hacker News",
      style: TextStyle(
        fontSize: 22,
        color: Colors.white,
        fontWeight: FontWeight.w900,
      ),
    );
  }

  Container buildHNlogo() {
    return Container(
      constraints: BoxConstraints(
        minHeight: 25,
        minWidth: 25,
        maxHeight: 35,
        maxWidth: 35,
      ),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.white, width: 2),
      ),
      child: Center(
        child: Text(
          "Y",
          style: GoogleFonts.roboto(fontSize: 22),
        ),
      ),
    );
  }
}
