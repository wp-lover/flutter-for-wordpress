import 'package:provider/provider.dart';
import 'package:flutter/material.dart';

import '../manage-state-provider/user-info-provider.dart';

class AppDrawer extends StatelessWidget {
  BuildContext mainContext;
  AppDrawer({super.key, required this.mainContext});

  @override
  Widget build(BuildContext context) {
    final userInfo = Provider.of<UserInfoProvider>(context, listen: false);
    userInfo.setUserData("Joshim", "Joshim@gmail.com");
    return Drawer(
      child: Column(children: [
        Consumer<UserInfoProvider>(builder: (context, value, child) {
          return UserAccountsDrawerHeader(
            currentAccountPicture: CircleAvatar(
                // backgroundImage: AssetImage('images/img-1.jpg'),
                ),
            accountName: Text(
              userInfo.name,
              textDirection: TextDirection.ltr,
            ),
            accountEmail: Text(
              userInfo.userMail,
              textDirection: TextDirection.ltr,
            ),
          );
        }),
        Container(
          padding: EdgeInsets.only(left: 10.00),
          child: Column(children: [
            Row(
              children: [
                Row(
                  children: [
                    TextButton(
                      onPressed: () {
                        Navigator.pushNamed(mainContext, "/");
                      },
                      child: const Text(
                        "Blogs Reading",
                        textDirection: TextDirection.ltr,
                      ),
                    )
                  ],
                ),
              ],
            ),
          ]),
        ),
      ]),
    );
  }
}
