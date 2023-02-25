import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:provider/provider.dart';

import '../manage-state-provider/blogs/blogs-provider.dart';

class HomeBlogs extends StatelessWidget {
  BlogsProvider logic;
  BuildContext context;
  bool loading = true;
  HomeBlogs({super.key, required this.context, required this.logic});
  int index = 1;
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemBuilder: (context, index) {
          return Container(
            margin: const EdgeInsets.only(bottom: 8.00),
            child: Column(children: [
              index == 0 ? setButtons(context) : const Text(""),
              setContents(context, index),
            ]),
          );
        },
        itemCount: logic.blogs.length);
  }

  Widget setContents(BuildContext context, int index) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(8.00),
        child: Column(children: [
          Text(logic.blogs[index]["title"]["rendered"]),
          Html(data: logic.blogs[index]["excerpt"]["rendered"]),
          TextButton(
            onPressed: () {
              continueReading(index);
            },
            child: const Text("Continue..."),
          ),
        ]),
      ),
    );
  }

  // set all buttons
  Widget setButtons(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(left: 10.00),
      margin: const EdgeInsets.only(right: 10.00),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Consumer(builder: (context, val, child) {
            return logic.loading
                ? const CircularProgressIndicator(strokeWidth: 2.00)
                : const Text("");
          }),
        ],
      ),
    );
  }

  void continueReading(int index) {
    BlogsProvider.index = index;
    print(index.toString());
    Navigator.pushNamed(context, '/single-blog');
  }
}
