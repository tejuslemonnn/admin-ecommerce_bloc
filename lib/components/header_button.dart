import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HeaderButton extends StatelessWidget {
  const HeaderButton({
    Key? key,
    required this.onPressed,
    required this.height,
    required this.text,
  }) : super(key: key);

  final VoidCallback onPressed;
  final double height;
  final String text;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: SizedBox(
        height: height,
        child: Card(
          margin: EdgeInsets.zero,
          color: Colors.black,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Row(
              children: [
                const Icon(
                  CupertinoIcons.add_circled_solid,
                  color: Colors.white,
                ),
                const SizedBox(width: 10),
                Text(
                  text,
                  style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
