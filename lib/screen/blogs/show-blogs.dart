import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../elements/styles.dart';
import '../../manage-state-provider/blogs/blogs-provider.dart';
import '../../screen-parts/header.dart';
import '../../screen-parts/home-blogs.dart';

class ShowBlogs extends StatelessWidget {
  BlogsProvider logic = BlogsProvider();
  Widget build(BuildContext context) {
    logic = Provider.of<BlogsProvider>(context, listen: false);
    // send network request
    logic.showBlogs();

    return Header(
      drawer: true,
      rightSide: [setButtons(context)],
      body: Container(
        padding: const EdgeInsets.all(10.00),
        color: const Color.fromARGB(31, 114, 70, 70),
        child: Consumer<BlogsProvider>(
          builder: (context, val, child) {
            return logic.firstLoading
                ? Column(children: const [
                    Expanded(
                      child: Center(
                        child: const CircularProgressIndicator(),
                      ),
                    ),
                  ])
                : HomeBlogs(context: context, logic: logic);
          },
        ),
      ),
    );
  }

  // set all buttons
  Widget setButtons(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(left: 10.00),
      margin: const EdgeInsets.only(right: 10.00),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Consumer<BlogsProvider>(builder: (context, val, child) {
            if (logic.activePreviousButton) {
              return ElevatedButton(
                onPressed: () {
                  logic.previousBlogs();
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: GSPstyle.btnPrimary, // Background color
                  foregroundColor:
                      GSPstyle.btnPrimaryText, // Text Color (Foreground color)
                ),
                child: const Text(
                  "Previous",
                  textDirection: TextDirection.ltr,
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 15.00,
                  ),
                ),
              );
            } else {
              return ElevatedButton(
                onPressed: null,
                style: ElevatedButton.styleFrom(
                  backgroundColor: GSPstyle.btnDisaable, // Background color
                  foregroundColor:
                      GSPstyle.btnDisaableText, // Text Color (Foreground color)
                ),
                child: const Text(
                  "Previous",
                  textDirection: TextDirection.ltr,
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 15.00,
                  ),
                ),
              );
            }
          }),
          const SizedBox(
            width: 15.00,
          ),
          Consumer<BlogsProvider>(builder: (context, val, child) {
            if (logic.activeNextButton) {
              return ElevatedButton(
                onPressed: () {
                  logic.nextBlogs();
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: GSPstyle.btnPrimary, // Background color
                  foregroundColor:
                      GSPstyle.btnPrimaryText, // Text Color (Foreground color)
                ),
                child: const Text(
                  "Next",
                  textDirection: TextDirection.ltr,
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 15.00,
                  ),
                ),
              );
            } else {
              return ElevatedButton(
                onPressed: null,
                style: ElevatedButton.styleFrom(
                  backgroundColor: GSPstyle.btnDisaable, // Background color
                  foregroundColor:
                      GSPstyle.btnDisaableText, // Text Color (Foreground color)
                ),
                child: const Text(
                  "Next",
                  textDirection: TextDirection.ltr,
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 15.00,
                  ),
                ),
              );
            }
          })
        ],
      ),
    );
  }
}
