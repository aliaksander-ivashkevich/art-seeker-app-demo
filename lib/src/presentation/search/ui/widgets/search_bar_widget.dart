import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../bloc/search_bloc.dart';

class SearchBarWidget extends StatefulWidget {
  const SearchBarWidget({super.key});

  @override
  State<SearchBarWidget> createState() => _SearchBarWidgetState();
}

class _SearchBarWidgetState extends State<SearchBarWidget> {
  late final SearchBloc _bloc = context.read<SearchBloc>();

  void _handleQueryChanged(String query) {
    _bloc.add(
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
            Size.fromHeight(
              min(
                max(
                  70.0 * _bloc.state.suggestions.length + 50,
                  110.0,
                ),
                300,
              ),
            ),
          ),
          builder: (_, SearchController controller) {
            return Focus(
              onFocusChange: (bool isFocused) {
                if (isFocused) {
                  _bloc.add(
                    UpdateSearchSuggestions(
                      suggestion: controller.text,
                    ),
                  );
                }
              },
              child: SearchBar(
                controller: controller,
                padding: const WidgetStatePropertyAll<EdgeInsets>(
                  EdgeInsets.symmetric(horizontal: 16.0),
                ),
                onTap: controller.openView,
                onChanged: (String query) => controller.openView(),
                leading: const Icon(Icons.search),
              ),
            );
          },
          suggestionsBuilder: (_, SearchController controller) {
            final Set<String> suggestions = _bloc.state.suggestions;

            if (suggestions.isEmpty) {
              return <Widget>[
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Text(
                    'No suggestions available',
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: Colors.grey,
                        ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ];
            }

            final Iterable<String> reversedSuggestions = suggestions.toList().reversed;

            return reversedSuggestions.map(
              (String suggestion) {
                return SizedBox(
                  height: 70,
                  child: ListTile(
                    leading: const Icon(Icons.watch_later_outlined),
                    title: Text(suggestion),
                    onTap: () => controller.closeView(suggestion),
                  ),
                );
              },
            );
          },
        );
      },
    );
  }
}
