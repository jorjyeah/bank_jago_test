import 'package:bank_jago_test/confirmation_view.dart';
import 'package:bank_jago_test/email_view.dart';
import 'package:bank_jago_test/helper.dart';
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
  PageController pageController;

  PageView pageView;
  int pageSelected = 0;

  @override
  void initState() {
    pageController = PageController(initialPage: pageSelected);
    pageView = PageView(
      controller: pageController,
      pageSnapping: true,
      physics: NeverScrollableScrollPhysics(),
      scrollDirection: Axis.horizontal,
      children: [
        EmailView(
          canNext: (value) {
            goToNextPage(1, value);
          },
        ),
        PasswordView(
          canNext: (value) {
            goToNextPage(2, value);
          },
        ),
        PersonalInfoView(
          canNext: (value) {
            goToNextPage(3, value);
          },
        ),
        ScheduleVideoMeetingView(
          canNext: (value) {
            goToNextPage(4, value);
          },
        ),
        ConfirmationView(),
      ],
    );
    super.initState();
  }

  void goToNextPage(int page, bool value) {
    print("next $value");
    if (value) {
      setState(() {
        pageSelected = page;
      });
      pageController.animateToPage(page, duration: durationDefault, curve: curveDefaults);
    }
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
        leading: Theme.of(context).platform == TargetPlatform.android
            ? Icon(Icons.arrow_back_rounded)
            : Icon(Icons.arrow_back_ios_rounded),
        centerTitle: false,
        title: Text("Create Account"),
      ),
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              IndexSelectedInherited(
                data: pageSelected,
                child: ProgressIndicatorWidget(
                  indexSelected: (value) {
                    setState(() {
                      pageSelected = value;
                    });
                    pageController.animateToPage(value, duration: durationDefault, curve: curveDefaults);
                  },
                ),
              ),
              Expanded(child: pageView),
            ],
          ),
        ),
      ),
    );
  }
}

class IndexSelectedInherited extends InheritedWidget {
  final int data;

  IndexSelectedInherited({
    Widget child,
    this.data,
  }) : super(child: child);

  @override
  bool updateShouldNotify(IndexSelectedInherited oldWidget) => data != oldWidget.data;
  static IndexSelectedInherited of(BuildContext context) =>
      context.dependOnInheritedWidgetOfExactType<IndexSelectedInherited>();
}
