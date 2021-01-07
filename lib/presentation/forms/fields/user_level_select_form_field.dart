import 'package:flutter/material.dart';

import '../../../core/utils/user_level.dart';

class UserLevelSelectFormField extends StatefulWidget {
  final void Function(UserLevel) onChanged;
  final UserLevel value;
  const UserLevelSelectFormField({
    Key key,
    @required this.onChanged,
    this.value = const UserLevel.na(),
  }) : super(key: key);

  @override
  UserLevelSelectFormFieldState createState() =>
      UserLevelSelectFormFieldState();
}

class UserLevelSelectFormFieldState extends State<UserLevelSelectFormField> {
  UserLevel _level;

  @override
  void initState() {
    super.initState();
    _level = widget.value;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: DropdownButton<UserLevel>(
        dropdownColor: Theme.of(context).colorScheme.surface,
        value: _level,
        iconSize: 24,
        elevation: 16,
        underline: Container(
          height: 1,
          color: Colors.grey,
        ),
        onChanged: (value) {
          setState(() {
            _level = value;
            widget.onChanged(value);
          });
        },
        items: List<DropdownMenuItem<UserLevel>>.generate(
          UserLevel.maxLevel + 1,
          (index) {
            final level = UserLevel(index);
            return DropdownMenuItem<UserLevel>(
              value: level,
              child: Text(level.toString()),
            );
          },
          growable: false,
        ),
      ),
    );
  }

  void reset() {
    setState(() {
      _level = const UserLevel.na();
    });
  }
}
