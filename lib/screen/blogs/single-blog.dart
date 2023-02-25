import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:provider/provider.dart';

import '../../manage-state-provider/blogs/blogs-provider.dart';
import '../../screen-parts/header.dart';

class SingleBlog extends StatelessWidget {
  //
  late List post;
  late int index;

  bool redirectBlogs = false;

  SingleBlog({super.key}) {
    if (BlogsProvider.signleArticle.length < 2) {
      redirectBlogs = true;
    } else {
      post = BlogsProvider.signleArticle;
      index = BlogsProvider.index;
    }
  }

  @override
  Widget build(BuildContext context) {
    if (redirectBlogs) {
      Navigator.pushNamed(context, '/blogs');
    }
    return Header(
      drawer: false,
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        padding: const EdgeInsets.all(10.00),
        child: Consumer(builder: (context, val, child) {
          return Column(children: [
            Text(
              post[index]["title"]["rendered"],
              style:
                  const TextStyle(fontSize: 18.00, fontWeight: FontWeight.bold),
            ),
            SingleChildScrollView(
              child: Html(
                data: post[index]["content"]["rendered"],
              ),
            )
          ]);
        }),
      ),
    );
  }
}
