import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:rxdart/rxdart.dart';

import '../../../../di/app_di.dart';
import '../../../data/inputs/search_art_previews_input.dart';
import '../../../data/models/pagination/pagination.dart';
import '../../../data/models/preview/art_preview.dart';
import '../../../data/repositories/art_repository.dart';
import '../../../navigation/router.dart';

part 'search_event.dart';
part 'search_pagination_state.dart';
part 'search_state.dart';

class SearchBloc extends Bloc<SearchEvent, SearchState> {
  final ArtRepository _artRepository;

  final StreamController<String> _queryController = StreamController<String>();

  SearchBloc({
    required ArtRepository artRepository,
  })  : _artRepository = artRepository,
        super(
          const SearchIdle(suggestions: <String>{}),
        ) {
    on<SearchQuery>(_onQuery);
    on<SearchCompleted>(_handleSearchResult);
    on<SearchPaginate>(_onPaginate);
    on<SearchScroll>(_onScroll);
    on<SearchResultSelected>(_onSearchResultSelected);
    on<UpdateSearchSuggestions>(_onUpdateSearchSuggestions);
    _initializeStream();
  }

  void _initializeStream() {
    _queryController.stream
        .debounceTime(
          const Duration(milliseconds: 300),
        )
        .switchMap(
          (String query) => _searchArt(
            query: query,
            currentSuggestions: state.suggestions,
          ),
        )
        .listen(
      (SearchState state) {
        add(
          SearchCompleted(
            resultState: state,
          ),
        );
      },
    );
  }

  Stream<SearchState> _searchArt({
    required String query,
    required Set<String> currentSuggestions,
  }) async* {
    try {
      yield SearchLoading(suggestions: currentSuggestions);

      final PaginatedResponse<ArtPreview> response = await _artRepository.searchArtPreviews(
        SearchArtPreviewsInput(
          query: query,
          limit: 20,
          page: 1,
        ),
      );

      yield SearchSuccess(
        query: query,
        artPreviews: List<ArtPreview>.from(response.data),
        paginationState: SearchPaginationSuccess(
          pagination: response.pagination,
        ),
        suggestions: currentSuggestions,
      );
    } catch (e) {
      yield SearchFailure(suggestions: currentSuggestions);
    }
  }

  void _onQuery(
    SearchQuery event,
    Emitter<SearchState> emit,
  ) {
    _queryController.add(event.query);
  }

  void _handleSearchResult(
    SearchCompleted event,
    Emitter<SearchState> emit,
  ) {
    emit(event.resultState);
  }

  void _onSearchResultSelected(
    SearchResultSelected event,
    Emitter<SearchState> emit,
  ) {
    router.push(
      DetailsRoute(artPreview: event.artPreview),
    );
  }

  Future<void> _onPaginate(
    SearchPaginate event,
    Emitter<SearchState> emit,
  ) async {
    final SearchState state = this.state;

    if (state is! SearchSuccess) return;

    try {
      emit(
        state.copyWith(
          paginationState: const SearchPaginationLoading(),
        ),
      );

      final PaginatedResponse<ArtPreview> response = await _artRepository.searchArtPreviews(
        SearchArtPreviewsInput(
          query: state.query,
          limit: event.limit,
          page: event.page,
        ),
      );

      emit(
        state.copyWith(
          artPreviews: state.artPreviews..addAll(response.data),
          paginationState: SearchPaginationSuccess(
            pagination: response.pagination,
          ),
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          paginationState: const SearchPaginationFailure(),
        ),
      );
    }
  }

  void _onUpdateSearchSuggestions(
    UpdateSearchSuggestions event,
    Emitter<SearchState> emit,
  ) {
    final SearchState state = this.state;

    if (state is! SearchSuccess) return;

    if (event.suggestion.isEmpty) return;

    final Set<String> updateSuggestions = Set<String>.from(state.suggestions);
    updateSuggestions.add(event.suggestion);

    emit(
      state.copyWith(suggestions: updateSuggestions),
    );
  }

  Future<void> _onScroll(
    SearchScroll event,
    Emitter<SearchState> emit,
  ) async {
    final SearchState state = this.state;

    if (state is! SearchSuccess) return;

    final SearchPaginationState paginationState = state.paginationState;

    if (paginationState is! SearchPaginationSuccess) return;
    if (paginationState.hasReachedEnd) return;
    if (event.offset < (event.maxOffset * 0.9)) return;

    add(
      SearchPaginate(
        limit: paginationState.pagination.limit,
        page: paginationState.pagination.currentPage + 1,
      ),
    );
  }
}
