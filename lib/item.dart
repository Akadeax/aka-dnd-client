import 'dart:convert';

class Item {
  String id;
  double amount;
  String name;

  Item({
    required this.id,
    required this.amount,
    required this.name,
  });

  factory Item.fromRawJson(String str) => Item.fromJson(json.decode(str));
  static List<Item> fromRawJsonArray(String str) {
    List<dynamic> decoded = json.decode(str);
    List<Item> list = [];

    for (dynamic item in decoded) {
      list.add(Item.fromJson(item));
    }

    list.sort((a, b) => b.amount.compareTo(a.amount));
    return list;
  }

  String toRawJson() => json.encode(toJson());

  factory Item.fromJson(Map<String, dynamic> json) => Item(
        id: json["_id"],
        amount: json["amount"],
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "amount": amount,
        "name": name,
      };
}
