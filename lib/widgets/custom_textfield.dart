import 'package:flutter/material.dart';
import 'package:fooddelivery_fe/config/colors.dart';
import 'package:fooddelivery_fe/widgets/shake_widget.dart';

class RoundTextfield extends StatefulWidget {
  final TextEditingController controller;
  final Function(String?)? onChanged;
  final String hintText;
  final TextInputType? keyboardType;
  final bool obscureText;
  final Color? bgColor;
  final Widget? left;
  final Icon? icon;
  const RoundTextfield(
      {super.key,
      required this.hintText,
      required this.controller,
      this.keyboardType,
      this.bgColor,
      this.left,
      this.obscureText = false,
      this.onChanged,
      this.icon});

  @override
  State<RoundTextfield> createState() => _RoundTextfieldState();
}

class _RoundTextfieldState extends State<RoundTextfield> {
  final _textFieldErrorShakeKey = GlobalKey<ShakeWidgetState>();
  @override
  void initState() {
    super.initState();
  }

  String? _errorText;
  void checkOnchangedValidate(String? value) {
    setState(() {
      if (value != '' || value != null) {
        _errorText = widget.onChanged?.call(value);
        if (widget.controller.text.isEmpty) {
          _textFieldErrorShakeKey.currentState?.shakeWidget();
        }
      } else {
        _errorText = null;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return ShakeWidget(
      key: _textFieldErrorShakeKey,
      shakeCount: 3,
      shakeOffset: 10,
      shakeDuration: const Duration(milliseconds: 500),
      child: Container(
        decoration: BoxDecoration(
            color: widget.bgColor ?? TextColor.textfield,
            borderRadius: BorderRadius.circular(25)),
        child: Row(
          children: [
            widget.icon != null
                ? Padding(
                    padding: const EdgeInsets.only(left: 10),
                    child: widget.icon)
                : const SizedBox.shrink(),
            if (widget.left != null)
              Padding(
                padding: const EdgeInsets.only(
                  left: 15,
                ),
                child: widget.left!,
              ),
            Expanded(
              child: TextFormField(
                autovalidateMode: AutovalidateMode.onUserInteraction,
                controller: widget.controller,
                obscureText: widget.obscureText,
                keyboardType: widget.keyboardType,
                onChanged: checkOnchangedValidate,
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
                  errorText: _errorText,
                  focusedErrorBorder: const UnderlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.transparent,
                      width: 0,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class RoundTitleTextfield extends StatelessWidget {
  final TextEditingController? controller;
  final String title;
  final String hintText;
  final TextInputType? keyboardType;
  final bool obscureText;
  final Color? bgColor;
  final Widget? left;

  const RoundTitleTextfield(
      {super.key,
      required this.title,
      required this.hintText,
      this.controller,
      this.keyboardType,
      this.bgColor,
      this.left,
      this.obscureText = false});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 55,
      decoration: BoxDecoration(
          color: bgColor ?? TextColor.textfield,
          borderRadius: BorderRadius.circular(25)),
      child: Row(
        children: [
          if (left != null)
            Padding(
              padding: const EdgeInsets.only(
                left: 15,
              ),
              child: left!,
            ),
          Expanded(
            child: Stack(
              children: [
                Container(
                  height: 55,
                  margin: const EdgeInsets.only(
                    top: 8,
                  ),
                  alignment: Alignment.topLeft,
                  child: TextField(
                    autocorrect: false,
                    controller: controller,
                    obscureText: obscureText,
                    keyboardType: keyboardType,
                    decoration: InputDecoration(
                      contentPadding:
                          const EdgeInsets.symmetric(horizontal: 20),
                      enabledBorder: InputBorder.none,
                      focusedBorder: InputBorder.none,
                      hintText: hintText,
                      hintStyle: TextStyle(
                          color: TextColor.placeholder,
                          fontSize: 14,
                          fontWeight: FontWeight.w500),
                    ),
                  ),
                ),
                Container(
                  height: 55,
                  margin: const EdgeInsets.only(top: 10, left: 20),
                  alignment: Alignment.topLeft,
                  child: Text(
                    title,
                    style:
                        TextStyle(color: TextColor.placeholder, fontSize: 11),
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class ProfileInputTextField extends StatefulWidget {
  const ProfileInputTextField({
    Key? key,
    this.hintText,
    this.focusNode,
    this.nextfocusNode,
    this.labelText,
    this.validator,
    required this.controller,
    this.onChanged,
    this.textInputType,
  }) : super(key: key);
  final String? Function(String?)? validator;
  final Function(String?)? onChanged;
  final String? hintText;
  final TextInputType? textInputType;
  final String? labelText;
  final FocusNode? focusNode;
  final FocusNode? nextfocusNode;
  final TextEditingController controller;
  @override
  State<ProfileInputTextField> createState() => _ProfileInputTextFieldState();
}

class _ProfileInputTextFieldState extends State<ProfileInputTextField> {
  late TextEditingController _controller;
  String? _errorText;
  @override
  void initState() {
    super.initState();
    _controller = widget.controller;
  }

  void checkOnchangedValidate(String? value) {
    setState(() {
      if (value != '' || value != null) {
        _errorText = widget.onChanged?.call(value);
      } else {
        _errorText = null;
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      focusNode: widget.focusNode,
      onFieldSubmitted: (value) {
        if (widget.nextfocusNode != null) {
          widget.focusNode?.unfocus();
          FocusScope.of(context).requestFocus(widget.nextfocusNode);
        }
      },
      keyboardType: widget.textInputType,
      onChanged: checkOnchangedValidate,
      validator: widget.validator,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      controller: _controller,
      cursorColor: Colors.black,
      decoration: InputDecoration(
        hintText: widget.hintText,
        labelText: widget.labelText,
        border: InputBorder.none,
        errorText: _errorText,
      ),
    );
  }
}
