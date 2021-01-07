import 'package:flutter/material.dart';
import 'package:styled_widget/styled_widget.dart';

import 'form_title.dart';

class FormContainer extends StatelessWidget {
  final Widget form;
  const FormContainer(this.form, {Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) => Stack(
        alignment: Alignment.topCenter,
        children: [
          SizedBox(child: form.padding(top: 30))
              .decorated(
                color: Colors.white,
                border: Border.all(
                  color: Colors.grey.shade500,
                ),
                borderRadius: BorderRadius.all(Radius.circular(15)),
              )
              .padding(top: 26),
          LoginFormTitle()
        ],
      )
          .padding(horizontal: 10)
          .constrained(
            minHeight: 250,
            maxHeight: 380,
            minWidth: constraints.maxWidth,
          )
          .center(),
    );
  }
}
