import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:social_app_2/src/common_widgets/input_dropdown_widget.dart';
import 'package:social_app_2/src/constants/app_sizes.dart';
import 'package:social_app_2/src/utils/format.dart';

class CustomDateTimePicker extends StatelessWidget {
  const CustomDateTimePicker(
      {super.key,
      required this.labelText,
      required this.selectedDate,
      this.selectedTime,
      this.onSelectedDate,
      this.onSelectedTime});

  final String labelText;
  final DateTime selectedDate;
  final TimeOfDay? selectedTime;
  final ValueChanged<DateTime>? onSelectedDate;
  final ValueChanged<TimeOfDay>? onSelectedTime;

  @override
  Widget build(BuildContext context) {
    final valueStyle = Theme.of(context).textTheme.bodyMedium;

    return Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: <Widget>[
        Expanded(
          flex: 5,
          child: InputDropdownWidget(
            labelText: labelText,
            valueText: Format.date(selectedDate),
            valueStyle: valueStyle,
            onPressed: () => _selectDate(context),
          ),
        ),
        gapW12,
        selectedTime != null
            ? Expanded(
                flex: 4,
                child: InputDropdownWidget(
                  labelText: 'Time',
                  valueText: selectedTime!.format(context),
                  valueStyle: valueStyle,
                  onPressed: () => _selectTime(context),
                ),
              )
            : const SizedBox(),
      ],
    );
  }

  Future<void> _selectTime(BuildContext context) async {
    final ThemeData theme = Theme.of(context);
    switch (theme.platform) {
      case TargetPlatform.iOS:
      case TargetPlatform.macOS:
        return _buildCupertinoTimePicker(context);
      case TargetPlatform.android:
      case TargetPlatform.fuchsia:
      case TargetPlatform.linux:
      case TargetPlatform.windows:
        return _buildMaterialTimePicker(context);
    }
  }

  Future<void> _selectDate(BuildContext context) async {
    final ThemeData theme = Theme.of(context);
    switch (theme.platform) {
      case TargetPlatform.iOS:
      case TargetPlatform.macOS:
        return _buildCupertinoDatePicker(context);
      case TargetPlatform.android:
      case TargetPlatform.fuchsia:
      case TargetPlatform.linux:
      case TargetPlatform.windows:
        return _buildMaterialDatePicker(context);
    }
  }

  Future<void> _buildMaterialDatePicker(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(2000, 1),
      lastDate: DateTime(2100),
      builder: (context, child) {
        return Theme(
          data: ThemeData.light(),
          child: child!,
        );
      },
    );

    if (picked != null && picked != selectedDate) {
      onSelectedDate?.call(picked);
    }
  }

  Future<void> _buildCupertinoDatePicker(BuildContext context) async {
    return showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Container(
          height: MediaQuery.of(context).copyWith().size.height * 0.4,
          color: Colors.white,
          child: CupertinoDatePicker(
            mode: CupertinoDatePickerMode.date,
            initialDateTime: selectedDate,
            onDateTimeChanged: (picked) {
              if (picked != selectedDate) {
                onSelectedDate!(picked);
              }
            },
          ),
        );
      },
    );
  }

  Future<void> _buildMaterialTimePicker(BuildContext context) async {
    final TimeOfDay? pickedTime = await showTimePicker(
      context: context,
      initialTime: selectedTime!,
      initialEntryMode: TimePickerEntryMode.dial,
      builder: (context, child) {
        return Theme(
          data: ThemeData.light(),
          child: child!,
        );
      },
    );

    if (pickedTime != null && pickedTime != selectedTime) {
      onSelectedTime?.call(pickedTime);
    }
  }

  Future<void> _buildCupertinoTimePicker(BuildContext context) async {
    return showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Container(
          height: MediaQuery.of(context).copyWith().size.height * 0.4,
          color: Colors.white,
          child: CupertinoDatePicker(
            mode: CupertinoDatePickerMode.time,
            initialDateTime: DateTime(selectedTime!.hour, selectedTime!.minute),
            use24hFormat: false,
            minuteInterval: 5,
            onDateTimeChanged: (picked) {
              if (picked != selectedDate) {
                onSelectedTime!(TimeOfDay.fromDateTime(picked));
              }
            },
          ),
        );
      },
    );
  }
}
// class CustomDateTimePicker extends StatelessWidget {
//   const CustomDateTimePicker(
//       {Key? key,
//       required this.labelText,
//       required this.minimumYear,
//       required this.maximumYear,
//       this.selectedDate,
//       this.selectedTime,
//       this.onSelectedDate,
//       this.onSelectedTime})
//       : super(key: key);

//   final String labelText;
//   final int minimumYear;
//   final int maximumYear;
//   final DateTime? selectedDate;
//   final TimeOfDay? selectedTime;
//   final ValueChanged<DateTime>? onSelectedDate;
//   final ValueChanged<TimeOfDay>? onSelectedTime;

//   @override
//   Widget build(BuildContext context) {
//     final valueStyle = Theme.of(context).textTheme.bodyText2;

//     return Row(
//       crossAxisAlignment: CrossAxisAlignment.end,
//       children: <Widget>[
//         Expanded(
//           flex: 5,
//           child: InputDropdown(
//             labelText: labelText,
//             valueText: Format.date(selectedDate ?? DateTime.now()),
//             valueStyle: valueStyle,
//             onPressed: () => _selectDate(context),
//           ),
//         ),
//         gapW12,
//         selectedTime != null
//             ? Expanded(
//                 flex: 4,
//                 child: InputDropdown(
//                   labelText: 'Time',
//                   valueText: selectedTime!.format(context),
//                   valueStyle: valueStyle,
//                   onPressed: () => _selectTime(context),
//                 ),
//               )
//             : const SizedBox(),
//       ],
//     );
//   }

//   Future<void> _selectTime(BuildContext context) async {
//     final ThemeData theme = Theme.of(context);
//     assert(theme.platform != null);
//     switch (theme.platform) {
//       case TargetPlatform.iOS:
//       case TargetPlatform.macOS:
//         return _buildCupertinoTimePicker(context);
//       case TargetPlatform.android:
//       case TargetPlatform.fuchsia:
//       case TargetPlatform.linux:
//       case TargetPlatform.windows:
//         return _buildMaterialTimePicker(context);
//     }
//   }

//   Future<void> _selectDate(BuildContext context) async {
//     final ThemeData theme = Theme.of(context);
//     assert(theme.platform != null);
//     switch (theme.platform) {
//       case TargetPlatform.iOS:
//       case TargetPlatform.macOS:
//         return _buildCupertinoDatePicker(context);
//       case TargetPlatform.android:
//       case TargetPlatform.fuchsia:
//       case TargetPlatform.linux:
//       case TargetPlatform.windows:
//         return _buildMaterialDatePicker(context);
//     }
//   }

//   Future<void> _buildMaterialDatePicker(BuildContext context) async {
//     final DateTime? picked = await showDatePicker(
//       context: context,
//       initialDate: selectedDate!,
//       firstDate: DateTime(minimumYear),
//       lastDate: DateTime(maximumYear),
//       builder: (context, child) {
//         return Theme(
//           data: ThemeData.light(),
//           child: child!,
//         );
//       },
//     );

//     if (picked != null && TimeOfDay.fromDateTime(picked) != selectedTime) {
//       onSelectedDate!(picked);
//     }
//   }

//   Future<void> _buildCupertinoDatePicker(BuildContext context) async {
//     return showModalBottomSheet(
//       context: context,
//       builder: (BuildContext context) {
//         return Container(
//           height: MediaQuery.of(context).copyWith().size.height * 0.4,
//           color: Colors.white,
//           child: CupertinoDatePicker(
//             mode: CupertinoDatePickerMode.date,
//             initialDateTime: selectedDate,
//             minimumYear: minimumYear,
//             maximumYear: maximumYear,
//             onDateTimeChanged: (picked) {
//               if (picked != null && picked != selectedDate) {
//                 onSelectedDate!(picked);
//               }
//             },
//           ),
//         );
//       },
//     );
//   }

//   Future<void> _buildMaterialTimePicker(BuildContext context) async {
//     final TimeOfDay? picked = await showTimePicker(
//       context: context,
//       initialTime: selectedTime!,
//       initialEntryMode: TimePickerEntryMode.dial,
//       builder: (context, child) {
//         return Theme(
//           data: ThemeData.light(),
//           child: child!,
//         );
//       },
//     );

//     if (picked != null && picked != selectedTime) {
//       onSelectedDate!(DateTime(picked.hour, picked.minute));
//     }
//   }

//   Future<void> _buildCupertinoTimePicker(BuildContext context) async {
//     return showModalBottomSheet(
//       context: context,
//       builder: (BuildContext context) {
//         return Container(
//           height: MediaQuery.of(context).copyWith().size.height * 0.4,
//           color: Colors.white,
//           child: CupertinoDatePicker(
//             mode: CupertinoDatePickerMode.time,
//             initialDateTime: DateTime(selectedTime!.hour, selectedTime!.minute),
//             use24hFormat: false,
//             minuteInterval: 5,
//             onDateTimeChanged: (picked) {
//               if (picked != null && picked != selectedDate) {
//                 onSelectedTime!(TimeOfDay.fromDateTime(picked));
//               }
//             },
//           ),
//         );
//       },
//     );
//   }
// }
