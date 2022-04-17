import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase/firebase.dart';
import 'package:flutter/material.dart';
import 'package:universal_html/html.dart';

import '../Firestore/database_manager.dart';

class ManageRequest extends StatefulWidget {
  const ManageRequest({Key? key}) : super(key: key);

  @override
  State<ManageRequest> createState() => _ManageRequestState();
}

class _ManageRequestState extends State<ManageRequest> {
  List dataList=[];
  List reserveListID=[];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Manage Request"),
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('Reserve')
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

//
// FutureBuilder(
// future: getReserveData1([],reserveListID),
// builder: (context, snapshot) {
// if (snapshot.hasError) {
// return const Text(
// "Something went wrong",
// );
// }
// if (snapshot.connectionState == ConnectionState.done) {
// dataList = snapshot.data as List;
// return buildReserveItems(dataList,reserveListID,FireStoreDataBase().reserveRef);
// }
// return const Center(child: CircularProgressIndicator());
// },
// )
// if (snapshot.connectionState == ConnectionState.done) {
// dataList = snapshot.data as List;
// return buildReserveItems(dataList,reserveListID,FireStoreDataBase().reserveRef);
// }

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
                        ElevatedButton(onPressed: (){
                          ref.doc(dataList?.docs[index].id).update({"confirm":"1"});

                        }, child: const Text("Accept"),style: ElevatedButton.styleFrom(
                            primary: Colors.green,
                            padding:const EdgeInsets.symmetric(horizontal: 50, vertical: 20),
                            textStyle:const TextStyle(
                                fontWeight: FontWeight.bold)),),
                        const SizedBox(width: 8,),
                        ElevatedButton(onPressed: (){
                          ref.doc(dataList?.docs[index].id).update({"confirm":"2"});
                        }, child: const Text("Reject"),style: ElevatedButton.styleFrom(
                            primary: Colors.red,
                            padding:const EdgeInsets.symmetric(horizontal: 50, vertical: 20),
                            textStyle:const TextStyle(
                                fontWeight: FontWeight.bold)),),
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
                    const SizedBox(height: 5,),
                    GestureDetector(   onTap: () async {
        await showDialog(
        context: context,
        builder: (_) => ImageDialog()
        );
        }, child: const Text('\t\tView License')),
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

class ImageDialog extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Container(
        width: 200,
        height: 200,
        decoration: BoxDecoration(
            image: DecorationImage(
                image: NetworkImage('https://upload.wikimedia.org/wikipedia/commons/thumb/0/0a/Projekt_nowego_prawa_jazdy.png/220px-Projekt_nowego_prawa_jazdy.png'),
                fit: BoxFit.cover
            )
        ),
      ),
    );
  }
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