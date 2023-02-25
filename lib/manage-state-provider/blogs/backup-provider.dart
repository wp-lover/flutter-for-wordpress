import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

import '../../network-request/urls.dart';
import 'blogs-provider.dart';

class BlogsProviderTwo with ChangeNotifier {
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

  List _firstThreadData = [
    {
      "title": {"rendered": ""},
      "content": {"rendered": ""}
    }
  ];

  List _secondThreadData = [
    {
      "title": {"rendered": ""},
      "content": {"rendered": ""}
    }
  ];

  List? _previousFristData;
  List? _previousSecondData;

  List get blogs => _blogs;

  int pageNo = 1;

  http.Response? response;

  bool loading = true;

  bool previousBntActive = false;

  bool activePreviousBlogs = false;

  bool nextBntActive = true;

  bool setFirstBlogs = true;

  bool setSecondBlogs = false;

  bool firstNetwork = true;

// when user press button for next blogs or previous blogs
  bool userClickedButton = false;

  void loader() {
    notifyListeners();
  }

  Future<void> showBlogs() async {
    loading = true;
    userClickedButton = true;

    if (firstNetwork) {
      print("firstNetwork true");
      firstNetworkThread(pageNo);
    } else {
      print("firstNetwork false");
      secondNetworkThread(pageNo);
    }

    // set button activities
    previousButtonVisiblity();
  }

  Future<void> firstNetworkThread(int pageNo_) async {
    //

    // if run the statement the previous data will be assigned,
    //and function will exit;
    if (setSecondBlogs && firstNetwork) {
      _blogs = _firstThreadData;
      BlogsProvider.signleArticle = _firstThreadData;
      loading = false;
      notifyListeners();
      userClickedButton = false;
      setSecondBlogs = false;
      secondNetworkThread(pageNo + 1);
      firstNetwork = true;
      return;
    }

    http.Response response = await getBlogs(pageNo_);

    if (response.statusCode == 200) {
      _firstThreadData = jsonDecode(response.body);

      _previousFristData = _firstThreadData;

      // if setFirstBlogs is true then data will store to the _blogs property.
      if (setFirstBlogs) {
        _blogs = _firstThreadData;
        BlogsProvider.signleArticle = _firstThreadData;
        loading = false;
        notifyListeners();
        // and asign the false to setSecondBlogs property
        if (setSecondBlogs) {
          setSecondBlogs = false;
        }
      } else {
        // assign the false to setFirstBlogs property
      }

      // secondNetworkThread for reserve next blogs
      if (userClickedButton) {
        userClickedButton = false;
        secondNetworkThread(pageNo_ + 1);
        // pageNo = pageNo_ + 1;
      }
    }

    pageNo = pageNo_;
    // as if second time secondNetwordThread will have been called.
  }

  Future<void> secondNetworkThread(int pageNo_) async {
    //

    // if run the statement the previous data will be assigned,
    //and function will exit;
    if (firstNetwork == false && setFirstBlogs == false && setSecondBlogs) {
      _blogs = _secondThreadData;
      BlogsProvider.signleArticle = _secondThreadData;
      loading = false;
      notifyListeners();
      userClickedButton = false;
      firstNetworkThread(pageNo + 1);
      firstNetwork = true;
      setSecondBlogs = true;
      return;
    }

    http.Response response = await getBlogs(pageNo_);

    if (response.statusCode == 200) {
      _secondThreadData = jsonDecode(response.body);

      _previousSecondData = _secondThreadData;

      // if setFirstBlogs is true then data will store to the _blogs property.
      if (setSecondBlogs) {
        _blogs = _secondThreadData;
        BlogsProvider.signleArticle = _secondThreadData;
        loading = false;
        notifyListeners();
      } else {
        // assign the false to setFirstBlogs property
        setFirstBlogs = false;
        setSecondBlogs = true;
      }

      if (userClickedButton) {
        userClickedButton = false;
        firstNetworkThread(pageNo);
      }
    }
    firstNetwork = false;
    pageNo = pageNo_;
  }

//  this is method responsible for getting the blogs from server
  Future<http.Response> getBlogs(int pageNo_) async {
    http.Response response = await http
        .get(Uri.parse("${Urls.blogsURL}?page=${pageNo_.toString()}"));

    if (response.statusCode != 200) {
      nextBntActive = false;
      notifyListeners();
    }

    return response;
  }

  void previousButtonVisiblity() {
    // set previous button
    if (pageNo > 1) {
      previousBntActive = true;
    } else {
      previousBntActive = false;
    }
    // notifyListeners();
  }

  void nextBlogs() {
    showBlogs();
    notifyListeners();
  }

  Future<void> previousBlogs() async {
    http.Response response;
    activePreviousBlogs = true;
    print("previous blogs clicked");
    if (_blogs == _firstThreadData) {
      _blogs = _secondThreadData;
      print("the index No $pageNo from _previousFirst");
      return;
    }

    if (_blogs == _secondThreadData) {
      response = await getBlogs(pageNo - 2);

      if (response.statusCode == 200) {
        _blogs = jsonDecode(response.body);
      }

      print("the index No $pageNo from _previousSecond");
    }

    //else {
    //   _blogs = _firstThreadData;
    // }
    notifyListeners();
  }

  void fullBlog(int index_) {
    BlogsProvider.index = index_;
  }
}
