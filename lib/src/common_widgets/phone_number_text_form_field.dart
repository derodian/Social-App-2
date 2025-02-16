// lib/widgets/phone_number_field.dart
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:social_app_2/src/utils/phone_number_formatter.dart';
import 'package:social_app_2/src/utils/phone_number_validator.dart';

class PhoneNumberTextFormField extends StatefulWidget {
  final void Function(String) onChanged;
  final String? initialValue;
  final String? Function(String?)? validator;
  final bool isRequired;
  final bool requireUSFormat;
  final String label;
  final String hint;
  final TextEditingController? controller;
  final FocusNode? focusNode; // Add focus node
  final VoidCallback? onEditingComplete; // Add editing complete callback
  final TextInputAction? textInputAction; // Add text input action

  const PhoneNumberTextFormField({
    super.key,
    required this.onChanged,
    this.initialValue,
    this.validator,
    this.isRequired = true,
    this.requireUSFormat = true,
    this.label = 'Phone Number',
    this.hint = '(123) 456-7890',
    this.controller,
    this.focusNode,
    this.onEditingComplete,
    this.textInputAction = TextInputAction.next,
  });

  @override
  State<PhoneNumberTextFormField> createState() => _PhoneNumberFieldState();
}

class _PhoneNumberFieldState extends State<PhoneNumberTextFormField> {
  late TextEditingController _controller;
  late FocusNode _focusNode;
  bool _isValid = false;

  @override
  void initState() {
    super.initState();
    _controller = widget.controller ?? TextEditingController();
    _focusNode = widget.focusNode ?? FocusNode();
    _controller.text = widget.initialValue ?? '';
    _validatePhoneNumber(_controller.text);
  }

  @override
  void dispose() {
    if (widget.controller == null) {
      _controller.dispose();
    }
    if (widget.focusNode == null) {
      _focusNode.dispose();
    }
    super.dispose();
  }

  void _validatePhoneNumber(String value) {
    final cleanPhone = value.replaceAll(RegExp(r'[\s\-\(\)]'), '');
    setState(() {
      if (widget.requireUSFormat) {
        _isValid = PhoneNumberValidator.isValidUSPhone(cleanPhone);
      } else {
        _isValid = PhoneNumberValidator.isValidPhone(cleanPhone);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: _controller,
      focusNode: _focusNode,
      keyboardType: TextInputType.phone,
      textInputAction: widget.textInputAction,
      onEditingComplete: () {
        if (_isValid) {
          widget.onEditingComplete?.call();
        }
      },
      decoration: InputDecoration(
        labelText: widget.label,
        hintText: widget.hint,
        prefixIcon: const Icon(Icons.phone),
        suffixIcon: _controller.text.isNotEmpty
            ? Icon(
                _isValid ? Icons.check_circle : Icons.error,
                color: _isValid ? Colors.green : Colors.red,
              )
            : null,
        border: const OutlineInputBorder(),
      ),
      inputFormatters: [
        FilteringTextInputFormatter.digitsOnly,
        PhoneNumberFormatter(),
      ],
      onChanged: (value) {
        _validatePhoneNumber(value);
        widget.onChanged(value);
      },
      validator: widget.validator ??
          (value) => PhoneNumberValidator.validatePhone(
                value,
                requireUSFormat: widget.requireUSFormat,
              ),
    );
  }
}
