import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'Repository/Termin.dart';

import 'Termins.dart';
import 'add_new_elem.dart';
import 'auth.dart';
import 'calendar.dart';
import 'myEvent.dart';

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  void _addItemFunction(BuildContext ct) {
    showModalBottomSheet(
      context: ct,
      builder: (_) {
        return GestureDetector(
          onTap: () {},
          behavior: HitTestBehavior.opaque,
          child: NewCourseTermin(),
        );
      },
    ).whenComplete(() {
      setState(() {});
    });
  }

  void _showCalendar(BuildContext ctx, List<MyEvent> evs) {
    showModalBottomSheet(
      context: ctx,
      builder: (_) {
        return GestureDetector(
          onTap: () {},
          behavior: HitTestBehavior.opaque,
          child: MyCalendar(events: evs),
        );
      },
    );
  }

  List<MyEvent> initEvents() {
    final List<MyEvent> evs = <MyEvent>[];
    List<Termin> termins = TerminHelper.temp;
    print(termins);
    for (var termin in termins) {
      evs.add(MyEvent(termin: termin, c: Theme.of(context).primaryColor));
    }
    return evs;
  }

  @override
  Widget build(BuildContext context) {
    List<MyEvent> myEvents = initEvents();

    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showCalendar(context, myEvents),
        tooltip: "Calendar",
        child: const Icon(Icons.calendar_month),
      ),
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text(widget.title),
        actions: [
          IconButton(
            onPressed: () => _addItemFunction(context),
            icon: const Icon(Icons.add),
            tooltip: "Create new termin",
          ),
          const SizedBox(
            width: 15,
          ),
          IconButton(
            icon: const Icon(Icons.logout),
            tooltip: "Log out",
            onPressed: () {
              print(LoginAuth.isLoggedin);
              LoginAuth.isLoggedin = false;
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (_) => const LoginAuth()),
              );
            },
          ),
        ],
      ),
      body: TerminWidget(events: myEvents),
    );
  }
}