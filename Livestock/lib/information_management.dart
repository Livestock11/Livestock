import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:livestock/ReadPDF.dart';

class InformationMaangemt extends StatefulWidget {
  const InformationMaangemt({Key? key}) : super(key: key);

  @override
  State<InformationMaangemt> createState() => _InformationMaangemtState();
}

class _InformationMaangemtState extends State<InformationMaangemt> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text('Information Management'),
      ),
      body: SingleChildScrollView(
        child:Column(
          children: [

            ListTile(
              onTap: () {
                String path = 'lib/assets/images/Beef Production.pdf';
                String name = 'Beef Production';
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => ReadPDF(
                          path: path,
                          name: name,
                        )));
              },
              title: Text(
                'Beef Production',
                style: GoogleFonts.poppins(fontSize: 18, color: Colors.black),
              ),
              leading: Icon(Icons.picture_as_pdf,
                color: Colors.red,
              ),
            ),
            Padding(
              padding: EdgeInsets.all(8),
              child: Divider(
                thickness: 1.0,color: Colors.black,
              ),
            ),

            ListTile(
              onTap: () {
                String path = 'lib/assets/images/modern methods of raising buffalo.pdf';
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
                style: GoogleFonts.poppins(fontSize: 18, color: Colors.black),
              ),
              leading: Icon(Icons.picture_as_pdf,
                color: Colors.red,
              ),
            ),
            Padding(
              padding: EdgeInsets.all(8),
              child: Divider(
                thickness: 1.0,color: Colors.black,
              ),
            ),

            ListTile(
              onTap: () {
                String path = 'lib/assets/images/Broiler Farming (Feasibilty) 2020_0.pdf';
                String name = 'Broiler Farming (Feasibilty) 2020_0';
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => ReadPDF(
                          path: path,
                          name: name,
                        )));
              },
              title: Text(
                'Broiler Farming (Feasibilty) 2020_0',
                style: GoogleFonts.poppins(fontSize: 18, color: Colors.black),
              ),
              leading: Icon(Icons.picture_as_pdf,
                color: Colors.red,
              ),
            ),
            Padding(
              padding: EdgeInsets.all(8),
              child: Divider(
                thickness: 1.0,color: Colors.black,
              ),
            ),

            ListTile(
              onTap: () {
                String path = 'lib/assets/images/Cow Litrature 2021.pdf';
                String name = 'Cow Litrature 2021';
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => ReadPDF(
                          path: path,
                          name: name,
                        )));
              },
              title: Text(
                'Cow Litrature 2021',
                style: GoogleFonts.poppins(fontSize: 18, color: Colors.black),
              ),
              leading: Icon(Icons.picture_as_pdf,
                color: Colors.red,
              ),
            ),
            Padding(
              padding: EdgeInsets.all(8),
              child: Divider(
                thickness: 1.0,color: Colors.black,
              ),
            ),

            ListTile(
              onTap: () {
                String path = 'lib/assets/images/FAQs Urdu.pdf';
                String name = 'FAQs Urdu';
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => ReadPDF(
                          path: path,
                          name: name,
                        )));
              },
              title: Text(
                'FAQs Urdu',
                style: GoogleFonts.poppins(fontSize: 18, color: Colors.black),
              ),
              leading: Icon(Icons.picture_as_pdf,
                color: Colors.red,
              ),
            ),
            Padding(
              padding: EdgeInsets.all(8),
              child: Divider(
                thickness: 1.0,color: Colors.black,
              ),
            ),

            ListTile(
              onTap: () {
                String path = 'lib/assets/images/Goat production.pdf';
                String name = 'Goat production';
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => ReadPDF(
                          path: path,
                          name: name,
                        )));
              },
              title: Text(
                'Goat production',
                style: GoogleFonts.poppins(fontSize: 18, color: Colors.black),
              ),
              leading: Icon(Icons.picture_as_pdf,
                color: Colors.red,
              ),
            ),
            Padding(
              padding: EdgeInsets.all(8),
              child: Divider(
                thickness: 1.0,color: Colors.black,
              ),
            ),
            ListTile(
              onTap: () {
                String path = 'lib/assets/images/Rural Poultary.pdf';
                String name = 'Rural Poultary';
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => ReadPDF(
                          path: path,
                          name: name,
                        )));
              },
              title: Text(
                'Rural Poultary',
                style: GoogleFonts.poppins(fontSize: 18, color: Colors.black),
              ),
              leading: Icon(Icons.picture_as_pdf,
                color: Colors.red,
              ),
            ),
            Padding(
              padding: EdgeInsets.all(8),
              child: Divider(
                thickness: 1.0,color: Colors.black,
              ),
            ),
          ],
        ) ,
      ),
    );
  }
}