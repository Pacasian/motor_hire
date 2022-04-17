import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:motor_hire/Firestore/authenication.dart';

import '../Firestore/database_manager.dart';

class OrderPage extends StatefulWidget {
  const OrderPage({Key? key}) : super(key: key);

  @override
  State<OrderPage> createState() => _OrderPageState();
}

class _OrderPageState extends State<OrderPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Booking Status"),
      ),
      body: StreamBuilder(
          stream: FirebaseFirestore.instance
              .collection('Reserve').where('uid',isEqualTo:uid)
              .snapshots(),
          builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> streamSnapshot) {
            print(streamSnapshot.data?.docs.length);
            print(streamSnapshot.connectionState);
            if (streamSnapshot.connectionState == ConnectionState.active) {
              // print(streamSnapshot.data?.docs.);
              return buildReserveItems(streamSnapshot.data,FireStoreDataBase().reserveRef,streamSnapshot.data?.docs.length);

            }


            return Center(
              child: CircularProgressIndicator(),
            );
          }
      ),
    );
  }
}

Widget buildReserveItems(QuerySnapshot? dataList,CollectionReference ref,int? length) {
  String status='';
  MaterialColor col;
  return ListView.separated(
      padding: const EdgeInsets.all(8),
      itemCount: length ?? 0,
      separatorBuilder: (BuildContext context, int index) => const Divider(),
      itemBuilder: (BuildContext context, int index) {


        if(dataList?.docs[index]["confirm"]=="0"){
          status ="Waiting";
          col=Colors.amber;
        }else if (dataList?.docs[index]["confirm"]=="1"){
          status= "Agreed";
          col=Colors.green;
        }else{
          status= "Cancelled";
          col=Colors.red;
        }
        return ListTile(
          tileColor: index%2==0?Colors.blue.shade50:Colors.blue.shade300,
          title: Row(
            children: [
              Text("${index+1}. "),
              Text('${dataList?.docs[index].id}'),
            ],
          ),
          subtitle:  Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 28,),
                    Row(
                      children: [

                        CircleAvatar(
                          radius: 26,
                          backgroundColor: Colors.yellow,
                          child: CircleAvatar(
                            radius: 24,
                            backgroundImage: NetworkImage(dataList?.docs[index]["carPic"]),
                          ),
                        ),const SizedBox(width: 5,),
                        Text('  Name    : ${dataList?.docs[index]["carName"]}'),
                      ],
                    ),
                    Text('\t\tYear    : ${dataList?.docs[index]["carModelYear"]}'),
                    const SizedBox(height: 10,),
                    Text('\t\tLocation: ${dataList?.docs[index]["carLocation"]}'),
                    const SizedBox(height: 10,),
                    Text("\t\tDays Reserved: ${dataList?.docs[index]["numDays"]}"),
                    // Text(dataList[index]["registrationID"]),
                    // Text(dataList[index]["registrationID"]),
                    const SizedBox(height: 28,),
                    Row(
                      children: [
                        Card(elevation:4,child: Container(width:100,height:40,color:col,child: Center(child: Text(status)))),
                        const SizedBox(width: 8,),

                      ],
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 28,),
                    Row(
                      children: [

                        CircleAvatar(
                          radius: 26,
                          backgroundColor: Colors.blue,
                          child: CircleAvatar(
                            radius: 24,
                            backgroundImage: NetworkImage(dataList?.docs[index]["photoURL"]),
                          ),
                        ),const SizedBox(width: 5,),
                        Text('  Name    : ${dataList?.docs[index]["displayName"]}'),
                      ],
                    ),
                    Text('\t\tEmail    : ${dataList?.docs[index]["email"]}'),
                    const SizedBox(height: 10,),
                    Text('\t\tLicense No.: ${dataList?.docs[index]["registrationID"]}'),
                    const SizedBox(height: 10,),
                    Text("\t\tUserID: ${dataList?.docs[index]["uid"]}"),
                    // Text(dataList[index]["registrationID"]),
                    const SizedBox(height: 28,),
                    // Card(elevation:4,child: Container(width:100,height:40,color:col,child: Center(child: Text(status)))),
                  ],
                ),
              )
            ],
          ),

        );
      });
}


Future getReserveData1(List reserveList,List reserveListID) async {
  try {
    //to get data from a single/particular document alone.
    // var temp = await collectionRef.doc("<your document ID here>").get();

    // to get data from all documents sequentially
    await FirebaseFirestore.instance.collection("Reserve").get().then((querySnapshot) {
      for (int i=0;i<querySnapshot.docs.length;i++) {
        reserveListID.add(querySnapshot.docs[i].id);
        reserveList.add(querySnapshot.docs[i].data());
      }
    });
    print(reserveListID);
    return (reserveList);
  } catch (e) {
    debugPrint("Error - $e");
    return null;
  }
}