import 'package:flutter/material.dart';


  class TCard extends StatelessWidget {
  final String title;
  final String time;
  final Color color;
  final IconData icon;

  const TCard(
   this.title,
    this.time,
    this.color,
    this.icon,
   );

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 10),
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, size: 20, color: Colors.grey[800]),
              SizedBox(width: 8),
              Text(
                "Today  ",
                style: TextStyle(color: Colors.grey[800]),
              ),
              Text(
                time,
                style: TextStyle(
                  color: Colors.grey[800],
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          SizedBox(height: 8),
          Text(
            title,
            style: TextStyle(
              fontSize: 16,
              color: Colors.grey[900],
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}