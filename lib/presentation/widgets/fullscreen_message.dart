import 'package:flutter/material.dart';

class FullscreenMessage extends StatelessWidget {
  final String message;
  const FullscreenMessage(
    this.message, {
    Key key,
  })  : assert(message != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16),
      child: Center(
        child: Text(message),
      ),
    );
  }
}
