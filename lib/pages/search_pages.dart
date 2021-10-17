import 'dart:developer';
import 'package:flutter/material.dart';
import '../api/api_service.dart';
import '../models/search.dart';
import '../models/articles.dart';
import '../widgets/article_item.dart';
import 'package:http/http.dart' as http;

class SearchPage extends StatefulWidget {
  static const routeName = '/search';
  const SearchPage({Key? key}) : super(key: key);

  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final TextEditingController _searchController = TextEditingController();
  final ScrollController _controller = ScrollController();
  final List<SearchArticles> _listArticles = [];
  int _page = 1;
  bool _lastArticle = false;
  String searchQuery = "";

  Future<void> _requestData() async {
    if (_lastArticle) return;
    List<SearchArticles> articles =
        await ApiService.searchList(http.Client(), _page, searchQuery);
    if (articles.isNotEmpty) {
      if (_page == 1) {
        _listArticles.clear();
      }
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
        leading: const BackButton(),
        title: _searchWidget(),
        actions: _buildAction(),
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
                title: _listArticles[index].title,
                subtitle: _listArticles[index].url,
              );
            },
            itemCount: _listArticles.length,
          ),
          _lastArticle || _listArticles.length < 10
              ? const Text('No more article', textAlign: TextAlign.center)
              : const LinearProgressIndicator(),
          const SizedBox(height: 15),
        ],
      ),
    );
  }

  Widget _searchWidget() {
    return TextField(
      controller: _searchController,
      autofocus: true,
      decoration: const InputDecoration(
        hintText: "Search article..",
        border: InputBorder.none,
        hintStyle: TextStyle(color: Colors.white30, fontSize: 16.0),
      ),
      onChanged: (query) => _updateSearchQuery(query),
    );
  }

  List<Widget> _buildAction() {
    return <Widget>[
      IconButton(
        icon: const Icon(Icons.clear),
        onPressed: () {
          if (_searchController.text.isEmpty) {
            Navigator.pop(context);
            return;
          }
          _clearSearchQuery();
        },
      ),
    ];
  }

  _updateSearchQuery(String query) {
    setState(() {
      _page = 1;
      searchQuery = query;
      _requestData();
    });
  }

  _clearSearchQuery() {
    setState(() {
      _searchController.clear();
      _updateSearchQuery("");
    });
  }
}
