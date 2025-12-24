import 'package:flutter/material.dart';
import 'package:task_manager_app_flutter/theme.dart';
import 'package:task_manager_app_flutter/utils/task.dart';

class TodoCard extends StatefulWidget {
  final String taskName;
  final List<Task> tasks;
  final Function(String) onAddTask;
  final Function(int index) onToggleTask;

  const TodoCard({
    super.key,
    required this.taskName,
    required this.tasks,
    required this.onAddTask,
    required this.onToggleTask,
  });

  @override
  State<TodoCard> createState() => _TodoCardState();
}

class _TodoCardState extends State<TodoCard> {
  final TextEditingController _controller = TextEditingController();

  void _submit() {
    if (_controller.text.isEmpty) return;
    widget.onAddTask(_controller.text);
    _controller.clear();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextField(
          controller: _controller,
          style: TextStyle(color: AppTheme.secondaryDarkGray),
          decoration: InputDecoration(
            border: const UnderlineInputBorder(),
            labelText: 'Add a task',
            labelStyle: TextStyle(
              color: AppTheme.secondaryDarkGray.withOpacity(0.6),
            ),
            suffixIcon: IconButton(
              icon: Icon(Icons.add, color: AppTheme.secondaryDarkGray),
              onPressed: _submit,
            ),
          ),
          onSubmitted: (_) => _submit(),
        ),

        const SizedBox(height: 20),

        Expanded(
          child: widget.tasks.isEmpty
              ? Center(
                  child: Text(
                    "No tasks yet",
                    style: TextStyle(
                      color: AppTheme.secondaryDarkGray.withOpacity(0.5),
                    ),
                  ),
                )
              : ListView.builder(
                  physics: const BouncingScrollPhysics(),
                  padding: const EdgeInsets.only(bottom: 20),
                  itemCount: widget.tasks.length,
                  itemBuilder: (context, index) {
                    final task = widget.tasks[index];

                    return Container(
                      margin: const EdgeInsets.only(bottom: 12),
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: Colors.black.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Row(
                        children: [
                          GestureDetector(
                            onTap: () {
                              widget.onToggleTask(index);
                            },
                            child: Icon(
                              task.isCompleted
                                  ? Icons.check_circle
                                  : Icons.circle_outlined,
                              size: 24,
                              color: task.isCompleted
                                  ? AppTheme.secondaryDarkGray
                                  : AppTheme.secondaryDarkGray.withOpacity(0.5),
                            ),
                          ),
                          const SizedBox(width: 10),
                          Expanded(
                            child: Text(
                              task.name,
                              style: TextStyle(
                                fontWeight: FontWeight.w600,
                                color: task.isCompleted
                                    ? AppTheme.secondaryDarkGray.withOpacity(
                                        0.5,
                                      )
                                    : AppTheme.secondaryDarkGray,
                                decoration: task.isCompleted
                                    ? TextDecoration.lineThrough
                                    : null,
                              ),
                            ),
                          ),
                          Text(
                            "Today",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: AppTheme.secondaryDarkGray.withOpacity(
                                0.6,
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
        ),
      ],
    );
  }
}
