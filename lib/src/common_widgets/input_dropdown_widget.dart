import 'package:flutter/material.dart';

class InputDropdownWidget extends StatelessWidget {
  const InputDropdownWidget({
    super.key,
    this.labelText,
    this.valueText,
    this.valueStyle,
    this.onPressed,
    this.iconData,
  });

  final String? labelText;
  final String? valueText;
  final TextStyle? valueStyle;
  final VoidCallback? onPressed;
  final IconData? iconData;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: Container(
        height: 54.0,
        margin: const EdgeInsets.only(bottom: 10.0),
        child: InputDecorator(
          decoration: InputDecoration(
            contentPadding: const EdgeInsets.fromLTRB(12, 12, 12, 12),
            labelText: labelText,
            border: const OutlineInputBorder(
              borderSide: BorderSide(
                color: Colors.black12,
                width: 1.0,
              ),
            ),
            enabledBorder: const OutlineInputBorder(
              borderSide: BorderSide(
                color: Colors.black12,
                width: 1.0,
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: Theme.of(context).primaryColor,
                width: 1.0,
              ),
            ),
          ),
          baseStyle: valueStyle,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              valueText != null
                  ? Text(valueText!, style: valueStyle)
                  : Container(),
              Icon(Icons.arrow_drop_down,
                  color: Theme.of(context).brightness == Brightness.light
                      ? Colors.grey.shade700
                      : Colors.white70),
            ],
          ),
        ),
      ),
    );
  }
}
