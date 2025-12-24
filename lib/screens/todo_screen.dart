import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:task_manager_app_flutter/theme.dart';
import 'package:task_manager_app_flutter/widgets/todo_card.dart';
import 'package:task_manager_app_flutter/utils/task.dart';

class TodoScreen extends StatefulWidget {
  const TodoScreen({super.key});

  @override
  State<TodoScreen> createState() => _TodoScreenState();
}

class _TodoScreenState extends State<TodoScreen> {
  int? _expandedIndex;

  final int _cardCount = 7;

  final List<String> _cardNames = [
    'MONDAY',
    'TUESDAY',
    'WEDNESDAY',
    'THURSDAY',
    'FRIDAY',
    'SATURDAY',
    'SUNDAY',
  ];

  Map<String, List<Task>> allTask = {
    'MONDAY': [],
    'TUESDAY': [],
    'WEDNESDAY': [],
    'THURSDAY': [],
    'FRIDAY': [],
    'SATURDAY': [],
    'SUNDAY': [],
  };

  void _handleAddTask(String day, String taskName) {
    setState(() {
      allTask[day]?.add(Task(name: taskName, isCompleted: false));
    });
  }

  @override
  Widget build(BuildContext context) {
    DateTime now = DateTime.now();
    String readableYear = DateFormat('yyyy').format(now);
    String readableDate = DateFormat('MMMM dd').format(now);
    int weekNumber = ((now.day - 1) / 7).floor() + 1;

    return Scaffold(
      backgroundColor: AppTheme.primaryBlack,
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        bottom: false,
        child: Column(
          children: [
            SizedBox(
              height: 110,
              width: double.infinity,
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Text(
                  '$readableYear, \n$readableDate, Week $weekNumber',
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    color: AppTheme.secondaryLightGray,
                    fontWeight: FontWeight.bold,
                    fontSize: 28,
                  ),
                ),
              ),
            ),

            Expanded(
              child: LayoutBuilder(
                builder: (context, constraints) {
                  double availableHeight = constraints.maxHeight;
                  double verticalOffset = availableHeight / (_cardCount + 1);
                  double standardHeight = availableHeight * 0.20;
                  double expandedHeight = availableHeight * 0.45;

                  return GestureDetector(
                    onTap: () => setState(() => _expandedIndex = null),
                    child: Stack(
                      alignment: Alignment.bottomCenter,
                      clipBehavior: Clip.none,
                      children: List.generate(_cardCount, (index) {
                        return _buildResponsiveCard(
                          index,
                          verticalOffset,
                          standardHeight,
                          expandedHeight,
                        );
                      }),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildResponsiveCard(
    int index,
    double verticalOffset,
    double standardHeight,
    double expandedHeight,
  ) {
    final bool isExpanded = (index == _expandedIndex);
    final String currentDayName = _cardNames[index];
    final List<Task> tasksForThisDay = allTask[currentDayName] ?? [];

    double reversedIndex = (_cardCount - 1 - index).toDouble();
    double bottomPosition = reversedIndex * verticalOffset;

    if (_expandedIndex != null && index < _expandedIndex!) {
      bottomPosition += (expandedHeight - standardHeight);
    }

    return AnimatedPositioned(
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
      bottom: bottomPosition,
      left: 0,
      right: 0,
      height: isExpanded ? expandedHeight : standardHeight,
      child: GestureDetector(
        onTap: () {
          setState(() {
            _expandedIndex = (_expandedIndex == index) ? null : index;
          });
        },
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeInOut,
          margin: const EdgeInsets.symmetric(horizontal: 10),
          decoration: BoxDecoration(
            color: isExpanded
                ? AppTheme.primaryOrange
                : AppTheme.secondaryDarkGray,
            borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.3),
                blurRadius: 10,
                offset: const Offset(0, -5),
              ),
            ],
          ),
          child: Container(
            width: double.infinity,
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  _cardNames[index],
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: isExpanded
                        ? AppTheme.secondaryDarkGray
                        : AppTheme.primaryOrange,
                  ),
                ),
                if (isExpanded) ...[
                  const SizedBox(height: 20),
                  Expanded(
                    child: Column(
                      children: [
                        const SizedBox(height: 10),
                        Expanded(
                          child: TodoCard(
                            taskName: currentDayName,
                            tasks: tasksForThisDay,
                            onAddTask: (newTaskName) {
                              _handleAddTask(currentDayName, newTaskName);
                            },
                            onToggleTask: (index) {
                              setState(() {
                                var task = allTask[currentDayName]![index];
                                task.isCompleted = !task.isCompleted;
                              });
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }
}
