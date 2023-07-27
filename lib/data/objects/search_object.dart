// To parse this JSON data, do
//
//     final search = searchFromJson(jsonString);

import 'dart:convert';

Search searchFromJson(String str) => Search.fromJson(json.decode(str));

String searchToJson(Search data) => json.encode(data.toJson());

class Search {
  List<String> makes;
  List<String> models;

  Search({
    required this.makes,
    required this.models,
  });

  factory Search.fromJson(Map<String, dynamic> json) => Search(
        makes: List<String>.from(json["makes"].map((x) => x)),
        models: List<String>.from(json["models"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "makes": List<dynamic>.from(makes.map((x) => x)),
        "models": List<dynamic>.from(models.map((x) => x)),
      };
}
