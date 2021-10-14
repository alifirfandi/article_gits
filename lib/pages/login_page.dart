import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

import '../api/api_service.dart';
import '../provider/user_provider.dart';

class LoginPage extends StatefulWidget {
  static const routeName = '/login';
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login'),
        centerTitle: true,
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        children: [
          TextFormField(
            controller: usernameController,
            decoration: const InputDecoration(
              label: Text('Username'),
            ),
          ),
          TextFormField(
            controller: passwordController,
            obscureText: true,
            decoration: const InputDecoration(
              label: Text('Password'),
            ),
          ),
          const SizedBox(
            height: 25,
          ),
          Consumer<UserProvider>(builder: (context, userProvider, _) {
            if (_isLoading) {
              return const LinearProgressIndicator();
            } else {
              return ElevatedButton(
                onPressed: () async {
                  String username = usernameController.text;
                  String password = passwordController.text;

                  if (username.isEmpty || password.isEmpty) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Please fill all field.'),
                      ),
                    );
                    return;
                  }

                  setState(() {
                    _isLoading = true;
                  });

                  var user =
                      await ApiService.login(http.Client(), username, password);

                  if (user != null) {
                    userProvider.user = user;
                    Navigator.of(context).pop();
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('Login Success : ${user.displayName}'),
                      ),
                    );
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Wrong Username / Password'),
                      ),
                    );
                  }
                  setState(() {
                    _isLoading = false;
                  });
                },
                child: const Text('Login'),
              );
            }
          })
        ],
      ),
    );
  }
}
