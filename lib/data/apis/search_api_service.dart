import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:mobilicis_assignment/data/objects/search_object.dart';

class SearchApiService {
  static const String baseUrl = 'https://dev2be.oruphones.com/api/v1/global/assignment/searchModel';

  Future<Search> performSearch(String searchText) async {
    final Uri uri = Uri.parse(baseUrl);

    final response = await http.post(
      uri,
      headers: {'Content-Type': 'application/json'},
      body: json.encode({'searchModel': searchText}),
    );

    if (response.statusCode == 200) {
      return searchFromJson(response.body);
    } else {
      throw Exception('Failed to perform search');
    }
  }
}
