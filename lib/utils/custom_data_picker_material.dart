import 'package:bank_jago_test/custom_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

// This class contains two mode, CHECKBOX (isMultipleSelection == true) and RADIO BUTTON (isMultipleSelection != true)
// This class can be used only by Material Style
class CustomDataPickerMaterial extends StatefulWidget {
  final Function(dynamic) onDataSelected;
  final String defaultValue;
  final String titleDialogText;
  final String cancelText;
  final String confirmText;
  final List<String> dataSelector;
  final List<String> dataSelected;

  const CustomDataPickerMaterial(
      {Key key,
      this.onDataSelected,
      this.defaultValue,
      this.titleDialogText,
      this.cancelText,
      this.confirmText,
      this.dataSelector,
      this.dataSelected});

  @override
  _CustomDataPickerMaterialState createState() => _CustomDataPickerMaterialState();
}

class _CustomDataPickerMaterialState extends State<CustomDataPickerMaterial> {
  String defaultValue;
  List<String> dataSelected = [];
  List<String> dataSelectedDefault = [];
  @override
  void initState() {
    super.initState();
    defaultValue = widget.defaultValue;
    dataSelected.addAll(widget.dataSelected);
    dataSelectedDefault.addAll(widget.dataSelected);
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(widget.titleDialogText),
      scrollable: true,
      content: Container(
        height: 300,
        width: MediaQuery.of(context).size.width - 80,
        child: CustomRadioButton(
          dataSelector: widget.dataSelector,
          defaultValue: defaultValue,
          onDataSelected: (value) {
            defaultValue = value;
            setState(() {});
          },
        ),
      ), // This contains RADIO BUTTON
      actions: [
        TextButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: Text(widget.cancelText),
        ),
        TextButton(
          onPressed: () {
            debugPrint('setState on done button defaultValue : ${defaultValue.toString()}');
            Navigator.pop(context, defaultValue);
          },
          child: Text(
            widget.confirmText,
          ),
        ),
      ],
    );
  }
}
