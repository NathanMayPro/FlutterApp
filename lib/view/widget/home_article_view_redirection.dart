import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class HomeArticleViewRedirection extends StatelessWidget {
  const HomeArticleViewRedirection({Key? key, required this.url})
      : super(key: key);

  final String url;

  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.of(context).size.height / 15;
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          GestureDetector(
            onTap: () => _urlLauncher(url),
            child: Container(
                height: height,
                decoration: BoxDecoration(
                    color: Colors.blue.shade400,
                    borderRadius: const BorderRadius.all(Radius.circular(32))),
                child: const Center(
                    child: Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text("Read on the Website",
                      style: TextStyle(color: Colors.white)),
                ))),
          )
        ],
      ),
    );
  }

  void _urlLauncher(String url) async {
    if (!await launch(url)) throw 'Could not launch $url';
  }
}
