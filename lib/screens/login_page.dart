import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../utils/global_variables.dart';
import '../utils/api_wrapper.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            TextField(
              controller: _usernameController,
              decoration: const InputDecoration(
                labelText: 'Username',
              ),
            ),
            const SizedBox(height: 20.0),
            TextField(
              controller: _passwordController,
              obscureText: true,
              decoration: const InputDecoration(
                labelText: 'Password',
              ),
            ),
            const SizedBox(height: 20.0),
            ElevatedButton(
              onPressed: _loginHandler,
              child: const Text('Login'),
            ),
            const SizedBox(height: 10.0),
            TextButton(
              onPressed: () {
                // Navigate to the forgot password screen
                Navigator.pushNamed(context, '/forgot_password');
              },
              child: const Text('Forgot Password?'),
            ),
            TextButton(
              onPressed: () {
                // Navigate to the registration screen
                Navigator.pushNamed(context, '/register');
              },
              child: const Text('Register'),
            ),
          ],
        ),
      ),
    );
  }

  void _loginHandler() {
    Future<Map<String, dynamic>> userFuture = authenticateUser(
        context, _usernameController.text, _passwordController.text);
    userFuture.then((authenticatedUser) {
      if (!authenticatedUser.isEmpty) {
        String userToken = authenticatedUser["auth_token"];
        Provider.of<AppGlobalVariables>(context, listen: false)
            .setUserToken(userToken);
        Navigator.pushReplacementNamed(context, '/chat');
      }
    });
  }
}
