import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class GenderSelectionWidget extends StatefulWidget {
  final String? gender;
  final ValueChanged<String>? onChanged;
  final double? size;
  const GenderSelectionWidget(
      {Key? key, this.gender, this.onChanged, this.size})
      : super(key: key);

  @override
  GenderSelectionWidgetState createState() => GenderSelectionWidgetState();
}

class GenderSelectionWidgetState extends State<GenderSelectionWidget> {
  String? _selectedGender;

  @override
  void initState() {
    super.initState();
    _selectedGender = widget.gender;
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Transform.scale(
          scale: widget.size ?? 1 / 10.r,
          child: Radio(
            value: 'Nam',
            groupValue: _selectedGender,
            onChanged: (value) {
              setState(() {
                _selectedGender = value.toString();
                if (widget.onChanged != null) {
                  widget.onChanged!(value.toString());
                }
              });
            },
            activeColor: Colors.blue,
          ),
        ),
        Text(
          tr('sign_up.gender.male'),
          style: TextStyle(
            fontSize: 16,
            color: Colors.grey[800],
          ),
        ),
        SizedBox(width: 0.4.sw),
        Transform.scale(
          scale: widget.size ?? 1 / 1.r,
          child: Radio(
            value: 'Nữ',
            groupValue: _selectedGender,
            onChanged: (value) {
              setState(() {
                _selectedGender = value.toString();
                if (widget.onChanged != null) {
                  widget.onChanged!(value.toString());
                }
              });
            },
            activeColor: Colors.pink,
          ),
        ),
        Text(
          tr('sign_up.gender.female'),
          style: TextStyle(
            fontSize: 16,
            color: Colors.grey[800],
          ),
        ),
      ],
    );
  }
}
