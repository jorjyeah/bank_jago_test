import 'package:bank_jago_test/helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'extension.dart';

class PasswordView extends StatefulWidget {
  final Function(bool isPossibleNext) canNext;

  const PasswordView({Key key, this.canNext}) : super(key: key);

  @override
  _PasswordViewState createState() => _PasswordViewState();
}

class _PasswordViewState extends State<PasswordView> {
  final formKey = GlobalKey<FormState>();
  bool hidePassword = true;
  List<String> passwordComplexityMessages = ["Very Weak", "Weak", "Strong"];
  int passwordComplexityValue = 0;
  List<Color> passwordComplexityColors = [Colors.red, Colors.orangeAccent, Colors.green];
  bool isContainLowercase = false;
  bool isContainUppercase = false;
  bool isContainNumber = false;
  bool isContainChar = false;

  void togglePassword() {
    setState(() {
      hidePassword = !hidePassword;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: Scaffold(
        backgroundColor: Color(0x7F231F20),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: Text(
                  "Create Password",
                  style: TextStyle(fontSize: 32.0, color: Colors.white),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: Text(
                  "Password will be used to login to account",
                  style: TextStyle(fontSize: 16.0, color: Colors.white),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: TextFormField(
                  inputFormatters: [
                    FilteringTextInputFormatter.deny(RegExp('[ ]')),
                  ],
                  onChanged: (value) {
                    print(value);
                    print("contain lowerCase ${value.isContainLowercase()}");
                    print("contain upperCase ${value.isContainUppercase()}");
                    print("contain number ${value.isContainNumber()}");
                    print("contain char ${value.isContainChar()}");
                    setState(() {
                      isContainLowercase = value.isContainLowercase();
                      isContainUppercase = value.isContainUppercase();
                      isContainNumber = value.isContainNumber();
                      isContainChar = value.isContainChar();
                    });
                  },
                  // validator: (value) {
                  //   print(value.isContainLowercase());
                  //   // return value.isEmail().message;
                  // },
                  obscureText: hidePassword,
                  keyboardType: TextInputType.visiblePassword,
                  decoration: InputDecoration(
                    suffixIcon: IconButton(
                      icon: hidePassword ? Icon(Icons.visibility) : Icon(Icons.visibility_off),
                      onPressed: togglePassword,
                    ),
                    hintText: "Password",
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
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      "Complexity: ",
                      style: TextStyle(color: Colors.white, fontSize: 16),
                    ),
                    Text(
                      passwordComplexityMessages[passwordComplexityValue],
                      style: TextStyle(color: passwordComplexityColors[passwordComplexityValue], fontSize: 16),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        isContainLowercase
                            ? checkIcon(context)
                            : Text(
                                "a",
                                style: TextStyle(fontSize: 32, color: Colors.white),
                              ),
                        Text(
                          "Lowercase",
                          style: TextStyle(color: Colors.white),
                        ),
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        isContainUppercase
                            ? checkIcon(context)
                            : Text(
                                "A",
                                style: TextStyle(fontSize: 32, color: Colors.white),
                              ),
                        Text(
                          "Uppercase",
                          style: TextStyle(color: Colors.white),
                        ),
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        isContainNumber
                            ? checkIcon(context)
                            : Text(
                                "123",
                                style: TextStyle(fontSize: 32, color: Colors.white),
                              ),
                        Text(
                          "Number",
                          style: TextStyle(color: Colors.white),
                        ),
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        isContainChar
                            ? checkIcon(context)
                            : Text(
                                "9+",
                                style: TextStyle(fontSize: 32, color: Colors.white),
                              ),
                        Text(
                          "Character",
                          style: TextStyle(color: Colors.white),
                        ),
                      ],
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
        bottomNavigationBar: Container(
            padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
            height: 56,
            width: double.infinity,
            child: MaterialButton(
              elevation: 0.0,
              onPressed: (isContainLowercase && isContainUppercase && isContainNumber && isContainChar)
                  ? () {
                      print("next");
                      widget.canNext(true);
                    }
                  : null,
              color: Colors.blue,
              disabledColor: Colors.white,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
              child: Text("Next"),
            )),
      ),
    );
  }
}
