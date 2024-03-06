import 'package:flutter/material.dart';
// import 'package:hive/hive.dart';

import '../../model/dogdata_model.dart';
class HistoryPage extends StatefulWidget {
  var historyList;
  // final Box<DogDataModel> historyBox;
   HistoryPage({super.key, required this.historyList, });

  @override
  State<HistoryPage> createState() => _HistoryPageState();
}



class _HistoryPageState extends State<HistoryPage> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // print(widget.historyBox)
  }
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        title: Text('history'),
      ),
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Column(
          children: [
            ListView.builder(
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: widget.historyList.length, // Change this number based on your requirements
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      width: 150,
                      height: 200,

                      color: Colors.white,
                      child: Center(
                          child: Image.network(widget.historyList[index],
                            fit: BoxFit.cover,)
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
