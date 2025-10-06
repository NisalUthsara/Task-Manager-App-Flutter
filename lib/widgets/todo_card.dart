import 'package:flutter/material.dart';

class TodoCard extends StatelessWidget {
  final String title;
  final bool isMarked;

  const TodoCard({super.key, required this.isMarked, required this.title});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.orange,
      child: Padding(
        padding: EdgeInsets.all(20),
        child: ListTile(
          leading: Checkbox(value: isMarked, onChanged: (value) {}),
          title: Text(
            title,
            style: TextStyle(
              fontSize: 16,
              decoration: isMarked
                  ? TextDecoration.lineThrough
                  : TextDecoration.none,
            ),
          ),
          trailing: IconButton(
            icon: const Icon(Icons.delete, color: Colors.redAccent, size: 25),
            onPressed: () => {},
          ),
        ),
      ),
    );
  }
}
