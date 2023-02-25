import 'package:flutter/material.dart';

import '../elements/color.dart';

class LoginPage extends StatelessWidget {
  LoginPage({super.key});

  final TextEditingController _userName = TextEditingController();

  final TextEditingController _password = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("eSmartEnglish"),
      ),
      body: Container(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              const SizedBox(
                height: 30,
              ),
              const Text("Login Your Account",
                  textDirection: TextDirection.ltr,
                  style: TextStyle(
                    fontSize: 18.00,
                    fontWeight: FontWeight.bold,
                    color: UIColor.primary_,
                  )),
              const SizedBox(
                height: 30,
              ),
              TextField(
                controller: _userName,
                decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: "UserName",
                    hintText: "Type User-name or E-mail"),
              ),
              const SizedBox(
                height: 30,
              ),
              TextField(
                controller: _password,
                decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: "Password",
                    hintText: "Type the password"),
              ),
              const SizedBox(
                height: 30,
              ),
              ElevatedButton(
                  onPressed: () => login(context, _userName.text),
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.all(8.0),
                  ),
                  child: const Text(
                    "Login",
                    textDirection: TextDirection.ltr,
                  )),
              const SizedBox(
                height: 20,
              ),
              Row(
                children: [
                  Column(
                    children: [
                      TextButton(
                          onPressed: () => '',
                          child: const Text(
                            "Find Your Account",
                            textDirection: TextDirection.ltr,
                          )),
                      TextButton(
                          onPressed: () => '',
                          child: const Text(
                            "Forget Password",
                            textDirection: TextDirection.ltr,
                          )),
                    ],
                  ),
                ],
              ),
              Row(
                children: [
                  const Padding(
                    padding: EdgeInsets.only(
                        left: 13), //apply padding to all four sides
                    child: Text(
                      "Don't have an account?",
                      textDirection: TextDirection.ltr,
                    ),
                  ),
                  TextButton(
                      onPressed: () => login(context, _userName.toString()),
                      child: const Text(
                        "Register",
                        textDirection: TextDirection.ltr,
                      )),
                ],
              )
            ],
          )),
    );
  }

  void login(BuildContext context, String val) {
    print(val);
    // Navigator.pushNamed(context, "/word_learning");
  }
}
