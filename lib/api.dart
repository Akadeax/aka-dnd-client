import 'package:aka_dnd_client/item.dart';
import 'package:aka_dnd_client/user.dart';
import 'package:http/http.dart' as http;

const String baseURL = "http://127.0.0.1:6556/";
const String itemAPI = "${baseURL}item";
const String usersAPI = "${baseURL}users";

Future<User> fetchUserFromName(String name) async {
  final response = await http.get(Uri.parse("$usersAPI?name=$name"));

  if (response.statusCode == 200) {
    return User.fromRawJson(response.body);
  }

  throw Exception("Failed to load user");
}

Future<List<Item>> fetchCollectionItems(String collectionName) async {
  final response =
      await http.get(Uri.parse("$itemAPI?collection=$collectionName"));

  if (response.statusCode == 200) {
    return Item.fromRawJsonArray(response.body);
  }

  throw Exception("Failed to load item for $collectionName");
}
