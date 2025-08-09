


import 'package:flutter/material.dart';
import 'package:flutter_application_1/task.dart';

class Taskcard extends StatelessWidget {
    final Task task;
   Taskcard({required this.task ,super.key,});

  @override
  Widget build(BuildContext context) {
      return Container(
      width:150,
      height: 130,
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: task.color,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(task.icon, color:Color(0xFF3E2723)),
          SizedBox(height: 40),
          Row(
            children: [
              Text(
                task.text,
                style: TextStyle(
                  color: Color.fromARGB(255, 99, 65, 75),
                  fontWeight: FontWeight.bold,
                ),
              ),
              Spacer(),
              Text("${task.number}",
               style: TextStyle(color: Color.fromARGB(255, 77, 45, 54)
              ,
              fontWeight: FontWeight.bold)),
            ],
          ),
        ],
      ),
    );
 
  }
}