import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class YearCalendar extends StatelessWidget {
  final DateTime? selectedDate;
  final Function(DateTime) onDateSelected;

  const YearCalendar({
    super.key,
    required this.selectedDate,
    required this.onDateSelected,
  });

  @override
  Widget build(BuildContext context) {
    final year = DateTime.now().year;
    final months = List.generate(12, (index) => DateTime(year, index + 1));
    final slivers = <Widget>[];

    for (int i = 0; i < months.length; i += 2) {
      slivers.add(
        SliverToBoxAdapter(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(child: _buildMonthContainer(months[i])),
              if (i + 1 < months.length)
                Expanded(child: _buildMonthContainer(months[i + 1])),
            ],
          ),
        ),
      );
    }

    return CustomScrollView(
      slivers: slivers,
    );
  }

  Widget _buildMonthContainer(DateTime monthDate) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 3, horizontal: 14.0),
      child: SizedBox(
        width: 150,
        height: 160,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              DateFormat('MMMM yyyy').format(monthDate),
              style: const TextStyle(
                color: Colors.blueGrey,
                fontSize: 10,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(height: 4),
            Expanded(
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 7,
                ),
                itemCount:
                    DateUtils.getDaysInMonth(monthDate.year, monthDate.month),
                itemBuilder: (context, index) {
                  final day =
                      DateTime(monthDate.year, monthDate.month, index + 1);
                  bool isToday = DateTime.now().day == day.day &&
                      DateTime.now().month == day.month &&
                      DateTime.now().year == day.year;

                  return GestureDetector(
                    onTap: () {
                      onDateSelected(day);
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color: day == selectedDate
                            ? Colors.orange.withOpacity(0.4)
                            : Colors.transparent,
                        shape: BoxShape.circle,
                      ),
                      child: Center(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              DateFormat('d').format(day),
                              style: const TextStyle(
                                color: Colors.black,
                                fontSize: 10,
                              ),
                            ),
                            if (isToday)
                              Container(
                                margin: const EdgeInsets.only(top: 4),
                                width: 6,
                                height: 6,
                                decoration: const BoxDecoration(
                                  color: Colors.orange,
                                  shape: BoxShape.circle,
                                ),
                              ),
                          ],
                        ),
                      ),
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
}
