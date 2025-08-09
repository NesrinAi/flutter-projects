import 'package:flutter/material.dart';
import 'package:flutter_application_1/UserCard';
import 'package:flutter_application_1/edit_page.dart';
import 'package:flutter_application_1/local_storage.dart';
import 'package:flutter_application_1/users.dart';

class SavedUsersPage extends StatefulWidget {
  const SavedUsersPage({super.key, required List<Users> user});

  @override
  State<SavedUsersPage> createState() => _SavedUsersPageState();
}

class _SavedUsersPageState extends State<SavedUsersPage> {
  List<Users> users = [];
  @override
  void initState() {
    super.initState();
    loadUser();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Saved Users"),
        actions: [
          IconButton(onPressed: clearUser, icon: Icon(Icons.delete_forever)),
        ],
      ),

      body: users.isEmpty
          ? Center(child: Text("No users saved yet"))
          : ListView.builder(
              itemCount: users.length,
              itemBuilder: (context, i) {
                final user = users[i];
                return UserCard(
                  user: user,
                  onDelete: () => deleteUser(i),
                  onEdit: () => editUser(i),
                );
              },
            ),
    );
  }

  void loadUser() async {
    List<Users> loadedUsers = await LocalStorage.getUser();
    setState(() {
      users = loadedUsers;
    });
  }

  void clearUser() async {
    await LocalStorage.clearUser();
    setState(() {
      users.clear();
    });
  }

  void deleteUser(int index) async {
    setState(() {
      users.removeAt(index);
    });

    await LocalStorage.saveUsers(users);
  }

  void editUser(int index) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => EditUserPage(
          user: users[index],
          onSave: (newName, newAge, newEmail) {
            setState(() {
              users[index].name = newName;
              users[index].age = newAge;
              users[index].email = newEmail;
            });
            LocalStorage.saveUsers(users);
          },
        ),
      ),
    );
  }
}
