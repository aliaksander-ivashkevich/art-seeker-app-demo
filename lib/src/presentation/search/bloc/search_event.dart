part of 'search_bloc.dart';

sealed class SearchEvent {
  const SearchEvent();
}

final class SearchQuery extends SearchEvent {
  final String query;

  const SearchQuery({
    required this.query,
  });
}

final class SearchCompleted extends SearchEvent {
  final SearchState resultState;

  const SearchCompleted({
    required this.resultState,
  });
}

final class SearchPaginate extends SearchEvent {
  final int limit;
  final int page;

  const SearchPaginate({
    required this.limit,
    required this.page,
  });
}

final class SearchScroll extends SearchEvent {
  final double offset;
  final double maxOffset;

  const SearchScroll({
    required this.offset,
    required this.maxOffset,
  });
}

final class UpdateSearchSuggestions extends SearchEvent {
  final String suggestion;

  const UpdateSearchSuggestions({
    required this.suggestion,
  });
}

final class SearchResultSelected extends SearchEvent {
  final ArtPreview artPreview;

  const SearchResultSelected({
    required this.artPreview,
  });
}
