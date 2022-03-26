import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:yess_nutrion/model/resto.dart';

class ApiService {
  static final String _baseUrl = "https://restaurant-api.dicoding.dev/";
  static final String imgUrl =
      'https://restaurant-api.dicoding.dev/images/medium/';

  Future<RestoList> restaurantList() async {
    final response = await http.get(Uri.parse(_baseUrl + "list"));
    if (response.statusCode == 200) {
      return RestoList.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load the restaurant list');
    }
  }

  Future<RestoList> restaurantDetail(String id) async {
    final response = await http.get(Uri.parse(_baseUrl + "detail/$id"));
    if (response.statusCode == 200) {
      return RestoList.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load the restaurant details.');
    }
  }
}