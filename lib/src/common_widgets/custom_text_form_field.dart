import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:social_app_2/src/common_widgets/note_text.dart';
import 'package:social_app_2/src/constants/app_sizes.dart';

// class CustomTextFormField extends StatefulWidget {
//   const CustomTextFormField({
//     super.key,
//     required this.controller,
//     this.textInputType = TextInputType.text,
//     this.initialValue,
//     this.helperText,
//     this.labelText,
//     this.errorText,
//     this.isPassword = false,
//     this.isReadOnly = false,
//     this.enableSuggestions = false,
//     this.autocorrect = false,
//     this.autofocus = false,
//     this.isEnabled = true,
//     this.hintText,
//     this.maxLines = 1,
//     this.minLines = 1,
//     this.autovalidateMode,
//     this.validator,
//     this.validationMessage,
//     this.enterPressed,
//     this.onEditingComplete,
//     this.onSaved,
//     this.smallVersion = false,
//     this.fieldFocusNode,
//     this.nextFocusNode,
//     this.textInputAction = TextInputAction.next,
//     this.textCapitalization = TextCapitalization.none,
//     this.additionalNote,
//     this.onChanged,
//     this.formatter,
//     this.toolbarOptions,
//     this.prefixIcon,
//     this.keyboardAppearance,
//   });

//   final TextEditingController controller;
//   final TextInputType? textInputType;
//   final TextCapitalization? textCapitalization;
//   final String? initialValue;
//   final String? helperText;
//   final String? labelText;
//   final String? errorText;
//   final bool isPassword;
//   final bool isReadOnly;
//   final bool enableSuggestions;
//   final bool autocorrect;
//   final bool isEnabled;
//   final bool autofocus;
//   final String? hintText;
//   final int? maxLines;
//   final int? minLines;
//   final AutovalidateMode? autovalidateMode;
//   final FormFieldValidator? validator;
//   final String? validationMessage;
//   final Function? enterPressed;
//   final VoidCallback? onEditingComplete;
//   final FormFieldSetter? onSaved;
//   final bool smallVersion;
//   final FocusNode? fieldFocusNode;
//   final FocusNode? nextFocusNode;
//   final TextInputAction? textInputAction;
//   final String? additionalNote;
//   final Function(String)? onChanged;
//   final TextInputFormatter? formatter;
//   final ToolbarOptions? toolbarOptions;
//   final IconData? prefixIcon;
//   final Brightness? keyboardAppearance;

//   @override
//   State<CustomTextFormField> createState() => _CustomTextFormFieldState();
// }

// class _CustomTextFormFieldState extends State<CustomTextFormField> {
//   bool _isPassword = false;
//   double _fieldHeight = 48;

//   @override
//   void initState() {
//     super.initState();
//     _isPassword = widget.isPassword;
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: <Widget>[
//         Container(
//           height: _fieldHeight,
//           alignment: Alignment.centerLeft,
//           child: Row(
//             children: <Widget>[
//               Expanded(
//                 child: TextFormField(
//                   key: widget.key,
//                   controller: widget.controller,
//                   keyboardType: widget.textInputType,
//                   keyboardAppearance: widget.keyboardAppearance,
//                   enableSuggestions: widget.enableSuggestions,
//                   initialValue: widget.initialValue,
//                   autocorrect: widget.autocorrect,
//                   focusNode: widget.fieldFocusNode,
//                   autofocus: widget.autofocus,
//                   textInputAction: widget.textInputAction,
//                   textCapitalization: widget.textCapitalization!,
//                   onChanged: widget.onChanged,
//                   onSaved: widget.onSaved,
//                   autovalidateMode: widget.autovalidateMode,
//                   validator: widget.validator,
//                   inputFormatters:
//                       widget.formatter != null ? [widget.formatter!] : null,
//                   // onEditingComplete: () {
//                   //   if (widget.enterPressed != null) {
//                   //     FocusScope.of(context).requestFocus(FocusNode());
//                   //     widget.enterPressed!();
//                   //   }
//                   // },
//                   onEditingComplete: widget.onEditingComplete,
//                   onFieldSubmitted: (value) {
//                     if (widget.nextFocusNode != null) {
//                       widget.nextFocusNode?.requestFocus();
//                     } else if (widget.textInputAction == TextInputAction.done) {
//                       if (widget.enterPressed != null) {
//                         widget.enterPressed!();
//                       }
//                     }
//                   },
//                   obscureText: _isPassword,
//                   readOnly: widget.isReadOnly,
//                   maxLines: widget.maxLines,
//                   minLines: widget.minLines,
//                   toolbarOptions: widget.toolbarOptions,
//                   decoration: InputDecoration(
//                     contentPadding: const EdgeInsets.fromLTRB(12, 12, 12, 12),
//                     prefixIcon: widget.prefixIcon != null
//                         ? Icon(widget.prefixIcon)
//                         : null,
//                     hintText: widget.hintText,
//                     // helperText: widget.helperText,
//                     labelText: widget.labelText,
//                     errorText: widget.errorText,
//                     enabled: widget.isEnabled,
//                     hintStyle:
//                         TextStyle(fontSize: widget.smallVersion ? 12 : 15),
//                     border: const OutlineInputBorder(
//                       borderSide: BorderSide(
//                         color: Colors.black,
//                         width: 1.0,
//                       ),
//                     ),
//                     enabledBorder: const OutlineInputBorder(
//                       borderSide: BorderSide(
//                         color: Colors.black54,
//                         width: 1.0,
//                       ),
//                     ),
//                     focusedBorder: OutlineInputBorder(
//                       borderSide: BorderSide(
//                         color: Theme.of(context).primaryColor,
//                         width: 1.0,
//                       ),
//                     ),
//                   ),
//                 ),
//               ),
//               if (widget.isPassword)
//                 GestureDetector(
//                   onTap: () => setState(() {
//                     _isPassword = !_isPassword;
//                   }),
//                   child: widget.isPassword
//                       ? Container(
//                           width: _fieldHeight,
//                           height: _fieldHeight,
//                           alignment: Alignment.center,
//                           child: Icon(_isPassword
//                               ? Icons.visibility
//                               : Icons.visibility_off))
//                       : Container(),
//                 ),
//             ],
//           ),
//         ),
//         if (widget.validationMessage != null)
//           NoteText(
//             text: widget.validationMessage!,
//             color: Colors.red,
//           ),
//         if (widget.additionalNote != null) gapH4,
//         if (widget.additionalNote != null)
//           NoteText(
//             text: widget.additionalNote!,
//             color: Colors.grey[600],
//           ),
//         gapH12,
//       ],
//     );
//   }
// }

class CustomTextFormField extends StatefulWidget {
  const CustomTextFormField({
    super.key,
    required this.controller,
    this.textInputType = TextInputType.text,
    this.labelText,
    this.hintText,
    this.errorText,
    this.isPassword = false,
    this.isReadOnly = false,
    this.isEnabled = true,
    this.autoFocus = false,
    this.helperText,
    this.fieldFocusNode,
    this.nextFocusNode,
    this.maxLines = 1,
    this.minLines = 1,
    this.autovalidateMode,
    this.validator,
    this.onChanged,
    this.onSaved,
    this.onEditingComplete,
    this.prefixIcon,
    this.suffixIcon,
    this.textCapitalization = TextCapitalization.none,
    this.textInputAction = TextInputAction.next,
    this.keyboardAppearance,
    this.contextMenuBuilder,
    this.formatters,
    this.additionalNote,
    this.enterPressed,
  });

  final TextEditingController controller;
  final TextInputType textInputType;
  final TextCapitalization textCapitalization;
  final String? labelText;
  final String? hintText;
  final String? errorText;
  final bool isPassword;
  final bool isReadOnly;
  final bool isEnabled;
  final bool autoFocus;
  final String? helperText;
  final int? maxLines;
  final int minLines;
  final FocusNode? fieldFocusNode;
  final FocusNode? nextFocusNode;
  final AutovalidateMode? autovalidateMode;
  final FormFieldValidator<String>? validator;
  final ValueChanged<String>? onChanged;
  final FormFieldSetter<String>? onSaved;
  final VoidCallback? onEditingComplete;
  final IconData? prefixIcon;
  final IconData? suffixIcon;
  final TextInputAction textInputAction;
  final Brightness? keyboardAppearance;
  final EditableTextContextMenuBuilder? contextMenuBuilder;
  final List<TextInputFormatter>? formatters;
  final String? additionalNote;
  final Function? enterPressed;

  @override
  State<CustomTextFormField> createState() => _CustomTextFormFieldState();
}

class _CustomTextFormFieldState extends State<CustomTextFormField> {
  late bool _obscureText;
  late String? hintText;

  @override
  void initState() {
    super.initState();
    _obscureText = widget.isPassword;
    hintText = widget.helperText;
    widget.controller.addListener(_updateHintText);
  }

  @override
  void dispose() {
    widget.controller.removeListener(_updateHintText);
    super.dispose();
  }

  void _updateHintText() {
    setState(() {
      hintText = widget.controller.text.isEmpty ? widget.helperText : null;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          constraints: BoxConstraints(
            minHeight: 54.0, // Minimum height for the TextFormField
          ),
          child: TextFormField(
            controller: widget.controller,
            keyboardType: widget.textInputType,
            textCapitalization: widget.textCapitalization,
            textInputAction: widget.textInputAction,
            obscureText: _obscureText,
            readOnly: widget.isReadOnly,
            enabled: widget.isEnabled,
            autocorrect: false,
            focusNode: widget.fieldFocusNode,
            autofocus: widget.autoFocus,
            maxLines: widget.maxLines,
            minLines: widget.minLines,
            keyboardAppearance: widget.keyboardAppearance,
            onFieldSubmitted: (value) {
              if (widget.nextFocusNode != null) {
                widget.nextFocusNode?.requestFocus();
              } else if (widget.textInputAction == TextInputAction.done) {
                if (widget.enterPressed != null) {
                  widget.enterPressed!();
                }
              }
            },
            contextMenuBuilder: widget.contextMenuBuilder ??
                (BuildContext context, EditableTextState editableTextState) {
                  return AdaptiveTextSelectionToolbar.editableText(
                    editableTextState: editableTextState,
                  );
                },
            inputFormatters: widget.formatters,
            autovalidateMode: widget.autovalidateMode,
            validator: widget.validator,
            onChanged: widget.onChanged,
            onSaved: widget.onSaved,
            onEditingComplete: widget.onEditingComplete,
            decoration: _buildInputDecoration(),
          ),
        ),
        if (widget.additionalNote != null)
          Padding(
            padding: const EdgeInsets.only(top: 8.0),
            child: Text(
              widget.additionalNote!,
              style: TextStyle(
                color: Colors.grey[600],
                fontSize: 12,
              ),
            ),
          ),
      ],
    );
  }

  InputDecoration _buildInputDecoration() {
    return InputDecoration(
      labelText: widget.labelText,
      hintText: hintText,
      errorText: widget.errorText,
      prefixIcon: widget.prefixIcon != null ? Icon(widget.prefixIcon) : null,
      suffixIcon: widget.isPassword
          ? IconButton(
              icon: Icon(
                _obscureText ? Icons.visibility : Icons.visibility_off,
              ),
              onPressed: () {
                setState(() {
                  _obscureText = !_obscureText;
                });
              },
            )
          : widget.suffixIcon != null
              ? Icon(widget.suffixIcon)
              : null,
      contentPadding: const EdgeInsets.symmetric(
        vertical: 12.0, // Ensures proper alignment
        horizontal: 16.0,
      ),
      border: const OutlineInputBorder(),
      enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(color: Colors.grey.shade400),
      ),
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(color: Theme.of(context).primaryColor),
      ),
    );
  }
}
