import 'package:flutter/material.dart';

class TodoCard extends StatelessWidget {
  final String title;
  final bool isMarked;
  final VoidCallback onToggle;
  final VoidCallback onDelete;

  const TodoCard({
    super.key,
    required this.title,
    required this.isMarked,
    required this.onToggle,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: isMarked ? Colors.green : Colors.orange,
      child: Padding(
        padding: EdgeInsets.all(20),
        child: ListTile(
          leading: Checkbox(value: isMarked, onChanged: (_) => onToggle()),
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
            onPressed: () => {onDelete()},
          ),
        ),
      ),
    );
  }
}
