import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:sofomo_task/UI/repositories_list/repositories_list_body.dart';
import 'package:sofomo_task/utils/errors_provider.dart';
import 'package:sofomo_task/utils/repositories_provider.dart';
import 'package:sofomo_task/utils/texts.dart';

Timer? _debounce;

class RepositoriesListScaffold extends HookConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isLoading = ref.watch(repositoriesProvider).isLoading;
    final hasMoreData = ref.watch(repositoriesProvider).hasMore;
    final isLoadingMore = ref.watch(repositoriesProvider).isLoadingMore;
    final data = ref.watch(repositoriesProvider).data ?? [];
    final searchWord = useState('');
    final onSearchChanged = useCallback((String? text) {
      searchWord.value = text ?? '';
      if (text == null || text == '') {
        return;
      }

      if (_debounce?.isActive ?? false) _debounce?.cancel();
      _debounce = Timer(const Duration(milliseconds: 500), () {
        ref.read(repositoriesProvider.notifier).fetchRepositories(text);
      });
    }, []);

    ref.watch(errorListener);
    ref.listen(
      errorTextProvider,
      (previous, next) => {
        if (next != null)
          {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              backgroundColor: Colors.red,
              content: Text(next),
            ))
          }
      },
    );
    return Scaffold(
      appBar: AppBar(
        title: Text(Texts.serachRepository),
      ),
      body: Column(
        children: [
          TextField(
            onChanged: onSearchChanged,
            decoration: InputDecoration(
              hintText: Texts.search,
              prefixIcon: const Icon(Icons.search),
            ),
          ),
          if (isLoading)
            const Padding(
              padding: EdgeInsets.only(top: 12),
              child: CircularProgressIndicator(),
            ),
          if (data.isEmpty && !isLoading)
            Container(
              margin: const EdgeInsets.only(top: 16),
              child: Text(Texts.noRepositories),
            ),
          RepositoryListView(
            data: data,
            isLoadingMore: isLoadingMore,
            hasMore: hasMoreData,
            searchKeyword: searchWord.value,
          )
        ],
      ),
    );
  }
}
