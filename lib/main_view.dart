import 'package:bank_jago_test/email_view.dart';
import 'package:bank_jago_test/password_view.dart';
import 'package:bank_jago_test/personal_info_view.dart';
import 'package:bank_jago_test/progress_indicator_widget.dart';
import 'package:bank_jago_test/schedule_video_meeting_view.dart';
import 'package:flutter/material.dart';

class MainView extends StatefulWidget {
  @override
  _MainViewState createState() => _MainViewState();
}

class _MainViewState extends State<MainView> {
  PageController pageController = PageController(initialPage: 0);

  PageView pageView;

  @override
  void initState() {
    pageView = PageView(
      controller: pageController,
      scrollDirection: Axis.horizontal,
      children: [
        EmailView(),
        PasswordView(),
        PersonalInfoView(),
        ScheduleVideoMeetingView(),
      ],
    );
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueAccent,
      appBar: AppBar(
        title: Text("Create Account"),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ProgressIndicatorWidget(),
          Expanded(child: pageView),
        ],
      ),
      bottomNavigationBar: Container(
          padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
          height: 56,
          width: double.infinity,
          child: MaterialButton(
            elevation: 0.0,
            onPressed: () {},
            color: Colors.white,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            child: Text("Next"),
          )),
    );
  }
}
