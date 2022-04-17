
import 'package:flutter/material.dart';
import 'package:motor_hire/Screens/profile.dart';

import '../Firestore/authenication.dart';
import 'admin_add_cars.dart';
import 'admin_manage_request.dart';
import 'login.dart';


class AdminHome extends StatelessWidget {
  const AdminHome({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text("Admin Home"),
        actions: [
          IconButton(onPressed: (){
            signOut();
            Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>const LoginScreen(),),);
          }, icon: const Icon(Icons.logout)),
        ],
      ),
      body: GridView(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 6,
              mainAxisSpacing: 16),
          children: [
            InkWell(
              onTap: ()=>Navigator.push(context, MaterialPageRoute(builder: (context)=>AdminCarsAdd())),
              child: Card(
                elevation: 4,
                child: Padding(
                  padding: const EdgeInsets.all(26.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(child: Center(child: Icon(Icons.add,size: size.height*0.1,),),flex: 3,),
                      const Spacer(),
                      Expanded(child: Text("Add Cars",),flex: 1,),
                    ],
                  ),
                ),
              ),
            ),
            InkWell(
              onTap: ()=>Navigator.push(context, MaterialPageRoute(builder: (context)=>ManageRequest())),
              child: Card(
                elevation: 4,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(child: Center(child: Icon(Icons.edit,size: size.height*0.1,),),flex: 3,),
                      const Spacer(),
                      Expanded(child: Text("Manage Request",),flex: 1,),
                    ],
                  ),
                ),
              ),
            ),
      //     Image.network('https://picsum.photos/250?image=1'),
      // Image.network('https://picsum.photos/250?image=2'),
      // Image.network('https://picsum.photos/250?image=3'),
      ]
    ),
    );
  }
}
