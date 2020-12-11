import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hackernews/core/model/stories.dart';
import 'package:hackernews/view/screens/home.dart';
import 'package:hackernews/view/widgets/custom_appbar.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CupertinoTabScaffold(
      tabBar: CupertinoTabBar(
        backgroundColor: Colors.transparent,
        activeColor: const Color(0xFFFF6600),
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.grade),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.menu_book),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.people_outline),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.slideshow_outlined),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.question_answer_outlined),
          )
        ],
      ),
      tabBuilder: (BuildContext context, int index) {
        switch (index) {
          case 0:
            return Home(story: Stories.top);
          case 1:
            return Home(story: Stories.newest);
          case 2:
            return Home(story: Stories.jobs);
          case 3:
            return Home(story: Stories.shows);
          case 4:
            return Home(story: Stories.asks);
          default:
            break;
        }
      },
    );
  }
}
/*
aklsflkansfalnsfa
sfaklsfnlkanflanlfbaslfbjaf
alajsnflanlfknasf
a;sknfalsnflaf
asnfoaibfn ;ksvgodnfuysdufghk
fouysblzkfbgaiuodsm,.sdkjsdlnm,s
dfAfljabfnm,aofvbanm,qivdioq
qdoafaobfnmaf
alvfuibnal;faf
afoanifpaiopf
*/
