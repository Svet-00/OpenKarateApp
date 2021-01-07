import 'package:flutter/material.dart';

class StyledRaisedButton extends StatelessWidget {
  final String title;
  final VoidCallback onPressed;
  final bool _computeSize;
  final double _fontSize;

  const StyledRaisedButton({
    Key key,
    @required this.title,
    @required this.onPressed,
  })  : _computeSize = false,
        _fontSize = 16,
        super(key: key);

  const StyledRaisedButton.large({
    Key key,
    @required this.title,
    @required this.onPressed,
  })  : _computeSize = true,
        _fontSize = 20,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final width = _computeSize
        ? size.width > 320
            ? 270
            : 200
        : null;
    final height = _computeSize
        ? size.height > 600
            ? 70
            : 50
        : null;
    final text = Padding(
      padding: EdgeInsets.symmetric(vertical: 10),
      child: Text(
        title,
        style: TextStyle(
          fontSize: _fontSize,
        ),
      ),
    );
    return ElevatedButton(
      onPressed: onPressed,
      child: Container(
        width: width?.toDouble(),
        height: height?.toDouble(),
        child: _computeSize ? Center(child: text) : text,
      ),
    );
  }
}
