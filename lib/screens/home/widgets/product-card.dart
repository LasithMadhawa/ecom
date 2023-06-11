import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:cached_network_image/cached_network_image.dart';

class ProductCard extends StatelessWidget {
  const ProductCard({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(20),
      child: Container(
        decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.surface,
            boxShadow: [
              BoxShadow(
                color: Theme.of(context).colorScheme.shadow.withOpacity(0.2),
                spreadRadius: 3,
                blurRadius: 5,
                offset: const Offset(3, 3),
              ),
            ]),
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                AspectRatio(
                  aspectRatio: 1.5,
                  child: Container(
                    color: Theme.of(context).colorScheme.inversePrimary,
                    child: CachedNetworkImage(
                      fit: BoxFit.cover,
                      imageUrl:
                          "https://placeimg.com/640/480/food?i=3",
                      placeholder: (context, url) => const Center(
                        child: Icon(Icons.image),
                      ),
                      errorWidget: (context, url, error) =>
                          const Icon(Icons.error),
                    ),
                  ),
                ),
                Stack(
                  clipBehavior: Clip.none,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(
                            height: 10,
                          ),
                          Text(
                            "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Maecenas iaculis finibus turpis, convallis tincidunt mauris laoreet non.",
                            style: TextStyle(
                                fontSize: 14.sp,
                                overflow: TextOverflow.ellipsis),
                            maxLines: 2,
                            softWrap: true,
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          Text("Rs.4500.00",
                              style: TextStyle(
                                  fontSize: 12.sp,
                                  fontWeight: FontWeight.bold,
                                  color:
                                      Theme.of(context).disabledColor)),
                          Text("Rs.4200.00",
                              style: TextStyle(
                                  fontSize: 12.sp,
                                  fontWeight: FontWeight.bold))
                        ],
                      ),
                    ),
                    Positioned(
                        bottom: -5,
                        right: 0,
                        child: Container(
                          padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 15),
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              colors: [ Theme.of(context).colorScheme.primary, Theme.of(context).colorScheme.secondary ],
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                            ),
                            borderRadius: const BorderRadius.only(
                              topLeft: Radius.circular(20)
                            )
                          ),
                          child: Icon(
                            Icons.add,
                            color:
                                Theme.of(context).colorScheme.onPrimary,
                          ),
                        ),
                        ),
                    Positioned(
                        top: -15,
                        right: 5,
                        child: Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 8, vertical: 2),
                            margin: const EdgeInsets.all(5.0),
                            decoration: BoxDecoration(
                                color: Theme.of(context)
                                    .colorScheme
                                    .surface,
                                borderRadius: BorderRadius.circular(5),
                                boxShadow: [
                                  BoxShadow(
                                    color: Theme.of(context)
                                        .colorScheme
                                        .shadow
                                        .withOpacity(0.2),
                                    spreadRadius: 3,
                                    blurRadius: 5,
                                    offset: const Offset(2, 2),
                                  )
                                ]),
                            child: Row(
                              children: [
                                Icon(
                                  Icons.star,
                                  size: 15.0,
                                  color: Theme.of(context)
                                      .colorScheme
                                      .primary,
                                ),
                                const SizedBox(
                                  width: 5.0,
                                ),
                                Text(
                                  "7.5",
                                  style: TextStyle(
                                      color: Theme.of(context)
                                          .colorScheme
                                          .primary),
                                )
                              ],
                            )))
                  ],
                )
              ],
            ),
            Positioned(
              top: 30,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 5.0),
                color: Theme.of(context).colorScheme.onBackground,
                child: Text('50%', style: TextStyle(color: Theme.of(context).colorScheme.onPrimary),),
              ),
            )
          ],
        ),
      ),
    );
  }
}