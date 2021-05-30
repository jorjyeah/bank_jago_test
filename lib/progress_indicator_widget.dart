import 'package:flutter/material.dart';

class ProgressIndicatorWidget extends StatefulWidget {
  @override
  _ProgressIndicatorWidgetState createState() => _ProgressIndicatorWidgetState();
}

class _ProgressIndicatorWidgetState extends State<ProgressIndicatorWidget> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 20.0),
      child: Stack(
        children: [
          Positioned.fill(
            child: Divider(
              thickness: 4.0,
              color: Colors.black87,
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            mainAxisSize: MainAxisSize.max,
            children: List.generate(4, (index) {
              return OutlinedButton(
                onPressed: () {},
                child: Text(
                  '${index + 1}',
                  style: TextStyle(color: Colors.black87),
                ),
                style: OutlinedButton.styleFrom(
                  backgroundColor: Colors.white,
                  shape: CircleBorder(),
                  side: BorderSide(width: 4, color: Colors.black87),
                  padding: EdgeInsets.all(24),
                ),
              );
            }),
          ),
        ],
      ),
    );
  }
}
