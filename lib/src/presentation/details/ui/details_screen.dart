import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';

import '../../../../di/app_di.dart';
import '../../../data/models/preview/art_preview.dart';
import 'details_content.dart';

@RoutePage()
class DetailsScreen extends StatelessWidget {
  final ArtPreview artPreview;

  const DetailsScreen({
    required this.artPreview,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: router.popUntilRoot,
          icon: const Icon(Icons.arrow_back_ios),
        ),
      ),
      body: SafeArea(
        bottom: false,
        child: DetailsContent(
          artPreview: artPreview,
        ),
      ),
    );
  }
}
