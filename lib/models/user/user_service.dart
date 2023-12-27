// ignore_for_file: unnecessary_brace_in_string_interps

import 'package:flutter/material.dart';

// ignore: depend_on_referenced_packages
import 'package:hive/hive.dart';
// ignore: depend_on_referenced_packages
import 'package:logging/logging.dart';

import '../patientmodel.dart';
import 'user_model.dart';

class Userservice extends ChangeNotifier {
  late Box box;
  late int? count;
  late int? selectedKey;
  PatientModel? patientModel;

  final log = Logger('Userservice');
  init() async {
    Hive.registerAdapter(UserAdapter());
    box = await Hive.openBox('userbox1');
    count = box.length;

    selectedKey = box.get('selectedKey', defaultValue: 0);
    log.info('Hive $count  $selectedKey');
  }

  Future addUser(name, email) async {
    log.info('Adding user to Box');
    var person = User()
      ..firstName = name
      ..email = email;
    box.add(person);
  }

  User updateCurrentUser(String patientid, String name, String lastname) {
    User u = box.get(selectedKey);
    log.info('Updating user : ${u.firstName}');
    String fullname = "${name} ${lastname}";
    u.patientid = patientid;
    u.firstName = name;
    u.name = fullname;
    box.putAt(selectedKey!, u);
    return box.get(selectedKey);
  }

  User fetchCurrentUser() {
    User u = box.get(selectedKey);
    log.info('Fetching user at :${u.patientid}');
    return box.get(selectedKey);
  }

  Future deleteAllUsers() async {
    box.clear();
  }

  List<User> fetchAllUsers() {
    List<User> allusers = [];
    for (var i in box.keys) {
      if (i != 'selectedKey') {
        allusers.add(box.get(i));
      }
    }
    return allusers;
  }

  selectUser(int index) {
    selectedKey = index;
    box.put('selectedKey', index);
    notifyListeners();
  }

  int? getKeyfromName(String name) {
    for (var i in box.keys) {
      if (i != 'selectedKey') {
        User user = box.get(i);
        if (user.firstName == name) {
          return int.parse(i.toString());
        }
      }
    }
    return null;
  }

  PatientModel? getPatientModel() {
    return patientModel;
  }

  PatientModel? updatePatientModel(PatientModel newPatientModel) {
    patientModel = newPatientModel;
    return patientModel;
  }
}
