import 'package:flutter/material.dart';

class FormFieldWidget extends StatefulWidget {
  const FormFieldWidget({
    Key? key,
    required this.controller,
    this.isPasswordField = false,
    this.labelText,
    this.hintText = "",
    this.errorText,
    this.dismissibleLabel = false,
    this.keyboardType = TextInputType.name,
    this.focusNode,
  }) : super(key: key);

  final TextEditingController? controller;
  final TextInputType keyboardType;
  final bool isPasswordField;
  final String? labelText;
  final String hintText;
  final String? errorText;
  final bool dismissibleLabel;
  final FocusNode? focusNode;

  @override
  State<FormFieldWidget> createState() => _FormFieldWidgetState();
}

class _FormFieldWidgetState extends State<FormFieldWidget> {
  late final FocusNode focusNode;

  String hintText = '';
  bool obscureText = false;

  @override
  void initState() {
    super.initState();
    obscureText = widget.isPasswordField;
    hintText = widget.hintText;
    if (widget.focusNode != null) {
      focusNode = widget.focusNode!;
    } else {
      focusNode = FocusNode()
        ..addListener(() {
          focusNode.hasFocus ? hintText = '' : hintText = widget.hintText;
          setState(() {});
        });
    }
  }

  @override
  void didUpdateWidget(covariant FormFieldWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    hintText == '' ? hintText = '' : hintText = widget.hintText;
    if (!obscureText) {
      obscureText = widget.isPasswordField;
    }
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      textInputAction: TextInputAction.next,
      style: Theme.of(context).textTheme.headline2,
      keyboardType: widget.keyboardType,
      key: widget.key,
      controller: widget.controller,
      obscureText: obscureText,
      focusNode: focusNode,
      decoration: InputDecoration(
        errorText: widget.errorText,
        labelText: widget.dismissibleLabel ? null : widget.labelText,
        hintText: widget.hintText,
        disabledBorder: _defaultInputBorder(context),
        enabledBorder: _defaultInputBorder(context),
        focusedBorder: _activeInputBorder(context),
        errorBorder: _errorInputBorder(context),
        suffixIcon: widget.isPasswordField
            ? IconButton(
                icon: Icon(
                  obscureText ? Icons.visibility : Icons.visibility_off,
                  color: Theme.of(context).colorScheme.primary,
                ),
                onPressed: () {
                  setState(() {
                    obscureText = !obscureText;
                  });
                },
              )
            : null,
      ),
    );
  }

  UnderlineInputBorder _defaultInputBorder(BuildContext context) {
    return UnderlineInputBorder(
      borderSide:
          BorderSide(color: Theme.of(context).colorScheme.tertiary, width: 1),
    );
  }

  UnderlineInputBorder _activeInputBorder(BuildContext context) {
    return UnderlineInputBorder(
      borderSide:
          BorderSide(color: Theme.of(context).colorScheme.primary, width: 1),
    );
  }

  UnderlineInputBorder _errorInputBorder(BuildContext context) {
    return UnderlineInputBorder(
      borderSide:
          BorderSide(color: Theme.of(context).colorScheme.error, width: 1),
    );
  }
}
