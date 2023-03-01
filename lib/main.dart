import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import './course.dart';
import './add_new_elem.dart';
void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});



  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Termins',
      theme: ThemeData(
        primarySwatch: Colors.orange,
      ),
      home: MyHomePage(title: 'Termins'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  int auto_increment_value = 2;
  MyHomePage({super.key, required this.title});
  String title;
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
   void _addItemFunction(BuildContext ct) {
    showModalBottomSheet(
        context: ct,
        builder: (_) {
          return GestureDetector(onTap: () {}, child: NewCourseTermin(_addNewTerminToList,widget.auto_increment_value), behavior: HitTestBehavior.opaque);
        });
      widget.auto_increment_value +=1;
  }
  void _addNewTerminToList(Course new_course_termin) {
    setState(() {
      this.courses.add(new_course_termin);
    });
  }
  List<Course> courses = [
    Course(1, "Computer Networks", DateTime.parse("2023-03-26 12:30:00")),
    Course(2, "Structured Programming", DateTime.parse("2023-03-27 14:45:00"))
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(child: Icon(Icons.add),onPressed: () =>print(this.courses.toString()),),
      appBar: AppBar(
        title: Text(widget.title),
        actions: [
          IconButton(onPressed: () => _addItemFunction(context), icon: Icon(Icons.add),tooltip: "Create new termin",),
        ],
      ),
      body: ListView.builder(
        itemCount: this.courses.length,
        itemBuilder: (ctx,index){
          return Card(
            margin: EdgeInsets.all(10),
            elevation: 5,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  margin: EdgeInsets.all(15),
                  child: Text(
                    courses.elementAt(index).course_name,
                    style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold,color: Theme.of(ctx).primaryColorLight),
                  ),
                ),
                Container(
                  child: Text("Date: ${DateFormat.yMMMMEEEEd().format(courses.elementAt(index).termin_date)} Time: ${DateFormat.jm().format(courses.elementAt(index).termin_date)}")
                )
              ],
            ),
          );
        },
      ),
    );
  }
}
