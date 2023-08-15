import 'package:flutter/material.dart';
import 'package:sofomo_task/UI/components/titled_icon_widget.dart';
import 'package:sofomo_task/structs/github_repository.dart';

class RepositoryDetailsTileWidget extends StatelessWidget {
  final GitHubRepository repo;

  const RepositoryDetailsTileWidget({required this.repo, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Container(
            margin: const EdgeInsets.fromLTRB(8, 4, 8, 4),
            child: Container(
              padding: const EdgeInsets.all(16.0),
              decoration: BoxDecoration(
                color: Colors.blueGrey,
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    repo.name,
                    style: const TextStyle(
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 8.0),
                  Text(
                    repo.owner.login,
                    style: const TextStyle(
                      fontSize: 14.0,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 8.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      TitledIconWidget(
                        icon: Icons.star_outline_rounded,
                        title: '${repo.stargazersCount}',
                        iconColor: Colors.yellowAccent,
                      ),
                      TitledIconWidget(
                        icon: Icons.fork_right,
                        title: '${repo.forks}',
                        iconColor: Colors.green,
                      ),
                      TitledIconWidget(
                        icon: Icons.report_problem,
                        title: '${repo.openIssues}',
                        iconColor: Colors.deepPurple,
                      )
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
