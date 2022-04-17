import 'dart:html';
import 'dart:typed_data';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:motor_hire/Screens/order_page.dart';

import '../Firestore/authenication.dart';
import 'login.dart';


class Profile extends StatefulWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {


  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: const Text("Profile"),
        actions: [
          IconButton(onPressed: (){


            signOut();
            Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>const LoginScreen(),),);
          }, icon: const Icon(Icons.logout)),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding:  EdgeInsets.all(size.height*0.1),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children:  [
              CircleAvatar(
                radius: size.width*0.08,
                backgroundColor: Colors.black,
                child: CircleAvatar(
                  radius: size.width*0.078,
                  backgroundImage: NetworkImage(imageUrl!),
                ),
              ),
              SizedBox(
                height: size.height*0.1,
              ),
              Row(
                children: [
                  Expanded(
                    flex: 1,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8.0),
                          child: Text("Name :"+name!,style: Theme.of(context).textTheme.headline6),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8.0),
                          child: Text("Email :"+userEmail!,style: Theme.of(context).textTheme.headline6,),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8.0),
                          child: Text("ID :"+uid!,style: Theme.of(context).textTheme.headline6,),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8.0),
                          child: ElevatedButton( onPressed: () async {
                            var picked = await FilePicker.platform.pickFiles();

                            if (picked != null) {
                              print(picked.files.first.name);
                            }
                          }, child: Text("Drivers License",style: Theme.of(context).textTheme.headline6,),),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8.0),
                          child: ElevatedButton(onPressed: (){
                            Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>const OrderPage(),),);
                          }, child: Text("Booking Status",style: Theme.of(context).textTheme.headline6,),),
                        ),
                      ],
                    ),
                  ),
                ],
              ),




            ],
          ),
        ),
      ),
    );
  }
}

