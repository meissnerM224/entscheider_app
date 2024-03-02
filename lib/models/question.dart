class Question {
  final String? answer;
  final DateTime? created;
  final String? query;

  const Question({this.answer, this.created, this.query});

  Map<String, dynamic> toJson() => {
        'answer': answer,
        'created': created?.toIso8601String(),
        'query': query,
      };

  Question.fromSnapshot(snapshot)
      : answer = snapshot.data()['answer'],
        created = DateTime.tryParse(snapshot.data()['created']),
        query = snapshot.data()['query'];

  Question copyWith({
    String? answer,
    DateTime? created,
    String? query,
  }) =>
      Question(
        answer: answer ?? this.answer,
        created: created ?? this.created,
        query: query ?? this.query,
      );
}
