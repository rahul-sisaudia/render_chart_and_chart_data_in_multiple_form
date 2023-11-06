import 'package:flutter/material.dart';

import '../constants/app_text_style.dart';
import '../constants/color_constants.dart';
import '../constants/dimension_constants.dart';

class CustomButton extends StatelessWidget {
  final Color borderColor;
  final double borderRadius;
  final double borderWidth;
  final Color btnColor;
  final bool isEnabled;
  final bool isExpanded;
  final Color lblColor;
  final VoidCallback? onTap;
  final String label;
  final TextStyle? style;
  final double? height;
  final double paddingHorizontal;
  final double paddingVertical;
  final IconData? icon;
  final Widget? iconWidget;

  const CustomButton({
    super.key,
    this.borderColor = ColorConstants.transparent,
    this.borderRadius = Dimensions.px10,
    this.borderWidth = Dimensions.px1,
    this.btnColor = ColorConstants.radicalRed,
    this.height = Dimensions.px50,
    this.icon,
    this.iconWidget,
    this.isEnabled = true,
    this.isExpanded = false,
    this.lblColor = ColorConstants.white,
    this.label = '',
    this.onTap,
    this.style,
    this.paddingHorizontal = Dimensions.px10,
    this.paddingVertical = Dimensions.px10,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: isEnabled ? onTap : null,
      child: Container(
        height: height,
        alignment: Alignment.center,
        padding: EdgeInsets.symmetric(
          horizontal: paddingHorizontal,
          vertical: paddingVertical,
        ),
        decoration: BoxDecoration(
          border: Border.all(
            color: isEnabled ? borderColor : ColorConstants.alto,
            width: borderWidth,
          ),
          color: isEnabled ? btnColor : ColorConstants.green.withOpacity(0.6),
          borderRadius: BorderRadius.circular(borderRadius),
        ),
        child: (icon != null)
            ? Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    icon,
                    color: ColorConstants.white,
                    size: Dimensions.px25,
                  ),
                  isExpanded
                      ? Expanded(child: _buildTextPart())
                      : _buildTextPart(),
                ],
              )
            : (iconWidget != null)
                ? Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      iconWidget!,
                      isExpanded
                          ? Expanded(child: _buildTextPart())
                          : _buildTextPart(),
                    ],
                  )
                : isExpanded
                    ? Expanded(child: _buildTextPart())
                    : _buildTextPart(),
      ),
    );
  }

  _buildTextPart() {
    return Container(
      alignment: Alignment.center,
      padding: const EdgeInsets.symmetric(horizontal: Dimensions.px10),
      child: Text(
        label,
        textAlign: TextAlign.center,
        style: style ??
            AppTextStyles.regularText(
              color: lblColor,
              fontSize: Dimensions.px20,
            ),
      ),
    );
  }
}
