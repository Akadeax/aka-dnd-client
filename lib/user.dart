import 'dart:convert';

class User {
  String id;
  List<dynamic> joinedCollections;
  String name;

  User({
    required this.id,
    required this.joinedCollections,
    required this.name,
  });

  factory User.fromRawJson(String str) => User.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory User.fromJson(Map<String, dynamic> json) => User(
        id: json["_id"],
        joinedCollections:
            List<dynamic>.from(json["joined_collections"].map((x) => x)),
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "joined_collections":
            List<dynamic>.from(joinedCollections.map((x) => x)),
        "name": name,
      };
}
