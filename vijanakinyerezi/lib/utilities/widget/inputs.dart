import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:vijanakinyerezi/utilities/constants/constant.dart';

class JTInputField extends StatelessWidget {
  final TextEditingController? controller;
  final TextStyle? textStyle;
  final FontWeight? fontWeight;
  final FontWeight? labelWight;
  final String? fontStyle;
  final String? fontFamily;
  final String? label;
  final String? initialValue;
  final int? maxLines;
  final TextInputAction? inputAction;
  final IconData? prefixIcon;
  final IconData? sufixIcon;
  final bool obscure;
  final bool isPassword;
  final String? hint;
  final Color? errorColor;
  final Color? cursorColor;
  final Color? hintColor;
  final bool? filled;
  final bool readOnly;
  final Color? fillColor;
  final Color? labelColor;
  final TextInputType? keyboardType;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? stepperPadding;
  final List<TextInputFormatter>? inputFormatter;
  final double? labelSize;
  final double? hintSize;
  final String pre;
  final InputBorder? border;
  final void Function(String)? onchanged;
  final Color? preIconColor;
  final Widget? sufixWidget;

  final Color? helperColor;
  final double? helperSize;
  final String? Function(String?)? validator;

  ///inputs for all texts committed
  const JTInputField({
    this.fontFamily,
    this.labelWight,
    this.readOnly = false,
    this.initialValue,
    this.validator,
    this.isPassword = false,
    this.fontStyle,
    this.fontWeight,
    this.hintSize,
    this.preIconColor,
    this.border,
    this.onchanged,
    this.sufixWidget,
    this.labelColor,
    this.textStyle,
    this.hint,
    this.stepperPadding,
    this.padding,
    this.controller,
    this.fillColor,
    this.labelSize,
    this.filled = false,
    this.hintColor,
    this.cursorColor,
    required this.pre,
    this.errorColor = Colors.redAccent,
    this.obscure = false,
    this.label,
    this.maxLines = 1,
    this.prefixIcon,
    this.sufixIcon,
    this.inputAction = TextInputAction.done,
    this.inputFormatter,
    Key? key,
    this.keyboardType,
    this.helperColor,
    this.helperSize,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: stepperPadding ?? const EdgeInsets.all(10),
      child: TextFormField(
        initialValue: initialValue,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        validator: validator,
        style: textStyle,
        obscureText: obscure,
        controller: controller,
        maxLines: maxLines,
        textInputAction: inputAction,
        enableInteractiveSelection: true,
        keyboardType: keyboardType,
        onChanged: onchanged,
        readOnly: readOnly,
        inputFormatters: inputFormatter,
        smartQuotesType: SmartQuotesType.enabled,
        decoration: InputDecoration(
          floatingLabelBehavior: FloatingLabelBehavior.always,
          hintStyle: TextStyle(
              color: hintColor, fontFamily: fontFamily, fontSize: hintSize),
          contentPadding: padding,
          hintText: hint,
          filled: filled,
          helperStyle: TextStyle(color: helperColor, fontSize: helperSize),
          prefix: Text(
            pre,
            style: TextStyle(fontSize: labelSize),
            textScaleFactor: textScaleFactor,
          ),
          errorStyle: TextStyle(
            color: errorColor,
            fontSize: 10,
            fontWeight: FontWeight.normal,
          ),
          prefixIcon: Icon(
            prefixIcon,
            color: preIconColor ?? Theme.of(context).primaryColor,
          ),
          suffixIcon: isPassword
              ? sufixWidget
              : Icon(
                  sufixIcon,
                  color: Colors.green,
                ),
          labelText: label,
          labelStyle: TextStyle(
            fontSize: labelSize,
            color: labelColor,
            fontWeight: labelWight,
          ),
          enabledBorder: border,
          focusedBorder: border,
        ),
      ),
    );
  }
}
