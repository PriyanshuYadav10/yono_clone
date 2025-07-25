class TransactionModel {
  final String date;
  final String title;
  final String amount;
  final bool isCredit;

  TransactionModel({
    required this.date,
    required this.title,
    required this.amount,
    required this.isCredit,
  });

  Map<String, dynamic> toJson() => {
    'date': date,
    'title': title,
    'amount': amount,
    'isCredit': isCredit,
  };

  factory TransactionModel.fromJson(Map<String, dynamic> json) {
    return TransactionModel(
      date: json['date'],
      title: json['title'],
      amount: json['amount'],
      isCredit: json['isCredit'],
    );
  }
}
