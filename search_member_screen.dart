import 'package:flutter/material.dart';
import '../services/excel_service.dart';
import '../services/group_data.dart';

class SearchMemberScreen extends StatefulWidget {
  const SearchMemberScreen({super.key});

  @override
  State<SearchMemberScreen> createState() =>
      _SearchMemberScreenState();
}

class _SearchMemberScreenState
    extends State<SearchMemberScreen> {
  final TextEditingController searchController =
  TextEditingController();

  List<Map<String, dynamic>> results = [];

  Future<void> search(String keyword) async {
    if (keyword.trim().isEmpty) {
      setState(() {
        results = [];
      });
      return;
    }

    List<Map<String, dynamic>> tempResults = [];

    // SEARCH EXCEL MEMBERS
    final excelResults =
    await ExcelService.searchMember(keyword);

    for (final result in excelResults) {
      tempResults.add({
        "type": "Member",
        "title": result["value"],
        "group": result["sheet"],
      });
    }

    // SEARCH GROUP NAMES
    for (final groupName in GroupData.groups.keys) {
      if (groupName
          .toLowerCase()
          .contains(keyword.toLowerCase())) {
        tempResults.add({
          "type": "Group",
          "title": groupName,
          "group": groupName,
        });
      }
    }

    // SEARCH CURRENT BIDDERS
    GroupData.groups.forEach(
          (groupName, groupData) {
        final bidder =
            groupData["bidderName"] ?? "";

        if (bidder
            .toString()
            .toLowerCase()
            .contains(
          keyword.toLowerCase(),
        )) {
          tempResults.add({
            "type": "Current Bidder",
            "title": bidder,
            "group": groupName,
            "month":
            groupData["bidMonth"],
            "amount":
            groupData["bidAmount"],
          });
        }
      },
    );

    setState(() {
      results = tempResults;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Search Member",
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: searchController,
              onChanged: search,
              decoration: InputDecoration(
                hintText:
                "Search member, bidder or group...",
                prefixIcon:
                const Icon(Icons.search),
                border:
                OutlineInputBorder(
                  borderRadius:
                  BorderRadius.circular(
                    12,
                  ),
                ),
              ),
            ),

            const SizedBox(height: 20),

            Expanded(
              child: results.isEmpty
                  ? const Center(
                child: Text(
                  "No results found",
                ),
              )
                  : ListView.builder(
                itemCount:
                results.length,
                itemBuilder:
                    (context, index) {
                  final item =
                  results[index];

                  return Card(
                    child: ListTile(
                      leading: Icon(
                        item["type"] ==
                            "Group"
                            ? Icons
                            .groups
                            : item["type"] ==
                            "Current Bidder"
                            ? Icons
                            .gavel
                            : Icons
                            .person,
                      ),
                      title: Text(
                        item["title"]
                            .toString(),
                      ),
                      subtitle: Text(
                        item["type"] ==
                            "Current Bidder"
                            ? "Group: ${item["group"]}\nMonth: ${item["month"]}\nBid Amount: ₹${item["amount"]}"
                            : "Group: ${item["group"]}",
                      ),
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