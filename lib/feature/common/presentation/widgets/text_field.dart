import 'package:ecohero/feature/feature.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CustomTextFormField extends StatefulWidget {
  const CustomTextFormField({
    Key? key,
    required TextFieldEntity textFieldEntity,
    int maxLines = 1,
    String? Function(String?)? validator,
    List<TextInputFormatter>? formatter,
  })  : _textFieldEntity = textFieldEntity,
        _maxLines = maxLines,
        _validator = validator,
        _formatter = formatter,
        super(key: key);

  final TextFieldEntity _textFieldEntity;
  final int _maxLines;
  final String? Function(String?)? _validator;
  final List<TextInputFormatter>? _formatter;

  @override
  State<CustomTextFormField> createState() => _CustomTextFormFieldState();
}

class _CustomTextFormFieldState extends State<CustomTextFormField> {
  String? _error;
  bool _isObscureText = false;

  @override
  void initState() {
    _isObscureText = widget._textFieldEntity.isPassword;

    widget._textFieldEntity.focusNode?.addListener(() {
      if (widget._textFieldEntity.focusNode?.hasFocus ?? false) {
      } else {
        widget._textFieldEntity.focusNode?.unfocus();
      }
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      autofocus: widget._textFieldEntity.isAutofocus ?? false,
      enabled: widget._textFieldEntity.isEnabled,
      controller: widget._textFieldEntity.textController,
      focusNode: widget._textFieldEntity.focusNode,
      inputFormatters: widget._formatter,
      maxLines: widget._maxLines,
      style: const TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w400,
      ),
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(28),
        ),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 8,
        ),
        hintText: widget._textFieldEntity.hint,
        hintStyle: const TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w400,
        ),
        // errorText: _error?.toUpperCase(),
        // helperText: _error?.toUpperCase(),
        helperStyle: const TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.w400,
        ),
      ),
      textInputAction: widget._textFieldEntity.textInputAction,
      obscureText: _isObscureText,
      keyboardType: widget._textFieldEntity.keyboardType,
      validator: (value) {
        // Note : https://pub.dev/packages/form_validator (documentations)
        _error = _error = widget._validator?.call(value) ??
            widget._textFieldEntity.validator?.call(value);

        WidgetsBinding.instance.addPostFrameCallback((_) {
          setState(() {});
        });

        return _error;
      },
      autovalidateMode: AutovalidateMode.onUserInteraction,
    );
  }
}
