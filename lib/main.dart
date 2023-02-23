import 'package:blog/provider/blog.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'blog-screen.dart';

void main() {
  runApp(Blog());
}

class Blog extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => BlogProvider()),
      ],
      child: MaterialApp(
        routes: {"/": (context) => BlogScreen()},
      ),
    );
  }
}
