import 'package:http/http.dart' as http;
import 'dart:async';
import 'package:booksapp/api_storing.dart';
import 'dart:io';

class HttpService {
// final post = postFromJson(jsonString);
  String url = 'https://run.mocky.io/v3/f3feef1c-9bfa-43fd-b2a0-bbe9abadb4f6';

  Future<List<Client>> getAllPosts() async {
    final response = await http.get(Uri.parse(url));
    return allPostsFromJson(response.body);
  }

  Future<Post> getPost() async {
    final response = await http.get(Uri.parse(
        'https://run.mocky.io/v3/f3feef1c-9bfa-43fd-b2a0-bbe9abadb4f6'));
    return postFromJson(response.body);
  }
}

Future<http.Response> createPost(Post post) async {
  final response = await http.post(
      Uri.parse('https://run.mocky.io/v3/f3feef1c-9bfa-43fd-b2a0-bbe9abadb4f6'),
      headers: {
        HttpHeaders.contentTypeHeader: 'application/json',
        HttpHeaders.authorizationHeader: ''
      },
      body: postToJson(post));
  return response;
}
