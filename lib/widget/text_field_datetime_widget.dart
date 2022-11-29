import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:intl/intl.dart';

class TextFieldDateTimeWidget extends StatefulWidget {
  final TextEditingController controller;
  final Widget? icon;
  final InputDecoration? inputDecoration;
  final String hintText;
  final String? labelText;
  final String requiredText;
  final bool? isDense;
  final InputBorder? inputBorder;
  const TextFieldDateTimeWidget(
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
  State<TextFieldDateTimeWidget> createState() =>
      _TextFieldDateTimeWidgetState();
}

class _TextFieldDateTimeWidgetState extends State<TextFieldDateTimeWidget> {
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
        DatePicker.showDateTimePicker(context,
            showTitleActions: true,
            minTime: DateTime(DateTime.now().year, 1, 1, 7, 0),
            maxTime: DateTime(DateTime.now().year, 12, 31, 18, 60),
            onChanged: (date) {
          String formattedDate = DateFormat('yyyy-MM-ddThh:mm:ss').format(date);
          setState(() {
            widget.controller.text = formattedDate;
          });
        }, onConfirm: (date) {
          String formattedDate = DateFormat('yyyy-MM-ddThh:mm:ss').format(date);
          setState(() {
            widget.controller.text = formattedDate;
          });
        }, currentTime: DateTime.now(), locale: LocaleType.en);
      },
    );
  }
}
