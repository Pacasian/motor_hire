import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:motor_hire/Screens/profile.dart';

import '../Firestore/database_manager.dart';
import 'car_page.dart';


class UserHome extends StatefulWidget {
  const UserHome({Key? key}) : super(key: key);

  @override
  State<UserHome> createState() => _UserHomeState();
}

class _UserHomeState extends State<UserHome> {
  List dataList = [];
  String dropdownValue = 'Dublin';
  List<String> _list=['Dublin', 'Limerick', 'Galway', 'Cork'];
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(title: const Text("Home"),actions: [
        IconButton(onPressed: (){
          Navigator.push(context, MaterialPageRoute(builder: (context)=>const Profile(),),);
        }, icon: const Icon(Icons.account_circle),),
      ],),
      body: Row(
        children: [
          Expanded(child:
          Container(
          width: 100,
          //

          //   child: Lottie.network(
          //   'https://assets3.lottiefiles.com/packages/lf20_asjtnqce.json',
          //   fit: BoxFit.fill,
          // )
            ),flex: 1,),
          Expanded(
            flex: 5,
            child: Column(
              children: [
                SizedBox(
                  height: size.height*0.04,
                ),
                DropdownButton<String>(
                  value: dropdownValue,
                  icon: const Icon(Icons.arrow_downward),
                  elevation: 16,
                  style: const TextStyle(color: Colors.deepPurple),
                  underline: Container(
                    height: 2,
                    color: Colors.deepPurpleAccent,
                  ),
                  onChanged: (String? newValue) {
                    setState(() {
                      dropdownValue = newValue!;
                    });
                  },
                  items: _list
                      .map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                ),
                SizedBox(
                  height: size.height*0.04,
                ),
                FutureBuilder(
                  future: FireStoreDataBase().getData(dropdownValue),
                  builder: (context, snapshot) {
                    if (snapshot.hasError) {
                      return const Text(
                        "Something went wrong",
                      );
                    }
                    if (snapshot.connectionState == ConnectionState.done) {
                      dataList = snapshot.data as List;
                      // print(dataList.r)
                      return buildItems(dataList);
                    }
                    return const Center(child: CircularProgressIndicator());
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

Expanded buildItems(dataList){
  return Expanded(
    child: GridView.builder(  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 4,
        mainAxisSpacing: 16), itemBuilder: (context,index)=>InkWell(
      onTap: (){
        Navigator.push(context, MaterialPageRoute(builder: (context)=>CarPage(dataList: dataList[index],)));
      },
          child: Card(
      elevation: 4,
      child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(child: Image.network(dataList[index]['img'],fit: BoxFit.cover,),flex: 3,),
            const SizedBox(
              height: 10,
            ),
            Expanded(child: ListTile(
              title: Text(dataList[index]['name']),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(dataList[index]['year']),
                  Text(dataList[index]['location']),
                ],
              ),
            ),flex: 1,),
          ],
      ),
    ),
        ),itemCount: dataList.length,),
  );

}
