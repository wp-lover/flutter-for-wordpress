import 'dart:math';
import 'package:flutter_html/flutter_html.dart';
import 'package:blog/provider/blog.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class BlogScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    BlogProvider logic = Provider.of<BlogProvider>(context, listen: false);

    logic.get_blogs();

    return Scaffold(
      appBar: AppBar(
        title: const Text("Blogs"),
      ),
      body: Container(
        margin: const EdgeInsets.all(10.00),
        child: Column(
          children: [
            Consumer<BlogProvider>(
              builder: (BuildContext context, value, child) {
                print("this is length " + logic.blogs.length.toString());

                if (logic.blogs.length > 1) {
                  return Expanded(
                    child: ListView.builder(
                      itemBuilder: (context, index) {
                        return Column(
                          children: [
                            Text(
                              logic.blogs[index]["title"]["rendered"],
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 20.00),
                            ),
                            Html(
                                data: logic.blogs[index]["content"]
                                    ["rendered"]),
                          ],
                        );
                      },
                      itemCount: 10,
                    ),
                  );
                } else {
                  return const Expanded(
                    child: Center(
                      child: CircularProgressIndicator(),
                    ),
                  );
                }
              },
            ),
            TextButton(onPressed: () => '', child: const Text("Next"))
          ],
        ),
      ),
    );
  }
}
