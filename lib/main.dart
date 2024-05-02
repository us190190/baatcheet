import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'utils/global_variables.dart';
import 'utils/initialize_app_config.dart';
import 'screens/chat_page.dart';
import 'screens/login_page.dart';
import 'screens/register_page.dart';
import 'screens/forgot_password_page.dart';

void main() async {
  // Initialize app configurations
  AppConfigModel appConfig = AppConfigModel();
  await initializeAppConfig(appConfig);
  // Run the app
  runApp(
    ChangeNotifierProvider(
      create: (_) => appConfig,
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => AppGlobalVariables(),
      child: MaterialApp(
        title: 'Baatcheet',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurpleAccent),
          useMaterial3: true,
        ),
        initialRoute: '/login', // Set the initial route to the login page
        routes: {
          '/login': (context) =>
              const LoginPage(), // Define the route for the login page
          '/chat': (context) =>
              const ChatPage(), // Define the route for the home page
          '/forgot_password': (context) =>
              const ForgotPasswordPage(), // Define the route for the forgot password page
          '/register': (context) =>
              const RegisterPage(), // Define the route for the registration page
        },
      ),
    );
  }
}
