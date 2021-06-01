import 'package:flutter/material.dart';

class CustomRadioButton extends StatefulWidget {
  final Function(String) onDataSelected;
  final String defaultValue;
  final List<String> dataSelector;

  const CustomRadioButton({Key key, this.onDataSelected, this.defaultValue, this.dataSelector}) : super(key: key);

  @override
  _CustomRadioButtonState createState() => _CustomRadioButtonState();
}

class _CustomRadioButtonState extends State<CustomRadioButton> {
  String groupValue;
  @override
  void initState() {
    super.initState();
    groupValue = widget.defaultValue;
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      scrollDirection: Axis.vertical,
      physics: ScrollPhysics(),
      itemBuilder: (context, index) {
        return RadioListTile(
          // toggleable: true,
          title: Text(widget.dataSelector[index]),
          value: widget.dataSelector[index],
          groupValue: groupValue,
          onChanged: (value) {
            setState(() {
              groupValue = value;
              debugPrint('setState on RadioListTile ${value.toString()}');
            });
            widget.onDataSelected(value);
          },
        );
      },
      itemCount: widget.dataSelector.length,
    );
  }
}
