import 'package:flutter/material.dart';
import '../model/Item.dart';
import "package:provider/provider.dart";
import "../provider/shoppingcart_provider.dart";

class MyCheckout extends StatelessWidget {
  const MyCheckout({super.key});
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("MyCheckout")),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text("Item Details"),
          const Divider(),
          getItems(context),
          Flexible(
            child: Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  showButton(context),
                ]))),
        ],
      ),
    );
  }

Widget getItems(BuildContext context) {
  List<Item> products = context.watch<ShoppingCart>().cart;
  return products.isEmpty
    ? const Text('No items to checkout!')
    : Expanded(
      child: Column(
      children: [
        Flexible(
          child: ListView.builder(
        itemCount: products.length,
        itemBuilder: (BuildContext context, int index) {
          return ListTile(
            title: Text(products[index].name),
            trailing: Text(
              products[index].price.toString(), style: TextStyle(fontSize: 15.0),
            ),
          );
        },
          )),
      ],
      ));
  }
}

Widget showButton(BuildContext context){
  List<Item> products = context.watch<ShoppingCart>().cart;
  return products.isEmpty
    ? Text("")
    : Column(
      children: [
        computeCost(),
        ElevatedButton(
          onPressed: () {
            context.read<ShoppingCart>().removeAll();
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: Text("Payment Successful!"),
              duration:
                const Duration(seconds: 1, milliseconds: 100),
            ));
            Navigator.pushNamed(context, "/products");},
        child: const Text("Pay Now!"))
      ]);
}

Widget computeCost() {
  return Consumer<ShoppingCart>(builder: (context, cart, child) {
    return Text("Total Cost to Pay: ${cart.cartTotal}");
  });
}

