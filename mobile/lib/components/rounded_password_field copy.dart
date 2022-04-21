import 'package:cakrawala_mobile/components/text_field_container.dart';
import 'package:cakrawala_mobile/constants.dart';
import "package:flutter/material.dart";

class RoundedPasswordField extends StatefulWidget {
  final ValueChanged<String> onChanged;
  const RoundedPasswordField({
    Key? key,
    required this.onChanged,
  }) : super(key: key);

  @override
  RoundedPasswordFieldState createState() => RoundedPasswordFieldState();
}

class RoundedPasswordFieldState extends State<RoundedPasswordField> {
  bool _isVisible = false;

  void handleVisibility() {
    setState(() {
      _isVisible = !_isVisible;
    });
  }

  @override
  Widget build(BuildContext context) {
    return TextFieldContainer(
        child: TextField(
      obscureText: _isVisible ? false : true,
      onChanged: widget.onChanged,
      style: TextStyle(color: Colors.white),
      decoration: InputDecoration(
          hintText: "Password",
          hintStyle: TextStyle(color: Colors.white),
          icon: Icon(
            Icons.lock,
            color: primaryColor,
          ),
          suffixIcon: IconButton(
            onPressed: () => handleVisibility(),
            splashColor: Colors.transparent,
            highlightColor: Colors.transparent,
            icon: Icon(
              _isVisible ? Icons.visibility : Icons.visibility_off,
              color: primaryColor,
            ),
          ),
          border: InputBorder.none),
    ));
  }
}
