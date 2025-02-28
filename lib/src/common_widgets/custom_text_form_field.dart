import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

// class CustomTextFormField extends StatefulWidget {
//   const CustomTextFormField({
//     super.key,
//     required this.controller,
//     this.textInputType = TextInputType.text,
//     this.labelText,
//     this.hintText,
//     this.errorText,
//     this.isPassword = false,
//     this.isReadOnly = false,
//     this.isEnabled = true,
//     this.autoFocus = false,
//     this.helperText,
//     this.fieldFocusNode,
//     this.nextFocusNode,
//     this.maxLines = 1,
//     this.minLines = 1,
//     this.autovalidateMode,
//     this.validator,
//     this.onChanged,
//     this.onSaved,
//     this.onEditingComplete,
//     this.prefixIcon,
//     this.suffixIcon,
//     this.textCapitalization = TextCapitalization.none,
//     this.textInputAction = TextInputAction.next,
//     this.keyboardAppearance,
//     this.contextMenuBuilder,
//     this.formatters,
//     this.additionalNote,
//     this.enterPressed,
//     this.showValidationStatus = false,
//     this.validationFunction,
//   });

//   final TextEditingController controller;
//   final TextInputType textInputType;
//   final TextCapitalization textCapitalization;
//   final String? labelText;
//   final String? hintText;
//   final String? errorText;
//   final bool isPassword;
//   final bool isReadOnly;
//   final bool isEnabled;
//   final bool autoFocus;
//   final bool showValidationStatus;
//   final String? helperText;
//   final int? maxLines;
//   final int minLines;
//   final FocusNode? fieldFocusNode;
//   final FocusNode? nextFocusNode;
//   final AutovalidateMode? autovalidateMode;
//   final FormFieldValidator<String>? validator;
//   final ValueChanged<String>? onChanged;
//   final FormFieldSetter<String>? onSaved;
//   final VoidCallback? onEditingComplete;
//   final bool Function(String)? validationFunction;
//   final IconData? prefixIcon;
//   final IconData? suffixIcon;
//   final TextInputAction textInputAction;
//   final Brightness? keyboardAppearance;
//   final EditableTextContextMenuBuilder? contextMenuBuilder;
//   final List<TextInputFormatter>? formatters;
//   final String? additionalNote;
//   final Function? enterPressed;

//   @override
//   State<CustomTextFormField> createState() => _CustomTextFormFieldState();
// }

// class _CustomTextFormFieldState extends State<CustomTextFormField> {
//   late bool _obscureText;
//   late String? hintText;
//   bool _isValid = false;
//   bool _isDirty = false;

//   @override
//   void initState() {
//     super.initState();
//     _obscureText = widget.isPassword;
//     hintText = widget.helperText;
//     widget.controller.addListener(_handleControllerChange);
//   }

//   @override
//   void dispose() {
//     widget.controller.removeListener(_handleControllerChange);
//     super.dispose();
//   }

//   void _handleControllerChange() {
//     _updateHintText();
//     _validateField(widget.controller.text);
//   }

//   void _updateHintText() {
//     setState(() {
//       hintText = widget.controller.text.isEmpty ? widget.helperText : null;
//     });
//   }

//   void _validateField(String value) {
//     if (!widget.showValidationStatus) return;

//     setState(() {
//       _isDirty = value.isNotEmpty;
//       if (widget.validationFunction != null) {
//         _isValid = widget.validationFunction!(value);
//       } else if (widget.validator != null) {
//         _isValid = widget.validator!(value) == null;
//       }
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Container(
//           constraints: BoxConstraints(
//             minHeight: 54.0, // Minimum height for the TextFormField
//           ),
//           child: TextFormField(
//             controller: widget.controller,
//             keyboardType: widget.textInputType,
//             textCapitalization: widget.textCapitalization,
//             textInputAction: widget.textInputAction,
//             obscureText: _obscureText,
//             readOnly: widget.isReadOnly,
//             enabled: widget.isEnabled,
//             autocorrect: false,
//             focusNode: widget.fieldFocusNode,
//             autofocus: widget.autoFocus,
//             maxLines: widget.maxLines,
//             minLines: widget.minLines,
//             keyboardAppearance: widget.keyboardAppearance,
//             onFieldSubmitted: (value) {
//               if (widget.nextFocusNode != null) {
//                 widget.nextFocusNode?.requestFocus();
//               } else if (widget.textInputAction == TextInputAction.done) {
//                 if (widget.enterPressed != null) {
//                   widget.enterPressed!();
//                 }
//               }
//             },
//             contextMenuBuilder: widget.contextMenuBuilder ??
//                 (BuildContext context, EditableTextState editableTextState) {
//                   return AdaptiveTextSelectionToolbar.editableText(
//                     editableTextState: editableTextState,
//                   );
//                 },
//             inputFormatters: widget.formatters,
//             autovalidateMode: widget.autovalidateMode,
//             validator: widget.validator,
//             onChanged: widget.onChanged,
//             onSaved: widget.onSaved,
//             onEditingComplete: widget.onEditingComplete,
//             decoration: InputDecoration(
//               labelText: widget.labelText,
//               hintText: widget.hintText,
//               prefixIcon: const Icon(Icons.phone),
//               suffixIcon: _buildSuffixIcon(),
//               border: const OutlineInputBorder(),
//             ),
//           ),
//         ),
//         if (widget.additionalNote != null)
//           Padding(
//             padding: const EdgeInsets.only(top: 8.0),
//             child: Text(
//               widget.additionalNote!,
//               style: TextStyle(
//                 color: Colors.grey[600],
//                 fontSize: 12,
//               ),
//             ),
//           ),
//       ],
//     );
//   }

//   Widget? _buildSuffixIcon() {
//     if (widget.isPassword) {
//       return IconButton(
//         icon: Icon(
//           _obscureText ? Icons.visibility : Icons.visibility_off,
//         ),
//         onPressed: () {
//           setState(() {
//             _obscureText = !_obscureText;
//           });
//         },
//       );
//     }

//     if (widget.showValidationStatus && _isDirty) {
//       return Icon(
//         _isValid ? Icons.check_circle : Icons.error,
//         color: _isValid ? Colors.green : Colors.red,
//       );
//     }

//     if (widget.suffixIcon != null) {
//       return Icon(widget.suffixIcon);
//     }

//     return null;
//   }
// }

class CustomTextFormField extends StatefulWidget {
  final String label;
  final String? hint;
  final String? errorText;
  final String? helperText;
  final String? initialValue;
  final TextInputType keyboardType;
  final Brightness? keyboardAppearance;
  final EditableTextContextMenuBuilder? contextMenuBuilder;
  final TextInputAction textInputAction;
  final bool isPassword;
  final bool isRequired;
  final String? Function(String?)? validator;
  final AutovalidateMode? autovalidateMode;
  final bool Function(String)? validationFunction;
  final void Function(String)? onChanged;
  final FormFieldSetter<String>? onSaved;
  final TextEditingController controller;
  final bool isEnabled;
  final bool isReadOnly;
  final bool autoFocus;
  final bool showValidationStatus;
  final int? maxLength;
  final int maxLines;
  final int minLines;
  final List<TextInputFormatter>? inputFormatters;
  final TextCapitalization textCapitalization;
  final FocusNode? focusNode;
  final VoidCallback? onTap;
  final Widget? prefix;
  final Widget? suffix;
  final String? additionalNote;
  final Function? enterPressed;

  const CustomTextFormField({
    super.key,
    required this.controller,
    required this.label,
    this.hint,
    this.initialValue,
    this.keyboardType = TextInputType.text,
    this.isPassword = false,
    this.isRequired = true,
    this.isEnabled = true,
    this.isReadOnly = false,
    this.autoFocus = false,
    this.showValidationStatus = false,
    this.validator,
    this.onChanged,
    this.maxLength,
    this.maxLines = 1,
    this.minLines = 1,
    this.inputFormatters,
    this.textCapitalization = TextCapitalization.none,
    this.textInputAction = TextInputAction.next,
    this.focusNode,
    this.onTap,
    this.prefix,
    this.suffix,
    this.errorText,
    this.helperText,
    this.keyboardAppearance,
    this.contextMenuBuilder,
    this.autovalidateMode,
    this.validationFunction,
    this.onSaved,
    this.additionalNote,
    this.enterPressed,
  });

  @override
  State<CustomTextFormField> createState() => _CustomTextFormFieldState();
}

class _CustomTextFormFieldState extends State<CustomTextFormField> {
  late bool _obscureText;
  late String? hintText;
  late bool _isFocused;
  bool _isValid = false;
  bool _isDirty = false;

  @override
  void initState() {
    super.initState();
    // debugPrint('isPassword for ${widget.label}: ${widget.isPassword}');
    _obscureText = widget.isPassword;
    _isFocused = true;
    hintText = widget.helperText;
    widget.controller.addListener(_handleControllerChange);
  }

  @override
  void dispose() {
    widget.controller.removeListener(_handleControllerChange);
    super.dispose();
  }

  @override
  void didUpdateWidget(CustomTextFormField oldWidget) {
    super.didUpdateWidget(oldWidget);
    // Ensure _obscureText is synced with widget.isPassword
    if (oldWidget.isPassword != widget.isPassword) {
      setState(() {
        _obscureText = widget.isPassword;
      });
    }
  }

  void _handleControllerChange() {
    _updateHintText();
    _validateField(widget.controller.text);
  }

  void _updateHintText() {
    setState(() {
      hintText = widget.controller.text.isEmpty ? widget.helperText : null;
    });
  }

  void _validateField(String value) {
    if (!widget.showValidationStatus) return;

    setState(() {
      _isDirty = value.isNotEmpty;
      if (widget.validationFunction != null) {
        _isValid = widget.validationFunction!(value);
      } else if (widget.validator != null) {
        _isValid = widget.validator!(value) == null;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.label + (widget.isRequired ? ' *' : ''),
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(height: 8),
        Focus(
          onFocusChange: (hasFocus) {
            setState(() {
              _isFocused = hasFocus;
            });
          },
          child: Container(
            constraints: BoxConstraints(
              minHeight: 54.0, // Minimum height for the TextFormField
            ),
            child: TextFormField(
              controller: widget.controller,
              initialValue: widget.initialValue,
              keyboardType: widget.keyboardType,
              keyboardAppearance: widget.keyboardAppearance,
              textInputAction: widget.textInputAction,
              obscureText: _obscureText,
              readOnly: widget.isReadOnly,
              enabled: widget.isEnabled,
              maxLength: widget.maxLength,
              maxLines: widget.maxLines,
              minLines: widget.minLines,
              inputFormatters: widget.inputFormatters,
              textCapitalization: widget.textCapitalization,
              focusNode: widget.focusNode,
              onTap: widget.onTap,
              onChanged: widget.onChanged,
              onSaved: widget.onSaved,
              autovalidateMode: widget.autovalidateMode,
              validator: widget.validator ??
                  (widget.isRequired
                      ? (value) {
                          if (value == null || value.isEmpty) {
                            return '${widget.label} is required';
                          }
                          return null;
                        }
                      : null),
              contextMenuBuilder: widget.contextMenuBuilder ??
                  (BuildContext context, EditableTextState editableTextState) {
                    return AdaptiveTextSelectionToolbar.editableText(
                      editableTextState: editableTextState,
                    );
                  },
              decoration: InputDecoration(
                hintText: widget.hint,
                prefixIcon: widget.prefix,
                suffixIcon: widget.isPassword
                    ? IconButton(
                        icon: Icon(
                          _obscureText
                              ? Icons.visibility
                              : Icons.visibility_off,
                        ),
                        onPressed: () {
                          setState(() {
                            _obscureText = !_obscureText;
                          });
                        },
                      )
                    : widget.suffix,
                filled: true,
                fillColor: widget.isEnabled
                    ? _isFocused
                        ? Colors.blue.withOpacity(0.1)
                        : Colors.grey.withOpacity(0.1)
                    : Colors.grey.withOpacity(0.05),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide.none,
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide(
                    color: Colors.grey.withOpacity(0.3),
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: const BorderSide(
                    color: Colors.blue,
                    width: 2,
                  ),
                ),
                errorBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: const BorderSide(
                    color: Colors.red,
                  ),
                ),
                focusedErrorBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: const BorderSide(
                    color: Colors.red,
                    width: 2,
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
