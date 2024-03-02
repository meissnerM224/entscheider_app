import 'dart:developer' as log;
import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:entscheider_app/extensions/string_extension.dart';
import 'package:entscheider_app/models/question.dart';
import 'package:entscheider_app/routes/app_router.dart';
import 'package:entscheider_app/services/auth_service.dart';
import 'package:flutter/material.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  final TextEditingController _askController = TextEditingController();
  String _answer = '';
  bool _askBTNActive = false;

  @override
  void initState() {
    super.initState();
    _askController.text = _answer;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Entscheidungen'),
          actions: [
            Padding(
              padding: const EdgeInsets.only(right: 20.0),
              child: GestureDetector(
                onTap: () => log.log('Auf den shop geklickt'),
                child: const Icon(Icons.shopping_bag),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(right: 20.0),
              child: GestureDetector(
                onTap: () =>
                    Navigator.of(context).pushNamed(AppRouter.historyScreen),
                child: const Icon(Icons.history),
              ),
            )
          ],
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Padding(
                padding: EdgeInsets.all(8),
                child: Text('Entscheidung über: unlimedet'),
              ),
              _buildQuestionForm(),
              const Expanded(child: SizedBox()),
              const Padding(
                  padding: EdgeInsets.all(8),
                  child: Text('Account Type: Free')),
              Text('${AuthService().currentUser?.uid}'),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildQuestionForm() {
    return Column(
      children: [
        Text(
          'Sollte ich...',
          style: Theme.of(context).textTheme.headlineMedium,
        ),
        Padding(
          padding: const EdgeInsets.only(left: 30, right: 30, bottom: 10),
          child: TextField(
            controller: _askController,
            decoration: const InputDecoration(helperText: 'Stell deine Frage'),
            maxLines: 1,
            textInputAction: TextInputAction.done,
            onChanged: (value) {
              setState(() {
                _askController.text = value;
                _askBTNActive = value.length >= 3;
              });
            },
          ),
        ),
        ElevatedButton(
          onPressed: _askBTNActive ? _answerQuestion : null,
          child: const Text('Bestätigen'),
        ),
        _questionAndAnswer(),
      ],
    );
  }

  String _getAnswer() {
    final answerOptions = ['Ja', 'Nein', 'Unbedingt!', 'nicht Jetzt'];
    return answerOptions[Random().nextInt(answerOptions.length)];
  }

  Widget _questionAndAnswer() {
    return _answer != ''
        ? Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 20.0),
                child: Text('Sollte ich ${_askController.text.capytalize()}'),
              ),
              Text(
                _answer.capytalize(),
                style: Theme.of(context).textTheme.bodyMedium,
              ),
            ],
          )
        : const SizedBox();
  }

  void _answerQuestion() async {
    if (_askBTNActive) {
      setState(() => _answer = _getAnswer());
      log.log(_askController.text);
      log.log(_answer);
      final question = Question(
        query: _askController.text,
        answer: _answer,
        created: DateTime.now(),
      );
      await FirebaseFirestore.instance
          .collection('users')
          .doc(AuthService().currentUser?.uid)
          .collection('questions')
          .add(question.toJson());
    }
    _askController.clear();
  }
}
