import 'package:flutter/material.dart';

class DiarySection extends StatelessWidget {
  const DiarySection({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      //height: 400,
      width: MediaQuery.of(context).size.width,
      child: GridView.count(
        shrinkWrap: true,
        // Create a grid with 3
        crossAxisCount: 3,
        // Generate 100 widgets that display their index in the List.
        children: List.generate(100, (index) {
          return Center(
            child: Text('Item $index',
              style: Theme.of(context).textTheme.headlineSmall,
            ),
          );
        }),
        )
    );
  }
}
