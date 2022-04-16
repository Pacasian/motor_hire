import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';

class FireStoreDataBase {
  List studentsList = [];
  static List reserveList = [];
  List reserveListID = [];


  final CollectionReference collectionRef =
      FirebaseFirestore.instance.collection("Cars");
  final CollectionReference reserveRef =
      FirebaseFirestore.instance.collection("Reserve");


   Future getData() async {
    try {
      //to get data from a single/particular document alone.
      // var temp = await collectionRef.doc("<your document ID here>").get();

      // to get data from all documents sequentially
      await collectionRef.get().then((querySnapshot) {
        for (var result in querySnapshot.docs) {
          studentsList.add(result.data());
        }
      });

      return studentsList;
    } catch (e) {
      debugPrint("Error - $e");
      return null;
    }
  }



   Future getReserveData() async {
    try {
      //to get data from a single/particular document alone.
      // var temp = await collectionRef.doc("<your document ID here>").get();

      // to get data from all documents sequentially
      await reserveRef.get().then((querySnapshot) {
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

  Future getReserveDataIDs() async {
    try {
      //to get data from a single/particular document alone.
      // var temp = await collectionRef.doc("<your document ID here>").get();

      // to get data from all documents sequentially
      await reserveRef.get().then((querySnapshot) {
        for (int i=0;i<querySnapshot.docs.length;i++) {
          reserveListID.add(querySnapshot.docs[i].id);
          // reserveList.add(querySnapshot.docs[i].data());
        }
      });
      // print(reserveListID);
      return (reserveListID);
    } catch (e) {
      debugPrint("Error - $e");
      return null;
    }
  }

  Future<void> addStudents(String _name,String _roll,String _dept) async {
    await printDocID();
    //creates a new doc with unique doc ID
    return collectionRef
        .add({
      'Name': _name,
      'RollNo':_roll,
      'Dept':_dept,
    })
        .then((value) => debugPrint("User Added"))
        .catchError((error) => debugPrint("Failed to add user: $error"));
  }
  Future<void> addCars(String _name,String _year,String _img,String _loc,String _latlong) async {
    await printDocID();
    //creates a new doc with unique doc ID
    return collectionRef
        .add({
      'name': _name,
      'img':_img,
      'year':_year,
      'location':_loc,
      'latlang':_latlong,
      'reserved':'0',
    })
        .then((value) => debugPrint("Car Added"))
        .catchError((error) => debugPrint("Failed to add user: $error"));
  }

  Future<void> addReservation(String _clientName,String _email,String _clientPhoto,String _uid,String _cName,String _cID,String _cYear,String _cPic,String _cLoc,String _reg,String _days,String _confirm) async {
    await printDocID();
    //creates a new doc with unique doc ID
    return reserveRef
        .add({
      'displayName':_clientName,
      'email':_email,
      'photoURL':_clientPhoto,
      'uid':_uid,
       'carName':_cName,
       'carID':_cID,
       'carModelYear':_cYear,
       'carPic':_cPic,
      'carLocation':_cLoc,
       'registrationID':_reg,
       'numDays':_days,
      'confirm': _confirm
    })
        .then((value) => debugPrint("Reservation in Transit"))
        .catchError((error) => debugPrint("Failed to add user: $error"));
  }

  Future<void> addField() {
    return collectionRef
        .doc('MyDoc')
    //will edit the doc if already available or will create a new doc with this given ID
        .set(
      {'role': "developer"},
      SetOptions(merge: true),
      // if set to 'false', then only these given fields will be added to that doc
    )
        .then((value) => debugPrint("User Added"))
        .catchError((error) => debugPrint("Failed to add user: $error"));
  }

  printDocID() async {
    var querySnapshots = await collectionRef.get();
    for (var snapshot in querySnapshots.docs) {
      var documentID = snapshot.id;
      debugPrint(documentID);
    }
  }
}