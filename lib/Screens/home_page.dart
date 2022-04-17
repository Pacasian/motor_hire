import 'package:flutter/material.dart';
import '../Firestore/database_manager.dart';
import 'car_add.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List dataList = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Firebase Demo"),
        actions: [
          IconButton(icon:Icon(Icons.ac_unit_sharp), onPressed: () { Navigator.push(context, MaterialPageRoute(builder: (context)=>const CarAdd())); },)
        ],
      ),
      body: FutureBuilder(
        future: FireStoreDataBase().getData("dsfdsf"),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return const Text(
              "Something went wrong",
            );
          }
          if (snapshot.connectionState == ConnectionState.done) {
            dataList = snapshot.data as List;
            return buildItems(dataList);
          }
          return const Center(child: CircularProgressIndicator());
        },
      ),
    );
  }

  Widget buildItems(dataList) => ListView.separated(
      padding: const EdgeInsets.all(8),
      itemCount: dataList.length,
      separatorBuilder: (BuildContext context, int index) => const Divider(),
      itemBuilder: (BuildContext context, int index) {
        return ListTile(
          title: Text(
            dataList[index]["Name"],
          ),
          subtitle:  Text(dataList[index]["Dept"]),
          trailing: Text(
            dataList[index]["RollNo"],
          ),
        );
      });
}
