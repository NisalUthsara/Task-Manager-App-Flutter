import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:task_manager_app_flutter/theme.dart';
import 'package:task_manager_app_flutter/widgets/todo_card.dart';

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

  final Map<String, List<String>> _allTasks = {
    'MONDAY': [],
    'TUESDAY': [],
    'WEDNESDAY': [],
    'THURSDAY': [],
    'FRIDAY': [],
    'SATURDAY': [],
    'SUNDAY': [],
  };

  void _handleAddTask(String day, String newTask) {
    setState(() {
      _allTasks[day]?.add(newTask);
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
            // --- Header ---
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

            // --- Responsive Stack Area ---
            Expanded(
              child: LayoutBuilder(
                builder: (context, constraints) {
                  double availableHeight = constraints.maxHeight;

                  //Calculate offset to ensure all 7 cards fit exactly in the space
                  //divide by slightly more than card count to leave a gap at the top.
                  double verticalOffset = availableHeight / (_cardCount + 1);

                  //Dynamic card heights based on screen size
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

    final List<String> tasksForThisDay = _allTasks[currentDayName] ?? [];

    double reversedIndex = (_cardCount - 1 - index).toDouble();
    double bottomPosition = reversedIndex * verticalOffset;

    // If a card is expanded, push cards above it further up.
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
                            onAddTask: (newTask) {
                              _handleAddTask(currentDayName, newTask);
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
