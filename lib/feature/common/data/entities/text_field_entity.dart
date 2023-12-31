import 'package:flutter/material.dart';
import 'package:form_validator/form_validator.dart';

class TextFieldEntity {
  TextEditingController textController;
  String hint;
  String label;
  bool isEnabled;
  bool isPassword;
  TextInputType keyboardType;
  bool? isAutofocus;
  TextInputAction? textInputAction;
  FocusNode? focusNode;
  String? Function(String?)? validator;

  TextFieldEntity({
    required this.textController,
    required this.hint,
    this.label = "",
    this.isPassword = false,
    this.isEnabled = true,
    this.isAutofocus = false,
    this.keyboardType = TextInputType.text,
    this.textInputAction = TextInputAction.next,
    this.focusNode,
    this.validator,
  }) {
    // ValidationBuilder.setLocale('id');
  }

  //* Challenge
  static final List<TextFieldEntity> challenge = [
    TextFieldEntity(
      textController: TextEditingController(text: ''),
      hint: "Judul Challenge",
      label: "Judul Challenge",
      focusNode: FocusNode(),
      validator: (value) {
        return ValidationBuilder().maxLength(40).build().call(value);
      },
    ),
    TextFieldEntity(
      textController: TextEditingController(text: ''),
      hint: "Deskripsi Challenge",
      label: "Deskripsi Challenge",
      keyboardType: TextInputType.multiline,
      textInputAction: TextInputAction.newline,
      focusNode: FocusNode(),
      validator: (value) {
        return ValidationBuilder()
            .required()
            .maxLength(500)
            .build()
            .call(value);
      },
    ),
  ];
}
