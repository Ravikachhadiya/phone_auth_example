import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';

enum UserType {
  Member,
  HigherAuthority,
  SecurityGuard,
}

enum UserStatus {
  Owner,
  Renter,
}

enum OccupancyStatus {
  CurrentlyResiding,
  EmptyHouse,
}

class User with ChangeNotifier {
  final String id;
  final UserType userType;
  final String mobileNumber;
  final String name;
  final String email;
  final String password;
  final String houseNumberId;
  final UserStatus userStatus;
  final OccupancyStatus occupancyStatus;

  User({
    @required this.id,
    @required this.userType,
    @required this.mobileNumber,
    @required this.name,
    @required this.email,
    @required this.password,
    @required this.houseNumberId,
    @required this.userStatus,
    @required this.occupancyStatus,
  });

  Map userData;
  User userInfo;

  void addNewUser(User user) async {
    print("New User addded .... => " + user.toString());

    Map<String, dynamic> userData = {
      "userType": user.userType.index,
      "mobileNumber": user.mobileNumber,
      "name": user.name,
      "email": user.email,
      "password": user.password,
      "houseNumberId": user.houseNumberId,
      "userStatus": user.userStatus.index,
      "occupancyStatus": user.occupancyStatus.index,
    };

    CollectionReference collectionReference =
        Firestore.instance.collection('users');

    collectionReference.document(user.id).setData(userData);
    print(user.id);

    notifyListeners();
    printUserData();
  }

  Future<bool> isUserNew(String userId) async {
    // Get data from firestore
    DocumentSnapshot user =
        await Firestore.instance.collection('user').document(userId).get();

    //print(variable.data == null);

    // Check whether userId is in collection or not
    return (user.data == null) ? true : false;
  }

  void fetchUserData(String userId) async {
    DocumentSnapshot user =
        await Firestore.instance.collection('user').document(userId).get();

    userInfo = User(
      id: userId,
      userType: UserType.values[user.data['userType']],
      mobileNumber: user.data['mobileNumber'],
      name: user.data['name'],
      email: user.data['email'],
      password: user.data['password'],
      houseNumberId: user.data['houseNumberId'],
      userStatus: UserStatus.values[user.data['userStatus']],
      occupancyStatus: OccupancyStatus.values[user.data['occupancyStatus']],
    );

    notifyListeners();
    printUserData();
  }

  void editUserData(User user) async {
    Map<String, dynamic> userData = {
      "userType": user.userType.index,
      "mobileNumber": user.mobileNumber,
      "name": user.name,
      "email": user.email,
      "password": user.password,
      "houseNumberId": user.houseNumberId,
      "userStatus": user.userStatus.index,
      "occupancyStatus": user.occupancyStatus.index,
    };

    CollectionReference collectionReference =
        Firestore.instance.collection('users');

    collectionReference.document(user.id).updateData(userData);

    fetchUserData(user.id);
  }

  void printUserData() {
    print("...............................................................");
    print("User Id : " + userInfo.id);
    print(userInfo.userType.toString());
    print(userInfo.mobileNumber);
    print(userInfo.name);
    print(userInfo.email);
    print(userInfo.password);
    print(userInfo.houseNumberId);
    print(userInfo.userStatus.toString());
    print(userInfo.occupancyStatus.toString());
    print("...............................................................");
  }
}
