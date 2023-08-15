import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:sofomo_task/UI/components/github_tile_widget.dart';
import 'package:sofomo_task/UI/repository_details/repository_details_elements_list.dart';
import 'package:sofomo_task/UI/repository_details/repository_details_tile_widget.dart';
import 'package:sofomo_task/UI/repository_details/repository_details_widget.dart';
import 'package:sofomo_task/structs/github_issue.dart';
import 'package:sofomo_task/structs/github_pr.dart';
import 'package:sofomo_task/structs/github_repository.dart';
import 'package:sofomo_task/utils/issues_provider.dart';
import 'package:sofomo_task/utils/prs_provider.dart.dart';

class RepositoryDetailsBody extends HookConsumerWidget {
  const RepositoryDetailsBody({
    Key? key,
    required this.selectedState,
    required this.repo,
    required this.issuesData,
    required this.prsData,
  }) : super(key: key);

  final ValueNotifier<DetailsState> selectedState;
  final GitHubRepository repo;
  final List<GitHubIssue> issuesData;
  final List<GitHubPr> prsData;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final issuesViewModels = issuesData
        .map((e) => TileViewModel(
            color: Colors.purple, title: e.title, subtitle: e.user.login))
        .toList();
    final hasMoreIssues = ref.watch(issuesProvider).hasMore;
    final isLoadingMoreIssuess = ref.watch(issuesProvider).isLoadingMore;
    final onLoadMoreIssuess = useCallback(() {
      ref.read(issuesProvider.notifier).fetchMore(repo.id);
    }, [issuesProvider]);

    final prsViewModels = prsData
        .map((e) => TileViewModel(
            color: Colors.green, title: e.title, subtitle: e.user.login))
        .toList();
    final hasMorePrs = ref.watch(prsProvider).hasMore;
    final isLoadingMorePrs = ref.watch(prsProvider).isLoadingMore;
    final onLoadMorePrs = useCallback(() {
      ref.read(prsProvider.notifier).fetchMore(repo.id);
    }, [issuesProvider]);

    if (selectedState.value == DetailsState.details) {
      return RepositoryDetailsTileWidget(repo: repo);
    }
    if (selectedState.value == DetailsState.prs) {
      return RepositoryDetailsElementsList(
          data: prsViewModels,
          hasMore: hasMorePrs,
          isLoadingMore: isLoadingMorePrs,
          onBottomReach: onLoadMorePrs);
    } else {
      return RepositoryDetailsElementsList(
          data: issuesViewModels,
          hasMore: hasMoreIssues,
          isLoadingMore: isLoadingMoreIssuess,
          onBottomReach: onLoadMoreIssuess);
    }
  }
}
