import 'package:flutter/material.dart';
import 'package:auto_size_text/auto_size_text.dart';

class Display extends StatelessWidget {
  final String displayNum;
  const Display({super.key, required this.displayNum});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 16, right: 10),
      child: Align(
        alignment: Alignment.bottomRight,
        child: AutoSizeText(
          displayNum,
          style: const TextStyle(fontSize: 32, fontWeight: FontWeight.w400),
          minFontSize: 30,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
      ),
    );
  }
}
