import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:sofomo_task/UI/repository_details/repository_details_widget.dart';
import 'package:sofomo_task/UI/components/github_tile_widget.dart';
import 'package:sofomo_task/structs/github_repository.dart';

class RepositoryTileLogicWidget extends HookWidget {
  final GitHubRepository repo;

  const RepositoryTileLogicWidget({required this.repo, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final onTileSelected = useCallback(() {
      Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => RepositoryDetailsWidget(repo: repo)),
      );
    }, [repo]);
    return GithubTileWidget(
      viewModel: TileViewModel.init(repository: repo),
      onTileSelected: onTileSelected,
    );
  }
}
