import 'package:flutter/material.dart';
import 'package:flutter_application_1/local_storage.dart';
import 'package:flutter_application_1/savedUserPage.dart';
import 'package:flutter_application_1/users.dart';

class Home extends StatelessWidget {
  final TextEditingController name = TextEditingController();
  final TextEditingController age = TextEditingController();
  final TextEditingController email = TextEditingController();

  Home({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('User information'),
        actions: [
          IconButton(
            onPressed: () {
              LocalStorage.getUser();
            },
            icon: Icon(Icons.save_alt),
          ),
          IconButton(
            onPressed: () async {
              List<Users> user = await LocalStorage.getUser();
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => SavedUsersPage(user: user),
                ),
              );
            },
            icon: Icon(Icons.details),
          ),
        ],
        backgroundColor: Color.fromARGB(255, 190, 154, 174),
      ),
      body: Padding(
        padding: const EdgeInsets.all(40.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            TextField(
              controller: name,
              decoration: InputDecoration(
                hintText: 'Name:',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 40),
            TextField(
              controller: age,
              decoration: InputDecoration(
                hintText: 'Age:',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 40),
            TextField(
              controller: email,
              decoration: InputDecoration(
                hintText: 'Email:',
                border: OutlineInputBorder(),
              ),
            ),

            SizedBox(height: 20),

            ElevatedButton(
              onPressed: () {
                LocalStorage.saveUser(
                  Users(
                    name: name.text,
                    age: int.parse(age.text),
                    email: email.text,
                  ),
                );
              },
              child: Text("save"),
            ),
          ],
        ),
      ),
    );
  }
}
