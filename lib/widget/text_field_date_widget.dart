import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TextFieldDateWidget extends StatefulWidget {
  final TextEditingController controller;
  final Widget? icon;
  final InputDecoration? inputDecoration;
  final String hintText;
  final String? labelText;
  final String requiredText;
  final bool? isDense;
  final InputBorder? inputBorder;
  const TextFieldDateWidget(
      {Key? key,
      required this.controller,
      this.icon,
      this.inputDecoration,
      required this.hintText,
      this.labelText,
      required this.requiredText,
      this.isDense,
      this.inputBorder})
      : super(key: key);

  @override
  State<TextFieldDateWidget> createState() => _TextFieldDateWidgetState();
}

class _TextFieldDateWidgetState extends State<TextFieldDateWidget> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      decoration: InputDecoration(
          border: widget.inputBorder,
          isDense: widget.isDense,
          icon: widget.icon,
          hintText: widget.hintText,
          labelText: widget.labelText,
          fillColor: Colors.blue.shade200),
      validator: (value) {
        if (value!.isEmpty) {
          return widget.requiredText;
        }
        return null;
      },
      readOnly: true,
      onTap: () async {
        DateTime? pickedDate = await showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime(1930),
            lastDate: DateTime(2100));

        if (pickedDate != null) {
          String formattedDate = DateFormat('yyyy-MM-dd').format(pickedDate);

          setState(() {
            widget.controller.text = formattedDate;
          });
        }
      },
    );
  }
}
