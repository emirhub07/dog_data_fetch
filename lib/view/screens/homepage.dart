import 'package:fetchdog/controller/cart_controller.dart';
import 'package:fetchdog/view/screens/cartpage_screen.dart';
import 'package:fetchdog/view/screens/history_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:hive/hive.dart';

import '../../controller/fetchdog_controller.dart';
import '../../model/dogdata_model.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  FetchDogDataController fetchDogDataController =
      Get.put(FetchDogDataController());
  CartController cartController = Get.put(CartController());
  RxList doglist = [].obs;
  int dogPrice = 2000;

  Future<void> addDataIntoList() async {
    try {
      // Assuming fetchDogImage returns a DogDataModel
      var newDogData = await fetchDogDataController.fetchDogImage();

      // Add the new data to the list
      doglist.add(newDogData);
      print('newDogData${newDogData}');
      print(doglist);
    } catch (e) {
      print('Error adding data to the list: $e');
    }
  }

   void addToCart(int index) {
    cartController.addItemToCart(doglist[index]);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        leading: GestureDetector(
          onTap: () {
            Get.to(() => HistoryPage(
                  historyList: doglist,
              // historyBox:  Hive.box<DogDataModel>('dogHistory')
              ),
                );
          },
          child: const Icon(
            Icons.history_rounded,
            size: 30,
            color: Colors.black,
          ),
        ),
        actions: [
          GestureDetector(
            onTap: () {
              Get.to(() => CartPage(
                        dogprice: dogPrice,
                  ));
            },
            child: const Icon(
              Icons.shopping_cart,
              color: Colors.black,
              size: 30,
            ),
          )
        ],
        backgroundColor: Colors.transparent,
        title: const Text(
          'Fetch Dog',
          style: TextStyle(
              color: Colors.black, fontSize: 20, fontWeight: FontWeight.w500),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      floatingActionButton: FloatingActionButton(
        onPressed: () async {

          setState(() {
            addDataIntoList();
            // fetchDogDataController.addDataIntoList();
          });
          // await fetchDogDataController.fetchDogImage();
        },
      ),
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Column(
          children: [
            ListView.builder(
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: doglist
                    .length, // Change this number based on your requirements
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Card(
                      // width: 150,
                      // height: 290,

                      color: Colors.white,
                      child: Column(
                        children: [
                          Center(
                              child: Image.network(
                            doglist[index],
                            fit: BoxFit.cover,
                          )),

                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(dogPrice.toString(),
                            style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.w600,
                              fontSize: 30,

                            ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(15),
                            child: GestureDetector(
                              onTap: (){
                                setState(() {
                                  addToCart(index);
                                });

                              }
                              ,
                              child: Container(
                                height: 40,
                                width: 40,
                                color: Colors.blueGrey,
                                child: Icon(
                                  Icons.add,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                }),
          ],
        ),
      ),
    );
  }
}
