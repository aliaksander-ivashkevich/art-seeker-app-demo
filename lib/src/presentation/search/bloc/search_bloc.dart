import 'package:bloc/bloc.dart';

import '../../../data/inputs/search_art_previews_input.dart';
import '../../../data/models/pagination/pagination.dart';
import '../../../data/models/preview/art_preview.dart';
import '../../../data/repositories/art_repository.dart';

part 'search_event.dart';
part 'search_pagination_state.dart';
part 'search_state.dart';

class SearchBloc extends Bloc<SearchEvent, SearchState> {
  final ArtRepository _artRepository;

  SearchBloc({
    required ArtRepository artRepository,
  })  : _artRepository = artRepository,
        super(const SearchIdle()) {
    on<SearchQuery>(_onQuery);
    on<SearchPaginate>(_onPaginate);
    on<SearchScroll>(_onScroll);
  }

  Future<void> _onQuery(
    SearchQuery event,
    Emitter<SearchState> emit,
  ) async {
    try {
      emit(
        const SearchLoading(),
      );

      final PaginatedResponse<ArtPreview> response =
          await _artRepository.searchArtPreviews(
        SearchArtPreviewsInput(
          query: event.query,
          limit: 20,
          page: 1,
        ),
      );

      emit(
        SearchSuccess(
          query: event.query,
          artPreviews: List<ArtPreview>.from(response.data),
          paginationState: SearchPaginationSuccess(
            pagination: response.pagination,
          ),
        ),
      );
    } catch (e) {
      emit(
        const SearchFailure(),
      );
    }
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

      final PaginatedResponse<ArtPreview> response =
          await _artRepository.searchArtPreviews(
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
