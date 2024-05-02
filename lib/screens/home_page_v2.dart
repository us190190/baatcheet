import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:baatcheet/utils/global_variables.dart';

class ChatPage extends StatelessWidget {
  const ChatPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Baatcheet'),
      ),
      body: ListView.builder(
        itemCount: 20, // Replace this with the actual number of chat messages
        itemBuilder: (context, index) {
          return ListTile(
            leading: const CircleAvatar(
              child: Text('A'), // Replace with profile image
            ),
            title: const Text('Contact Name'), // Replace with contact name
            subtitle: const Text('Message text'), // Replace with message text
            trailing: const Text('10:00'), // Replace with message time
            onTap: () {
              // Action to perform when a chat is tapped
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Action to perform when the floating action button is pressed
        },
        child: const Icon(Icons.message),
      ),
    );
    // return Scaffold(
    //   appBar: AppBar(
    //     title: const Text('Home'),
    //   ),
    //   body: Center(
    //     child: Column(
    //       mainAxisAlignment: MainAxisAlignment.center,
    //       children: <Widget>[
    //         Center(
    //           child: Consumer<AppGlobalVariables>(
    //             builder: (context, appGlobalVariables, child) {
    //               return Text('Welcome to home page of Baatcheet Username: ${appGlobalVariables.userToken}');
    //             },
    //           ),
    //         ),
    //         const SizedBox(height: 20.0),
    //         ElevatedButton(
    //           onPressed: () {
    //             // Navigate back to the login page
    //             Provider.of<AppGlobalVariables>(context, listen: false).resetUserToken();
    //             Navigator.pushReplacementNamed(context, '/login');
    //           },
    //           child: const Text('Logout'),
    //         ),
    //       ],
    //     ),
    //   ),
    // );
  }
}