import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'Repository/Termin.dart';

class NewCourseTermin extends StatefulWidget {
  const NewCourseTermin({super.key});

  @override
  State<StatefulWidget> createState() => _NewCourseTerminState();
}

class _NewCourseTerminState extends State<NewCourseTermin> {
  // ignore: non_constant_identifier_names
  final _CourseNameController = TextEditingController();
  // ignore: non_constant_identifier_names
  final _TerminDateController = TextEditingController();
  // ignore: non_constant_identifier_names
  final _TerminTimeController = TextEditingController();

  late LatLng _selectedLocation;

  @override
  void initState() {
    super.initState();
    _selectedLocation = LatLng(41.9981, 21.4254);
  }

  void _onMapCreated(GoogleMapController controller) {
    setState(() {
      // Center the map initially at (0, 0)
      _selectedLocation = LatLng(41.9981, 21.4254);
    });
  }

  void _selectLocation(LatLng position) {
    setState(() {
      _selectedLocation = position;
    });
  }

  void _submitTermin() async {
    DateTime pickedDateTime = DateTime(
      DateTime.parse(_TerminDateController.text).year,
      DateTime.parse(_TerminDateController.text).month,
      DateTime.parse(_TerminDateController.text).day,
      TimeOfDay.fromDateTime(DateTime.parse(_TerminTimeController.text)).hour,
      TimeOfDay.fromDateTime(DateTime.parse(_TerminTimeController.text)).minute,
    );

    await TerminDatabaseHelper.instance.addTermin(
      Termin(
        course_name: _CourseNameController.text,
        termin_date: pickedDateTime.toIso8601String(),
        created_by: 1,
        latitude: _selectedLocation.latitude,
        longitude: _selectedLocation.longitude,
      ),
    );

    setState(() {
      _CourseNameController.clear();
      _TerminDateController.clear();
      _TerminTimeController.clear();
      _selectedLocation = LatLng(41.9981, 21.4254);
    });

    Navigator.of(context).pop();
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8),
      child: Column(
        children: [
          TextField(
            controller: _CourseNameController,
            decoration: const InputDecoration(labelText: "Enter Course Name"),
            onSubmitted: (_) => _submitTermin(),
          ),
          TextField(
            controller: _TerminDateController,
            decoration: const InputDecoration(labelText: "Enter termin date"),
            onSubmitted: (_) => _submitTermin(),
            onTap: () async {
              DateTime? pickedDate = await showDatePicker(
                context: context,
                initialDate: DateTime.now(),
                firstDate: DateTime(2000),
                lastDate: DateTime(2101),
              );
              if (pickedDate != null) {
                String formattedDate = DateFormat('yyyy-MM-dd').format(pickedDate);
                setState(() {
                  _TerminDateController.text = formattedDate;
                });
              } else {
                print("Date is not selected");
              }
            },
          ),
          TextField(
            controller: _TerminTimeController,
            decoration: const InputDecoration(labelText: "Enter termin time"),
            onSubmitted: (_) => _submitTermin(),
            onTap: () async {
              TimeOfDay? pickedTime = await showTimePicker(
                initialTime: TimeOfDay.now(),
                context: context,
              );
              if (pickedTime != null) {
                DateTime parsedTime = DateFormat.jm().parse(pickedTime.format(context));
                String formattedTime = DateFormat('HH:mm:ss').format(parsedTime);
                setState(() {
                  _TerminTimeController.text = formattedTime;
                });
              } else {
                print("Time is not selected");
              }
            },
          ),
          ElevatedButton(
            onPressed: _submitTermin,
            child: const Text("Create new termin"),
          ),
          SizedBox(height: 20),
          Expanded(
            child: GoogleMap(
              onMapCreated: _onMapCreated,
              initialCameraPosition: CameraPosition(
                target: _selectedLocation,
                zoom: 14.0,
              ),
              markers: Set<Marker>.of([
                Marker(
                  markerId: MarkerId('selected_location'),
                  position: _selectedLocation,
                  draggable: true,
                  onDragEnd: _selectLocation,
                ),
              ]),
            ),
          ),
        ],
      ),
    );
  }
}