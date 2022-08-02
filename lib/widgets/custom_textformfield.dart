import 'package:flutter/material.dart';

class CustomTextFormField extends StatelessWidget {
  final String? hintText;
  final FormFieldValidator<String>? validator;
  final FormFieldSetter<String>? onSaved;
  final TextEditingController? controller;
  const CustomTextFormField(
      {Key? key, this.hintText, this.validator, this.onSaved, this.controller})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextFormField(
          validator: validator,
          onSaved: onSaved,
          controller: controller,
          decoration: InputDecoration(
            hintText: hintText,
            enabledBorder: const OutlineInputBorder(),
            focusedBorder: const OutlineInputBorder(),
          ),
        ),
        const SizedBox(height: 20),
      ],
    );
  }
}
