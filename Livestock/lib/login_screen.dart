import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:ndialog/ndialog.dart';



class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  var namecontroller = TextEditingController();
  var phonecontroller = TextEditingController();
  String? verificationCode;
  late final String phone;
 late final String codeDigits;
  final FocusNode pinOTPCodeFoucus = FocusNode();
  

  @override
  Widget build(BuildContext context) {
    return Scaffold(


      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [

            SizedBox(height: 100),
            Padding(
              padding: const EdgeInsets.only(left: 28.0, right: 28.0),
              child: Image.asset("lib/assets/images/Welcome.png"),
            ),

            Container(
              margin: EdgeInsets.only(top: 10),
              child: Center(
                child: Text(
                  "Welcome to Livestock Information System",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                ),
              ),
            ),
            TextField(
              controller: namecontroller,
              decoration: const InputDecoration(
                hintText: 'Please Enter Your Name',
              ) ,
            ),

            const SizedBox(
              height: 10,
            ),
            TextField(
              controller: phonecontroller,
              decoration: const InputDecoration(
                hintText: 'Please Enter your Number'
              ),
            ),
            const SizedBox(
              height: 10,
            ),

            ElevatedButton(
                onPressed: () async{
                  var name = namecontroller.text.trim();
                  var phone= phonecontroller.text.trim();

                  if(name.isEmpty || phone.isEmpty){
                    Fluttertoast.showToast(msg: "Please Fill all the Fields");
                    return;
                  }

                  ProgressDialog progressDialog = ProgressDialog(
                      context,
                      title: const Text('Logging In...'),
                      message: const Text('Please Wait'),
                  );
                  
                  progressDialog.show();



                },
                child: const Text('Register Now')
            )


          ],
        ),
      ),);
  }
}

