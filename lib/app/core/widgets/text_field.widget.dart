import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../l10n/app_localizations.dart';

class TextFieldWidget extends StatefulWidget {
  final TextEditingController controller;
  final String label;
  final bool isPassword;
  final String? Function(String?)? validator;
  final TextInputType? keyboardType;
  final bool enableSuggestions;
  final TextInputAction? textInputAction;
  final TextInputFormatter? inputFormatter;
  final void Function(String)? onChanged;

  const TextFieldWidget({
    super.key,
    required this.controller,
    required this.label,
    this.isPassword = false,
    this.validator,
    this.keyboardType,
    this.enableSuggestions = false,
    this.textInputAction,
    this.inputFormatter,
    this.onChanged,
  });

  @override
  State<TextFieldWidget> createState() => _TextFieldWidgetState();
}

class _TextFieldWidgetState extends State<TextFieldWidget> {
  bool _obscureText = true;

  void _toggleObscureText() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return TextFormField(
      controller: widget.controller,
      obscureText: widget.isPassword && _obscureText,
      keyboardType: widget.keyboardType,
      keyboardAppearance: Theme.of(context).brightness == Brightness.dark
          ? Brightness.dark
          : Brightness.light,
      enableSuggestions: widget.enableSuggestions,
      autocorrect: widget.enableSuggestions,
      textInputAction: widget.textInputAction,
      inputFormatters: widget.inputFormatter != null
          ? [widget.inputFormatter!]
          : null,
      onChanged: widget.onChanged,
      decoration: InputDecoration(
        labelText: widget.label,
        suffixIcon: widget.isPassword
            ? IconButton(
                icon: Icon(
                  _obscureText ? Icons.visibility_off : Icons.visibility,
                  color: Colors.grey[700],
                ),
                onPressed: _toggleObscureText,
              )
            : null,
      ),
      validator:
          widget.validator ??
          (value) => value?.isEmpty ?? true ? l10n.requiredField : null,
    );
  }
}
