
import 'package:flutter/material.dart';
import '../models/space_object_model.dart';
import '../services/nasa_api_service.dart';
import 'object_detail_page.dart';
import '../widgets/space_object_card.dart';

class ObjectListPage extends StatefulWidget {
  final String category;

  const ObjectListPage({Key? key, required this.category}) : super(key: key);

  @override
  State<ObjectListPage> createState() => _ObjectListPageState();
}

class _ObjectListPageState extends State<ObjectListPage> {
  final NasaApiService _apiService = NasaApiService();
  late Future<List<SpaceObject>> _objects;

  
  final Map<String, List<String>> planetMoons = {
    'Mercury': [], 
    'Venus': [],
    'Earth': ['Moon'], 
    'Mars': ['Phobos', 'Deimos'],
    'Jupiter': ['Io', 'Europa', 'Ganymede', 'Callisto'],
    'Saturn': ['Titan', 'Enceladus', 'Rhea'],
    'Uranus': ['Miranda', 'Ariel', 'Umbriel', 'Titania', 'Oberon'],
    'Neptune': ['Triton', 'Nereid'],
  };

  String? selectedMoon;

  @override
  void initState() {
    super.initState();
    _loadObjects();
  }

  void _loadObjects() {
    String query = selectedMoon ?? widget.category;
    _objects = _apiService.searchObjects(query);
  }

  void _onMoonSelected(String? moon) {
    setState(() {
      selectedMoon = moon;
      _loadObjects();
    });
  }

  bool get isPlanetWithMoons => planetMoons.containsKey(widget.category);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(selectedMoon ?? widget.category)),
      body: Column(
        children: [
          if (isPlanetWithMoons)
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: DropdownButton<String>(
                hint: Text('Select a moon'),
                value: selectedMoon,
                items: [
                  DropdownMenuItem(
                    child: Text('All (${widget.category})'),
                    value: null,
                  ),
                  ...planetMoons[widget.category]!.map(
                    (moon) => DropdownMenuItem(
                      child: Text(moon),
                      value: moon,
                    ),
                  ),
                ],
                onChanged: _onMoonSelected,
                isExpanded: true,
              ),
            ),
          Expanded(
            child: FutureBuilder<List<SpaceObject>>(
              future: _objects,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(child: Text('Ошибка: ${snapshot.error}'));
                } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return const Center(child: Text('Нет данных.'));
                }

                final objects = snapshot.data!;
                return ListView.separated(
                  padding: const EdgeInsets.all(12),
                  itemCount: objects.length,
                  separatorBuilder: (_, __) => const SizedBox(height: 10),
                  itemBuilder: (context, index) {
                    final object = objects[index];
                    return SpaceObjectCard(
                      object: object,
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) =>
                                ObjectDetailPage(spaceObject: object),
                          ),
                        );
                      },
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
