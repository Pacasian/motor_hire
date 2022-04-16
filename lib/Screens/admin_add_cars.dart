import 'package:flutter/material.dart';

import '../Firestore/database_manager.dart';
import '../Widget/constants.dart';

class AdminCarsAdd extends StatefulWidget {
  const AdminCarsAdd({Key? key}) : super(key: key);

  @override
  State<AdminCarsAdd> createState() => _AdminCarsAddState();
}

class _AdminCarsAddState extends State<AdminCarsAdd> {
  TextEditingController _cName=TextEditingController(),_img=TextEditingController(),_loc=TextEditingController(),_latlong=TextEditingController(),_year=TextEditingController();
  @override
  Widget build(BuildContext context) {
    Size size= MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text("Add Cars"),
      ),
      body: Column(
        children: [
          Text("Car Name",style:Theme.of(context).textTheme.headline6),
          nwTF(_cName,""),
          SizedBox(height: size.height*0.02,),
          Text("Car Image Link",style:Theme.of(context).textTheme.headline6),
          nwTF(_img,""),
          Text("Model Year",style:Theme.of(context).textTheme.headline6),
          nwTF(_year,""),
          Text("Station Location",style:Theme.of(context).textTheme.headline6),
          nwTF(_loc,""),
          SizedBox(height: size.height*0.02,),
          Text("Station Latitude and Longitude",style:Theme.of(context).textTheme.headline6),
          nwTF(_latlong,""),
          SizedBox(height: size.height*0.05,),
          ElevatedButton(onPressed: (){


            FireStoreDataBase().addCars(_cName.text,_year.text,_img.text,_loc.text,_latlong.text);
            setState(() {});
            Navigator.pop(context);


            //  car name
            //  car model year
            //  car pic
          //reserved
          //   location
          //  latlong
          }, child: const Text("ADD CAR"),),
        ],
      ),
    );
  }
}
