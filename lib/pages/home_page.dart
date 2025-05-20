import 'package:flutter/material.dart';
import 'object_list_page.dart';
import 'favorites_page.dart';

class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final Map<String, List<Map<String, dynamic>>> categorizedItems = {
    'Planets': [
      {'name': 'Mercury', 'icon': Icons.public},
      {'name': 'Venus', 'icon': Icons.language},
      {'name': 'Earth', 'icon': Icons.terrain},
      {'name': 'Mars', 'icon': Icons.sports_martial_arts},
      {'name': 'Jupiter', 'icon': Icons.blur_circular},
      {'name': 'Saturn', 'icon': Icons.brightness_2},
      {'name': 'Uranus', 'icon': Icons.brightness_3},
      {'name': 'Neptune', 'icon': Icons.water},
    ],
    'Other Objects': [
      {'name': 'Asteroid', 'icon': Icons.ac_unit},
      {'name': 'Comet', 'icon': Icons.waves},
      {'name': 'Nebula', 'icon': Icons.cloud},
      {'name': 'Galaxy', 'icon': Icons.auto_awesome},
    ],
  };

  String searchQuery = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.deepPurple,
        title: const Text('🌌 Space Objects Explorer'),
        actions: [
          IconButton(
            icon: const Icon(Icons.favorite),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => FavoritesPage()),
              );
            },
          ),
        ],
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(56),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: TextField(
              style: const TextStyle(color: Colors.white),
              decoration: InputDecoration(
                hintText: 'Search categories...',
                hintStyle: const TextStyle(color: Colors.white70),
                prefixIcon: const Icon(Icons.search, color: Colors.white70),
                filled: true,
                fillColor: Colors.deepPurple[700],
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide.none,
                ),
              ),
              onChanged: (value) {
                setState(() {
                  searchQuery = value;
                });
              },
            ),
          ),
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: categorizedItems.entries.map((entry) {
          final categoryTitle = entry.key;
          final items = entry.value
              .where((item) => item['name']
                  .toString()
                  .toLowerCase()
                  .contains(searchQuery.toLowerCase()))
              .toList();

          if (items.isEmpty) return SizedBox();

          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                categoryTitle,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 10),
              ...items.map((category) {
                return Card(
                  color: Colors.deepPurple[100],
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12)),
                  elevation: 6,
                  margin: const EdgeInsets.symmetric(vertical: 8),
                  child: ListTile(
                    contentPadding: const EdgeInsets.symmetric(
                        vertical: 12, horizontal: 16),
                    leading: CircleAvatar(
                      backgroundColor: Colors.deepPurple,
                      child: Icon(
                        category['icon'],
                        color: Colors.white,
                      ),
                    ),
                    title: Text(
                      category['name'],
                      style: const TextStyle(
                          fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    subtitle:
                        Text('Tap to explore more about ${category['name']}'),
                    trailing: const Icon(Icons.arrow_forward_ios),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) =>
                              ObjectListPage(category: category['name']),
                        ),
                      );
                    },
                  ),
                );
              }).toList(),
              const SizedBox(height: 20),
            ],
          );
        }).toList(),
      ),
    );
  }
}
