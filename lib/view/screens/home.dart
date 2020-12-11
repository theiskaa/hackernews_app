import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:hackernews/core/model/news_item.dart';
import 'package:hackernews/view/widgets/custom_appbar.dart';
import 'package:hackernews/view/widgets/new_card.dart';
import 'package:http/http.dart' as http;

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {

  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFFFFCF5),
      appBar: CustomAppBar(),
      body: buildNewsBody(),
    );
  }

  Container buildNewsBody() {
    return Container(
      padding: EdgeInsets.all(8),
      child: ListView.builder(
        itemCount: 10,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 5),
            child: CustomNewCard(
              storyTitle: " Microsoft releases a preview of x64 emulation on Windows for ARM",
              storyVotes: 12,
              id: 1,
              storyCommentCount: 23,
            ),
          );
        },
      ),
    );
  }
}
