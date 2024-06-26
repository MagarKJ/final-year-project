import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class AddFoodShimmer extends StatelessWidget {
  const AddFoodShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(itemBuilder: (context, index) {
        return Container(
          margin: const EdgeInsets.only(bottom: 10, top: 10),
          child: Shimmer.fromColors(
            baseColor: Colors.grey[300]!,
            highlightColor: Colors.grey[100]!,
            child: Container(
              height: 80,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.white,
              ),
            ),
          ),
        );
      }),
    );
  }
}
