import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/providers/cart.dart';
import 'package:shop_app/providers/orders.dart';
import 'package:shop_app/screens/cartScreen.dart';
import 'package:shop_app/screens/edit_product_screen.dart';
import 'package:shop_app/screens/product_detail_screen.dart';
import 'package:shop_app/screens/user_products_screen.dart';
import 'package:shop_app/widgets/user_product_item.dart';
import './screens/product_overview_screens.dart';
import './providers/products_providers.dart';
import './screens/ordersScreen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (ctx) => Products(),
        ),
        ChangeNotifierProvider(
          create: (ctx) => Cart(),
        ),

        ChangeNotifierProvider(
        create: (ctx) => Orders(),
        ),
      ],
      child: MaterialApp(
        title: 'Dilli Dukaan',
        theme: ThemeData(
          primarySwatch: Colors.blueGrey,
          accentColor: Colors.black38,
          fontFamily: 'Lato',
        ),
        home: ProductOverviewScreens(),
        routes: {
          ProductDetailScreen.routeName: (ctx) => ProductDetailScreen(),
          CartScreen.routeName: (ctx)=> CartScreen(),
          OrdersScreen.routeName : (ctx) => OrdersScreen(),
          UserProductsScreen.routeName : (ctx) => UserProductsScreen(),
          EditProductScreen.routeName : (ctx) => EditProductScreen(),
        },
      ),
    );
  }
}

class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('MySHOP'),
      ),
      body: Center(
        child: Text('Lets build a shop app'),
      ),
    );
  }
}
