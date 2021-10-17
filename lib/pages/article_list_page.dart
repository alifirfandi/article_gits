import 'package:flutter/material.dart';
import 'package:flutter_article_gits/pages/search_pages.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;

import '../api/api_service.dart';
import '../models/articles.dart';
import '../provider/user_provider.dart';
import '../widgets/article_item.dart';
import 'login_page.dart';

class ArticleListPage extends StatefulWidget {
  static const routeName = '/articles';
  const ArticleListPage({Key? key}) : super(key: key);

  @override
  State<ArticleListPage> createState() => _ArticleListPageState();
}

class _ArticleListPageState extends State<ArticleListPage> {
  final ScrollController _controller = ScrollController();
  final List<Articles> _listArticles = [];
  int _page = 1;
  bool _lastArticle = false;

  Future<void> _requestData() async {
    if (_lastArticle) return;
    List<Articles> articles =
        await ApiService.listArticle(http.Client(), _page);
    if (articles.isNotEmpty) {
      _page++;
      _listArticles.addAll(articles);
    } else {
      _lastArticle = true;
    }
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    _requestData();
    _controller.addListener(() {
      double _pixels = _controller.position.pixels;
      double _maxScroll = _controller.position.maxScrollExtent;
      if (_pixels == _maxScroll) _requestData();
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('List Article'),
        actions: [
          Consumer<UserProvider>(
            builder: (context, userProvider, _) {
              if (userProvider.user == null) {
                return TextButton(
                  onPressed: () {
                    Navigator.of(context).pushNamed(LoginPage.routeName);
                  },
                  child: const Text(
                    'Login',
                    style: TextStyle(color: Colors.white),
                  ),
                );
              } else {
                return TextButton(
                  onPressed: () {
                    userProvider.user = null;
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Logout Success!'),
                      ),
                    );
                  },
                  child: const Text(
                    'Logout',
                    style: TextStyle(color: Colors.white),
                  ),
                );
              }
            },
          ),
          IconButton(
            icon: const Icon(Icons.search),
            color: Colors.white,
            onPressed: () {
              Navigator.of(context).pushNamed(SearchPage.routeName);
            },
          )
        ],
      ),
      body: ListView(
        controller: _controller,
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.all(2.0),
        children: [
          ListView.builder(
            primary: false,
            shrinkWrap: true,
            itemBuilder: (BuildContext context, int index) {
              return ArticleItem(
                title: _listArticles[index].title.rendered,
                subtitle: _listArticles[index].links.wpAttachment[0].href,
              );
            },
            itemCount: _listArticles.length,
          ),
          _lastArticle
              ? const Text('No more article', textAlign: TextAlign.center)
              : const LinearProgressIndicator(),
          const SizedBox(height: 15),
        ],
      ),
    );
  }
}
