import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

import 'myEvent.dart';

class MyCalendar extends StatelessWidget {
  final List<MyEvent> events;
  const MyCalendar({super.key, required this.events});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          Row(
            children: [
              Padding(
                  padding: const EdgeInsets.fromLTRB(10, 2, 0, 10),
                  child: ElevatedButton(
                    onPressed: () => {Navigator.of(context).pop()},
                    child: const Text("Go Back"),
                  )),
            ],
          ),
          Expanded(
            child: SfCalendar(
              view: CalendarView.month,
              dataSource: MyEventDataSource(events),
              monthViewSettings: const MonthViewSettings(
                  appointmentDisplayMode:
                      MonthAppointmentDisplayMode.appointment),
            ),
          ),
        ],
      ),
    );
  }
}
