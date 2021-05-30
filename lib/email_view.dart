import 'package:flutter/material.dart';

class EmailView extends StatefulWidget {
  @override
  _EmailViewState createState() => _EmailViewState();
}

class _EmailViewState extends State<EmailView> {
  TextEditingController textController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 20.0),
          child: Text(
            "Welcome to\nGIN Finans",
            style: TextStyle(fontSize: 32.0),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 20.0),
          child: Text(
            "Welcome to The Bank of The Future.\nManage and track your accounts on the go",
            style: TextStyle(fontSize: 16.0),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 20.0),
          child: TextField(
            decoration: InputDecoration(
              prefixIcon: Icon(Icons.email),
              hintText: "Email",
              errorText: "Please input valid email",
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
    );
  }
}
