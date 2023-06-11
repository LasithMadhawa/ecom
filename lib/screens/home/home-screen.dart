import 'dart:developer';

import 'package:ecom/providers/products.provider.dart';
import 'package:ecom/screens/home/widgets/product-card.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _controller = ScrollController();

  @override
  void initState() {
    super.initState();
  }

  _addListener(ProductProvider productProvider) {
    _controller.addListener(() {
          if (_controller.position.maxScrollExtent == _controller.position.pixels) {
            log("Should call");
            productProvider.fetchData();
          } else {
            log("Should not call");
          }
        });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: SingleChildScrollView(
        controller: _controller,
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
              ChangeNotifierProvider(
          create: (context) => ProductProvider(),
          child: Consumer<ProductProvider>(builder: (context, productProvider, child) {
            if (productProvider.dataState == ProductDataState.uninitialized) {
              WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
                productProvider.fetchData();
              _addListener(productProvider);
              });
              return Container();
            }
            return 
              Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  MasonryGridView.builder(
                    gridDelegate: const SliverSimpleGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2
                      ),
                    // padding: const EdgeInsets.only(top: 0, bottom:90),
                    crossAxisSpacing: 15,
                    mainAxisSpacing: 15,
                    itemCount: productProvider.products.length,
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemBuilder: (context, index) {
                    return ProductCard(product: productProvider.products[index], index: index);
                  },),
                  if (productProvider.dataState == ProductDataState.loading)
                  Center(
                    child: Container(
                      padding: const EdgeInsets.all(10.0),
                      width: 15,
                      height: 15,
                      child: CircularProgressIndicator(strokeWidth: 1,)
                      ),
                  ),
                  SizedBox(height: 30.w,)
                ],
              );
          })),
            ],
          )
        ),
      ),
    );
  }
}
