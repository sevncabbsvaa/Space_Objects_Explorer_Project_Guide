
import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/space_object_model.dart';

class NasaApiService {
  Future<List<SpaceObject>> searchObjects(String keyword) async {
    final url =
        'https://images-api.nasa.gov/search?q=$keyword&media_type=image';
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      final items = data['collection']['items'] as List;

      return items.map((item) {
        final data = item['data'][0];
        final links = item['links'];
        return SpaceObject(
          name: data['title'] ?? 'No Title',
          description: data['description'] ?? 'No Description',
          imageUrl: links != null ? links[0]['href'] : '',
          date: data['date_created'] ?? '',
          type: keyword,
        );
      }).toList();
    } else {
      throw Exception('Failed to load search results');
    }
  }
}