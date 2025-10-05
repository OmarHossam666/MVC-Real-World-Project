import 'package:flutter/material.dart';

enum FlutButtonType { elevated, outline, text }

class FlutButton extends StatelessWidget {
  final FlutButtonType buttonType;

  final ButtonStyle? style;

  final VoidCallback onPressed;
  final WidgetStateProperty<EdgeInsetsGeometry>? msPadding;
  final EdgeInsetsGeometry? padding;

  final WidgetStateProperty<EdgeInsetsGeometry>? msShape;
  final OutlinedBorder? shape;
  final BorderRadiusGeometry? borderRadius;
  final double borderRadiusAll;

  final WidgetStateProperty<Color>? msBackgroundColor;
  final Color? backgroundColor;
  final WidgetStateProperty<Color>? msShadowColor;
  final Color? shadowColor;

  final Widget child;

  const FlutButton(
      {super.key, required this.onPressed,
      required this.child,
      this.msPadding,
      this.padding,
      this.msShape,
      this.shape,
      this.borderRadius,
      this.borderRadiusAll = 0,
      this.msBackgroundColor,
      this.backgroundColor,
      this.buttonType = FlutButtonType.elevated,
      this.style,
      this.msShadowColor,
      this.shadowColor});

  const FlutButton.rounded(
      {super.key, required this.onPressed,
      required this.child,
      this.msPadding,
      this.padding,
      this.msShape,
      this.shape,
      this.borderRadius,
      this.borderRadiusAll = 4,
      this.msBackgroundColor,
      this.backgroundColor,
      this.buttonType = FlutButtonType.elevated,
      this.style,
      this.msShadowColor,
      this.shadowColor});

  const FlutButton.small(
      {super.key, required this.onPressed,
      required this.child,
      this.msPadding,
      this.padding = const EdgeInsets.fromLTRB(8, 4, 8, 4),
      this.msShape,
      this.shape,
      this.borderRadius,
      this.borderRadiusAll = 0,
      this.msBackgroundColor,
      this.backgroundColor,
      this.buttonType = FlutButtonType.elevated,
      this.style,
      this.msShadowColor,
      this.shadowColor});

  const FlutButton.medium(
      {super.key, required this.onPressed,
      required this.child,
      this.msPadding,
      this.padding = const EdgeInsets.fromLTRB(24, 12, 24, 12),
      this.msShape,
      this.shape,
      this.borderRadius,
      this.borderRadiusAll = 0,
      this.msBackgroundColor,
      this.backgroundColor,
      this.buttonType = FlutButtonType.elevated,
      this.style,
      this.msShadowColor,
      this.shadowColor});

  const FlutButton.large(
      {super.key, required this.onPressed,
      required this.child,
      this.msPadding,
      this.padding = const EdgeInsets.fromLTRB(36, 16, 36, 16),
      this.msShape,
      this.shape,
      this.borderRadius,
      this.borderRadiusAll = 0,
      this.msBackgroundColor,
      this.backgroundColor,
      this.buttonType = FlutButtonType.elevated,
      this.style,
      this.msShadowColor,
      this.shadowColor});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        style: style ??
            ButtonStyle(
                backgroundColor: msBackgroundColor ??
                    WidgetStateProperty.all(backgroundColor),
                shadowColor:
                    msShadowColor ?? WidgetStateProperty.all(shadowColor),
                padding: msPadding ?? WidgetStateProperty.all(padding),
                shape: msShape as WidgetStateProperty<OutlinedBorder?>? ??
                    WidgetStateProperty.all(shape ??
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(borderRadiusAll),
                        ))),
        onPressed: onPressed,
        child: child);
  }
}
