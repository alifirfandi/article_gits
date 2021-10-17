import 'dart:convert';
import 'dart:developer';
import 'package:flutter_article_gits/models/search.dart';
import 'package:http/http.dart' as http;
import '../models/articles.dart';
import '../models/user.dart';
import '../models/search.dart';

class ApiService {
  static const String _baseUrl = 'https://gits-msib.my.id/wp-json';

  static Future<List<Articles>> listArticle(
    http.Client client,
    int page,
  ) async {
    final response =
        await client.get(Uri.parse(_baseUrl + "/wp/v2/posts?page=$page"));
    if (response.statusCode == 200) {
      return articlesFromJson(response.body);
    } else {
      return [];
    }
  }

  static Future<User?> login(
    http.Client client,
    String username,
    String password,
  ) async {
    var body = {'username': username, 'password': password};

    final response = await client.post(
      Uri.parse(_baseUrl + "/jwt-auth/v1/token"),
      body: body,
    );

    if (response.statusCode == 200) {
      return User.fromJson(json.decode(response.body));
    } else {
      return null;
    }
  }

  static Future<List<SearchArticles>> searchList(
    http.Client client,
    int page,
    String searchQuery,
  ) async {
    http.Response? response;
    log(" DATA $searchQuery Page $page");
    if (searchQuery.isNotEmpty) {
      log(" DATA QUERY $searchQuery Page $page");
      response = await client.get(
          Uri.parse(_baseUrl + "/wp/v2/search?search=$searchQuery&page=$page"));
    } else {
      log(" DATA QUERY NOT $searchQuery");
      response =
          await client.get(Uri.parse(_baseUrl + "/wp/v2/search?&page=$page"));
    }
    if (response.statusCode == 200) {
      return searchArticlesFromJson(response.body);
    } else {
      return [];
    }
  }
}
