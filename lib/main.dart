import 'package:flutter/material.dart';

void main() {
  runApp(const QuizApp());
}

class QuizApp extends StatelessWidget {
  const QuizApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomeScreen(),
    );
  }
}

// Tela inicial
class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Imagem de fundo
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/img/fundo_app.jpg'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Center(
            // Centraliza o conteúdo
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text(
                  'Bem-vindo ao Quiz!',
                  style: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const QuizScreen(),
                      ),
                    );
                  },
                  child: const Text(
                    'Iniciar Quiz',
                    style: TextStyle(fontSize: 20),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// Tela do Quiz
class QuizScreen extends StatefulWidget {
  const QuizScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _QuizScreenState createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  final List<Map<String, dynamic>> questions = [
    {
      "question": "O que é uma estrela?",
      "options": [
        "Um planeta que emite luz própria",
        "Um corpo celeste que reflete a luz do Sol",
        "Uma esfera de gás quente e luminosa mantida unida pela gravidade",
        "Um satélite natural que orbita um planeta"
      ],
      "correctAnswer": 2
    },
    {
      "question": "Qual é o maior planeta do Sistema Solar?",
      "options": ["Terra", "Júpiter", "Saturno", "Urano"],
      "correctAnswer": 1
    },
    {
      "question": "O que significa a sigla 'NASA'?",
      "options": [
        "Administração Nacional de Aeronáutica e Espaço",
        "Agência Espacial Norte-Americana",
        "Agência Nacional para Avanços Espaciais",
        "Nova Aliança Aeronáutica e Espacial"
      ],
      "correctAnswer": 1
    },
    {
      "question": "O que são buracos negros?",
      "options": [
        "Estrelas que se apagaram e deixaram um vazio no espaço",
        "Regiões do espaço com gravidade tão forte que nada pode escapar, nem mesmo a luz",
        "Galáxias que colapsaram em si mesmas",
        "Pontos do universo onde o tempo para completamente"
      ],
      "correctAnswer": 1
    },
    {
      "question": "Quantas luas tem Marte?",
      "options": ["1", "2", "4", "Nenhuma"],
      "correctAnswer": 1
    },
  ];

  int currentQuestionIndex = 0;
  int score = 0;

  void checkAnswer(int selectedIndex) {
    if (selectedIndex == questions[currentQuestionIndex]["correctAnswer"]) {
      score += 10; // Cada resposta correta vale 10 pontos
    }
    setState(() {
      currentQuestionIndex++;
    });
  }

  void restartQuiz() {
    setState(() {
      currentQuestionIndex = 0;
      score = 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Imagem de fundo
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/img/fundo_app.jpg'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Center(
            // Centraliza o conteúdo
            child: currentQuestionIndex < questions.length
                ? buildQuestion()
                : buildResult(),
          ),
        ],
      ),
    );
  }

  Widget buildQuestion() {
    final currentQuestion = questions[currentQuestionIndex];
    return Column(
      mainAxisSize: MainAxisSize.min, // Centraliza o conteúdo verticalmente
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          currentQuestion["question"],
          style: const TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 20),
        ...List.generate(
          currentQuestion["options"].length,
          (index) => Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: ElevatedButton(
              onPressed: () => checkAnswer(index),
              child: Text(
                currentQuestion["options"][index],
                textAlign: TextAlign.center,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget buildResult() {
    return Column(
      mainAxisSize: MainAxisSize.min, // Centraliza o conteúdo verticalmente
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const Text(
          'Quiz Finalizado!',
          style: TextStyle(
            fontSize: 28,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 20),
        Text(
          'Sua pontuação total: $score pontos',
          style: const TextStyle(
            fontSize: 22,
            color: Colors.white,
          ),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 20),
        ElevatedButton.icon(
          onPressed: restartQuiz,
          icon: const Icon(Icons.restart_alt),
          label: const Text('Reiniciar Quiz'),
        ),
      ],
    );
  }
}
