import 'package:flutter/material.dart';
import 'package:task_manager_app_flutter/theme.dart';

class TodoCard extends StatefulWidget {
  final String taskName;
  final List<String> tasks;
  final Function(String) onAddTask;

  const TodoCard({
    super.key,
    required this.taskName,
    required this.tasks,
    required this.onAddTask,
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
            labelText: 'Add a task for ${widget.taskName}',
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

        SizedBox(height: 20),

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
                  // BouncingScrollPhysics gives it that nice iOS "spring" feel
                  physics: const BouncingScrollPhysics(),
                  padding: const EdgeInsets.only(
                    bottom: 20,
                  ), // Padding for bottom of list
                  itemCount: widget.tasks.length,
                  itemBuilder: (context, index) {
                    return Container(
                      margin: const EdgeInsets.only(bottom: 12),
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: Colors.black.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Row(
                        children: [
                          Icon(
                            Icons.check_circle_outline,
                            size: 20,
                            color: AppTheme.secondaryDarkGray,
                          ),
                          const SizedBox(width: 10),
                          Expanded(
                            child: Text(
                              widget.tasks[index],
                              style: TextStyle(
                                fontWeight: FontWeight.w600,
                                color: AppTheme.secondaryDarkGray,
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
