import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:wolt_assignment/restaurant/models/models.dart';

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
              Image.network(
                restaurant.imgUrl,
                height: 50,
                width: 50,
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
                            fontWeight: FontWeight.w400,
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
                            fontSize: 15.0,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Icon(
                restaurant.isFavourite
                    ? Icons.favorite
                    : Icons.favorite_outline,
                size: 35,
                color: Colors.black,
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
