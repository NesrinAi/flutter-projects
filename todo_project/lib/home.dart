import 'package:flutter/material.dart';
import 'package:flutter_application_1/reminders.dart';
import 'package:flutter_application_1/task.dart';
import 'package:flutter_application_1/taskCard.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    List<Task> tasks = [
      Task('Today', 6, Icons.check, Color(0xFFD8E2DC)), // Platinum
      Task(
        'Meetings',
        3,
        Icons.video_call,
        Color(0xFFFFE5D9),
      ), // Champagne pink
      Task('Reminders', 9, Icons.alarm, Color(0xFFFFCAD4)), // Pink
      Task('Notes', 12, Icons.note_alt, Color(0xFFF4ACB7)), // Cherry blossom
    ];
    return Scaffold(
      backgroundColor: Color(0xFFFAF0E6),
      appBar: AppBar(
        actionsPadding: EdgeInsets.all(10),

        backgroundColor: Color(0xFF9D8189),
        title: Text(
          'Hello queen,',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),

        actions: [
          Icon(
            Icons.notification_add,
            color: const Color.fromARGB(255, 52, 25, 2),
          ),
          SizedBox(width: 10),
          Icon(Icons.menu, color: const Color.fromARGB(255, 65, 29, 3)),
        ],
      ),
      body: SingleChildScrollView(
        child:
      Container(
        padding: EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Taskcard(task: tasks[0]),
                SizedBox(width: 10),
                Taskcard(task: tasks[1]),
              ],
            ),
            SizedBox(height: 20),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Taskcard(task: tasks[2]),
                SizedBox(width: 10),
                Taskcard(task: tasks[3]),
              ],
            ),
            SizedBox(height: 10),
           Text(
                'Today\'s Task:',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold,
                color: const Color.fromARGB(183, 67, 46, 59)),
              ),
          
            SizedBox(height: 15),
            TCard(
              'Design meeting',
              '10:00 AM',
              Color(0xFFFFE5D9),
              Icons.calendar_today,
            ),
            TCard('Code review', '1:00 PM', Color(0xFFFFF9C4), Icons.code),
            TCard('Write blog post', '3:30 PM', Color(0xFFF8BBD0), Icons.edit),
            TCard(
              'Gym Session',
              '6:00 PM',
              Color(0xFFD1C4E9),
              Icons.fitness_center,
            ),
          ],
        ),
      ),
    )
    );
  }
}
