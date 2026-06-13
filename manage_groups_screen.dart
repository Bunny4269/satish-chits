import 'package:flutter/material.dart';
import '../services/group_data.dart';
import '../services/storage_service.dart';
import 'history_screen.dart';

class ManageGroupsScreen extends StatefulWidget {
  const ManageGroupsScreen({super.key});

  @override
  State<ManageGroupsScreen> createState() =>
      _ManageGroupsScreenState();
}

class _ManageGroupsScreenState
    extends State<ManageGroupsScreen> {
  @override
  Widget build(BuildContext context) {
    final groups = GroupData.groups.entries.toList();

    return Scaffold(
      appBar: AppBar(
        title: const Text("Manage Groups"),
      ),
      body: ListView.builder(
        itemCount: groups.length,
        itemBuilder: (context, index) {
          final entry = groups[index];
          final groupName = entry.key;
          final group = entry.value;

          return Card(
            margin: const EdgeInsets.all(8),
            child: ListTile(
              title: Text(groupName),
              subtitle: Text(
                "Bidder: ${group["bidderName"]}",
              ),
              trailing: const Icon(Icons.edit),
              onTap: () {
                _editGroup(
                  groupName,
                  group,
                );
              },
            ),
          );
        },
      ),
    );
  }

  void _editGroup(
      String groupName,
      Map<String, dynamic> group,
      ) {
    final bidderController = TextEditingController(
      text: group["bidderName"]?.toString() ?? "",
    );

    final monthController = TextEditingController(
      text: group["bidMonth"]?.toString() ?? "",
    );

    final dateController = TextEditingController(
      text: group["auctionDate"]?.toString() ?? "",
    );

    final bidController = TextEditingController(
      text: group["bidAmount"]?.toString() ?? "",
    );

    final payController = TextEditingController(
      text: group["monthlyPay"]?.toString() ?? "",
    );

    showDialog(
      context: context,
      builder: (_) {
        return AlertDialog(
          title: Text(groupName),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  controller: bidderController,
                  decoration: const InputDecoration(
                    labelText: "Bidder Name",
                  ),
                ),
                TextField(
                  controller: monthController,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    labelText: "Bid Month",
                  ),
                ),
                TextField(
                  controller: dateController,
                  decoration: const InputDecoration(
                    labelText: "Auction Date",
                  ),
                ),
                TextField(
                  controller: bidController,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    labelText: "Bid Amount",
                  ),
                ),
                TextField(
                  controller: payController,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    labelText: "Monthly Pay",
                  ),
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text("Cancel"),
            ),
            ElevatedButton(
              onPressed: () async {
                setState(() {
                  group["bidderName"] =
                      bidderController.text.trim();

                  group["bidMonth"] =
                      int.tryParse(
                        monthController.text,
                      ) ??
                          1;

                  group["auctionDate"] =
                      dateController.text.trim();

                  group["bidAmount"] =
                      double.tryParse(
                        bidController.text,
                      ) ??
                          0;

                  group["monthlyPay"] =
                      double.tryParse(
                        payController.text,
                      ) ??
                          0;
                });

                // Add auction history
                final history =
                    (group["auctionHistory"] as List?)
                        ?.map(
                          (e) => Map<String, dynamic>.from(
                        e as Map,
                      ),
                    )
                        .toList() ??
                        <Map<String, dynamic>>[];

                history.add({
                  "month":
                  int.tryParse(
                    monthController.text,
                  ) ??
                      1,
                  "bidder":
                  bidderController.text.trim(),
                  "date":
                  dateController.text.trim(),
                  "amount":
                  double.tryParse(
                    bidController.text,
                  ) ??
                      0,
                });

                group["auctionHistory"] = history;

                // Save to Hive
                await StorageService.saveGroup(
                  groupName,
                  group,
                );

                // Save activity history
                HistoryScreen.history.insert(
                  0,
                  "${DateTime.now()}\n"
                      "Group: $groupName\n"
                      "Bidder: ${bidderController.text}\n"
                      "Month: ${monthController.text}\n"
                      "Auction Date: ${dateController.text}\n"
                      "Bid Amount: ${bidController.text}\n"
                      "Monthly Pay: ${payController.text}",
                );

                if (!mounted) return;

                Navigator.pop(context);

                ScaffoldMessenger.of(context)
                    .showSnackBar(
                  const SnackBar(
                    content: Text(
                      "Group Updated Successfully",
                    ),
                  ),
                );
              },
              child: const Text("Save"),
            ),
          ],
        );
      },
    );
  }
}