import 'package:flutter/material.dart';

import 'drawer.dart';

class DataShow extends StatefulWidget {
  final Map<String, dynamic> fetchedData;

  const DataShow({Key key, this.fetchedData}) : super(key: key);
  @override
  _DataShowState createState() => _DataShowState(fetchedData);
}

class _DataShowState extends State<DataShow> {
  final Map<String, dynamic> fetchedData;

  _DataShowState(this.fetchedData);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
          appBar: AppBar(
            title: Text("Welcome ${fetchedData["name"]}"),
          ),
          drawer: navigationMenufunction(context),
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(height: 20,),
              searchUsersList(),
            ],
          )
    );
  }

  Widget searchUsersList() {
    print("inside searchUserList if O n View Screen ");
    if(fetchedData!=null && fetchedData!={}) {
      return SingleChildScrollView(
        child: DataTable(
          columns: [
            DataColumn(label: Text('Name')),
            DataColumn(label: Text('Data')),
          ],
          rows: [
            DataRow(
              cells: [
                DataCell(Text("Employee Name:")),
                DataCell(Text(fetchedData["name"])),
              ],
            ),
            DataRow(
              cells: [
                DataCell(Text("Employee Name:")),
                DataCell(Text(fetchedData["empid"])),
              ],
            ),
            DataRow(
              cells: [
                DataCell(Text("Username:")),
                DataCell(Text(fetchedData["username"])),
              ],
            ),
            DataRow(
              cells: [
                DataCell(Text("Department:")),
                DataCell(Text(fetchedData["department"])),
              ],
            ),
            DataRow(
              cells: [
                DataCell(Text("Joining Date:")),
                DataCell(Text(fetchedData["doj"])),
              ],
            ),
            DataRow(
              cells: [
                DataCell(Text("Date of Birth:")),
                DataCell(Text(fetchedData["dob"])),
              ],
            ),
            // DataRow(
            //   cells: [
            //     DataCell(Text("Driver Name ")),
            //     DataCell(Text(fetchedData["Driver"])),
            //   ],
            // ),
            // DataRow(
            //   cells: [
            //     DataCell(Text("Helper Name")),
            //     DataCell(Text(fetchedData["Helper"])),
            //   ],
            // ),
            // DataRow(
            //   cells: [
            //     DataCell(Text("Bus Contact")),
            //     DataCell(Text(fetchedData["ContactNumber"])),
            //   ],
            // ),
          ],
        ),
      );
    }else{
      return Container(
        color: Colors.redAccent,
        child: Text("Problem in fetching data!"),
      );
    }
  }
}

