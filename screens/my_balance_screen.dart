import 'package:flutter/material.dart';

class MyBalanceScreen extends StatelessWidget {
  const MyBalanceScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      initialIndex: 1,
      child: Scaffold(
        backgroundColor: const Color(0xFFFFF5F8),
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0.5,
          title: const Text(
            "My Balance",
            style: TextStyle(color: Colors.black),
          ),
          automaticallyImplyLeading: false,
          leadingWidth: 60,
          leading: Row(
            children: [
              IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: const Icon(
                  Icons.arrow_back_ios_new,
                  color: Colors.black,
                  size: 15,
                ),
              ),
              const Icon(Icons.menu, color: Colors.black, size: 12),
            ],
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: const [
                  Text(
                    "Select Account",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Row(
                    children: [
                      Text(
                        "Savings A/c\nXXXXXXXX7317",
                        textAlign: TextAlign.right,
                        style: TextStyle(fontSize: 12),
                      ),
                      Icon(Icons.arrow_drop_down),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 12),
              const Text(
                "₹ 92.30",
                style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 16),
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: const [
                    BoxShadow(
                      color: Colors.black12,
                      blurRadius: 4,
                      offset: Offset(0, 2),
                    ),
                  ],
                ),
                child: const TabBar(
                  labelColor: Colors.deepPurple,
                  unselectedLabelColor: Colors.black54,
                  indicatorColor: Colors.deepPurple,
                  tabs: [
                    Tab(text: 'Account'),
                    Tab(text: 'Transaction'),
                    Tab(text: 'Spend Analysis'),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              const Expanded(
                child: TabBarView(
                  children: [
                    AccountTab(),
                    TransactionTab(),
                    Center(child: Text("Spend Analysis Placeholder")),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class TransactionTab extends StatelessWidget {
  const TransactionTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(10),
          margin: const EdgeInsets.only(bottom: 10),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Row(
            children: const [
              Icon(Icons.info_outline, size: 16, color: Colors.deepPurple),
              SizedBox(width: 8),
              Expanded(
                child: Text(
                  "You can now filter Account Statement for a particular period. (Max upto 150 transactions)",
                  style: TextStyle(fontSize: 12),
                ),
              ),
            ],
          ),
        ),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8),
          ),
          child: const Row(
            children: [
              Icon(Icons.search, size: 20, color: Colors.grey),
              SizedBox(width: 8),
              Expanded(
                child: Text("Search...", style: TextStyle(color: Colors.grey)),
              ),
              Icon(Icons.filter_list, size: 20, color: Colors.grey),
            ],
          ),
        ),
        const SizedBox(height: 10),
        const Align(
          alignment: Alignment.centerLeft,
          child: Text(
            "Transactions Details",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
        const SizedBox(height: 8),
        Expanded(
          child: ListView(
            children: const [
              TransactionTile(
                date: "01 Jul 2025",
                title:
                    "TRANSFER TO 4897692162094 -\nUPI/DR/554801699627/Mr MAJI/YESB/Q108508118/UPI",
                amount: "₹ 50.00",
                isCredit: false,
              ),
              TransactionTile(
                date: "01 Jul 2025",
                title:
                    "TRANSFER TO 4897692162094 -\nUPI/DR/518297778389/PAWAN KU/YESB/paytmqr5xc/UPI",
                amount: "₹ 60.00",
                isCredit: false,
              ),
              TransactionTile(
                date: "01 Jul 2025",
                title:
                    "TRANSFER FROM 4897734162099 -\nUPI/CR/01643213006/Ankit KU/JIOP/8287712965/Payme",
                amount: "₹ 200.00",
                isCredit: true,
              ),
              TransactionTile(
                date: "01 Jul 2025",
                title:
                    "TRANSFER TO 4897692162094 -\nUPI/DR/518295742391/MANSAB K/YESB/0113456251/UPI",
                amount: "₹ 40.00",
                isCredit: false,
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class TransactionTile extends StatelessWidget {
  final String date;
  final String title;
  final String amount;
  final bool isCredit;

  const TransactionTile({
    super.key,
    required this.date,
    required this.title,
    required this.amount,
    required this.isCredit,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 4),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(date, style: const TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(height: 4),
            Text(title, style: const TextStyle(fontSize: 12)),
            const SizedBox(height: 4),
            Align(
              alignment: Alignment.centerRight,
              child: Text(
                (isCredit ? "+ " : "- ") + amount,
                style: TextStyle(
                  color: isCredit ? Colors.green : Colors.red,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class AccountTab extends StatelessWidget {
  const AccountTab({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Card(
            margin: const EdgeInsets.symmetric(vertical: 8),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: const [
                  _BalanceRow(label: "Available balance", value: "₹ 92.30"),
                  Divider(),
                  _BalanceRow(label: "Hold / Lien Amount", value: "₹ 0.00"),
                  Divider(),
                  _BalanceRow(label: "Uncleared Balance", value: "₹ 0.00"),
                  Divider(),
                  _BalanceRow(label: "MOD Balance", value: "₹ 0.00"),
                ],
              ),
            ),
          ),
          const SizedBox(height: 8),
          const Text(
            "Account Description",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 4),
          const Text("REGULAR SB CHQ-INDIVIDUALS"),
          const SizedBox(height: 12),
          const Text("Currency", style: TextStyle(fontWeight: FontWeight.bold)),
          const SizedBox(height: 4),
          const Text("Rupees"),
          const SizedBox(height: 12),
          const Text(
            "Mode of Operation",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 4),
          const Text("SINGLE"),
          const SizedBox(height: 12),
          const Text(
            "Rate of Interest",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 4),
          const Text("2.50%"),
          const SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: const [
              Text(
                "Branch Name",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              Text(
                "View Details",
                style: TextStyle(
                  color: Colors.deepPurple,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          const SizedBox(height: 4),
          const Text("MANDAWA"),
          const SizedBox(height: 16),
          const Divider(thickness: 0.5),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: const [
              Text("View Nominee Details"),
              Row(
                children: [
                  Icon(Icons.edit, size: 16, color: Colors.deepPurple),
                  SizedBox(width: 4),
                  Text(
                    "Edit",
                    style: TextStyle(
                      color: Colors.deepPurple,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }
}

class _BalanceRow extends StatelessWidget {
  final String label;
  final String value;

  const _BalanceRow({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(label),
        Text(value, style: const TextStyle(fontWeight: FontWeight.bold)),
      ],
    );
  }
}
