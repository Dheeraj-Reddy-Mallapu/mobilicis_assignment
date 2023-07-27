import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mobilicis_assignment/const_colors.dart';
import 'package:mobilicis_assignment/data/objects/listing_object.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:shimmer/shimmer.dart';

class ListingTile extends StatelessWidget {
  const ListingTile({super.key, required this.listing});
  final Listing listing;

  @override
  Widget build(BuildContext context) {
    String numToINR(int num) {
      final indianRupeesFormat = NumberFormat.currency(
        name: '₹ ',
        locale: 'en_IN',
        decimalDigits: 0,
      );
      return indianRupeesFormat.format(num);
    }

    return Padding(
      padding: const EdgeInsets.all(6.0),
      child: Container(
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(5), color: Colors.white),
        child: Padding(
          padding: const EdgeInsets.all(6.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(
                children: [
                  Center(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: CachedNetworkImage(
                        height: 120,
                        width: 120,
                        fit: BoxFit.contain,
                        imageUrl: listing.defaultImage.fullImage,
                        placeholder: (context, url) => Shimmer(
                          gradient: const LinearGradient(colors: [Colors.grey, Colors.white]),
                          child: Container(
                              decoration:
                                  BoxDecoration(borderRadius: BorderRadius.circular(5), color: backgroundColor)),
                        ),
                        errorWidget: (context, url, error) => const Icon(Icons.broken_image),
                      ),
                    ),
                  ),
                  const Positioned(
                    right: 0,
                    top: 0,
                    child: Icon(Icons.favorite_border, color: Colors.red, size: 20),
                  )
                ],
              ),
              Text(
                numToINR(listing.listingNumPrice),
                style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
              ),
              Text(
                listing.model,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(fontSize: 13, letterSpacing: 0.08),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 6.0, bottom: 6.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      listing.deviceRam,
                      style: const TextStyle(fontSize: 10),
                    ),
                    Text(
                      "Condition: ${listing.deviceCondition}",
                      style: const TextStyle(fontSize: 10),
                    ),
                  ],
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    listing.listingLocation,
                    style: const TextStyle(fontSize: 10),
                  ),
                  Text(
                    listing.listingDate,
                    style: const TextStyle(fontSize: 10),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
