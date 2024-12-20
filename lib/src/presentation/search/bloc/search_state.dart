part of 'search_bloc.dart';

sealed class SearchState extends Equatable {
  final Set<String> suggestions;
  const SearchState({required this.suggestions});
}

final class SearchIdle extends SearchState {
  @override
  List<Object> get props => <Object>[suggestions];

  const SearchIdle({required Set<String> suggestions}) : super(suggestions: suggestions);
}

final class SearchLoading extends SearchState {
  @override
  List<Object> get props => <Object>[suggestions];

  const SearchLoading({required Set<String> suggestions}) : super(suggestions: suggestions);
}

final class SearchFailure extends SearchState {
  @override
  List<Object> get props => <Object>[suggestions];

  const SearchFailure({required Set<String> suggestions}) : super(suggestions: suggestions);
}

final class SearchSuccess extends SearchState {
  final String query;
  final List<ArtPreview> artPreviews;
  final SearchPaginationState paginationState;

  const SearchSuccess({
    required this.query,
    required this.artPreviews,
    required this.paginationState,
    required Set<String> suggestions,
  }) : super(suggestions: suggestions);

  @override
  List<Object> get props => <Object>[
        query,
        artPreviews,
        paginationState,
        suggestions,
      ];

  SearchSuccess copyWith({
    String? query,
    List<ArtPreview>? artPreviews,
    SearchPaginationState? paginationState,
    Set<String>? suggestions,
  }) {
    return SearchSuccess(
      query: query ?? this.query,
      artPreviews: artPreviews ?? this.artPreviews,
      paginationState: paginationState ?? this.paginationState,
      suggestions: suggestions ?? this.suggestions,
    );
  }
}
