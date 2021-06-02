import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class CustomTextFormFieldDatePicker extends StatefulWidget {
  final Function(DateTime) onUpdateData;
  final Function(String) validator;
  final String titleDialogText;
  final String cancelText;
  final String confirmText;
  final String hintText;
  final String mode;
  final DateTime initialDate;
  final DateTime lastDate;
  final DateTime firstDate;
  final DateFormat dateFormat;
  final FocusNode focusNode;
  final String labelText;
  final Icon prefixIcon;
  final Icon suffixIcon;

  CustomTextFormFieldDatePicker({
    Key key,
    this.labelText,
    this.prefixIcon,
    this.suffixIcon,
    this.focusNode,
    @required this.lastDate,
    @required this.firstDate,
    @required this.initialDate,
    @required this.onUpdateData,
    this.validator,
    this.titleDialogText,
    this.cancelText,
    this.confirmText,
    this.hintText,
    @required this.mode,
    this.dateFormat,
  })  : assert(initialDate != null),
        assert(lastDate != null),
        assert(firstDate != null),
        assert(mode != null),
        super(key: key);

  @override
  _CustomTextFormFieldDatePicker createState() => _CustomTextFormFieldDatePicker();
}

class _CustomTextFormFieldDatePicker extends State<CustomTextFormFieldDatePicker> {
  TextEditingController _controllerDate;
  DateFormat _dateFormat;
  DateTime _selectedDate;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 64,
      padding: EdgeInsets.only(top: 12),
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(8), color: Colors.white),
      child: TextFormField(
        validator: widget.validator,
        focusNode: widget.focusNode,
        controller: _controllerDate,
        decoration: InputDecoration(
          suffixIcon: widget.suffixIcon,
          labelText: widget.labelText,
          contentPadding: new EdgeInsets.symmetric(vertical: 16.0, horizontal: 8.0),
          border: const OutlineInputBorder(
            borderSide: BorderSide.none,
            borderRadius: BorderRadius.all(
              Radius.circular(8.0),
            ),
          ),
          fillColor: Colors.white,
          filled: true,
          enabled: true,
          labelStyle: TextStyle(color: Colors.grey),
        ),
        onTap: () {
          selectDate(context);
        },
        readOnly: true,
      ),
    );
  }

  @override
  void initState() {
    super.initState();

    if (widget.dateFormat != null) {
      _dateFormat = widget.dateFormat;
    } else {
      if (widget.mode == "time") {
        _dateFormat = DateFormat.Hm();
      } else {
        _dateFormat = DateFormat('E,d MMMM y');
      }
    }

    _selectedDate = widget.initialDate;

    _controllerDate = TextEditingController();
    _controllerDate.text = widget.hintText;
    // _controllerDate.text = _dateFormat.format(_selectedDate);
  }

  @override
  void dispose() {
    _controllerDate.dispose();
    super.dispose();
  }

  selectDate(BuildContext context) async {
    final ThemeData theme = Theme.of(context);
    assert(theme.platform != null);
    switch (theme.platform) {
      case TargetPlatform.android:
        return buildMaterialDatePicker(context);
      case TargetPlatform.fuchsia:
      case TargetPlatform.linux:
      case TargetPlatform.windows:
        return buildCupertinoDatePicker(context);
      case TargetPlatform.iOS:
      case TargetPlatform.macOS:
        return buildCupertinoDatePicker(context);
    }
  }

  /// This builds material date picker in Android
  buildMaterialDatePicker(BuildContext context) async {
    final DateTime picked = widget.mode == "time"
        ? await showTimePicker(
            context: context,
            confirmText: widget.confirmText ?? "Confirm",
            cancelText: widget.cancelText ?? "Cancel",
            initialTime: TimeOfDay(hour: widget.initialDate.hour, minute: widget.initialDate.minute),
            builder: (context, child) {
              return Theme(
                data: ThemeData.light().copyWith(
                  colorScheme: ColorScheme.light().copyWith(
                    primary: Colors.blueAccent,
                  ),
                ),
                child: child,
              );
            })
        : await showDatePicker(
            context: context,
            initialDate: _selectedDate,
            firstDate: widget.firstDate,
            confirmText: widget.confirmText ?? "Confirm",
            cancelText: widget.cancelText ?? "Cancel",
            fieldLabelText: "Select Date",
            errorFormatText: "Error Format",
            errorInvalidText: "Invalid Date",
            lastDate: widget.lastDate,
            fieldHintText: 'DD/MM/YYYY',
            builder: (context, child) {
              return Theme(
                data: ThemeData.light().copyWith(
                  colorScheme: ColorScheme.light().copyWith(
                    primary: Colors.blueAccent,
                  ),
                ),
                child: child,
              );
            },
          );
    if (picked != null && picked != _selectedDate)
      setState(() {
        _selectedDate = picked;
        widget.onUpdateData(_selectedDate);
      });
  }

  /// This builds cupertion date picker in iOS
  buildCupertinoDatePicker(BuildContext context) {
    showModalBottomSheet(
        isDismissible: true,
        enableDrag: true,
        useRootNavigator: true,
        context: context,
        builder: (BuildContext builder) {
          return Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Container(
                color: Colors.white,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    MaterialButton(
                        elevation: 0.0,
                        child: Text(widget.cancelText),
                        color: Colors.transparent,
                        textColor: Colors.black,
                        onPressed: () {
                          Navigator.pop(context);
                        }),
                    Spacer(),
                    Text(
                      widget.titleDialogText ?? "Select",
                    ),
                    Spacer(),
                    MaterialButton(
                      elevation: 0.0,
                      child: Text(widget.confirmText),
                      color: Colors.transparent,
                      textColor: Colors.black,
                      onPressed: () {
                        _controllerDate.text = _dateFormat.format(_selectedDate);
                        widget.onUpdateData(_selectedDate);
                        debugPrint('setState on done button dateTime formatted : ${_selectedDate.toString()}');
                        Navigator.of(context).pop();
                      },
                    ),
                  ],
                ),
              ),
              Container(
                height: MediaQuery.of(context).copyWith().size.height / 3,
                color: Colors.white,
                child: CupertinoDatePicker(
                  use24hFormat: true,
                  mode: widget.mode == "time" ? CupertinoDatePickerMode.time : CupertinoDatePickerMode.date,
                  onDateTimeChanged: (picked) {
                    if (picked != null && picked != _selectedDate) _selectedDate = picked;
                  },
                  initialDateTime: widget.initialDate,
                  minimumDate: widget.firstDate,
                  maximumDate: widget.lastDate,
                  minimumYear: 1800,
                  maximumYear: 2040,
                ),
              ),
            ],
          );
        });
  }
}
