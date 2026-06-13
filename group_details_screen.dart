import 'package:flutter/material.dart';
import '../services/excel_service.dart';
import '../services/group_data.dart';
import '../services/storage_service.dart';

class GroupDetailsScreen extends StatefulWidget {
  final String category;
  final String sheetName;
  final bool isAdmin;

  const GroupDetailsScreen({
    super.key,
    required this.category,
    required this.sheetName,
    this.isAdmin = false,
  });

  @override
  State<GroupDetailsScreen> createState() =>
      _GroupDetailsScreenState();
}

class _GroupDetailsScreenState
    extends State<GroupDetailsScreen> {
  List<List<String>> rows = [];
  bool loading = true;

  String chitValue = '';
  String totalMonths = '';
  String groupTitle = '';
  List<String> members = [];

  @override
  void initState() {
    super.initState();
    loadSheet();
  }

  Future<void> loadSheet() async {
    final data = await ExcelService.getSheetData(
      category: widget.category,
      sheetName: widget.sheetName,
    );

    String value = '';
    String months = '';
    String title = widget.sheetName;

    final List<String> memberList = [];

    for (final row in data) {
      final rowText = row.join(' ').trim();

      if (rowText.contains('Rs.')) {
        value = rowText;
      }

      if (rowText.toUpperCase().contains('MONTHS')) {
        months = rowText
            .replaceAll('MONTHS -', '')
            .trim();
      }

      if (rowText.toUpperCase().contains('GROUP')) {
        title = rowText;
      }

      if (row.isNotEmpty) {
        final firstCell = row[0].trim();

        final isNumber =
            int.tryParse(firstCell) != null;

        if (isNumber && row.length > 1) {
          final memberName = row[1].trim();

          if (memberName.isNotEmpty) {
            memberList.add(memberName);
          }
        }
      }
    }

    setState(() {
      rows = data;
      chitValue = value;
      totalMonths = months;
      groupTitle = title;
      members = memberList;
      loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final currentData =
    GroupData.groups[widget.sheetName];

    final auctionHistory =
    List<Map<String, dynamic>>.from(
      currentData?["auctionHistory"] ?? [],
    );

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.sheetName),
      ),
      body: loading
          ? const Center(
        child:
        CircularProgressIndicator(),
      )
          : ListView(
        padding:
        const EdgeInsets.all(16),
        children: [
          Card(
            elevation: 3,
            child: Padding(
              padding:
              const EdgeInsets.all(
                16,
              ),
              child: Column(
                children: [
                  Text(
                    groupTitle,
                    textAlign:
                    TextAlign.center,
                    style:
                    const TextStyle(
                      fontSize: 20,
                      fontWeight:
                      FontWeight.bold,
                    ),
                  ),

                  const SizedBox(
                    height: 15,
                  ),

                  ListTile(
                    leading: const Icon(
                      Icons
                          .currency_rupee,
                    ),
                    title: const Text(
                      'Chit Value',
                    ),
                    subtitle:
                    Text(chitValue),
                  ),

                  ListTile(
                    leading: const Icon(
                      Icons
                          .calendar_month,
                    ),
                    title: const Text(
                      'Total Months',
                    ),
                    subtitle: Text(
                      totalMonths,
                    ),
                  ),

                  ListTile(
                    leading: const Icon(
                      Icons.people,
                    ),
                    title: const Text(
                      'Members',
                    ),
                    subtitle: Text(
                      members.length
                          .toString(),
                    ),
                  ),
                ],
              ),
            ),
          ),

          const SizedBox(height: 20),

          if (currentData != null)
            Card(
              elevation: 4,
              child: Padding(
                padding:
                const EdgeInsets.all(
                  16,
                ),
                child: Column(
                  crossAxisAlignment:
                  CrossAxisAlignment
                      .start,
                  children: [
                    const Text(
                      "Current Auction",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight:
                        FontWeight
                            .bold,
                      ),
                    ),

                    const Divider(),

                    Text(
                      "Bidder : ${currentData["bidderName"]}",
                      style:
                      const TextStyle(
                        fontSize: 16,
                      ),
                    ),

                    const SizedBox(
                      height: 8,
                    ),

                    Text(
                      "Month : ${currentData["bidMonth"]}",
                      style:
                      const TextStyle(
                        fontSize: 16,
                      ),
                    ),

                    const SizedBox(
                      height: 8,
                    ),

                    Text(
                      "Auction Date : ${currentData["auctionDate"]}",
                      style:
                      const TextStyle(
                        fontSize: 16,
                      ),
                    ),

                    const SizedBox(
                      height: 8,
                    ),

                    Text(
                      "Bid Amount : ₹${currentData["bidAmount"]}",
                      style:
                      const TextStyle(
                        fontSize: 16,
                      ),
                    ),

                    const SizedBox(
                      height: 8,
                    ),

                    Text(
                      "Monthly Pay : ₹${currentData["monthlyPay"]}",
                      style:
                      const TextStyle(
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
              ),
            ),

          const SizedBox(height: 20),

          if (auctionHistory.isNotEmpty)
            Card(
              elevation: 4,
              child: Padding(
                padding:
                const EdgeInsets.all(
                  16,
                ),
                child: Column(
                  crossAxisAlignment:
                  CrossAxisAlignment
                      .start,
                  children: [
                    Row(
                      mainAxisAlignment:
                      MainAxisAlignment
                          .spaceBetween,
                      children: [
                        const Text(
                          'Auction History',
                          style:
                          TextStyle(
                            fontSize:
                            18,
                            fontWeight:
                            FontWeight
                                .bold,
                          ),
                        ),
                        if (widget.isAdmin)
                          IconButton(
                            icon: const Icon(
                              Icons.delete,
                              color: Colors.red,
                            ),
                            onPressed: () async {
                            final confirm =
                            await showDialog<
                                bool>(
                              context:
                              context,
                              builder:
                                  (_) =>
                                  AlertDialog(
                                    title:
                                    const Text(
                                      "Clear Auction History",
                                    ),
                                    content:
                                    const Text(
                                      "Delete all auction history for this group?",
                                    ),
                                    actions: [
                                      TextButton(
                                        onPressed:
                                            () {
                                          Navigator.pop(
                                            context,
                                            false,
                                          );
                                        },
                                        child:
                                        const Text(
                                          "Cancel",
                                        ),
                                      ),
                                      ElevatedButton(
                                        onPressed:
                                            () {
                                          Navigator.pop(
                                            context,
                                            true,
                                          );
                                        },
                                        child:
                                        const Text(
                                          "Delete",
                                        ),
                                      ),
                                    ],
                                  ),
                            );

                            if (confirm !=
                                true) {
                              return;
                            }

                            final group =
                            GroupData.groups[
                            widget
                                .sheetName];

                            if (group ==
                                null) {
                              return;
                            }

                            group[
                            "auctionHistory"] =
                            [];

                            await StorageService
                                .saveGroup(
                              widget
                                  .sheetName,
                              group,
                            );

                            setState(
                                    () {});
                          },
                        ),
                      ],
                    ),

                    const Divider(),

                    ...auctionHistory.map(
                          (item) {
                        return ListTile(
                          leading:
                          const Icon(
                            Icons.history,
                          ),
                          title: Text(
                            "Month ${item["month"]}",
                          ),
                          subtitle:
                          Text(
                            "${item["bidder"]}\n₹${item["amount"]}",
                          ),
                          trailing:
                          Text(
                            item["date"]
                                .toString(),
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),

          const SizedBox(height: 20),

          const Text(
            'Members',
            style: TextStyle(
              fontSize: 22,
              fontWeight:
              FontWeight.bold,
            ),
          ),

          const SizedBox(height: 10),

          ...List.generate(
            members.length,
                (index) {
              return Card(
                child: ListTile(
                  leading:
                  CircleAvatar(
                    child: Text(
                      '${index + 1}',
                    ),
                  ),
                  title: Text(
                    members[index],
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}