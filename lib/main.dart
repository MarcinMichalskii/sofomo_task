import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:sofomo_task/UI/repositories_list/repositories_list_scaffold.dart';

void main() {
  runApp(const ProviderScope(child: GithubSofomoApp()));
}

class GithubSofomoApp extends StatelessWidget {
  const GithubSofomoApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Sofomo Github Task',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: RepositoriesListScaffold(),
    );
  }
}
