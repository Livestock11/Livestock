import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class SearchWidget extends StatefulWidget {

  final String search;
  const SearchWidget({Key? key, required this.search,})
      : super(key: key);
  @override
  _SearchWidgetState createState() => _SearchWidgetState();
}

class _SearchWidgetState extends State<SearchWidget> {
  String searchString = '';
  @override
  void initState() {
    super.initState();
    controller.text = widget.search;
    searchString = widget.search;
  }




  CollectionReference animalCollection =
  FirebaseFirestore.instance.collection('Animal');
  TextEditingController controller = TextEditingController();

  convertIntoArray(username) {
    return List<String>.generate(username.length, (index) => username[index]);
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        elevation: 0.0,
        title: Text(
          "Search",
          style: TextStyle(
            color: Colors.white,
            fontSize: width * 0.05,
          ),
        ),
      ),
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              child: TextFormField(
                controller: controller,
                autofocus: true,
                style: const TextStyle(
                  fontSize: 15.0,
                  color: Colors.black,
                ),
                cursorColor: Colors.black,
                showCursor: true,
                decoration: const InputDecoration(
                    filled: true,
                    fillColor: Colors.transparent,
                    hintText: 'Search item...',
                    hintStyle: TextStyle(color: Colors.grey),
                    border: InputBorder.none),
                onChanged: (value) {
                  setState(() {
                    searchString = value.toLowerCase();
                  });
                },
              ),
            ),
            Container(
              padding:
              EdgeInsets.only(left: width * 0.045, right: width * 0.045),
              child: const Divider(
                thickness: 2.0,
              ),
            ),

            TextButton(onPressed: (){
              addAnimal(controller.text, controller.text);

            }, child: Text('Save data')),
            Expanded(
                child: StreamBuilder<QuerySnapshot>(
                    stream: FirebaseFirestore.instance
                        .collection('Animal')
                        .where("searchIndex", arrayContains: searchString)
                        .snapshots(),
                    builder: (context, snapshot) {
                      if (snapshot.hasError) {
                        return Text("Error: ${snapshot.error}");
                      }
                      switch (snapshot.connectionState) {
                        case ConnectionState.waiting:
                          return const Center(
                              child: CircularProgressIndicator());

                        default:
                          return ListView(
                            children: snapshot.data!.docs
                                .map((DocumentSnapshot document) {
                              return ListTile(
                                onTap: () {},
                                title: Text(
                                    "${(document.data() as dynamic)['item']}"),
                              );
                            }).toList(),
                          );
                      }
                    })),
          ],
        ),
      ),
    );
  }

  addAnimal(searchIndex , item) {

    List<String> splitList = searchIndex.split(" ");
    List<String> indexList = [];
    for (int i = 0; i < splitList.length; i++) {
      for (int y = 1; y < splitList[i].length + 1; y++) {
        indexList.add(splitList[i].substring(0, y).toLowerCase());
      }
    }
    animalCollection.doc("Goat").set({
      'item': item,
      'searchIndex': indexList
    });
  }
}


