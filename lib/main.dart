import 'package:flutter/material.dart';
import 'package:flutter_article_gits/pages/search_pages.dart';
import 'package:provider/provider.dart';

import 'pages/article_list_page.dart';
import 'pages/login_page.dart';
import 'provider/user_provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => UserProvider()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'List Article',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        initialRoute: ArticleListPage.routeName,
        routes: {
          ArticleListPage.routeName: (context) => const ArticleListPage(),
          LoginPage.routeName: (context) => const LoginPage(),
          SearchPage.routeName: (context) => const SearchPage(),
        },
      ),
    );
  }
}
