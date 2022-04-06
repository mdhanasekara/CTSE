import 'package:flutter/material.dart';
import 'package:CTSE/colors.dart' as color;

class CustomerInputBox extends StatefulWidget {
  final String label;
  final String inputHint;
  final controller;

  const CustomerInputBox(
      {Key? key,
      required this.label,
      required this.inputHint,
      required this.controller})
      : super(key: key);

  @override
  State<CustomerInputBox> createState() => _CustomerInputBoxState();
}

class _CustomerInputBoxState extends State<CustomerInputBox> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Align(
          alignment: Alignment.centerLeft,
          child: Padding(
            padding: const EdgeInsets.only(left: 15.0, bottom: 8),
            child: Text(
              widget.label,
              style:
                  TextStyle(fontSize: 17, color: color.AppColor.formTextColor),
            ),
          ),
        ),
        TextFormField(
          onEditingComplete: () {},
          controller: widget.controller,
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Please Enter the Value';
            }
            return null;
          },
          style: TextStyle(fontSize: 17, color: color.AppColor.formTextColor),
          decoration: InputDecoration(
            hintText: widget.inputHint,
            hintStyle: TextStyle(
              fontSize: 17,
              color: Colors.grey[350],
            ),
            contentPadding: EdgeInsets.symmetric(vertical: 20, horizontal: 25),
            focusColor: color.AppColor.formTextColor,
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(27),
              borderSide: BorderSide(
                //  color: Color(0xff0962ff),
                color: color.AppColor.gradientFirst,
              ),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(27),
              borderSide: BorderSide(
                color: Colors.grey,
              ),
            ),
          ),
        )
      ],
    );
  }
}
