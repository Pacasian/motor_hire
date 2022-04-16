
import 'package:flutter/material.dart';
import '../Firestore/authenication.dart';
import '../Firestore/database_manager.dart';
import '../Widget/constants.dart';
import '../Widget/get_maps_screen.dart';

class CarPage extends StatefulWidget {
  const CarPage({Key? key,required this.dataList}) : super(key: key);
final Map<String, dynamic> dataList;
  @override
  State<CarPage> createState() => _CarPageState();
}

class _CarPageState extends State<CarPage> {
  TextEditingController _days= TextEditingController();
  TextEditingController _license= TextEditingController();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text("Reserve Car"),
      ),
      body: Column(
        children: [
          const SizedBox(
            height: 50,
          ),
          Expanded(
            child: Row(
              children: [
                Expanded(
                  child: Container(
                    height: size.height*0.7,
                    
                    // color: Colors.red,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Expanded(
                          flex: 2,
                          child: Image.network(widget.dataList['img'],fit: BoxFit.contain,),
                        ),
                        Expanded(
                          flex: 1,
                          child: getMap(widget.dataList['latlang']),
                        ),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  child: Container(
                    height: size.height*0.7,
                     width: 100,
                    // color: Colors.green,
                    child: Column(
                      children: [
                        SizedBox(height: size.height*0.05,),
                        ListTile(
                          title: Text(widget.dataList['name'],style:Theme.of(context).textTheme.headline2),
                          subtitle: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(height: size.height*0.05,),
                              Text(widget.dataList['year'],style:Theme.of(context).textTheme.headline6),
                              SizedBox(height: size.height*0.02,),
                              Text(widget.dataList['location'],style:Theme.of(context).textTheme.headline6),
                              SizedBox(height: size.height*0.02,),
                              Text("Number of Days",style:Theme.of(context).textTheme.headline6),
                              nwTF(_days,""),
                              SizedBox(height: size.height*0.02,),
                              Text("Drivers License number",style:Theme.of(context).textTheme.headline6),
                              nwTF(_license,""),
                              SizedBox(height: size.height*0.05,),
                              ElevatedButton(onPressed: (){

                                  // print(name!+userEmail!+imageUrl!+uid!+widget.dataList['name']+"carID"+widget.dataList['year']+widget.dataList['img']+widget.dataList['location']+_license.text+_days.text+'0');
                                FireStoreDataBase().addReservation(name!,userEmail!,imageUrl!,uid!,widget.dataList['name'],"carID",widget.dataList['year'],widget.dataList['img'],widget.dataList['location'],_license.text,_days.text,'0',);
                                setState(() {});
                                Navigator.pop(context);

                              //displayname
                              //email
                              //photoURL
                              //uid
                              //  car name
                              //  car id
                              //  car model year
                              //  car pic
                              //  registration id
                              //  number days
                              }, child: Text("Reserve"),),
                            ],
                          ),
                        ),
                        SizedBox(height: size.height*0.05,),

                      ],
                    ),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
