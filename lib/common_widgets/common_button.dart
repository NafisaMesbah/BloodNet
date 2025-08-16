import 'package:bloodnet/util/appstyles.dart';
import 'package:bloodnet/util/size_config.dart';
import 'package:flutter/material.dart';

class CommonButton extends StatefulWidget {
  const CommonButton({
    super.key,
    required this.onTap,
    required this.title,
    required this.isLoading,
  });

  final VoidCallback onTap;
  final String title;
  final bool isLoading;

  @override
  State<CommonButton> createState() => _CommonButtonState();
}

class _CommonButtonState extends State<CommonButton> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: widget.onTap,
      child: Container(
        alignment: Alignment.center,
        height: SizeConfig.getProportionateScreenHeight(50),
        width: SizeConfig.screenWidth,
        decoration: BoxDecoration(
          color: Appstyles.mainColor,
          borderRadius: BorderRadius.circular(20),
        ),
        child: widget.isLoading
            ? const CircularProgressIndicator()
            : Text(widget.title, style: Appstyles.normalTextStyle),
      ),
    );
  }
}
