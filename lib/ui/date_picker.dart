import 'package:calendar_timeline/calendar_timeline.dart';
import 'package:flutter/material.dart';
import 'package:useful_useless_app/ui/global/google_maps_widget.dart';




class DatePicker extends StatefulWidget {
  @override
  _DatePickerState createState() => _DatePickerState();
}

class _DatePickerState extends State<DatePicker> {

  DateTime _selectedDate;

  @override
  void initState() {
    super.initState();
    _resetSelectedDate();
  }

  void _resetSelectedDate() {
    _selectedDate = DateTime.now();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF333A47),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            CalendarTimeline(
              initialDate: _selectedDate,
              firstDate: DateTime(2020, 10, 15),
              lastDate: DateTime(2040,12,31),
              onDateSelected: (date) {
                setState(() {
                  _selectedDate = date;
                });
              },
              leftMargin: 20,
              monthColor: Colors.white70,
              dayColor: Colors.teal[200],
              dayNameColor: Color(0xFF333A47),
              activeDayColor: Colors.white,
              activeBackgroundDayColor: Colors.redAccent[100],
              dotsColor: Color(0xFF333A47),
            ),
            SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.only(left: 16),
              child: FlatButton(
                color: Colors.teal[200],
                child: Text('RESET', style: TextStyle(color: Color(0xFF333A47))),
                onPressed: () => setState(() => _resetSelectedDate()),
              ),
            ),
            SizedBox(height: 20),
            Center(child: Text('Selected date is $_selectedDate', style: TextStyle(color: Colors.white))),
            GoogleMapsWidget()
          ],
        ),
      ),

    );
  }
}

// import 'package:date_picker_timeline/date_picker_timeline.dart';
// import 'package:flutter/material.dart';
//
//
//
// class DatePicker2 extends StatefulWidget {
//   DatePicker2({Key key}) : super(key: key);
//
//   @override
//   _DatePicker2State createState() => _DatePicker2State();
// }
//
// class _DatePicker2State extends State<DatePicker2> {
//   final DatePickerController _controller = DatePickerController();
//
//   DateTime _selectedValue = DateTime.now();
//
//
//   @override
//   void initState() {
//     super.initState();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         floatingActionButton: FloatingActionButton(
//           child: Icon(Icons.replay),
//           onPressed: () {
//             _controller.animateToSelection();
//           },
//         ),
//
//         body: Container(
//           padding: EdgeInsets.all(20.0),
//           color: Colors.blueGrey[100],
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: <Widget>[
//               Text('You Selected:'),
//               Padding(
//                 padding: EdgeInsets.all(10),
//               ),
//               Text(_selectedValue.toString()),
//               Padding(
//                 padding: EdgeInsets.all(20),
//               ),
//               Container(
//                 child: DatePicker(
//                   DateTime.now(),
//                   width: 60,
//                   height: 80,
//                   controller: _controller,
//                   initialSelectedDate: DateTime.now(),
//                   selectionColor: Colors.black,
//                   selectedTextColor: Colors.white,
//
//                   onDateChange: (date) {
//                     // New date selected
//                     setState(() {
//                       _selectedValue = date;
//                     });
//                   },
//                 ),
//               ),
//             ],
//           ),
//         ));
//   }
// }