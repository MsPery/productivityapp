import 'package:flutter/material.dart';
import 'package:prodigy/calendar.dart';
import 'package:prodigy/main.dart';

class SchedulePage extends StatefulWidget {
  @override
  _SchedulePageState createState() => _SchedulePageState();
}

class _SchedulePageState extends State<SchedulePage> {
  List<Map<String, String>> _schedule = [
    {"title": "Wake Up", "time": "8:00 AM"},
    {"title": "Breakfast", "time": "8:30 AM"},
    {"title": "Exercise", "time": "9:30 AM"},
    {"title": "Meeting", "time": "10:30 AM"},
    {"title": "Lunch", "time": "12:00 PM"},
    {"title": "Project Work", "time": "1:00 PM"},
    {"title": "Study", "time": "3:00 PM"},
    {"title": "Dinner", "time": "6:00 PM"},
    {"title": "Relaxation", "time": "8:00 PM"},
  ];

  void _addSchedule() async {
    final TextEditingController titleController = TextEditingController();
    final TextEditingController timeController = TextEditingController();
    DateTime _selectedDate = DateTime.now();
    TimeOfDay _selectedTime = TimeOfDay.now();

    await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Add Schedule"),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: titleController,
              decoration: InputDecoration(
                hintText: "Title",
              ),
            ),
            SizedBox(height: 16),
            TextField(
              controller: timeController,
              decoration: InputDecoration(
                hintText: "Time",
              ),
              onTap: () async {
                TimeOfDay? picked = await showTimePicker(
                  context: context,
                  initialTime: _selectedTime,
                );

                if (picked != null) {
                  _selectedTime = picked;
                  timeController.text = picked.format(context);
                }
              },
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () async {
                DateTime? picked = await showDatePicker(
                  context: context,
                  initialDate: _selectedDate,
                  firstDate: DateTime(_selectedDate.year, 1, 1),
                  lastDate: DateTime(_selectedDate.year, 12, 31),
                );

                if (picked != null) {
                  _selectedDate = picked;
                }
              },
              child: Text("Select Date"),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text("Cancel"),
          ),
          ElevatedButton(
            onPressed: () {
              setState(() {
                _schedule.add({
                  "title": titleController.text,
                  "time": timeController.text,
                  "date": _selectedDate.toString(),
                });
              });
              Navigator.pop(context);
            },
            child: Text("Save"),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: Text("Schedule"),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/images/mockbg.jpg'),
              fit: BoxFit.cover,
              colorFilter: ColorFilter.mode(
                Colors.black.withOpacity(0.75),
                BlendMode.dstATop,
              ),
            ),
          ),
          child: _schedule.isEmpty
              ? Center(
                  child: Text(
                  "No Schedules",
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ))
              : ListView.builder(
                  itemCount: _schedule.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      title: 
                      Text(
                        _schedule[index]["title"] ?? "",
                        style: TextStyle(color: Colors.white),
                        ),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            _schedule[index]["time"] ?? "",
                            style: TextStyle(color: Colors.white),
                            ),
                          Text(
                            _schedule[index]["date"] ?? "",
                            style: TextStyle(color: Colors.white),
                            ),
                        ],
                      ),
                    );
                  },
                )),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Color(0x44aaaaff),
        elevation: 0,
        currentIndex: 0,
        onTap: (index) {
          switch (index) {
            case 0:
              break;
            case 1:
              Navigator.popUntil(
                context,
                ModalRoute.withName('/'),
              ); // Go back to the root route
              Navigator.pushNamed(context, '/calendar');
              break;
            case 2:
              Navigator.popUntil(
                context,
                ModalRoute.withName('/'),
              ); // Go back to the root route
              Navigator.pushNamed(context, '/tasks');
              break;
          }
    },
        
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.schedule, color: Colors.purpleAccent),
            label: 'My schedule',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.calendar_today, color: Colors.purpleAccent),
            label: 'Calendar',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.list, color: Colors.purpleAccent),
            label: 'Tasks',
          ),
        ],
      ),
      // ignore: dead_code
    );
  }
}
