import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const CallGuardApp());
}

class CallGuardApp extends StatelessWidget {
  const CallGuardApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Call Guard',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const HomeScreen(),
    );
  }
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool isListening = false;
  String detectedPhrase = "";

  final List<String> scamPhrases = [
    "váš účet byl napaden",
    "musíte okamžitě zadat své údaje",
    "převeďte peníze na bezpečný účet",
  ];

  void toggleListening() {
    setState(() {
      isListening = !isListening;
      detectedPhrase = isListening ? "Poslouchám..." : "";
    });

    // Simulace detekce fráze
    Future.delayed(const Duration(seconds: 5), () {
      setState(() {
        detectedPhrase = scamPhrases[0]; // jen pro demo
      });
      _showAlert(context, scamPhrases[0]);
    });
  }

  void _showAlert(BuildContext context, String phrase) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text("⚠️ Možný podvod"),
        content: Text("Zazněla podezřelá fráze: \"$phrase\""),
        actions: [
          TextButton(
            child: const Text("OK"),
            onPressed: () => Navigator.of(context).pop(),
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Call Guard")),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: toggleListening,
              child: Text(isListening ? "Zastavit" : "Spustit ochranu"),
            ),
            const SizedBox(height: 20),
            Text(
              detectedPhrase,
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            )
          ],
        ),
      ),
    );
  }
}
