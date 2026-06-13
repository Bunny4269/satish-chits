import 'package:flutter/material.dart';

class HistoryScreen extends StatefulWidget {
  const HistoryScreen({super.key});

  static final List<String> history = [];

  @override
  State<HistoryScreen> createState() =>
      _HistoryScreenState();
}

class _HistoryScreenState
    extends State<HistoryScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Modification History",
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.delete),
            onPressed: () {
              setState(() {
                HistoryScreen.history.clear();
              });

              ScaffoldMessenger.of(context)
                  .showSnackBar(
                const SnackBar(
                  content: Text(
                    "History Cleared",
                  ),
                ),
              );
            },
          ),
        ],
      ),
      body: HistoryScreen.history.isEmpty
          ? const Center(
        child: Text(
          "No modifications yet",
        ),
      )
          : ListView.builder(
        itemCount:
        HistoryScreen.history.length,
        itemBuilder: (context, index) {
          return Card(
            margin:
            const EdgeInsets.all(8),
            child: ListTile(
              leading: const Icon(
                Icons.history,
              ),
              title: Text(
                HistoryScreen
                    .history[index],
              ),
            ),
          );
        },
      ),
    );
  }
}