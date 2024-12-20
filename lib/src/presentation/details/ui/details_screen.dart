import 'package:auto_route/annotations.dart';
import 'package:flutter/widgets.dart';

@RoutePage()
class DetailsScreen extends StatelessWidget {
  final int artId;

  const DetailsScreen({
    @PathParam('id') required this.artId,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
