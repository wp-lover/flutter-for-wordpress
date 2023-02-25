import 'package:blogs/manage-state-provider/user-info-provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'elements/styles.dart';
import 'screen/blogs/show-blogs.dart';
import 'screen/blogs/single-blog.dart';
import 'manage-state-provider/blogs/blogs-provider.dart';

void main() {
  runApp(const EsmartEnglishInitialize());
}

class EsmartEnglishInitialize extends StatelessWidget {
  const EsmartEnglishInitialize({super.key});

  @override
  Widget build(BuildContext context) {
    //

    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => BlogsProvider()),
        ChangeNotifierProvider(create: (_) => UserInfoProvider())
      ],
      child: MaterialApp(
        routes: {
          "/": (context) => ShowBlogs(),
          "/single-blog": (context) => SingleBlog(),
        },
      ),
    );
  }
}
