import 'package:flutter/material.dart';

class FolderEmptyWidget extends StatelessWidget {
  const FolderEmptyWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [Text("Empty(((")],
      ),
    );
  }
}
