import 'package:blindbnking/features/home/presentation/home_scree.dart';
import 'package:blindbnking/features/register/domain/service/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';


class CustomFormScreen extends StatelessWidget {
  final AuthIdService _auth = AuthIdService();
  final String selectedBankName;
  final TextEditingController dateController = TextEditingController(text: DateFormat('yyyy-MM-dd').format(DateTime.now()));

  CustomFormScreen({required this.selectedBankName});

  final TextEditingController accountNumberController = TextEditingController();
  final TextEditingController idNumberController = TextEditingController();
  final TextEditingController fullNameController = TextEditingController();
  final TextEditingController branchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text(selectedBankName),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Center(child: Text("Fill Your Bank Details",style: TextStyle(color: Colors.blue, fontSize: 20.0),)),
             SizedBox(height: 20.0),
              TextFormField(
                controller: fullNameController,
                decoration: InputDecoration(
                  labelText: 'Full Name',
                  hintText: 'Enter full name',
                  prefixIcon: Icon(Icons.person, color: Colors.blue,),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    borderSide: BorderSide(color: Colors.blue),
                  ),
                  filled: true,
                  fillColor: Colors.white,
                  contentPadding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
                ),
              ),
               SizedBox(height: 20.0),

            TextFormField(
              controller: branchController,
              decoration: InputDecoration(
                labelText: 'Branch',
                hintText: 'Enter branch name',
                prefixIcon: Icon(Icons.location_on, color: Colors.blue,),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                  borderSide: BorderSide(color: Colors.blue),
                ),
                filled: true,
                fillColor: Colors.white,
                contentPadding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
              ),
            ),
            SizedBox(height: 20.0),
            
            TextFormField(
                controller: accountNumberController,
                decoration: InputDecoration(
                  labelText: 'Account Number',
                  hintText: 'Enter account number',
                  prefixIcon: Icon(Icons.account_balance, color: Colors.blue,),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    borderSide: BorderSide(color: Colors.blue),
                  ),
                  filled: true,
                  fillColor: Colors.white,
                  contentPadding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
                ),
              ),
              SizedBox(height: 20.0),
              TextFormField(
                controller: idNumberController,
                decoration: InputDecoration(
                  labelText: 'ID Number',
                  hintText: 'Enter ID number',
                  prefixIcon: Icon(Icons.perm_identity, color: Colors.blue,),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    borderSide: BorderSide(color: Colors.blue),
                  ),
                  filled: true,
                  fillColor: Colors.white,
                  contentPadding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
                ),
              ),

            SizedBox(height: 20.0),
            TextFormField(
                controller: dateController,
                decoration: InputDecoration(
                  labelText: 'Date',
                  hintText: 'Enter Date',
                  prefixIcon: Icon(Icons.calendar_today, color: Colors.blue,),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    borderSide: BorderSide(color: Colors.blue),
                  ),
                  filled: true,
                  fillColor: Colors.white,
                  contentPadding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
                ),
              ),
              SizedBox(height: 20.0,),
            ElevatedButton(
                onPressed: () async {
                  String accountNumber = accountNumberController.text;
                  String idNumber = idNumberController.text;
                  String fullName = fullNameController.text;
                  String branch = branchController.text;
                  String date = dateController.text;

                  // Save data to Firestore
                  try {
                    await FirebaseFirestore.instance.collection('users').doc(_auth.userId).set({
                      'accountNumber': accountNumber,
                      'idNumber': idNumber,
                      'fullName': fullName,
                      'branch': branch,
                      'bankName': selectedBankName,
                      'date': date
                    });
                    Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => HomeScreen()),
                  );
                  } catch (e) {
                    // Handle errors
                    print('Error saving data: $e');
                  }
                },
                child: Text('Save'),
              ),
          ],
        ),
      ),
    );
  }
}
