import 'package:flutter/material.dart';
import 'package:styled_widget/styled_widget.dart';

class StyledTextFormField extends StatefulWidget {
  final String initialValue;
  final String placeholder;
  final String errorText;
  final String Function(String) validator;
  final void Function(String) onSaved;
  final bool obscureToggle;
  final void Function() onTap;
  final TextEditingController controller;
  final bool enabled;
  final bool readonly;
  final bool obscureText;

  const StyledTextFormField({
    Key key,
    this.initialValue,
    this.placeholder,
    this.errorText,
    this.validator,
    this.onSaved,
    this.onTap,
    this.controller,
    this.enabled = true,
    this.readonly = false,
    this.obscureToggle = false,
    this.obscureText = false,
  }) : super(key: key);

  @override
  _StyledTextFormFieldState createState() => _StyledTextFormFieldState();
}

class _StyledTextFormFieldState extends State<StyledTextFormField> {
  bool _obscureText = false;
  AutovalidateMode _autovalidateMode = AutovalidateMode.disabled;
  FocusNode focusNode;

  @override
  void initState() {
    super.initState();
    _obscureText = widget.obscureText;
    focusNode = FocusNode();
    focusNode.addListener(() {
      if (focusNode.hasFocus == false) {
        setState(() {
          _autovalidateMode = AutovalidateMode.onUserInteraction;
        });
      }
    });
  }

  @override
  void dispose() {
    focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final field = TextFormField(
      initialValue: widget.initialValue,
      decoration: InputDecoration(
        border: OutlineInputBorder(),
        labelText: widget.placeholder,
        errorText: widget.errorText,
        errorMaxLines: 2,
      ),
      validator: widget.validator,
      onSaved: widget.onSaved,
      obscureText: _obscureText,
      onTap: widget.onTap,
      enabled: widget.enabled,
      readOnly: widget.readonly,
      controller: widget.controller,
      autovalidateMode: _autovalidateMode,
      focusNode: focusNode,
    ).padding(vertical: 8);

    return Container(
      child: widget.obscureToggle
          ? Stack(
              children: [
                field,
                SizedBox(
                  child: IconButton(
                    onPressed: () => setState(
                      () => _obscureText = !_obscureText,
                    ),
                    icon: Icon(
                      _obscureText ? Icons.visibility : Icons.visibility_off,
                    ),
                  ),
                ).padding(top: 15, right: 10).alignment(Alignment.centerRight),
              ],
            )
          : field,
    );
  }
}
