import 'package:flutter/material.dart';
import 'manage_groups_screen.dart';
import 'history_screen.dart';
import 'change_password_screen.dart';

class AdminScreen extends StatelessWidget {
  const AdminScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [

            _menuCard(
              context,
              "Manage Groups",
              Icons.table_chart,
              const ManageGroupsScreen(),
            ),

            const SizedBox(height: 16),
            _menuCard(
              context,
              "Modification History",
              Icons.history,
              const HistoryScreen(),
            ),
            _menuCard(
              context,
              "Change Password",
              Icons.lock,
              const ChangePasswordScreen(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _menuCard(
      BuildContext context,
      String title,
      IconData icon,
      Widget screen,
      ) {
    return Card(
      child: ListTile(
        leading: Icon(icon),
        title: Text(title),
        trailing: const Icon(Icons.arrow_forward_ios),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => screen,
            ),
          );
        },
      ),
    );
  }
}