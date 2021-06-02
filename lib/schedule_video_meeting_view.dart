import 'package:bank_jago_test/custom_widget.dart';
import 'package:flutter/material.dart';

class ScheduleVideoMeetingView extends StatefulWidget {
  final Function(bool isPossibleNext) canNext;

  const ScheduleVideoMeetingView({Key key, this.canNext}) : super(key: key);

  @override
  _ScheduleVideoMeetingViewState createState() => _ScheduleVideoMeetingViewState();
}

class _ScheduleVideoMeetingViewState extends State<ScheduleVideoMeetingView> with TickerProviderStateMixin {
  final formKey = GlobalKey<FormState>();

  DateTime dateSelected;
  DateTime timeSelected;

  AnimationController animationController;
  Animation<double> animation;

  @override
  void initState() {
    super.initState();
    dateSelected = DateTime.now();
    timeSelected = DateTime(dateSelected.year, dateSelected.month, dateSelected.day, dateSelected.hour, 0);
    animationController = AnimationController(duration: const Duration(milliseconds: 1000), vsync: this)
      ..forward()
      ..repeat(reverse: true);
    animation = CurvedAnimation(parent: animationController, curve: Curves.bounceInOut);
  }

  bool isNextButtonDisabled() {
    if (dateSelected != null && timeSelected != null) {
      if (dateSelected.isAfter(DateTime.now()) && timeSelected.isAfter(DateTime.now())) {
        return true;
      } else {
        return false;
      }
    } else {
      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: Scaffold(
        backgroundColor: Colors.blueAccent,
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: 72,
                width: 72,
                child: Stack(
                  children: [
                    Align(
                      alignment: Alignment.center,
                      child: AnimatedBuilder(
                        animation: animationController,
                        builder: (context, child) {
                          return Container(
                            height: 72 * animationController.value,
                            width: 72 * animationController.value,
                            decoration: BoxDecoration(shape: BoxShape.circle, color: Colors.white.withOpacity(0.4)),
                          );
                        },
                      ),
                    ),
                    Align(
                      alignment: Alignment.center,
                      child: Container(
                        height: 48,
                        width: 48,
                        child: Icon(
                          Icons.calendar_today_rounded,
                          color: Colors.blueAccent,
                        ),
                        decoration: BoxDecoration(shape: BoxShape.circle, color: Colors.white),
                      ),
                    ),
                  ],
                ),
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
                    firstDate: DateTime.now().subtract(Duration(minutes: 30)),
                    lastDate: DateTime(2100),
                    onUpdateData: (selectedDate) {
                      print("choose date $selectedDate");
                      setState(() {
                        dateSelected = selectedDate;
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
                    firstDate: DateTime.now(),
                    lastDate: DateTime(2100),
                    onUpdateData: (selectedDate) {
                      print("Choose Time $selectedDate");
                      setState(() {
                        dateSelected = selectedDate;
                        timeSelected = selectedDate;
                      });
                    },
                    mode: "time"),
              ),
            ],
          ),
        ),
        bottomNavigationBar: Container(
            padding: EdgeInsets.symmetric(vertical: 8.0),
            height: 56,
            width: double.infinity,
            child: MaterialButton(
              elevation: 0.0,
              onPressed: isNextButtonDisabled != null && isNextButtonDisabled()
                  ? () {
                      print("next");
                      widget.canNext(true);
                    }
                  : null,
              color: Colors.white,
              disabledColor: Colors.white60,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
              child: Text("Next"),
            )),
      ),
    );
  }
}
