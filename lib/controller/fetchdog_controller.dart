// api_response_controller.dart
import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';

import '../model/dogdata_model.dart';

class FetchDogDataController extends GetxController {
  var isLoading = false.obs;
  var apiResponse = DogDataModel();
  RxList doglist = [].obs;
  // var hiveBox = Hive.box<String?>('dogHistory');

  @override
  void onInit() {
    super.onInit();
    // Fetch data when the controller is initialized
    fetchDogImage();
    // doglist.assignAll(hiveBox.values.toList());
  }

  Future<String?> fetchDogImage() async {
    isLoading.value = true;
    try {
      var response = await Dio().get('https://dog.ceo/api/breeds/image/random');
      apiResponse = DogDataModel.fromJson(response.data);
      print(apiResponse.status);
      print(apiResponse.message);

      return apiResponse.message;
    } catch (e) {
      print('Error fetching data: $e');
      isLoading.value = false;
    }
  }
/////////add to list///////
  Future<void> addDataIntoList() async {
    try {

      var newDogData = await fetchDogImage();

      doglist.add(newDogData);
      print('newDogData${newDogData}');

      // await
      // hiveBox.add(newDogData);
      // Hive.openBox('dogHistory');

      // print(doglist);
    } catch (e) {
      print('Error adding data to the list: $e');
    }
  }
}
