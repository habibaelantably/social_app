import 'package:flutter/material.dart';
import 'package:social_app/components/reusable_components.dart';

class AddPostsScreen extends StatelessWidget
{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: deafultAppBar(
          context: context,
        title: 'Add post'
      )
    );
  }

}