import 'storage_service.dart';

class GroupData {
  static final Map<String, Map<String, dynamic>> groups = {
    "5L1": {
      "bidderName": "",
      "bidMonth": 1,
      "auctionDate": "",
      "bidAmount": 0,
      "monthlyPay": 25000,
      "auctionHistory": [],
    },
    "5L2": {
      "bidderName": "",
      "bidMonth": 1,
      "auctionDate": "",
      "bidAmount": 0,
      "monthlyPay": 25000,
      "auctionHistory": [],
    },
    "5L3": {
      "bidderName": "",
      "bidMonth": 1,
      "auctionDate": "",
      "bidAmount": 0,
      "monthlyPay": 25000,
      "auctionHistory": [],
    },
    "5L4": {
      "bidderName": "",
      "bidMonth": 1,
      "auctionDate": "",
      "bidAmount": 0,
      "monthlyPay": 25000,
      "auctionHistory": [],
    },
    "5L5": {
      "bidderName": "",
      "bidMonth": 1,
      "auctionDate": "",
      "bidAmount": 0,
      "monthlyPay": 25000,
      "auctionHistory": [],
    },
    "5L6": {
      "bidderName": "",
      "bidMonth": 1,
      "auctionDate": "",
      "bidAmount": 0,
      "monthlyPay": 25000,
      "auctionHistory": [],
    },
    "5L7": {
      "bidderName": "",
      "bidMonth": 1,
      "auctionDate": "",
      "bidAmount": 0,
      "monthlyPay": 25000,
      "auctionHistory": [],
    },
    "3L1": {
      "bidderName": "",
      "bidMonth": 1,
      "auctionDate": "",
      "bidAmount": 0,
      "monthlyPay": 15000,
      "auctionHistory": [],
    },
    "3L2": {
      "bidderName": "",
      "bidMonth": 1,
      "auctionDate": "",
      "bidAmount": 0,
      "monthlyPay": 15000,
      "auctionHistory": [],
    },
    "3L3": {
      "bidderName": "",
      "bidMonth": 1,
      "auctionDate": "",
      "bidAmount": 0,
      "monthlyPay": 15000,
      "auctionHistory": [],
    },
    "3L4": {
      "bidderName": "",
      "bidMonth": 1,
      "auctionDate": "",
      "bidAmount": 0,
      "monthlyPay": 15000,
      "auctionHistory": [],
    },
    "2L1": {
      "bidderName": "",
      "bidMonth": 1,
      "auctionDate": "",
      "bidAmount": 0,
      "monthlyPay": 10000,
      "auctionHistory": [],
    },
    "2L2": {
      "bidderName": "",
      "bidMonth": 1,
      "auctionDate": "",
      "bidAmount": 0,
      "monthlyPay": 10000,
      "auctionHistory": [],
    },
  };

  static void loadSavedData() {
    groups.forEach((groupName, groupData) {
      final savedData =
      StorageService.getGroup(groupName);

      if (savedData != null) {
        groups[groupName] = savedData;
      }
    });
  }
}