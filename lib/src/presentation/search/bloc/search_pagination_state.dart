part of 'search_bloc.dart';

sealed class SearchPaginationState {
  const SearchPaginationState();
}

final class SearchPaginationLoading extends SearchPaginationState {
  const SearchPaginationLoading();
}

final class SearchPaginationFailure extends SearchPaginationState {
  const SearchPaginationFailure();
}

final class SearchPaginationSuccess extends SearchPaginationState {
  final Pagination pagination;

  const SearchPaginationSuccess({
    required this.pagination,
  });

  bool get hasReachedEnd => pagination.hasReachedEnd;
}
