import 'package:flutter/material.dart';

class CustomDropdownWidget extends StatefulWidget {
  const CustomDropdownWidget({
    super.key,
    required this.itemsList,
    this.labelText,
    required this.value,
    this.hint,
    this.onChanged,
  });

  final List<String> itemsList;
  final String? labelText;
  final String value;
  final String? hint;
  final ValueChanged<String?>? onChanged;

  @override
  State<CustomDropdownWidget> createState() => _CustomDropdownWidgetState();
}

class _CustomDropdownWidgetState extends State<CustomDropdownWidget> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 60,
      child: InputDecorator(
        decoration: InputDecoration(
          contentPadding: const EdgeInsets.fromLTRB(12, 12, 12, 12),
          labelText: widget.labelText,
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
          focusedBorder: const OutlineInputBorder(
            borderSide: BorderSide(
              color: Colors.blue,
              width: 1.0,
            ),
          ),
          // filled: true,
          // fillColor: Colors.grey,
        ),
        child: DropdownButtonHideUnderline(
          child: DropdownButton(
            isDense: true,
            icon: const Icon(Icons.keyboard_arrow_down),
            items: widget.itemsList
                .map(
                  (item) => DropdownMenuItem(
                    value: item,
                    child: Text(item),
                  ),
                )
                .toList(),
            hint: Text(widget.hint ?? 'Select from list'),
            isExpanded: true,
            value: widget.value,
            onChanged: widget.onChanged,
            dropdownColor: Colors.white,
          ),
        ),
      ),
    );
  }
}
