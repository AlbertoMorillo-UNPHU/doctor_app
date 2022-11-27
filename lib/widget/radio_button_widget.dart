import 'package:flutter/material.dart';

class RadioButtonWidget extends StatefulWidget {
  final Function(bool)? onChanged;
  final bool? generoSelected;
  final String labelText2;
  final String labelText1;
  const RadioButtonWidget(
      {Key? key,
      required this.labelText1,
      required this.labelText2,
      this.onChanged,
      this.generoSelected})
      : super(key: key);

  @override
  State<RadioButtonWidget> createState() => _RadioButtonWidgetState();
}

class _RadioButtonWidgetState extends State<RadioButtonWidget> {
  bool? gender;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if (widget.generoSelected != null) {
      gender = widget.generoSelected;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        RadioListTile(
          title: Text(widget.labelText1),
          value: true,
          groupValue: gender,
          onChanged: (value) {
            widget.onChanged?.call(value!);
            setState(() {
              gender = value;
            });
          },
        ),
        RadioListTile(
          title: Text(widget.labelText2),
          value: false,
          groupValue: gender,
          onChanged: (value) {
            widget.onChanged?.call(value!);
            setState(() {
              gender = value;
            });
          },
        ),
      ],
    );
  }
}
