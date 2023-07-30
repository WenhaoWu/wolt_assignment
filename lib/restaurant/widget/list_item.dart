import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:wolt_assignment/restaurant/cubit/restaurant_cubit.dart';
import 'package:wolt_assignment/restaurant/models/models.dart';
import 'package:wolt_assignment/restaurant/widget/favourite_animated_icon.dart';

class ListItem extends StatelessWidget {
  final Restaurant restaurant;

  const ListItem({super.key, required this.restaurant});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
          child: Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(15),
                child: Image.network(
                  restaurant.imgUrl,
                  height: 75,
                  width: 75,
                  fit: BoxFit.cover,
                ),
              ),
              Expanded(
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          restaurant.name,
                          style: GoogleFonts.montserrat(
                            fontSize: 15.0,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        Text(
                          restaurant.shortDescription,
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                          style: GoogleFonts.montserrat(
                            fontSize: 13.0,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              FavouriteAnimatedIcon(
                restaurant: restaurant,
                key: ValueKey<String>(
                    "${restaurant.id}-${restaurant.isFavourite}"),
              ),
            ],
          ),
        ),
        const Padding(
          padding: EdgeInsets.fromLTRB(77, 0, 0, 0),
          child: Divider(height: 1, color: Colors.grey),
        ),
      ],
    );
  }
}
