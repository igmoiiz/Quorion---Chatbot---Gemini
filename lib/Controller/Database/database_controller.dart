import 'dart:developer';

import 'package:firebase_database/firebase_database.dart';

class DatabaseController {
  //  INSTANCE FOR FIREBASE DATABASE (REALTIME)
  final FirebaseDatabase _database = FirebaseDatabase.instance;

  //  METHOD TO INSERT DATA INTO THE DATABASE
  Future<void> insertData(String description) async {
    try {
      await _database
          .ref('Root')
          .child('Path1')
          .set({'description': description})
          .then((value) {
            log("Data Posted Successfully!");
          })
          .catchError((error) {
            log(error.toString());
          });
    } catch (error) {
      log(error.toString());
    }
  }

  //  METHOD TO UPDATE DATA IN THE DATABASE
  Future<void> updateData(String description) async {
    try {
      await _database
          .ref('Root')
          .child('Path1')
          .update({'description': description})
          .then((value) {
            log("Data Updated Successfully!");
          })
          .catchError((error) {
            log(error.toString());
          });
    } catch (error) {
      log(error.toString());
    }
  }

  //  METHOD TO DELETE DATA FROM THE DATABASE
  Future<void> deleteData() async {
    try {
      await _database
          .ref('Root')
          .child('Path1')
          .remove()
          .then((value) {
            log("Data Deleted Successfully!");
          })
          .catchError((error) {
            log(error.toString());
          });
    } catch (error) {
      log(error.toString());
    }
  }

  //  METHOD TO READ DATA FROM THE DATABASE
  Future<void> readData() async {
    try {
      await _database
          .ref('Root')
          .child('Path1')
          .get()
          .then((value) {
            log("Data: ${value.value}");
          })
          .catchError((error) {
            log(error.toString());
          });
    } catch (error) {
      log(error.toString());
    }
  }
}
