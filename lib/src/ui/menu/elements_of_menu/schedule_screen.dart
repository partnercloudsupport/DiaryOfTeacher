import 'package:diary_of_teacher/src/ui/menu/elements_of_menu//drawer.dart';
import 'package:flutter/material.dart';


class ScheduleScreen extends StatefulWidget {
  _ScheduleState createState() => _ScheduleState();
}

class _ScheduleState extends State<ScheduleScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Расписание'),
      ),
      body: Container(

      ),
      drawer: MenuDrawer(),
    );
  }
}