import 'package:ecom/screens/home/widgets/product-card.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            children: [
              Image.asset('assets/images/banner.jpg', errorBuilder: (context, error, stackTrace) {
                return Container();
              },),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 5.0),
                    child: Text("Recommended For You", style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.bold),),
                  ),
                  TextButton(
                    onPressed: () {}, 
                    child: const Row(
                      children: [
                        Text("Show More"),
                        Icon(Icons.keyboard_arrow_right)
                      ],
                    ))
                ],
              ),
              MasonryGridView.builder(
                gridDelegate: const SliverSimpleGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2
                  ),
                padding: const EdgeInsets.only(top: 0, bottom:90),
                crossAxisSpacing: 15,
                mainAxisSpacing: 15,
                itemCount: 10,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) {
                return const ProductCard();
              },),
            ],
          )
        ),
      ),
    );
  }
}
