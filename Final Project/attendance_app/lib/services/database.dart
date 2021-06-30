import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseMethods {
  String reply = " ";
  Future<String> addUserInfoToDB(
      String email, Map<String, dynamic> userRegMap) async {
    DocumentReference dr =
        await FirebaseFirestore.instance.collection("User").doc(email);
    await dr.get().then((data) {
      if (data.exists) {
        reply = "User Already exists";
        print("Reply in addUserInfoToDB in if part is:");
        print(reply);
      } else {
        FirebaseFirestore.instance
            .collection("User")
            .doc(email)
            .set(userRegMap);
        reply = "Success";
        print("Reply in addUserInfoToDB in else part is:");
        print(reply);
      }
      print("Reply in addUserInfoToDB inside the then part is:");
      print(reply);
      // return reply;
    });
    print("Reply in addUserInfoToDB in return part is:");
    print(reply);
    return await reply;
  }

//ToDO: -----------------------Start Methods-----------------------------------
  Future<Map<String, dynamic>> FetchAll(String username) async {
    print("inside FetchAll() is: ");
    var collection = FirebaseFirestore.instance.collection('Employee');
    var querySnapshot =
        await collection.where("username", isEqualTo: username).get();
    for (var queryDocumentSnapshot in querySnapshot.docs) {
      Map<String, dynamic> data = queryDocumentSnapshot.data();
      if (data != null && data != {}) {
        var name = data['name'];
        var username = data['username'];
        print("name in FetchAll is: $name");
        print("username in FetchAll is: $username");
        print("Map is: ");
        data.forEach((k, v) => print('Key: ${k}: value: ${v}'));
        print("data in FetchAll with username: $username is $data");
        return data;
      } else {
        return null;
      }
    }
  }

  FetchAttendanceData(String empid, String date) async {
    Map<String, dynamic> data = {};
    print("inside FetchAttendanceData() is: ");
    print("empid in FetchAttendanceData is: $empid");
    print("date in FetchAttendanceData is: $date");
    var collection = FirebaseFirestore.instance.collection('Attendance');
    await collection
        .where("empid", isEqualTo: empid)
        .where("date", isEqualTo: date)
        .get()
        .then((value) async {
      for (var queryDocumentSnapshot in value.docs) {
        data = await queryDocumentSnapshot.data();
        var name = data['empid'];
        var date = data['date'];
        print("name in FetchAttendanceData is: $name");
        print("username in FetchAttendanceData is: $date");
        print("Map is: ");
        data.forEach((k, v) => print('Key: ${k}: value: ${v}'));
      }
    });

    return data;
  }

  markAttendanceCheckIn(String empid, Map<String, dynamic> empAttendanceMap) {
    FirebaseFirestore.instance
        .collection("Attendance")
        .doc(empid)
        .set(empAttendanceMap);
  }

  markAttendanceCheckOut(String empid, Map<String, dynamic> empAttendanceMap) {
    FirebaseFirestore.instance
        .collection("Attendance")
        .doc(empid)
        .update(empAttendanceMap);
  }

//ToDO: -----------------------End Methods-------------------------------------


  Future<Stream<DocumentSnapshot>> getUserByEmail(String email) async {
    return FirebaseFirestore.instance.collection("User").doc(email).snapshots();
    // .where("email id", isEqualTo: email)
    // .snapshots();
  }
}
