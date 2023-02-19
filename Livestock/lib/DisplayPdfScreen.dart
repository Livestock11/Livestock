import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart';
import 'package:livestock/ReadPDF.dart';

class DiesesInformation extends StatefulWidget {
  const DiesesInformation({Key? key}) : super(key: key);

  @override
  State<DiesesInformation> createState() => _DiesesInformationState();
}

class _DiesesInformationState extends State<DiesesInformation> {

  @override
  Widget build(BuildContext context) {
    CollectionReference users =
        FirebaseFirestore.instance.collection('Chicken');
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 50,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(color: Colors.white),
            child: Center(
              child: Text(
                'Diseases Information',
                style: GoogleFonts.poppins(
                  fontSize: 20,
                  color: Colors.black,
                ),
              ),
            ),
          ),
          Container(
            height: 200,
            child: FutureBuilder<DocumentSnapshot>(
              future: users.doc('wrxGgLVXdcLKUYKIdZ8F').get(),
              builder: (BuildContext context,
                  AsyncSnapshot<DocumentSnapshot> snapshot) {
                if (snapshot.hasError) {
                  return Text("Something went wrong");
                }

                if (snapshot.hasData && !snapshot.data!.exists) {
                  return Text("Document does not exist");
                }

                if (snapshot.connectionState == ConnectionState.done) {
                  Map<String, dynamic> data =
                      snapshot.data!.data() as Map<String, dynamic>;
                  return ListView(
                    shrinkWrap: true,
                    children: [
                      ListTile(
                        onTap: (){

                          String path = data['doc1'].toString();
                          String name = 'Bird Flue';
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => ReadPDF(
                                    path: path,
                                    name: name,
                                  )));

                        },
                        title: Text(
                          'Bird Flue',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                      ListTile(
                        onTap: (){
                          String path = data['doc2'].toString();
                          String name = 'Boiler Farming';
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => ReadPDF(
                                    path: path,
                                    name: name,
                                  )));


                        },
                        title: Text(
                          'Boiler Farming',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                      ListTile(
                        onTap: (){
                          String path = data['doc3'].toString();
                          String name = 'Rural Poultry';
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => ReadPDF(
                                    path: path,
                                    name: name,
                                  )));

                        },
                        title: Text(
                          'Rural Poultry',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ],
                  );

                  //   "Full Name: ${data['name']} ${data['phone']}"

                  // );
                }

                return Center(child: Container(height: 50,width: 50,

                child: CircularProgressIndicator(
                  color: Colors.white,
                ),));
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Divider(
              thickness: 2,
              color: Colors.white,
            ),
          ),
          Container(
            height: 50,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(color: Colors.white),
          ),
          Padding(
            padding: EdgeInsets.all(10),
            child: Text('Measure to avoid diseases',
                style: GoogleFonts.poppins(fontSize: 20, color: Colors.white)),
          ),
          ListTile(
            onTap: () {
              String path = 'lib/assets/images/Exotic_Grasses.pdf';
              String name = 'Exotic_Grasses';
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => ReadPDF(
                            path: path,
                            name: name,
                          )));
            },
            title: Text(
              'Exotic_Grasses',
              style: GoogleFonts.poppins(fontSize: 18, color: Colors.white),
            ),
          ),
          ListTile(
            onTap: () {
              String path =
                  'lib/assets/images/Instructions_for_raising_calf.pdf';
              String name = 'Instructions_for_raising_calf';
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => ReadPDF(
                            path: path,
                            name: name,
                          )));
            },
            title: Text(
              'Instructions_for_raising_calf',
              style: GoogleFonts.poppins(fontSize: 18, color: Colors.white),
            ),
          ),
          ListTile(
            onTap: () {
              String path =
                  'lib/assets/images/modern methods of raising buffalo.pdf';
              String name = 'modern methods of raising buffalo';
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => ReadPDF(
                            path: path,
                            name: name,
                          )));
            },
            title: Text(
              'modern methods of raising buffalo',
              style: GoogleFonts.poppins(fontSize: 18, color: Colors.white),
            ),
          ),
          ListTile(
            onTap: () {
              String path = 'lib/assets/images/MottGrass.pdf';
              String name = 'MottGrass';
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => ReadPDF(
                            path: path,
                            name: name,
                          )));
            },
            title: Text(
              'MottGrass',
              style: GoogleFonts.poppins(fontSize: 18, color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }
}
