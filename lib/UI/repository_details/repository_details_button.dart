import 'package:flutter/material.dart';
import 'package:sofomo_task/UI/components/rounded_button.dart';
import 'package:sofomo_task/UI/repository_details/repository_details_widget.dart';
import 'package:sofomo_task/utils/texts.dart';

class RepositoryDetailsButtons extends StatelessWidget {
  const RepositoryDetailsButtons({
    Key? key,
    required this.onStateSelected,
    required this.selectedState,
  }) : super(key: key);

  final DetailsState selectedState;
  final ValueSetter<DetailsState> onStateSelected;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.fromLTRB(16, 8, 16, 0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          RoundedButton(
            backgroundColor: selectedState == DetailsState.details
                ? Colors.blueGrey
                : Colors.grey,
            text: Texts.details,
            onPressed: () {
              onStateSelected(DetailsState.details);
            },
          ),
          RoundedButton(
            backgroundColor: selectedState == DetailsState.issues
                ? Colors.purple
                : Colors.grey,
            text: Texts.issues,
            onPressed: () {
              onStateSelected(DetailsState.issues);
            },
          ),
          RoundedButton(
            backgroundColor:
                selectedState == DetailsState.prs ? Colors.green : Colors.grey,
            text: Texts.prs,
            onPressed: () {
              onStateSelected(DetailsState.prs);
            },
          )
        ],
      ),
    );
  }
}
