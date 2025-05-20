
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/space_object_model.dart';
import 'object_detail_page.dart';
import '../services/nasa_api_service.dart';

class FavoritesPage extends StatefulWidget {
  @override
  State<FavoritesPage> createState() => _FavoritesPageState();
}

class _FavoritesPageState extends State<FavoritesPage> {
  List<String> favoriteNames = [];
  List<SpaceObject> favoriteObjects = [];
  final NasaApiService _apiService = NasaApiService();

  @override
  void initState() {
    super.initState();
    _loadFavorites();
  }

  Future<void> _loadFavorites() async {
    final prefs = await SharedPreferences.getInstance();
    final favs = prefs.getStringList('favorites') ?? [];
    setState(() {
      favoriteNames = favs;
    });
    await _fetchFavoriteObjects();
  }

  Future<void> _fetchFavoriteObjects() async {
    List<SpaceObject> loadedObjects = [];
    for (var name in favoriteNames) {
      try {
        // Используем поиск по имени, получаем первый результат
        final list = await _apiService.searchObjects(name);
        if (list.isNotEmpty) {
          loadedObjects.add(list.first);
        }
      } catch (_) {}
    }
    setState(() {
      favoriteObjects = loadedObjects;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Favorites')),
      body: favoriteObjects.isEmpty
          ? Center(child: Text('No favorites added'))
          : ListView.separated(
              itemCount: favoriteObjects.length,
              separatorBuilder: (_, __) => Divider(),
              itemBuilder: (context, index) {
                final obj = favoriteObjects[index];
                return ListTile(
                  title: Text(obj.name),
                  subtitle: Text(
                    obj.description,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  leading: obj.imageUrl.isNotEmpty
                      ? Image.network(obj.imageUrl,
                          width: 50, fit: BoxFit.cover)
                      : Icon(Icons.image_not_supported),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => ObjectDetailPage(spaceObject: obj),
                      ),
                    );
                  },
                );
              },
            ),
    );
  }
}