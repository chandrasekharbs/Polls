import 'package:Polls/screens/AskQuestionScreen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({Key key}) : super(key: key);

  _HomeScreen createState() => _HomeScreen();
}

class _HomeScreen extends State<HomeScreen> {
  Map<String, String> _selectedValues = new Map();

  Future<QuerySnapshot> getQuestions() async {
    return await FirebaseFirestore.instance.collection('questions').get();
  }

  List<Widget> _generateOptions(DocumentSnapshot snapshot) {
    List<Widget> list = [];

    String documentID = snapshot.id;
    Map<String, dynamic> data = snapshot.data();
    Map<String, dynamic> options = data["Options"];

    list.add(
      ListTile(
        title: Text(data["Question"]),
      ),
    );

    if (options.containsKey("A"))
      list.add(_generateOption("A", options["A"], documentID));
    if (options.containsKey("B"))
      list.add(_generateOption("B", options["B"], documentID));
    if (options.containsKey("C"))
      list.add(_generateOption("C", options["C"], documentID));
    if (options.containsKey("D"))
      list.add(_generateOption("D", options["D"], documentID));

    return list;
  }

  Widget _generateOption(String key, String value, String documentID) {
    return RadioListTile(
      value: key,
      groupValue: _selectedValues.containsKey(documentID)
          ? _selectedValues[documentID]
          : "",
      onChanged: (value) {
        setState(() {
          _selectedValues[documentID] = value;
        });
      },
      title: Text(value),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Polls'),
      ),
      body: FutureBuilder(
        future: getQuestions(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            if (snapshot.hasData) {
              return ListView.builder(
                shrinkWrap: true,
                itemCount: snapshot.data.docs.length,
                itemBuilder: (context, index) {
                  DocumentSnapshot data = snapshot.data.docs[index];

                  return Card(
                    clipBehavior: Clip.antiAliasWithSaveLayer,
                    elevation: 5,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Column(
                      children: _generateOptions(data),
                    ),
                  );
                },
              );
            }
          }
          return Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.edit),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => AskQuestionScreen(),
            ),
          );
        },
      ),
    );
  }
}
