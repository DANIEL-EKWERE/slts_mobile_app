import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iconsax/iconsax.dart';
import 'package:slts_mobile_app/shared_widgets/text_widget.dart';
import 'package:slts_mobile_app/styles/styles.dart';
import 'package:slts_mobile_app/utils/utils.dart';

Widget dropdownWidget(
    {required BuildContext context,
    // required Map<String, dynamic>? selectedUserValue,
    required String? hintText,
    required List<Map<String, dynamic>> values,
    required Function onChange,
    InputDecoration? decoration,
    required String title,
    Color? iconColor,
    void Function()? onTap,
    String? expectedVariable,

    }) {
  // Map<String, dynamic>? selectedValue;

  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      textWidget(
        text: title,
        style: getRegularStyle(fontSize: 14.sp),
      ),
      SizedBox(
        height: 5.sp,
      ),
      SizedBox(
        child: GestureDetector(
          onTap: onTap,
          child: Material(
            borderOnForeground: false,
            color: Colors.transparent,
            child: ButtonTheme(
              alignedDropdown: true,
              child: DropdownButtonFormField<Map<String, dynamic>>(
                isExpanded: true,
                   validator: (value) {
                  if (value == null || value.isEmpty) {
                    return fetchErrorText(
                        expectedTextVariable: expectedVariable ?? '');
                  }
                  return null;
                },
             dropdownColor: white,
                hint: Text(
                  hintText!,
                  style: getRegularStyle(color: borderColor),
                ),
                // value: selectedUserValue,
                selectedItemBuilder: (context) {
                  return values
                      .map((item) => Container(
                            alignment: Alignment.centerLeft,
                            constraints: const BoxConstraints(minWidth: 100),
                            child: Text(
                              item['name'] ?? '',
                              // selectedValue?['name'] ?? 'no bank',
                              style: getRegularStyle(),
                            ),
                          ))
                      .toList();
                },
                items: values.map((item) {
                //  bool isSelected = item == selectedValue;
                  return DropdownMenuItem(
                    value: item,
                    child: GestureDetector(
                  
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            item['name'] ?? 'yyyy',
                            style: getRegularStyle(
                              fontSize: 16,
                            ),
                          ),
                          Text(
                            item['details'] ?? '',
                            style: getRegularStyle(
                              fontSize: 10,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                }).toList(),
                style: Theme.of(context)
                    .textTheme
                    .titleLarge
                    ?.copyWith(color: Colors.white),
                onChanged: (Map<String, dynamic>? value) {
                  onChange(value);
                },
                icon: const Icon(
                  Iconsax.arrow_down_1,
                  color: borderColor,
                ),
                decoration: decoration ??
                    InputDecoration(
                      contentPadding: EdgeInsets.symmetric(
                          horizontal: 5.sp, vertical: 13.sp),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: borderColor,
                          width: 1.0.w,
                        ),
                        borderRadius: BorderRadius.all(
                          Radius.circular(4.0.r),
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: borderColor,
                          width: 1.0.w,
                        ),
                        borderRadius: BorderRadius.all(
                          Radius.circular(4.0.r),
                        ),
                      ),
                      border: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: secondaryColor,
                          width: 1.0.w,
                        ),
                        borderRadius: BorderRadius.all(
                          Radius.circular(4.0.r),
                        ),
                      ),

                      // filled: true,
                      fillColor: Colors.transparent,
                    ),
              ),
            ),
          ),
        ),
      ),
    ],
  );
}

Widget dropdownWidget1({
  required BuildContext context,
  // required String? selectedUserValue,
  required String? hintText,
  required List<String> values,
  required Function onChange,
  InputDecoration? decoration,
  required String? title,
  Color? iconColor,
  void Function()? onTap,
  String? expectedVariable,
  bool multipleSelection = false,
  // double? radius,
  // Color? arrow,
  // Color? display,
  // FontWeight? fontWeight,
  // double? fontSize,
}) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      textWidget(
        text: title,
        style: getRegularStyle(fontSize: 12.sp),
      ),
      SizedBox(
        height: 5.sp,
      ),
      SizedBox(
        // height: 55.sp,
        // padding: const EdgeInsets.symmetric(vertical: 5.0),
        child: GestureDetector(
          onTap: onTap,
          child: Material(
            borderOnForeground: false,
            color: Colors.transparent,
            child: ButtonTheme(
              alignedDropdown: true,
              child: DropdownButtonFormField(
                iconEnabledColor: red,
                isExpanded: true,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return fetchErrorText(
                        expectedTextVariable: expectedVariable ?? '');
                  }
                  return null;
                },
                dropdownColor: white,
                hint: Text(
                  hintText!,
                  style: getRegularStyle(color: borderColor),
                ),
                // value: selectedUserValue,
                selectedItemBuilder: (context) {
                  return values
                      .map((item) => Container(
                            alignment: Alignment.centerLeft,
                            constraints: const BoxConstraints(minWidth: 100),
                            child: Text(
                              item,
                              style: getRegularStyle(),
                            ),
                          ))
                      .toList();
                },
                items: values
                    .map(
                      (item) => DropdownMenuItem(
                        value: item,
                        child: multipleSelection ? Row(
                          children: [
                            Checkbox(
                              onChanged: (value) {},
                              value: false,
                            ),
                            Text(
                              item,
                              style: getRegularStyle(
                                fontSize: 16,
                              ),
                            ),
                          ],
                        ) :   Text(
                              item,
                              style: getRegularStyle(
                                fontSize: 16,
                              ),
                            ),
                      ),
                    )
                    .toList(),
                style: Theme.of(context)
                    .textTheme
                    .titleLarge
                    ?.copyWith(color: Colors.white),
                // onTap: onTap,
                onChanged: (String? value) => onChange(value),
                icon: Icon(
                  Iconsax.arrow_down_1,
                  color: iconColor ?? black,
                ),
                decoration: decoration ??
                    InputDecoration(
                      contentPadding: EdgeInsets.symmetric(
                          horizontal: 5.sp, vertical: 13.sp),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: black,
                          width: 1.0.w,
                        ),
                        borderRadius: BorderRadius.all(
                          Radius.circular(5.0.r),
                        ),
                      ),
                      errorBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: red,
                          width: 1.0.w,
                        ),
                        borderRadius: BorderRadius.all(
                          Radius.circular(5.0.r),
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: primaryColor,
                          width: 1.0.w,
                        ),
                        borderRadius: BorderRadius.all(
                          Radius.circular(5.0.r),
                        ),
                      ),
                      border: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: primaryColor,
                          width: 1.0.w,
                        ),
                        borderRadius: BorderRadius.all(
                          Radius.circular(450.r),
                        ),
                      ),

                      // filled: true,
                      fillColor: Colors.transparent,
                    ),
              ),
            ),
          ),
        ),
      ),
    ],
  );
}

// ignore: must_be_immutable
class DropDownMenuWidget extends StatelessWidget {
  DropDownMenuWidget({
    super.key,
    required this.selectedUserValue,
    required this.hintText,
    required this.values,
    required this.onChange,
    this.radius = 5,
    this.arrow = Colors.white,
    this.display = Colors.white,
    this.displayWeight = FontWeight.w600,
    this.displaySize = 16,
  });

  final String? selectedUserValue;
  final String? hintText;
  final Map<String, String> values;
  final Function onChange;
  double? radius;
  Color arrow;
  Color display;
  FontWeight displayWeight;
  double displaySize;

  @override
  Widget build(BuildContext context) {
    return Material(
      borderOnForeground: false,
      color: Colors.transparent,
      child: DropdownButtonFormField(
        hint: Text(
          hintText!,
          style: TextStyle(
            fontSize: displaySize,
            color: display,
            fontWeight: displayWeight,
          ),
        ),
        value: selectedUserValue,
        selectedItemBuilder: (context) {
          return values.values
              .map((item) => Container(
                    alignment: Alignment.centerLeft,
                    constraints: const BoxConstraints(minWidth: 100),
                    child: Text(
                      item,
                      style: TextStyle(
                        fontSize: displaySize,
                        color: display,
                        fontWeight: displayWeight,
                      ),
                    ),
                  ))
              .toList();
        },
        items: values.keys
            .map(
              (item) => DropdownMenuItem(
                value: item,
                child: Text(
                  item,
                  style: Theme.of(context).textTheme.titleMedium,
                ),
              ),
            )
            .toList(),
        style: Theme.of(context)
            .textTheme
            .titleLarge
            ?.copyWith(color: Colors.white),
        onChanged: (String? value) => onChange(value),
        icon: Icon(
          Icons.keyboard_arrow_down_outlined,
          color: arrow,
        ),
        decoration: InputDecoration(
          enabledBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.grey, width: 2),
            borderRadius: BorderRadius.circular(5.r),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: primaryColor, width: 2),
            borderRadius: BorderRadius.circular(5.r),
          ),
          focusColor: Colors.black,
          border: OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.grey, width: 2),
            borderRadius: BorderRadius.circular(5.r),
          ),
          // filled: true,
          fillColor: Colors.transparent,
        ),
      ),
    );
  }
}
