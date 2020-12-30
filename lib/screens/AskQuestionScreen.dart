import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class AskQuestionScreen extends StatefulWidget {
  AskQuestionScreen({Key key}) : super(key: key);

  _AskQuestionScreen createState() => _AskQuestionScreen();
}

class _AskQuestionScreen extends State<AskQuestionScreen> {
  GlobalKey<FormState> _formKey = GlobalKey();
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  TextEditingController _txtQuestion = TextEditingController();
  TextEditingController _txtOptionA = TextEditingController();
  TextEditingController _txtOptionB = TextEditingController();
  TextEditingController _txtOptionC = TextEditingController();
  TextEditingController _txtOptionD = TextEditingController();

  CollectionReference questions =
      FirebaseFirestore.instance.collection('questions');

  void _postQuestion() {
    if (!_formKey.currentState.validate()) {
      return;
    }

    questions.add({
      "Question": "What's on your mind?",
      "Options": {
        'A': 'Option A',
        'B': 'Option B',
        'C': 'Option C',
        'D': 'Option D',
      },
      "createdAt": FieldValue.serverTimestamp(),
      "createdBy": "123",
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text("Poll"),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(10),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                TextFormField(
                  controller: _txtQuestion,
                  decoration: InputDecoration(
                    hintText: "What's on your mind?",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'This field is required';
                    }
                    return null;
                  },
                ),
                Divider(
                  color: Colors.transparent,
                ),
                TextFormField(
                  controller: _txtOptionA,
                  decoration: InputDecoration(
                    hintText: 'Option A',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'This field is required';
                    }
                    return null;
                  },
                ),
                Divider(
                  color: Colors.transparent,
                ),
                TextFormField(
                  controller: _txtOptionB,
                  decoration: InputDecoration(
                    hintText: 'Option B',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'This field is required';
                    }
                    return null;
                  },
                ),
                Divider(
                  color: Colors.transparent,
                ),
                TextFormField(
                  controller: _txtOptionC,
                  decoration: InputDecoration(
                    hintText: 'Option C',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
                Divider(
                  color: Colors.transparent,
                ),
                TextFormField(
                  controller: _txtOptionD,
                  decoration: InputDecoration(
                    hintText: 'Option D',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
                Divider(
                  color: Colors.transparent,
                ),
                RaisedButton.icon(
                  onPressed: _postQuestion,
                  icon: Icon(Icons.edit),
                  label: Text('Post'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
