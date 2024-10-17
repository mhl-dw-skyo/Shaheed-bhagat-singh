import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:punjab_tourism/enum/loading.dart';
import 'package:punjab_tourism/utils.dart';

class MkButton extends StatelessWidget {
  final VoidCallback onTap;
  LoadingStatus loadingStatus;
  final String text;
  final TextStyle? textStyle;
  final String successText;
  final bool showIcon;
  Color? color;
  double? borderRadius;
  double? height;
  double? width;
  Border? border;
  EdgeInsets? padding;
  bool enabled;

  MkButton({
    required this.onTap,
    this.successText = "Success",
    required this.text,
    this.loadingStatus = LoadingStatus.none,
    super.key,
    this.showIcon = false,
    this.height,
    this.enabled = true,
    this.width,
    this.padding,
    this.border,
    this.textStyle,
    this.color,
    this.borderRadius,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: enabled
          ? () {
              if (loadingStatus != LoadingStatus.loading) {
                onTap();
              }
            }
          : () {},
      child: actionView(),
    );
  }

  actionView() {
    if (loadingStatus == LoadingStatus.none) {
      return defaultView();
    } else if (loadingStatus == LoadingStatus.loading) {
      return loadingView();
    } else if (loadingStatus == LoadingStatus.success) {
      return successView();
    } else {
      return defaultView();
    }
  }

  defaultView() {
    return Container(
      width: width ?? screenWidth,
      height: height,
      padding: padding ?? EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: enabled ? color ?? Color(0xff136EF1) : Colors.grey,
        border: border,
        borderRadius: BorderRadius.circular(borderRadius ?? 12),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            text,
            style: textStyle ??
                GoogleFonts.poppins(
                  color: Colors.white,
                  fontSize: 14,
                  fontWeight: FontWeight.normal,
                ),
          ),
          SizedBox(width: showIcon ? 16 : 0),
          showIcon
              ? Icon(
                  Icons.arrow_forward,
                  color: Colors.white,
                  size: 22,
                )
              : SizedBox(),
        ],
      ),
    );
  }

  loadingView() {
    return Container(
      width: screenWidth,
      padding: EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: color ?? Color(0xff136EF1),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Center(
        child: SizedBox(
            width: 26,
            height: 26,
            child: CircularProgressIndicator(
              color: Colors.white,
            )),
      ),
    );
  }

  successView() {
    return Container(
      width: screenWidth,
      padding: EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.green,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Center(
          child: Text(
        successText,
        style: GoogleFonts.poppins(
          color: Colors.white,
          fontSize: 14,
          fontWeight: FontWeight.normal,
        ),
      )),
    );
  }
}
