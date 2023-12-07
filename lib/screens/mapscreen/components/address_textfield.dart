import 'package:flutter/material.dart';
import 'package:fooddelivery_fe/config/colors.dart';

class AddressTextField extends StatefulWidget {
  final TextEditingController controller;
  final Function(String?)? onChanged;
  final String hintText;
  final Color? bgColor;
  final Widget? left;

  const AddressTextField(
      {super.key,
      required this.hintText,
      required this.controller,
      this.bgColor,
      this.left,
      this.onChanged});

  @override
  State<AddressTextField> createState() => _AddressTextFieldState();
}

class _AddressTextFieldState extends State<AddressTextField> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: widget.bgColor ?? TextColor.textfield,
          borderRadius: BorderRadius.circular(25)),
      child: Row(
        children: [
          const Padding(
            padding: EdgeInsets.only(left: 10),
            child: Icon(
              Icons.location_on_outlined,
              color: Colors.blue,
              size: 20,
            ),
          ),
          if (widget.left != null)
            Padding(
              padding: const EdgeInsets.only(
                left: 15,
              ),
              child: widget.left!,
            ),
          Expanded(
            child: Container(
              child: TextFormField(
                onChanged: widget.onChanged,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                controller: widget.controller,
                cursorColor: Colors.black,
                decoration: InputDecoration(
                  contentPadding: const EdgeInsets.symmetric(horizontal: 20),
                  enabledBorder: InputBorder.none,
                  focusedBorder: InputBorder.none,
                  errorBorder: InputBorder.none,
                  hintText: widget.hintText,
                  hintStyle: TextStyle(
                      color: TextColor.placeholder,
                      fontSize: 14,
                      fontWeight: FontWeight.w500),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
