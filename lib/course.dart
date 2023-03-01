import 'package:flutter/foundation.dart';

class Course {
  int course_id  = -1;
  String course_name = '';
  DateTime termin_date = DateTime.now();

  Course(int id, this.course_name, this.termin_date){
    course_id = id;
  }

  @override
  String toString() {
    return "id: $course_id -> $course_name $termin_date";
  }
}