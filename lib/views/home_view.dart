import 'dart:developer';

import 'package:flutter/material.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Entscheidungen'),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 20.0),
            child: GestureDetector(
              onTap: () => log('Auf den shop geklickt'),
              child: const Icon(Icons.shopping_bag),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(right: 20.0),
            child: GestureDetector(
              onTap: () => log('Click auf History'),
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
              child: Text(
                'Entscheidung über:##',
              ),
            ),
            _buildQuestionForm(),
            const Padding(
              padding: EdgeInsets.all(8),
              child: Text('Account type: free'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildQuestionForm() {
    return Column(
      children: [
        Text(
          'Sollte ich?',
          style: Theme.of(context).textTheme.headlineMedium,
        ),
        const Padding(
          padding: EdgeInsets.only(left: 30, right: 30, bottom: 10),
          child: TextField(
            decoration: InputDecoration(helperText: 'Stell deine Frage'),
          ),
        ),
        ElevatedButton(
          onPressed: () => log('clicked'),
          child: const Text('Bestätigen'),
        )
      ],
    );
  }
}
