import 'package:flutter/material.dart';

import '../../../data/models/preview/art_preview.dart';

class DetailsContent extends StatelessWidget {
  final ArtPreview artPreview;

  const DetailsContent({
    required this.artPreview,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final TextTheme textTheme = Theme.of(context).textTheme;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Center(
        child: Column(
          children: <Widget>[
            ClipRRect(
              borderRadius: const BorderRadius.all(
                Radius.circular(8),
              ),
              child: Image.network(
                artPreview.fullImageUrl,
                errorBuilder: (BuildContext context, Object exception, StackTrace? stackTrace) {
                  return const Icon(Icons.image_not_supported);
                },
              ),
            ),
            const SizedBox(height: 20),
            Text(
              textAlign: TextAlign.center,
              artPreview.title,
              style: textTheme.headlineMedium,
            ),
            const SizedBox(height: 12),
            Text(
              textAlign: TextAlign.center,
              artPreview.date ?? 'unknown',
              style: textTheme.labelMedium,
            ),
            const SizedBox(height: 12),
            Text(
              textAlign: TextAlign.center,
              artPreview.artist ?? 'unknown',
              style: textTheme.labelMedium,
            ),
            const SizedBox(height: 12),
          ],
        ),
      ),
    );
  }
}
