import 'package:flutter/material.dart';
import '../models/space_object_model.dart';
import 'package:cached_network_image/cached_network_image.dart';

class SpaceObjectCard extends StatelessWidget {
  final SpaceObject object;
  final VoidCallback onTap;

  const SpaceObjectCard({Key? key, required this.object, required this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      clipBehavior: Clip.hardEdge,
      child: InkWell(
        onTap: onTap,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            CachedNetworkImage(
              imageUrl: object.imageUrl,
              height: 130,
              fit: BoxFit.cover,
              placeholder: (context, url) => LinearProgressIndicator(),
              errorWidget: (context, url, error) => Icon(Icons.error),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                object.name,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: Theme.of(context).textTheme.bodyMedium,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
