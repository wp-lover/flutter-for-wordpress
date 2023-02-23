import 'dart:convert';
import 'dart:html';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class BlogProvider with ChangeNotifier {
  List? _blogs = [
    {
      "content": {"rendered": "hello"}
    }
  ];

  List get blogs => _blogs!;

  Future<void> get_blogs() async {
    var response = await http
        .get(Uri.parse("https://esmartenglish.com/wp-json/wp/v2/posts"));

    List<dynamic> json = jsonDecode(response.body);

    if (json != null) {
      print("got response");

      _blogs = json;
    }
    notifyListeners();
  }
}
