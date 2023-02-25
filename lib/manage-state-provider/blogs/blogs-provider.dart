import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

import '../../network-request/urls.dart';

class BlogsProvider with ChangeNotifier {
  // static
  static List signleArticle = [
    {
      "title": {"rendered": ""},
      "content": {"rendered": ""}
    }
  ];

  static int index = 1;

  List _blogs = [
    {
      "title": {"rendered": ""},
      "content": {"rendered": ""}
    }
  ];

  List get blogs => _blogs;

  int pageNo = 1;

  bool loading = true;

  bool firstLoading = true;

  bool activePreviousButton = false;

  bool activeNextButton = true;

// when user press button for next blogs or previous blogs

  Future<void> showBlogs() async {
    loading = true;
    notifyListeners();

    http.Response response = await getBlogs();

    if (response.statusCode == 200) {
      _blogs = jsonDecode(response.body);
      BlogsProvider.signleArticle = _blogs;

      // for first time create UI
      if (firstLoading) {
        firstLoading = false;
      }
      // set loading false
      loading = false;

      buttonsVisiablity();
      // increase pageNo by one
      pageNo++;

      notifyListeners();
    } else {
      activeNextButton = false;
      // set loading false
      loading = false;
      notifyListeners();
    }

    // set button activities
  }

//  this is method responsible for getting the blogs from server
  Future<http.Response> getBlogs() async {
    http.Response response =
        await http.get(Uri.parse("${Urls.blogsURL}?page=${pageNo.toString()}"));
    return response;
  }

  void buttonsVisiablity() {
    if (pageNo > 1) {
      activePreviousButton = true;
    } else {
      activePreviousButton = false;
    }

    if (activeNextButton == false) {
      activeNextButton = true;
    }
  }

  void nextBlogs() {
    showBlogs();
  }

  Future<void> previousBlogs() async {
    pageNo = pageNo - 2;
    print("pagae no $pageNo");
    showBlogs();
  }
}
