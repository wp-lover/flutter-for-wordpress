import 'package:flutter/cupertino.dart';

class UserInfoProvider with ChangeNotifier
{

  String _name = '';
  String _userMail = '';

  String get name => _name;
  String get userMail => _userMail;

  void setUserData ( name, userMail)
  {
    _name = name; _userMail = userMail;

    notifyListeners();
    
  }

}