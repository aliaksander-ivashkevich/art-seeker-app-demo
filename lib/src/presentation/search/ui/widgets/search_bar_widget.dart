import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../bloc/search_bloc.dart';

class SearchBarWidget extends StatefulWidget {
  const SearchBarWidget({super.key});

  @override
  State<SearchBarWidget> createState() => _SearchBarWidgetState();
}

class _SearchBarWidgetState extends State<SearchBarWidget> {
  void _handleQueryChanged(String query) {
    context.read<SearchBloc>().add(
          SearchQuery(query: query),
        );
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SearchBloc, SearchState>(
      builder: (_, SearchState state) {
        return SearchAnchor(
          isFullScreen: false,
          viewOnChanged: _handleQueryChanged,
          viewConstraints: BoxConstraints.loose(
            const Size.fromHeight(300),
          ),
          builder: (_, SearchController controller) {
            return SearchBar(
              controller: controller,
              padding: const WidgetStatePropertyAll<EdgeInsets>(
                EdgeInsets.symmetric(horizontal: 16.0),
              ),
              onTap: controller.openView,
              onChanged: (String query) => controller.openView(),
              leading: const Icon(Icons.search),
            );
          },
          suggestionsBuilder: (_, SearchController controller) {
            return List<ListTile>.generate(
              5,
              (int index) {
                final String item = 'item $index';

                return ListTile(
                  title: Text(item),
                  onTap: () {
                    controller.closeView(item);
                    // setState(() {
                    // });
                  },
                );
              },
            );
          },
        );
      },
    );
  }
}
