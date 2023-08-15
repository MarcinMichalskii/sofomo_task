import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:sofomo_task/UI/repository_details/repository_details_body.dart';
import 'package:sofomo_task/UI/repository_details/repository_details_button.dart';
import 'package:sofomo_task/structs/github_repository.dart';
import 'package:sofomo_task/utils/issues_provider.dart';
import 'package:sofomo_task/utils/prs_provider.dart.dart';
import 'package:sofomo_task/utils/use_build_effect.dart';

enum DetailsState { details, prs, issues }

class RepositoryDetailsWidget extends HookConsumerWidget {
  final GitHubRepository repo;

  const RepositoryDetailsWidget({required this.repo, Key? key})
      : super(key: key);
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    useBuildEffect(() {
      ref.read(issuesProvider.notifier).fetch(repo.id);

      ref.read(prsProvider.notifier).fetch(repo.id);
    }, []);

    final prsData = ref.watch(prsProvider).data ?? [];
    final issuesData = ref.watch(issuesProvider).data ?? [];
    final selectedState = useState(DetailsState.details);
    final onStateSelected = useCallback((DetailsState state) {
      selectedState.value = state;
    }, []);
    final isLoading =
        ref.watch(issuesProvider).isLoading || ref.watch(prsProvider).isLoading;

    return Scaffold(
      appBar: AppBar(
        title: Text(repo.name),
      ),
      body: Column(
        children: [
          RepositoryDetailsButtons(
            selectedState: selectedState.value,
            onStateSelected: onStateSelected,
          ),
          isLoading
              ? Container(
                  margin: const EdgeInsets.only(top: 16),
                  child: const CircularProgressIndicator())
              : RepositoryDetailsBody(
                  selectedState: selectedState,
                  repo: repo,
                  issuesData: issuesData,
                  prsData: prsData),
        ],
      ),
    );
  }
}
