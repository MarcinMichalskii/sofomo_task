import 'package:flutter/material.dart';
import 'package:sofomo_task/structs/github_repository.dart';

class TileViewModel {
  final String title;
  final String subtitle;
  final Color color;

  TileViewModel(
      {required this.color, required this.title, required this.subtitle});

  TileViewModel.init({
    required GitHubRepository repository,
    Color? color,
  })  : title = repository.name,
        subtitle = repository.owner.login,
        color = Colors.blueGrey;
}

class GithubTileWidget extends StatelessWidget {
  final TileViewModel viewModel;
  final VoidCallback? onTileSelected;

  const GithubTileWidget(
      {required this.viewModel, this.onTileSelected, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: GestureDetector(
            onTap: onTileSelected,
            child: Container(
              margin: const EdgeInsets.fromLTRB(8, 4, 8, 4),
              child: Container(
                padding: const EdgeInsets.all(16.0),
                decoration: BoxDecoration(
                  color: viewModel.color,
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      viewModel.title,
                      style: const TextStyle(
                        fontSize: 18.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 8.0),
                    Text(
                      viewModel.subtitle,
                      style: const TextStyle(
                        fontSize: 14.0,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
