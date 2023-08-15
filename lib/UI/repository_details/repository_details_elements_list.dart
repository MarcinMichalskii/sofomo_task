import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:sofomo_task/UI/components/github_tile_widget.dart';
import 'package:sofomo_task/utils/texts.dart';

class RepositoryDetailsElementsList extends ConsumerStatefulWidget {
  final List<TileViewModel> data;
  final bool hasMore;
  final bool isLoadingMore;
  final VoidCallback onBottomReach;

  const RepositoryDetailsElementsList(
      {super.key,
      required this.data,
      required this.hasMore,
      required this.isLoadingMore,
      required this.onBottomReach});

  @override
  _RepositoryListViewState createState() => _RepositoryListViewState();
}

class _RepositoryListViewState
    extends ConsumerState<RepositoryDetailsElementsList> {
  final _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();

    _scrollController.addListener(() {
      if (!widget.hasMore) {
        return;
      }
      if (_scrollController.position.maxScrollExtent ==
          _scrollController.offset) {
        widget.onBottomReach();
      }
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return widget.data.isEmpty
        ? Text(Texts.noData)
        : Expanded(
            child: ListView.builder(
              controller: _scrollController,
              itemCount: widget.data.length + 1,
              itemBuilder: (context, index) {
                if (index < widget.data.length) {
                  return GithubTileWidget(viewModel: widget.data[index]);
                } else if (widget.isLoadingMore) {
                  return const Center(child: CircularProgressIndicator());
                } else {
                  return Container();
                }
              },
            ),
          );
  }
}
