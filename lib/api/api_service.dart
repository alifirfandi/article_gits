import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/articles.dart';
import '../models/user.dart';

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
}
