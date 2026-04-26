import 'package:flutter/material.dart';

void main() {
  runApp(const SentenceJoinerApp());
}

class SentenceJoinerApp extends StatelessWidget {
  const SentenceJoinerApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Joining Sentence',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
      ),
      home: const SentenceJoinerHomePage(),
    );
  }
}

class SentenceJoinerHomePage extends StatefulWidget {
  const SentenceJoinerHomePage({super.key});

  @override
  State<SentenceJoinerHomePage> createState() => _SentenceJoinerHomePageState();
}

class _SentenceJoinerHomePageState extends State<SentenceJoinerHomePage> {
  final TextEditingController _controller = TextEditingController();
  final List<String> _parts = [];

  void _addPart() {
    final text = _controller.text.trim();
    if (text.isNotEmpty) {
      setState(() {
        _parts.add(text);
      });
      _controller.clear();
    }
  }

  void _clearParts() {
    setState(() {
      _parts.clear();
    });
  }

  String get _joinedSentence {
    if (_parts.isEmpty) return 'No words joined yet.';
    return _parts.join(' ') + '.';
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Joining Sentence'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        actions: [
          IconButton(
            icon: const Icon(Icons.delete_sweep),
            onPressed: _parts.isEmpty ? null : _clearParts,
            tooltip: 'Clear All',
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Card(
              elevation: 4,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    const Text(
                      'Joined Sentence',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 16),
                    Text(
                      _joinedSentence,
                      style: TextStyle(
                        fontSize: 20,
                        color: _parts.isEmpty ? Colors.grey : Colors.black87,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 24),
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _controller,
                    decoration: const InputDecoration(
                      labelText: 'Add a word or phrase',
                      border: OutlineInputBorder(),
                    ),
                    onSubmitted: (_) => _addPart(),
                  ),
                ),
                const SizedBox(width: 16),
                ElevatedButton(
                  onPressed: _addPart,
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 24,
                      vertical: 16,
                    ),
                  ),
                  child: const Text('Add'),
                ),
              ],
            ),
            const SizedBox(height: 24),
            const Text(
              'Current Parts:',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Expanded(
              child: ListView.builder(
                itemCount: _parts.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    leading: CircleAvatar(child: Text('${index + 1}')),
                    title: Text(_parts[index]),
                    trailing: IconButton(
                      icon: const Icon(Icons.remove_circle, color: Colors.red),
                      onPressed: () {
                        setState(() {
                          _parts.removeAt(index);
                        });
                      },
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
