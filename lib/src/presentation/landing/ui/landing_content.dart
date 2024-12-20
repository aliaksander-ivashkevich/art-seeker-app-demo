import 'package:flutter/material.dart';

import '../../../../di/app_di.dart';
import '../../../theme/assets.dart';

class LandingContent extends StatelessWidget {
  const LandingContent({super.key});

  void _handleContinueTap() {
    router.replaceNamed('/search');
  }

  @override
  Widget build(BuildContext context) {
    final TextTheme textTheme = Theme.of(context).textTheme;

    return SafeArea(
      child: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            vertical: 60,
            horizontal: 20,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              //
              ClipRRect(
                borderRadius: const BorderRadius.all(
                  Radius.circular(40),
                ),
                child: Image.asset(
                  Assets.staryNightImagePath,
                  fit: BoxFit.contain,
                ),
              ),

              const SizedBox(height: 50),

              Text(
                'Discover Unique Artworks',
                style: textTheme.headlineMedium,
              ),

              const SizedBox(height: 10),

              Text(
                'Explore a world of creativity, browse diverse collections. Your next masterpiece awaits!',
                textAlign: TextAlign.center,
                style: textTheme.bodyLarge,
              ),

              const Spacer(),

              FilledButton.tonal(
                child: const Text('Continue'),
                onPressed: _handleContinueTap,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
