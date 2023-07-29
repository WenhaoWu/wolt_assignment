import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wolt_assignment/restaurant/restaurant.dart';

class FavouriteAnimatedIcon extends StatefulWidget {
  const FavouriteAnimatedIcon({super.key, required this.restaurant});

  final Restaurant restaurant;

  @override
  State<FavouriteAnimatedIcon> createState() => _FavouriteAnimatedIconState();
}

class _FavouriteAnimatedIconState extends State<FavouriteAnimatedIcon> {
  bool _showFirstIcon = true;

  @override
  void initState() {
    super.initState();
    setState(() {
      _showFirstIcon = widget.restaurant.isFavourite;
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {
          context.read<RestaurantCubit>().toggleFavourite(widget.restaurant);
          _showFirstIcon = !_showFirstIcon;
        });
      },
      child: AnimatedSwitcher(
        duration: const Duration(milliseconds: 500),
        transitionBuilder: (Widget child, Animation<double> animation) =>
            _transitionBuilder(child, animation),
        layoutBuilder: (widget, list) => Stack(children: [widget!, ...list]),
        switchInCurve: Curves.ease,
        switchOutCurve: Curves.ease.flipped,
        child: _showFirstIcon
            ? Icon(
                Icons.favorite,
                size: 35,
                key: ValueKey<bool>(_showFirstIcon),
              )
            : Icon(
                Icons.favorite_outline,
                size: 35,
                key: ValueKey<bool>(_showFirstIcon),
              ),
      ),
    );
  }

  Widget _transitionBuilder(Widget widget, Animation<double> animation) {
    final rotateAnimation = Tween(begin: pi, end: 0.0).animate(animation);
    return AnimatedBuilder(
      animation: rotateAnimation,
      child: widget,
      builder: (context, widget) {
        final isFront = ValueKey(_showFirstIcon) == widget!.key;
        final rotationY = isFront
            ? rotateAnimation.value
            : min(rotateAnimation.value, pi * 0.5);
        return Transform(
          transform: Matrix4.rotationY(rotationY)..setEntry(3, 0, 0),
          alignment: Alignment.center,
          child: widget,
        );
      },
    );
  }
}
