class GroupModel {
  String groupName;
  String bidderName;
  int bidMonth;
  String auctionDate;
  double bidAmount;
  double monthlyPay;

  GroupModel({
    required this.groupName,
    required this.bidderName,
    required this.bidMonth,
    required this.auctionDate,
    required this.bidAmount,
    required this.monthlyPay,
  });
}