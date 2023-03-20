import 'dart:convert';

import "package:http/http.dart" as http;

Future<List> getNews(String category) async {
  List news = [];

  final response = await http.get(
    Uri.parse("https://inshorts.deta.dev/news?category=$category"),
  );

  switch(response.statusCode){
    case 200:
    news = jsonDecode(response.body)["data"] as List;
    return news;

    default:
    news = [];
    break;
  }

  return news;
}