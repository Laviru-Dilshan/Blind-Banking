import 'package:blindbnking/core/service/texttovoice/texttovoice.dart';
import 'package:blindbnking/features/home/presentation/home_scree.dart';
import 'package:blindbnking/features/register/domain/service/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';


class CashDepositScreen extends StatefulWidget {
  final String selectedService;
  final AuthIdService _auth = AuthIdService();
 
  CashDepositScreen({required this.selectedService});

  @override
  State<CashDepositScreen> createState() => _CashDepositScreenState();
}

class _CashDepositScreenState extends State<CashDepositScreen> {

  final TextEditingController dateController = TextEditingController(text: DateFormat('yyyy-MM-dd').format(DateTime.now()));

  final TextEditingController accountNumberController = TextEditingController();

  final TextEditingController idNumberController = TextEditingController();

  final TextEditingController fullNameController = TextEditingController();

  final TextEditingController branchController = TextEditingController();

  final TextEditingController amountController = TextEditingController();

  final TextEditingController bankNameController = TextEditingController();
   final TextToSpeech textToSpeech = TextToSpeech();

  @override
  void initState() {
    super.initState();
    // Fetch user data from Firestore using _auth.userId
    FirebaseFirestore.instance.collection('users').doc(widget._auth.userId!).get().then((doc) {
      if (doc.exists) {
        setState(() {
          accountNumberController.text = doc['accountNumber'];
          idNumberController.text = doc['idNumber'];
          fullNameController.text = doc['fullName'];
          branchController.text = doc['branch'];
          bankNameController.text = doc['bankName'];
          
        });
      }
    });
  }

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
        title: Text(widget.selectedService),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Center(child: Text('''Fill This Form For ${widget.selectedService}''',style: TextStyle(color: Colors.blue, fontSize: 20.0),)),
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
                controller: amountController,
                decoration: InputDecoration(
                  labelText: 'Amount',
                  hintText: 'Enter Amount',
                  prefixIcon: Icon(Icons.money, color: Colors.blue,),
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

                  // Show success notification
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('''${widget.selectedService} Succeessfully'''),
                    backgroundColor: Colors.green,
                    duration: Duration(seconds: 3),
                  ),
                );
                 // Convert text to speech
                textToSpeech.speak('''${widget.selectedService} Succeessfully''');
                // Stop speech
                textToSpeech.stop();

                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => HomeScreen(),
                  ),
                );
                //   String accountNumber = accountNumberController.text;
                //   String idNumber = idNumberController.text;
                //   String fullName = fullNameController.text;
                //   String branch = branchController.text;
                //   String date = dateController.text;

                //   // Save data to Firestore
                //   try {
                //     await FirebaseFirestore.instance.collection('services').doc(_auth.userId).set({
                //       'accountNumber': accountNumber,
                //       'idNumber': idNumber,
                //       'fullName': fullName,
                //       'branch': branch,
                //       'service': selectedService,
                //       'date': date
                //     });
                //     Navigator.push(
                //     context,
                //     MaterialPageRoute(builder: (context) => HomeScreen()),
                //   );
                //   } catch (e) {
                //     // Handle errors
                //     print('Error saving data: $e');
                //   }
                // },
                },
                child: Text('Save'),
              ),
          ],
        ),
      ),
    );
  }
}
