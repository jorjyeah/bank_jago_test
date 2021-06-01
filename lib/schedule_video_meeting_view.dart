import 'package:bank_jago_test/custom_widget.dart';
import 'package:flutter/material.dart';

class ScheduleVideoMeetingView extends StatefulWidget {
  final Function(bool isPossibleNext) canNext;

  const ScheduleVideoMeetingView({Key key, this.canNext}) : super(key: key);

  @override
  _ScheduleVideoMeetingViewState createState() => _ScheduleVideoMeetingViewState();
}

class _ScheduleVideoMeetingViewState extends State<ScheduleVideoMeetingView> {
  final formKey = GlobalKey<FormState>();

  DateTime dateSelected;
  DateTime timeSelected;

  @override
  void initState() {
    super.initState();
    dateSelected = DateTime.now();
    timeSelected = DateTime(dateSelected.year, dateSelected.month, dateSelected.day, dateSelected.hour, 0);
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: Scaffold(
        backgroundColor: Color(0x7F231F20),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Stack(
                  children: [
                    Container(
                      height: 56,
                      width: 56,
                      child: Icon(Icons.calendar_today_rounded),
                      decoration: BoxDecoration(shape: BoxShape.circle, color: Colors.grey),
                    ),
                    Container(
                      height: 48,
                      width: 48,
                      child: Icon(Icons.calendar_today_rounded),
                      decoration: BoxDecoration(shape: BoxShape.circle, color: Colors.white),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: Text(
                    "Schedule Video Call",
                    style: TextStyle(fontSize: 20.0, color: Colors.white),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: Text(
                    "Choose the date and time that you prefered, we will send a link via email to make a video call on the scheduled date and time.",
                    style: TextStyle(fontSize: 16.0, color: Colors.white),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 8.0),
                  child: CustomTextFormFieldDatePicker(
                      cancelText: "Cancel",
                      confirmText: "Confirm",
                      hintText: "- Choose Date -",
                      labelText: "Date",
                      initialDate: dateSelected,
                      onUpdateData: (selectedDate) {
                        print(selectedDate);
                        setState(() {
                          timeSelected =
                              DateTime(dateSelected.year, dateSelected.month, dateSelected.day, dateSelected.hour, 0);
                        });
                      },
                      mode: "date"),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 8.0),
                  child: CustomTextFormFieldDatePicker(
                      cancelText: "Cancel",
                      confirmText: "Confirm",
                      hintText: "- Choose Time -",
                      labelText: "Time",
                      initialDate: timeSelected,
                      onUpdateData: (selectedDate) {
                        print(selectedDate);
                      },
                      mode: "time"),
                ),
              ],
            ),
          ),
        ),
        bottomNavigationBar: Container(
            padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
            height: 56,
            width: double.infinity,
            child: MaterialButton(
              elevation: 0.0,
              onPressed: null,
              color: Colors.blue,
              disabledColor: Colors.white,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
              child: Text("Next"),
            )),
      ),
    );
  }
}
