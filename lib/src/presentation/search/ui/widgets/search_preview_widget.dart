import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../data/models/preview/art_preview.dart';
import '../../bloc/search_bloc.dart';
import 'search_failure_widget.dart';
import 'search_idle_widget.dart';
import 'search_loading_widget.dart';
import 'search_success_widget.dart';

class SearchPreviewWidget extends StatelessWidget {
  const SearchPreviewWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SearchBloc, SearchState>(
      builder: (_, SearchState state) {
        return switch (state) {
          SearchIdle() => const SearchIdleWidget(),
          SearchLoading() => const SearchLoadingWidget(),
          SearchFailure() => const SearchFailureWidget(),
          SearchSuccess(
            :final List<ArtPreview> artPreviews,
            :final SearchPaginationState paginationState,
          ) =>
            SearchSuccessWidget(
              artPreviews: artPreviews,
              paginationState: paginationState,
            ),
        };
      },
    );
  }
}
