import 'package:flutter/material.dart';

class SearchFailureWidget extends StatelessWidget {
  const SearchFailureWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final TextTheme textTheme = Theme.of(context).textTheme;
    final ColorScheme colorScheme = Theme.of(context).colorScheme;

    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 12,
        ),
        child: Column(
          spacing: 10,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            //
            Icon(
              Icons.error_outline,
              size: 50,
              color: colorScheme.error,
            ),

            Text(
              'Oops! Something went wrong. Please try again.',
              textAlign: TextAlign.center,
              style: textTheme.bodyLarge,
            ),
          ],
        ),
      ),
    );
  }
}
