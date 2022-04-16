import 'package:flutter/material.dart';

import '../Firestore/database_manager.dart';
import '../Widget/constants.dart';

class CarAdd extends StatefulWidget {
  const CarAdd({Key? key}) : super(key: key);

  @override
  State<CarAdd> createState() => _CarAddState();
}

class _CarAddState extends State<CarAdd> {
TextEditingController _controller1= TextEditingController(),_controller2= TextEditingController(),_controller3= TextEditingController();
  @override
  Widget build(BuildContext context) {
    Size size =MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(),
      body: Container(
        padding: EdgeInsets.all(size.width*0.05),
        child: Column(
          children: [
            nwTF(_controller1,""),
            nwTF(_controller2,""),
            nwTF(_controller3,""),
            ElevatedButton(onPressed: (){
              FireStoreDataBase().addStudents(_controller1.text,_controller2.text,_controller3.text);
              setState(() {});
            }, child:const Text("submit"),),
          ],
        ),
      ),
    );
  }









  
}
