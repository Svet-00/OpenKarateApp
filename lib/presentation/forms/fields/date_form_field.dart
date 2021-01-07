import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'styled_text_form_field.dart';

class DateFormField extends StatefulWidget {
  final DateTime initialDate;
  final String placeholder;
  final String errorText;
  final String Function(String) validator;
  final void Function(DateTime) onSave;
  DateFormField({
    Key key,
    this.placeholder,
    this.errorText,
    this.validator,
    this.onSave,
    this.initialDate,
  }) : super(key: key);

  @override
  DateFormFieldState createState() => DateFormFieldState();
}

class DateFormFieldState extends State<DateFormField> {
  final now = DateTime.now();
  final dateFormat = DateFormat('dd.M.y');
  DateTime _date;
  TextEditingController _dateTextController;

  @override
  void initState() {
    _date = widget.initialDate ?? now;
    _dateTextController = TextEditingController(
      text: _date != now ? dateFormat.format(_date) : null,
    );
    super.initState();
  }

  @override
  void dispose() {
    _dateTextController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return StyledTextFormField(
      onTap: () async => await _selectDate(context),
      placeholder: widget.placeholder,
      errorText: widget.errorText,
      controller: _dateTextController,
      validator: widget.validator,
      readonly: true,
      onSaved: (_) {
        widget.onSave?.call(_date);
      },
    );
  }

  void reset() {
    setState(() {
      _date = DateTime.now();
      _dateTextController.text = '';
    });
  }

  Future<void> _selectDate(
    BuildContext context,
  ) async {
    // TODO: add iOS style date picker
    try {
      _date = await showDatePicker(
            context: context,
            firstDate: DateTime(1950),
            lastDate: DateTime.now(),
            initialDate: _date,
            selectableDayPredicate: (day) => day.isBefore(now),
            useRootNavigator: false,
          ) ??
          _date;
      setState(() {
        _dateTextController.text = dateFormat.format(_date);
      });
    } catch (e) {
      print(e);
    }
  }
}
