import 'package:entscheider_app/extensions/string_extension.dart';
import 'package:entscheider_app/models/question.dart';
import 'package:flutter/material.dart';

class QuestionsCard extends StatelessWidget {
  final Question _question;
  const QuestionsCard({
    super.key,
    required Question question,
  }) : _question = question;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Card(
        elevation: 5,
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
          ),
          padding: const EdgeInsets.all(12),
          child: Column(
            children: [
              Row(
                children: [
                  Text(
                    'Sollte ich ${_question.query}',
                    textAlign: TextAlign.center,
                  )
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    _question.answer!.capytalize(),
                    style: Theme.of(context).textTheme.headlineSmall,
                  ),
                  Text(
                      '${_question.created!.day}.${_question.created!.month}.${_question.created!.year}'),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
