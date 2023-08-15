import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:sofomo_task/UI/repositories_list/repository_tile_logic_widget.dart';
import 'package:sofomo_task/structs/github_repository.dart';
import 'package:sofomo_task/utils/repositories_provider.dart';

class RepositoryListView extends ConsumerStatefulWidget {
  final List<GitHubRepository> data;
  final bool hasMore;
  final bool isLoadingMore;
  final String searchKeyword;

  const RepositoryListView(
      {required this.data,
      required this.hasMore,
      required this.isLoadingMore,
      required this.searchKeyword});

  @override
  _RepositoryListViewState createState() => _RepositoryListViewState();
}

class _RepositoryListViewState extends ConsumerState<RepositoryListView> {
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
        ref.read(repositoriesProvider.notifier).fetchMore(widget.searchKeyword);
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
    return Expanded(
      child: ListView.builder(
        controller: _scrollController,
        itemCount: widget.data.length + 1,
        itemBuilder: (context, index) {
          if (index < widget.data.length) {
            return RepositoryTileLogicWidget(repo: widget.data[index]);
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
