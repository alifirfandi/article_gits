import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class ArticleItem extends StatelessWidget {
  final int index;
  final String title;
  final String subtitle;
  final Color color;
  final Color? nextColor;

  const ArticleItem({
    Key? key,
    required this.index,
    required this.title,
    required this.subtitle,
    required this.color,
    this.nextColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: nextColor,
      child: Container(
        decoration: BoxDecoration(
          color: color,
          borderRadius: const BorderRadius.only(
            bottomLeft: Radius.circular(80.0),
          ),
        ),
        padding: const EdgeInsets.only(
            left: 32, top: 48.0, bottom: 24.0, right: 20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: const TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.bold),
            ),
            const SizedBox(
              height: 2,
            ),
            Text(
              subtitle,
              style: const TextStyle(color: Colors.white, fontSize: 16),
            ),
            Align(
              alignment: Alignment.bottomRight,
              child: TextButton(
                onPressed: () {
                  _launchURL(subtitle);
                },
                child: const Text(
                  'Read More...',
                  style: TextStyle(
                    color: Colors.white,
                    decoration: TextDecoration.underline,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _launchURL(String url) async =>
      await canLaunch(url) ? await launch(url) : throw 'Could not launch $url';
}
