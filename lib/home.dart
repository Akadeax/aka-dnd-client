import 'package:aka_dnd_client/api.dart';
import 'package:aka_dnd_client/collection_display.dart';
import 'package:aka_dnd_client/user.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Future<User>? _futureUser;
  String _usernameInputText = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
          children: [usernameInput(context), collectionListDisplay(context)]),
    ));
  }

  Widget usernameInput(BuildContext context) {
    return Column(
      children: [
        TextField(
          decoration: const InputDecoration(hintText: "Enter username..."),
          textInputAction: TextInputAction.search,
          onChanged: (text) {
            _usernameInputText = text;
          },
          onSubmitted: (text) {
            setState(() {
              _futureUser = fetchUserFromName(text);
            });
          },
        ),
        IconButton(
          icon: const Icon(Icons.search),
          onPressed: () {
            setState(() {
              _futureUser = fetchUserFromName(_usernameInputText);
            });
          },
        )
      ],
    );
  }

  Widget collectionListDisplay(BuildContext context) {
    return FutureBuilder(
      future: _futureUser,
      builder: (ctx, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          if (snapshot.hasData) {
            final collections = snapshot.data!.joinedCollections;
            return Expanded(
              child: ListView.builder(
                  itemExtent: 300,
                  scrollDirection: Axis.horizontal,
                  itemCount: collections.length,
                  itemBuilder: (ctx, i) => CollectionDisplay(collections[i])),
            );
          } else if (snapshot.hasError) {
            return Text(snapshot.error.toString());
          }
        }

        return const Padding(
          padding: EdgeInsets.all(32.0),
          child: CircularProgressIndicator(),
        );
      },
    );
  }
}
