import 'package:flutter/material.dart';
import './course.dart';

class NewCourseTermin extends StatefulWidget {
  final Function addItem;
  final int termin_id;
  NewCourseTermin(this.addItem, this.termin_id);
  @override
  State<StatefulWidget> createState() => _NewCourseTerminState();
}
class _NewCourseTerminState extends State<NewCourseTermin> {
  final _CourseNameController = TextEditingController();
  final _TerminDateController = TextEditingController();
  void _submitData() {
    if (_CourseNameController.text.isEmpty) {
      return;
    }
    final enteredName = _CourseNameController.text;
    final enteredTermin = _TerminDateController.text;
    final newItem = Course(widget.termin_id,enteredName, DateTime.parse(enteredTermin));
    widget.addItem(newItem);
    Navigator.of(context).pop();
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(8),
      child: Column(
        children: [
          TextField(
            controller: _CourseNameController,
            decoration: const InputDecoration(labelText: "Enter Course Name"),
            onSubmitted: (_) => _submitData(),
          ),
          TextField(
            controller: _TerminDateController,
            decoration: const InputDecoration(labelText: "Enter termin in following format '2023-01-01 12:00:00'"),
            onSubmitted: (_) => _submitData(),
          ),
          ElevatedButton(onPressed: _submitData, child: const Text("Create"))
        ],
      ),
    );
  }
}
