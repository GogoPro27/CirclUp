import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class FavoritesScreen extends StatelessWidget {
  const FavoritesScreen({Key? key}) : super(key: key);

  Future<List<Map<String, dynamic>>> _fetchFavorites() async {
    final firestore = FirebaseFirestore.instance;

    // 1. Get the user1 document (hardcoded Nidzo Aerodrom)
    final userDoc = await firestore.collection("Users").doc("user1").get();
    final favorites = List<String>.from(userDoc["favoritePlaces"] ?? []);

    // 2. For each favorite place name, fetch its details from Places collection
    List<Map<String, dynamic>> places = [];
    for (final favName in favorites) {
      final query = await firestore
          .collection("Places")
          .where("name", isEqualTo: favName)
          .get();

      if (query.docs.isNotEmpty) {
        places.add(query.docs.first.data());
      }
    }

    return places;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Favorites')),
      body: FutureBuilder<List<Map<String, dynamic>>>(
        future: _fetchFavorites(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(child: Text("Error: ${snapshot.error}"));
          }
          final places = snapshot.data ?? [];
          if (places.isEmpty) {
            return const Center(child: Text("No favorites yet."));
          }

          return ListView.builder(
            itemCount: places.length,
            itemBuilder: (context, index) {
              final place = places[index];
              return ListTile(
                leading: CircleAvatar(
                  backgroundImage: AssetImage(place["logo"]),
                ),
                title: Text(place["name"]),
                subtitle: Text(place["description"]),
              );
            },
          );
        },
      ),
    );
  }
}
