import 'package:fetchdog/controller/cart_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

class CartPage extends StatefulWidget {
  int dogprice;

   CartPage({super.key,required this.dogprice });

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {

  CartController cartController = Get.find();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    print(cartController.cartItems);
  }

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        title: Text('cart'),
      ),
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Column(
          children: [
            ListView.builder(
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: cartController.cartItems.length, // Change this number based on your requirements
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      width: 150,
                      height: 200,

                      color: Colors.white,
                      child: Center(
                          child: Image.network(cartController.cartItems[index],
                            fit: BoxFit.cover,)
                      ),
                    ),
                  );
                }),
            
            Text(
                'Total Amount : ${
              (widget.dogprice * cartController.cartItems.length).toString()
            }',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w500
            ),
            )
          ],
        ),
      ),
    );
  }
}
