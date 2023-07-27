import 'package:flutter/material.dart';
import 'package:wolt_assignment/restaurant/models/models.dart';
import 'package:wolt_assignment/restaurant/widget/list_item.dart';

class ListWidget extends StatelessWidget {
  final List<Restaurant> list;

  const ListWidget({super.key, required this.list});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: list.length,
      itemBuilder: (context, index) => ListItem(restaurant: list[index]),
    );
  }
}
