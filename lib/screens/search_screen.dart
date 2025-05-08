import 'package:flutter/material.dart';

class SearchPage extends StatelessWidget {
  final Map<String, dynamic> token;

  const SearchPage({super.key, required this.token});
  @override
  Widget build(BuildContext context) {
    return Center(child: Text('Esta es la página de search'));
  }
}
