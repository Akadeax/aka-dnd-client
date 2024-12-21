import 'package:aka_dnd_client/api.dart';
import 'package:aka_dnd_client/item.dart';
import 'package:flutter/material.dart';

class CollectionDisplay extends StatefulWidget {
  final String collectionName;

  const CollectionDisplay(this.collectionName, {super.key});

  @override
  State<CollectionDisplay> createState() => _CollectionDisplayState();
}

class _CollectionDisplayState extends State<CollectionDisplay> {
  Future<List<Item>>? _futureItemList;

  @override
  void initState() {
    _futureItemList = fetchCollectionItems(widget.collectionName);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _futureItemList,
      builder: (ctx, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          if (snapshot.hasData) {
            return itemList(ctx, snapshot.data!);
          } else if (snapshot.hasError) {
            return Text("${snapshot.error}");
          }
        }

        return const CircularProgressIndicator();
      },
    );
  }

  Widget itemList(BuildContext context, List<Item> items) {
    return Container(
      color: Colors.black26,
      child: ListView.builder(
        scrollDirection: Axis.vertical,
        shrinkWrap: true,
        itemCount: items.length,
        itemBuilder: (ctx, i) {
          return Text(items[i].name);
        },
      ),
    );
  }
}
