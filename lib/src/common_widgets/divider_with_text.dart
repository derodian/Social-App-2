import 'package:flutter/material.dart';

class DividerWithText extends StatelessWidget {
  final String? text;
  final double height;
  final double thickness;
  final double horizontalPadding;
  final double textPadding;
  final TextStyle? textStyle;

  const DividerWithText({
    super.key,
    this.text,
    this.height = 1.0,
    this.thickness = 1.0,
    this.horizontalPadding = 16.0,
    this.textPadding = 16.0,
    this.textStyle,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
      child: Row(
        children: [
          Expanded(child: _buildDivider()),
          if (text != null) ...[
            Padding(
              padding: EdgeInsets.symmetric(horizontal: textPadding),
              child: Text(
                text!,
                style: textStyle ?? Theme.of(context).textTheme.bodySmall,
              ),
            ),
            Expanded(child: _buildDivider()),
          ],
        ],
      ),
    );
  }

  Widget _buildDivider() {
    return Container(
      height: height,
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            width: thickness,
          ),
        ),
      ),
    );
  }
}
