import 'package:get/get.dart';

class CartController extends GetxController {
  RxList cartItems = [].obs;

  void addItemToCart(String item) {
    cartItems.add(item);
    print('Added$item');
  }

}
