import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:livestock/OTP_Controller.dart';


class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  SignUpScreenState createState() => SignUpScreenState();
}


class SignUpScreenState extends State<SignUpScreen>{
  var nameController = TextEditingController();
  String dialCodeDigits = "+00";
  TextEditingController controller= TextEditingController();
  @override


  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.only(left: 28.0, right: 28.0),
              child: Image.asset("lib/assets/images/Welcome.png"),
            ),

            Container(
              margin: EdgeInsets.only(top: 10),
              child: Center(
                child: Text(
                  "",
                  style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20),
                ),
              ),
            ),

        SizedBox(height: 50),

        SizedBox(
          width: 400,
          height: 60,
          child: CountryCodePicker(

          onChanged:(country){
            setState(() {
              dialCodeDigits = country.dialCode!;
            });

          },
            initialSelection: "IT",
            showCountryOnly: false,
            showOnlyCountryWhenClosed: false,
            favorite: ["+92","PAK"],
        )
        ),

    Padding(
    padding: const EdgeInsets.all(8.0),
    child: Column(
    children: [
    TextField(
    controller: nameController,
    decoration: const InputDecoration(
    //hintText: 'Name',

    ),
      keyboardType: TextInputType.emailAddress,
    ),

           Container(
             margin: EdgeInsets.only(top: 10,right: 10,left: 10),
             child: TextField(
               decoration: InputDecoration(
                 hintText: "Phone Number",
                 prefix: Padding(
                   padding: EdgeInsets.all(4),
                   child: Text(dialCodeDigits),
                 )
               ),
               maxLength: 12,
               keyboardType: TextInputType.number,
               controller: controller,
             ),
           ),


Container(

            margin: EdgeInsets.all(15),
            width: 100,
            child: ElevatedButton(


              onPressed: (){

                var phonenumber = controller.text.trim();
                if (phonenumber.isEmpty ) {
                  // show error toast
                  Fluttertoast.showToast(msg: 'Please Enter your Phone Number');
                  return;
                }

              Navigator.of(context).push(MaterialPageRoute(builder: (c)=>OTPControllerScreen(
              phone: controller.text,
                codeDigits: dialCodeDigits,
              )
              )
              );
              },

              child: const Text(


                'Next',style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold))),

)
  ],
    ),
    ),
    ]
    )
  )
    );

  }
}
