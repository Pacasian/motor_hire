import 'package:flutter/material.dart';

import '../Firestore/authenication.dart';
import 'login.dart';


class Profile extends StatelessWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Profile"),
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
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: Text("Name :"+name!,style: Theme.of(context).textTheme.headline2,),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: Text("Email :"+userEmail!,style: Theme.of(context).textTheme.headline2,),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: Text("ID :"+uid!,style: Theme.of(context).textTheme.headline2,),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: TextButton(onPressed: (){
                  // uploadImageFile(, imageName: uid!);
                }, child: Text("Drivers License",style: Theme.of(context).textTheme.headline2,),),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: TextButton(onPressed: (){}, child: Text("Orders",style: Theme.of(context).textTheme.headline2,),),
              ),
              ElevatedButton(onPressed: (){
                signOut();
                Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>const LoginScreen(),),);
              }, child:const Text("Sign Out"),),
            ],
          ),
        ),
      ),
    );
  }
}
