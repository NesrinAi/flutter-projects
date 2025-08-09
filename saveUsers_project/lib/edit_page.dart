import 'package:flutter/material.dart';
import 'package:flutter_application_1/users.dart';

class EditUserPage extends StatelessWidget {
  final Users user;
  final void Function(String newName, int age, String email) onSave;

  const EditUserPage({super.key, required this.user, required this.onSave});

  @override
  Widget build(BuildContext context) {
    final nameController = TextEditingController(text: user.name);
    final ageController = TextEditingController(text: user.age.toString());
    final emailController = TextEditingController(text: user.email);
    return Scaffold(
      appBar: AppBar(title: Text("Edit Name")),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            TextField(
              controller: nameController,
              decoration: InputDecoration(labelText: "Name"),
            ),
            SizedBox(height: 20),

            TextField(
              controller: emailController,
              decoration: InputDecoration(labelText: "Email"),
            ),
            SizedBox(height: 20),

            TextField(
              controller: ageController,
              decoration: InputDecoration(labelText: "age"),
            ),
            ElevatedButton(
              onPressed: () {
                onSave(
                  nameController.text,
                  int.parse(ageController.text),
                  emailController.text,
                );
                Navigator.pop(context);
              },
              child: Text("Save"),
            ),
          ],
        ),
      ),
    );
  }
}
