import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:task_id_04/core/style/question_style.dart';
import 'package:task_id_04/feature/home_screen/presentation/controller/riverpod_provider.dart';
import 'package:task_id_04/feature/home_screen/presentation/screens/widgets/custom_linerGradient.dart';
import 'package:task_id_04/feature/home_screen/presentation/screens/widgets/result_screen.dart';

class QuizScreen extends ConsumerStatefulWidget {
  const QuizScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _QuizScreenState createState() => _QuizScreenState();
}

class _QuizScreenState extends ConsumerState<QuizScreen> {
  int currentQuestionIndex = 0;

  @override
  Widget build(BuildContext context) {
    final questions = ref.watch(quizQuestionsProvider);
    final userAnswers = ref.watch(userAnswersProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Quiz',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: linearGradient(),
          ),
        ),
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: linearGradient(),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              LinearProgressIndicator(
                value: (currentQuestionIndex + 1) / questions.length,
                backgroundColor: const Color.fromARGB(255, 251, 15, 15),
                color: Colors.purpleAccent,
                minHeight: 10,
              ),
              const SizedBox(height: 20),
              Text(questions[currentQuestionIndex].questionText,
                  style: questionStyle),
              const SizedBox(height: 20),
              for (int i = 0;
                  i < questions[currentQuestionIndex].options.length;
                  i++)
                RadioListTile<int>(
                  title: Text(
                    questions[currentQuestionIndex].options[i],
                    style: TextStyle(
                      color: userAnswers[currentQuestionIndex] == i
                          ? Colors.amber
                          : Colors.white.withOpacity(0.8),
                    ),
                  ),
                  value: i,
                  groupValue: userAnswers[currentQuestionIndex],
                  activeColor: Colors.amber,
                  tileColor: userAnswers[currentQuestionIndex] == i
                      ? Colors.greenAccent.withOpacity(0.8)
                      : Colors.transparent,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  onChanged: (value) {
                    setState(() {
                      ref.read(userAnswersProvider.notifier).update((state) {
                        state[currentQuestionIndex] = value;
                        return state;
                      });
                    });
                  },
                ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  if (currentQuestionIndex > 0)
                    ElevatedButton(
                      onPressed: () {
                        setState(() {
                          currentQuestionIndex--;
                        });
                      },
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 15),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        backgroundColor: Colors.purpleAccent.shade100,
                        elevation: 5,
                        shadowColor: Colors.purpleAccent,
                      ),
                      child: Text('Previous', style: buttomStyle),
                    ),
                  if (currentQuestionIndex < questions.length - 1)
                    ElevatedButton(
                      onPressed: () {
                        setState(() {
                          currentQuestionIndex++;
                        });
                      },
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 15),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        backgroundColor: Colors.purpleAccent.shade100,
                        elevation: 5,
                        shadowColor: Colors.purpleAccent,
                      ),
                      child: Text('Next', style: buttomStyle),
                    ),
                  if (currentQuestionIndex == questions.length - 1)
                    ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const ResultScreen(),
                          ),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 15),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        backgroundColor: Colors.greenAccent.shade100,
                        elevation: 5,
                        shadowColor: Colors.greenAccent,
                      ),
                      child: const Text(
                        'Submit',
                        style: TextStyle(color: Colors.green, fontSize: 16),
                      ),
                    ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
