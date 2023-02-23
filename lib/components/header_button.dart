import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HeaderButton extends StatelessWidget {
  const HeaderButton({
    Key? key,
    required this.onPressed,
    this.height,
    required this.text,
    this.width,
    this.icon,
  }) : super(key: key);

  final VoidCallback onPressed;
  final Icon? icon;
  final double? height;
  final double? width;
  final String text;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: SizedBox(
        height: height,
        width: width,
        child: Card(
          margin: EdgeInsets.zero,
          color: Colors.black,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                icon ?? const SizedBox.shrink(),
                const SizedBox(width: 10),
                Text(
                  text,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
