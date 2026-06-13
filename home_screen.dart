import 'package:flutter/material.dart';
import 'admin_screen.dart';
import 'group_details_screen.dart';
import 'search_member_screen.dart';
import '../services/storage_service.dart';

void _showAdminLogin(BuildContext context) {
  final passwordController = TextEditingController();

  showDialog(
    context: context,
    builder: (_) {
      return AlertDialog(
        title: const Text('Admin Login'),
        content: TextField(
          controller: passwordController,
          obscureText: true,
          decoration: const InputDecoration(
            labelText: 'Password',
          ),
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              if (
              passwordController.text.trim() ==
                  StorageService.getAdminPassword()
              ){
                Navigator.pop(context);

                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => const AdminScreen(),
                  ),
                );
              } else {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Wrong Password'),
                  ),
                );
              }
            },
            child: const Text('Login'),
          ),
        ],
      );
    },
  );
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  static const Map<String, List<String>> groups = {
    '5L': [
      '5L1',
      '5L2',
      '5L3',
      '5L4',
      '5L5',
      '5L6',
      '5L7',
    ],
    '3L': [
      '3L1',
      '3L2',
      '3L3',
      '3L4',
    ],
    '2L': [
      '2L1',
      '2L2',
    ],
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('GSB Chits'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            _categoryButton(context, '5L'),
            const SizedBox(height: 15),

            _categoryButton(context, '3L'),
            const SizedBox(height: 15),

            _categoryButton(context, '2L'),
            const SizedBox(height: 30),

            SizedBox(
              width: double.infinity,
              height: 55,
              child: ElevatedButton.icon(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => const SearchMemberScreen(),
                    ),
                  );
                },
                icon: const Icon(Icons.search),
                label: const Text(
                  'Search Member',
                  style: TextStyle(fontSize: 18),
                ),
              ),
            ),

            const SizedBox(height: 15),

            SizedBox(
              width: double.infinity,
              height: 55,
              child: ElevatedButton.icon(
                onPressed: () {
                  _showAdminLogin(context);
                },
                icon: const Icon(Icons.admin_panel_settings),
                label: const Text(
                  'Admin',
                  style: TextStyle(fontSize: 18),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _categoryButton(
      BuildContext context,
      String category,
      ) {
    return SizedBox(
      width: double.infinity,
      height: 70,
      child: ElevatedButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => GroupListScreen(
                title: category,
                groups: groups[category]!,
              ),
            ),
          );
        },
        child: Text(
          category,
          style: const TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}

class GroupListScreen extends StatelessWidget {
  final String title;
  final List<String> groups;

  const GroupListScreen({
    super.key,
    required this.title,
    required this.groups,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: ListView.builder(
        itemCount: groups.length,
        itemBuilder: (context, index) {
          return Card(
            margin: const EdgeInsets.all(8),
            child: ListTile(
              title: Text(groups[index]),
              trailing: const Icon(
                Icons.arrow_forward_ios,
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => GroupDetailsScreen(
                      category: title,
                      sheetName: groups[index],
                    ),
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}