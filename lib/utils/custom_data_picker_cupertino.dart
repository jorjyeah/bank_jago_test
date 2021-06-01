import 'dart:core';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomDataPickerCupertino extends StatefulWidget {
  final String titleDialogText;
  final String cancelText;
  final String confirmText;
  final List<String> dataSelector;
  final String defaultValue;
  final List<String> multipleDataSelected;

  const CustomDataPickerCupertino(
      {Key key,
      this.titleDialogText,
      this.cancelText,
      this.confirmText,
      this.dataSelector,
      this.defaultValue,
      this.multipleDataSelected})
      : super(key: key);

  @override
  _CustomDataPickerCupertinoState createState() => _CustomDataPickerCupertinoState();
}

class _CustomDataPickerCupertinoState extends State<CustomDataPickerCupertino> {
  String defaultValue = '';
  List<String> multipleDataSelected = [];

  @override
  void dispose() {
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    defaultValue = widget.defaultValue;
    multipleDataSelected.addAll(widget.multipleDataSelected ?? []);
  }

  List<Widget> widgetSelector(List<String> dataSelector) {
    List<Widget> widgets;
    widgets = dataSelector.map((data) => Text(data)).toList();
    return widgets;
  }

  @override
  Widget build(BuildContext context) {
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
              Text(widget.titleDialogText),
              Spacer(),
              MaterialButton(
                elevation: 0.0,
                child: Text(widget.confirmText),
                color: Colors.transparent,
                textColor: Colors.black,
                onPressed: () {
                  debugPrint('setState on done button groupValue : ${defaultValue.toString()}');
                  Navigator.pop(context, defaultValue);
                },
              ),
            ],
          ),
        ),
        Container(
          height: MediaQuery.of(context).copyWith().size.height / 5,
          color: Colors.white,
          child: CupertinoPicker(
            scrollController: FixedExtentScrollController(initialItem: widget.dataSelector.indexOf(defaultValue)),
            backgroundColor: Colors.white,
            onSelectedItemChanged: (value) {
              defaultValue = widget.dataSelector[value];
              setState(() {});
              debugPrint('setState on onSelectedItemChanged Data Picker iOS ${value.toString()}');
            },
            itemExtent: 32.0,
            children: widgetSelector(widget.dataSelector),
          ),
        ),
      ],
    );
  }
}
