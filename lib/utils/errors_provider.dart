import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sofomo_task/utils/issues_provider.dart';
import 'package:sofomo_task/utils/prs_provider.dart.dart';
import 'package:sofomo_task/utils/repositories_provider.dart';

final errorTextProvider = StateProvider<String?>((ref) {
  return null;
});

final errorListener = Provider((ref) {
  ref.listen(prsProvider, (previous, next) {
    if (next.error != null) {
      ref.read(errorTextProvider.notifier).state = next.error!.text;
    }
  });

  ref.listen(issuesProvider, (previous, next) {
    if (next.error != null) {
      ref.read(errorTextProvider.notifier).state = next.error!.text;
    }
  });

  ref.listen(repositoriesProvider, (previous, next) {
    if (next.error != null) {
      ref.read(errorTextProvider.notifier).state = next.error!.text;
    }
  });
});
