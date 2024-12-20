part of 'search_bloc.dart';

sealed class SearchState {
  const SearchState();
}

final class SearchIdle extends SearchState {
  const SearchIdle();
}

final class SearchLoading extends SearchState {
  const SearchLoading();
}

final class SearchFailure extends SearchState {
  const SearchFailure();
}

final class SearchSuccess extends SearchState {
  final String query;
  final List<ArtPreview> artPreviews;
  final SearchPaginationState paginationState;

  const SearchSuccess({
    required this.query,
    required this.artPreviews,
    required this.paginationState,
  });

  SearchSuccess copyWith({
    String? query,
    List<ArtPreview>? artPreviews,
    SearchPaginationState? paginationState,
  }) {
    return SearchSuccess(
      query: query ?? this.query,
      artPreviews: artPreviews ?? this.artPreviews,
      paginationState: paginationState ?? this.paginationState,
    );
  }
}
