import 'package:flutter/material.dart';

class HomeArticleViewActionButton extends StatelessWidget {
  const HomeArticleViewActionButton({
    Key? key,
    required this.callBackFunction,
    required this.icon,
  }) : super(key: key);

  final VoidCallback callBackFunction;
  final IconData? icon;

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height / 13;
    return GestureDetector(
      onTap: callBackFunction,
      child: Container(
        height: height,
        width: height,
        decoration:
            const BoxDecoration(color: Colors.black, shape: BoxShape.circle),
        child: Icon(icon, color: Colors.white),
      ),
    );
  }
}
