import 'package:flutter/material.dart';
import 'package:shop_app/providers/products_providers.dart';
import './product_item.dart';
import 'package:provider/provider.dart';

class ProductsGrid extends StatelessWidget {
  final bool showFavs;

  ProductsGrid(this.showFavs);

  @override
  Widget build(BuildContext context) {
    final productData = Provider.of<Products>(context);
    final products = showFavs?productData.favouriteItems : productData.items;
    return GridView.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          childAspectRatio: 4 / 4,
          crossAxisSpacing: 1,
          mainAxisSpacing: 1),
      itemBuilder: (ctx, i) => ChangeNotifierProvider.value(
       // create: (c) => products[i],
        value: products[i],
        child: ProductItem(
          // products[i].id,
          //   products[i].title,
          //  products[i].imageUrl
        ),
      ),
      itemCount: products.length,
      padding: const EdgeInsets.all(5),
    );
  }
}
