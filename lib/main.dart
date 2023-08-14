import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sofomo_task/respositories_network_controller.dart';

void main() {
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyScaffoldWithButton(),
    );
  }
}

class MyScaffoldWithButton extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isLoading = ref.watch(repositoriesProvider).isLoading;
    final data = ref.watch(repositoriesProvider).data ?? [];
    final onPress = () {
      ref
          .read(repositoriesProvider.notifier)
          .fetchRepositories('MarcinMichalskii');
    };
    return Scaffold(
      appBar: AppBar(
        title: Text('Scaffold with Button'),
      ),
      body: Center(
        child: Column(
          children: [
            ElevatedButton(
              onPressed: onPress,
              child: Text('Click Me'),
            ),
            if (isLoading) CircularProgressIndicator(),
            ...data.map((e) => Text(e.name))
          ],
        ),
      ),
    );
  }
}
