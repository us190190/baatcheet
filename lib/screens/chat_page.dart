import 'package:flutter/material.dart';
import '../utils/api_wrapper.dart';

class ChatPage extends StatefulWidget {
  const ChatPage({super.key});

  @override
  _ChatPageState createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  List<dynamic> usersAndGroups = [];
  List<dynamic> usersAndGroupsFiltered = [];

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (usersAndGroups.length == 0) {
      _fetchData();
    }

    return Scaffold(
      appBar: AppBar(
        title: TextField(
          onChanged: _filterList,
          decoration: InputDecoration(
            hintText: 'Search ...',
            hintStyle: TextStyle(color: Colors.deepPurple),
            border: InputBorder.none,
          ),
          style: TextStyle(color: Colors.deepPurple),
        ),
      ),
      body: _getChatView(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // TODO Action to perform when the floating action button is pressed
        },
        child: const Icon(Icons.message),
      ),
    );
  }

  ListView _getChatView() {
    return ListView.builder(
      itemCount: usersAndGroupsFiltered.length,
      itemBuilder: (context, index) {
        return ListTile(
          leading: CircleAvatar(
            child: Text(usersAndGroupsFiltered[index].containsKey('group_name')
                ? "G"
                : "U"), // Replace with profile image
          ),
          title: usersAndGroupsFiltered[index].containsKey('group_name')
              ? Text(usersAndGroupsFiltered[index]['group_name']
                      .substring(0, 1)
                      .toUpperCase() +
                  usersAndGroupsFiltered[index]['group_name'].substring(1))
              : Text(usersAndGroupsFiltered[index]['username']
                      .substring(0, 1)
                      .toUpperCase() +
                  usersAndGroupsFiltered[index]['username'].substring(1)),
          subtitle: const Text("Tap for private messages"),
          trailing: const Text("Last seen"),
          onTap: () {
            // TODO Action to perform when a chat is tapped
          },
        );
      },
    );
  }

  void _fetchData() {
    Future<List<dynamic>> usersFuture = fetchUsers(context);
    usersFuture.then((users) {
      setState(() {
        this.usersAndGroups.addAll(users);
        this.usersAndGroupsFiltered = this.usersAndGroups;
      });
    });

    Future<List<dynamic>> groupsFuture = fetchGroups(context);
    groupsFuture.then((groups) {
      setState(() {
        this.usersAndGroups.addAll(groups);
        this.usersAndGroupsFiltered = this.usersAndGroups;
      });
    });
  }

  void _filterList(String query) {
    setState(() {
      if (query == "") {
        this.usersAndGroupsFiltered = this.usersAndGroups;
      } else {
        this.usersAndGroupsFiltered = this
            .usersAndGroups
            .where((userOrGroup) => userOrGroup.containsKey('group_name')
                ? userOrGroup['group_name']
                    .toLowerCase()
                    .contains(query.toLowerCase())
                : userOrGroup['username']
                    .toLowerCase()
                    .contains(query.toLowerCase()))
            .toList();
      }
    });
  }
}
