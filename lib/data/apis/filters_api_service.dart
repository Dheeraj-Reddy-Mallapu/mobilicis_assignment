// import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:mobilicis_assignment/data/objects/filter_object.dart';

class FiltersApiService {
  static const String baseUrl = 'https://dev2be.oruphones.com/api/v1/global/assignment/getFilters';

  Future<Filter> fetchFilter(bool isLimited) async {
    final Uri uri = Uri.parse('$baseUrl?isLimited=${isLimited.toString()}');

    final response = await http.get(uri);

    if (response.statusCode == 200) {
      return filterFromJson(response.body);
    } else {
      throw Exception('Failed to load filters');
    }
  }
}
