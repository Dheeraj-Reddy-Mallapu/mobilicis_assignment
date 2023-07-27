// import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:mobilicis_assignment/data/objects/listing_object.dart';

class ListingApiService {
  static const String baseUrl = 'https://dev2be.oruphones.com/api/v1/global/assignment/getListings';

  Future<Listings> fetchListings(int page, int limit) async {
    final Uri uri = Uri.parse('$baseUrl?page=$page&limit=$limit');

    final response = await http.get(uri);

    if (response.statusCode == 200) {
      return listingsFromJson(response.body);
      // final List<dynamic> responseData = json.decode(response.body);
      // return responseData.map((json) => Listing.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load products');
    }
  }
}
