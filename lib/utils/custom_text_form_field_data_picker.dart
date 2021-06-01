import 'package:bank_jago_test/custom_widget.dart';
import 'package:bank_jago_test/utils/custom_data_picker_cupertino.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class CustomTextFormFieldDataPicker extends StatefulWidget {
  final Function(String) validator;
  final Function(dynamic) onUpdateData;
  final List<String> dataSelector;
  final String titleDialogText;
  final String cancelText;
  final String confirmText;
  final FocusNode focusNode;
  final String labelText;
  final Icon prefixIcon;
  final Icon suffixIcon;
  final String defaultTextFieldData;
  final int maxLines;
  final int minLines;

  CustomTextFormFieldDataPicker({
    Key key,
    this.titleDialogText,
    this.cancelText,
    this.confirmText,
    this.validator,
    @required this.dataSelector,
    this.focusNode,
    this.labelText,
    this.prefixIcon,
    this.suffixIcon,
    this.onUpdateData,
    this.defaultTextFieldData,
    this.maxLines,
    this.minLines,
  }) : super(key: key);

  @override
  _CustomTextFormFieldDataPickerState createState() => _CustomTextFormFieldDataPickerState();
  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(StringProperty('defaultTextFieldData', defaultTextFieldData));
  }
}

class _CustomTextFormFieldDataPickerState extends State<CustomTextFormFieldDataPicker> {
  TextEditingController controller;
  String groupValue; // Alert Dialog & Radio Button
  String defaultValue; // Data Picker iOS, not multipleSelection
  List<String> multipleDataSelected = []; // multipleSelection Checkbox
  List<String> multipleDataSelectedDefault = []; // multipleSelection Checkbox Data Default

  @override
  void initState() {
    controller = TextEditingController();
    groupValue = widget.defaultTextFieldData;
    defaultValue = widget.defaultTextFieldData;
    controller.text = widget.defaultTextFieldData;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 64,
      padding: EdgeInsets.only(top: 16),
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(8), color: Colors.white),
      child: TextFormField(
        validator: widget.validator,
        focusNode: widget.focusNode,
        controller: controller,
        minLines: widget.minLines,
        maxLines: widget.maxLines,
        decoration: InputDecoration(
          hintTextDirection: TextDirection.ltr,
          isCollapsed: true,
          suffixIcon: widget.suffixIcon,
          labelText: widget.labelText ?? "Select",
          isDense: true,
          contentPadding: new EdgeInsets.symmetric(vertical: 16.0, horizontal: 8.0),
          enabledBorder: const OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.transparent, width: 0),
            borderRadius: BorderRadius.all(
              Radius.circular(8.0),
            ),
          ),
          focusedBorder: const OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.blueAccent, width: 2),
            borderRadius: BorderRadius.all(
              Radius.circular(8.0),
            ),
          ),
          errorBorder: const OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.redAccent, width: 2),
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
          FocusScope.of(context).unfocus();
          selectData(context);
        },
        readOnly: true,
      ),
    );
  }

  selectData(BuildContext context) async {
    final ThemeData theme = Theme.of(context);
    assert(theme.platform != null);
    switch (theme.platform) {
      case TargetPlatform.android:
        return buildMaterialDataPicker(context);
      case TargetPlatform.fuchsia:
      case TargetPlatform.linux:
      case TargetPlatform.windows:
      case TargetPlatform.iOS:
        return buildCupertinoDataPicker(context);
      case TargetPlatform.macOS:
    }
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  buildMaterialDataPicker(BuildContext context) async {
    final data = await showDialog(
      context: context,
      builder: (context) {
        return CustomDataPickerMaterial(
          defaultValue: groupValue ?? widget.dataSelector.first ?? 'None',
          titleDialogText: widget.titleDialogText ?? "Select",
          cancelText: widget.cancelText ?? "Cancel",
          confirmText: widget.confirmText ?? "Confirm",
          dataSelector: widget.dataSelector ?? [],
          dataSelected: multipleDataSelected,
        );
      },
    );
    processUpdatedData(data);
  }

  void processUpdatedData(dynamic updatedData) {
    String latestData = updatedData ?? defaultValue;
    print('value : $latestData');
    widget.onUpdateData(latestData);
    groupValue = latestData;
    setState(() {});
  }

  buildCupertinoDataPicker(BuildContext context) async {
    final data = await showModalBottomSheet(
        context: context,
        builder: (BuildContext builder) {
          return CustomDataPickerCupertino(
            defaultValue: defaultValue ?? widget.dataSelector.first ?? 'None',
            titleDialogText: widget.titleDialogText ?? "Select",
            cancelText: widget.cancelText ?? "Cancel",
            confirmText: widget.confirmText ?? "Confirm",
            dataSelector: widget.dataSelector ?? [],
          );
        });
    processUpdatedData(data);
  }
}
