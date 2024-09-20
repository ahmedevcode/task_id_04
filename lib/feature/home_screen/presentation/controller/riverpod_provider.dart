// Quiz data model
import 'package:flutter_riverpod/flutter_riverpod.dart';

class Question {
  final String questionText;
  final List<String> options;
  final int correctAnswerIndex;

  Question(this.questionText, this.options, this.correctAnswerIndex);
}

// Define quiz questions
final quizQuestionsProvider = Provider<List<Question>>((ref) {
  return [
    Question('What is the official language of Egypt?',
        ['Arabic', 'French', 'English', 'Greek'], 0),
    Question(
        'Which ancient wonder of the world is located in Egypt?',
        [
          'The Colossus of Rhodes',
          'The Statue of Zeus at Olympia',
          'The Great Pyramid of Giza',
          'The Hanging Gardens of Babylon'
        ],
        2),
    Question('Which river runs through Egypt and is the longest in the world?',
        ['Amazon', 'Yangtze', 'Nile', 'Mississippi'], 2),
    Question('What is the capital city of Egypt?',
        ['Alexandria', 'Cairo', 'Luxor', 'Administrative Capital'], 3),
  ];
});

// User answers state
final userAnswersProvider =
    StateProvider<List<int?>>((ref) => List.filled(4, null));
