import 'package:flutter/material.dart';

class TextButtonWidget extends StatelessWidget {
  const TextButtonWidget({
    super.key,
    required this.primaryText,
    this.secondaryText,
    this.onPressed,
    this.primaryTextColor,
    this.secondaryTextColor,
    this.alignment = Alignment.bottomCenter,
  });

  final String primaryText;
  final String? secondaryText;
  final VoidCallback? onPressed;
  final Color? primaryTextColor;
  final Color? secondaryTextColor;
  final Alignment alignment;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: alignment,
      child: InkWell(
        hoverColor: Colors.transparent,
        splashColor: Colors.transparent,
        highlightColor: Colors.transparent,
        onTap: onPressed,
        child: RichText(
          text: TextSpan(
            children: [
              TextSpan(
                text: primaryText,
                style: Theme.of(
                  context,
                ).textTheme.bodyMedium?.copyWith(color: primaryTextColor),
              ),
              if (secondaryText != null)
                TextSpan(
                  text: ' $secondaryText',
                  style: Theme.of(
                    context,
                  ).textTheme.bodyMedium?.copyWith(color: secondaryTextColor),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
