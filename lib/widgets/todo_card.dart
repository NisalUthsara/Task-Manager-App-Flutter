import 'package:flutter/material.dart';

class TodoCard extends StatelessWidget {
  final bool isMarked;

  const TodoCard({super.key, required this.isMarked});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.orange,
      child: Padding(
        padding: EdgeInsetsGeometry.all(20),
        child: ListTile(
          leading: Checkbox(value: isMarked, onChanged: (value) {}),
          title: Text(
            'Your task name',
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
