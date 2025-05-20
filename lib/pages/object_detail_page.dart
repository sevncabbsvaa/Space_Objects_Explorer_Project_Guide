asiman
import 'package:flutter/material.dart';
import '../models/space_object_model.dart';
import 'package:cached_network_image/cached_network_image.dart';

class ObjectDetailPage extends StatelessWidget {
  final SpaceObject spaceObject;

  const ObjectDetailPage({Key? key, required this.spaceObject})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(
          title: Text(spaceObject.name),
          backgroundColor: Colors.deepPurple[900],
        ),
        body: SingleChildScrollView(
            child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CachedNetworkImage(
              imageUrl: spaceObject.imageUrl,
              placeholder: (context, url) =>
                  LinearProgressIndicator(color: Colors.white),
              errorWidget: (context, url, error) =>
                  Icon(Icons.error, color: Colors.white),
              width: double.infinity,
              height: 250,
              fit: BoxFit.cover,
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    spaceObject.name,
                    style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                  ),
                  SizedBox(height: 8),
                  Text(
                    "Date: ${spaceObject.date}",
                    style: TextStyle(color: Colors.grey[300]),
                  ),
                  SizedBox(height: 16),
                  Text(
                    spaceObject.description,
                    style: TextStyle(color: Colors.white),
                  ),
                  SizedBox(height: 20),
                  Text(
                    "Source: NASA",
                    style: TextStyle(
                        fontStyle: FontStyle.italic, color: Colors.blue[100]),
                  ),
                ],
              ),
            ),
          ],
        )));
  }
}
