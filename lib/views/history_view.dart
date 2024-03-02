import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:entscheider_app/models/question.dart';
import 'package:entscheider_app/services/auth_service.dart';
import 'package:entscheider_app/views/helpers/questions_card.dart';
import 'package:flutter/material.dart';

class HistoryView extends StatefulWidget {
  const HistoryView({super.key});

  @override
  State<HistoryView> createState() => _HistoryViewState();
}

class _HistoryViewState extends State<HistoryView> {
  List<Object> _historyList = [];
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    getUSerQuestionsList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Vergangene Entscheidungen'),
      ),
      body: SafeArea(
        child: ListView.builder(
            itemCount: _historyList.length,
            itemBuilder: (context, i) {
              return QuestionsCard(question: _historyList[i] as Question);
            }),
      ),
    );
  }

  Future getUSerQuestionsList() async {
    final uid = AuthService().currentUser?.uid;
    var data = await FirebaseFirestore.instance
        .collection('users')
        .doc(uid)
        .collection('questions')
        .orderBy('created')
        .get();

    setState(() {
      _historyList = List.from(data.docs.map((e) => Question.fromSnapshot(e)));
    });
  }
}
