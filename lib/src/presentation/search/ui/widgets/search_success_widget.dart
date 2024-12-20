import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../data/models/preview/art_preview.dart';
import '../../bloc/search_bloc.dart';

class SearchSuccessWidget extends StatefulWidget {
  final List<ArtPreview> artPreviews;
  final SearchPaginationState paginationState;

  const SearchSuccessWidget({
    required this.artPreviews,
    required this.paginationState,
    super.key,
  });

  @override
  State<SearchSuccessWidget> createState() => _SearchSuccessWidgetState();
}

class _SearchSuccessWidgetState extends State<SearchSuccessWidget> {
  late final SearchBloc _bloc = context.read<SearchBloc>();
  final ScrollController _scrollController = ScrollController();

  void _handleScroll() {
    _bloc.add(
      SearchScroll(
        offset: _scrollController.offset,
        maxOffset: _scrollController.position.maxScrollExtent,
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_handleScroll);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      controller: _scrollController,
      slivers: <Widget>[
        //
        SliverPadding(
          padding: const EdgeInsets.symmetric(vertical: 30),
          sliver: SliverList.separated(
            separatorBuilder: (BuildContext context, int index) {
              return const SizedBox(height: 10);
            },
            itemBuilder: (_, int index) {
              final ArtPreview artPreview = widget.artPreviews[index];

              return ListTile(
                leading: SizedBox.square(
                  dimension: 70,
                  child: Image.network(
                    artPreview.previewImageUrl,
                    fit: BoxFit.contain,
                    errorBuilder: (_, __, ___) {
                      return const Icon(
                        Icons.image_not_supported_outlined,
                        size: 40,
                      );
                    },
                  ),
                ),
                title: Text(
                  artPreview.title,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                subtitle: Text(
                  <String?>[
                    artPreview.artist,
                    artPreview.date,
                  ].whereType<String>().join(', '),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                onTap: () => _bloc.add(
                  SearchResultSelected(artPreview: artPreview),
                ),
              );
            },
            itemCount: widget.artPreviews.length,
          ),
        ),

        SliverPadding(
          padding: const EdgeInsets.only(bottom: 60),
          sliver: SliverToBoxAdapter(
            child: Center(
              child: switch (widget.paginationState) {
                SearchPaginationLoading() => const CircularProgressIndicator(),
                SearchPaginationFailure() => const Column(
                    children: <Widget>[
                      //
                      Icon(
                        Icons.warning_amber_rounded,
                      ),

                      Text(
                        'Failed to load',
                      ),
                    ],
                  ),
                SearchPaginationSuccess(:final bool hasReachedEnd) => Text(
                    hasReachedEnd.toString(),
                  ),
              },
            ),
          ),
        ),
      ],
    );
  }
}
