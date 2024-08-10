import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:news_app/data/ViewModels/vm_article.dart';

class ApiService {
  static const String _baseUrl = 'https://newsapi.org/v2/';
  static const String _apiKey = '2148acdf0fff4b67a3a9e4bf1bcf8809';
  static const String _category = 'business';
  static const String _country = 'us';

  Future<VmArticlesResult> topHeadlines() async {
    final response = await http.get(Uri.parse(
        "${_baseUrl}top-headlines?country=$_country&category=$_category&apiKey=$_apiKey"));
    if (response.statusCode == 200) {
      return VmArticlesResult.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load top headlines');
    }
  }
}
