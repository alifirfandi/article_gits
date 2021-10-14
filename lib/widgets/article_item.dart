import 'package:flutter/material.dart';

class ArticleItem extends StatelessWidget {
  final String title;
  final String subtitle;
  
  const ArticleItem({
    Key? key,
    required this.title,
    required this.subtitle,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(title),
      isThreeLine: true,
      subtitle: Text(subtitle),
    );
  }
}
