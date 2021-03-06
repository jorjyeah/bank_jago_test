import 'package:bank_jago_test/helper.dart';
import 'package:flutter/material.dart';
import 'extension.dart';

class EmailView extends StatefulWidget {
  final Function(bool isPossibleNext) canNext;

  const EmailView({Key key, this.canNext}) : super(key: key);
  @override
  _EmailViewState createState() => _EmailViewState();
}

class _EmailViewState extends State<EmailView> {
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: Scaffold(
        backgroundColor: Colors.blueAccent,
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: Text(
                "Welcome to\nGIN Finans",
                style: TextStyle(fontSize: 32.0, color: Colors.white),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: Text(
                "Welcome to The Bank of The Future.\nManage and track your accounts on the go",
                style: TextStyle(fontSize: 16.0, color: Colors.white),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: TextFormField(
                validator: (value) {
                  return value.isEmail().message;
                },
                decoration: InputDecoration(
                  prefixIcon: Icon(Icons.email),
                  hintText: "Email",
                  hintStyle: TextStyle(color: Color(0x7F231F20)),
                  enabledBorder: const OutlineInputBorder(
                    borderSide: const BorderSide(color: Colors.transparent, width: 0),
                    borderRadius: BorderRadius.all(
                      Radius.circular(6.0),
                    ),
                  ),
                  focusedBorder: const OutlineInputBorder(
                    borderSide: const BorderSide(color: Colors.blueAccent, width: 2),
                    borderRadius: BorderRadius.all(
                      Radius.circular(6.0),
                    ),
                  ),
                  errorBorder: const OutlineInputBorder(
                    borderSide: const BorderSide(color: Colors.redAccent, width: 2),
                    borderRadius: BorderRadius.all(
                      Radius.circular(6.0),
                    ),
                  ),
                  filled: true,
                  fillColor: Color(0xFFF6F8FB),
                ),
              ),
            ),
          ],
        ),
        bottomNavigationBar: Container(
            padding: EdgeInsets.symmetric(vertical: 8.0),
            height: 56,
            width: double.infinity,
            child: MaterialButton(
              elevation: 0.0,
              onPressed: () {
                if (formKey.currentState.validate()) {
                  print("next");
                  widget.canNext(true);
                } else {
                  print("not next");
                  widget.canNext(false);
                }
              },
              color: Colors.white,
              disabledColor: Colors.white60,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
              child: Text("Next"),
            )),
      ),
    );
  }
}
