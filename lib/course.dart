

class Course {
  // ignore: non_constant_identifier_names
  int course_id = -1;
  // ignore: non_constant_identifier_names
  String course_name = '';
  // ignore: non_constant_identifier_names
  DateTime termin_date = DateTime.now();

  Course(int id, this.course_name, this.termin_date) {
    course_id = id;
  }

  @override
  String toString() {
    return "id: $course_id -> $course_name $termin_date";
  }
}
