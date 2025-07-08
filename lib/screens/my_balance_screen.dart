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
          title: Text(
            "My Balance",
            style: TextStyle(color: Colors.blue.shade900,fontSize: 15),
          ),
          automaticallyImplyLeading: false,
          leadingWidth: 75,
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
              const Icon(Icons.menu, color: Colors.black, size: 20),
            ],
          ),
          centerTitle: false,
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Select Account",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 12),
              Container(
                padding: EdgeInsets.all(4),
                decoration: BoxDecoration(
                  color: Colors.black.withOpacity(0.09),
                  border: Border.all(color: Colors.deepPurple,width: 0.2)
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      "₹ 92.30",
                      style: TextStyle(fontSize: 25, fontWeight: FontWeight.w600),
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
              ),
              const SizedBox(height: 16),
              PreferredSize(
                preferredSize: Size.fromHeight(48),
                child: Container(
                  decoration: BoxDecoration(
                    color: Color(0xFFEFEFEF), // light gray tab bar background
                    borderRadius: BorderRadius.circular(5),
                    border: Border.all(color: Colors.deepPurple,width: 0.5)
                  ),
                  child: TabBar(
                    indicatorSize: TabBarIndicatorSize.tab,
                    labelPadding: EdgeInsets.zero,
                    indicator: BoxDecoration(
                      color: Colors.white,
                    ),
                    labelColor: Colors.black,
                    unselectedLabelColor: Colors.grey[600],
                    indicatorPadding: EdgeInsets.all(2),
                    tabs: [
                      _buildTabWithBorder('Account', rightBorder: true),
                      _buildTabWithBorder('Transaction', rightBorder: true),
                      _buildTabWithBorder('Spend Analysis', rightBorder: false),
                    ],
                  ),
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
  Tab _buildTabWithBorder(String label, {bool rightBorder = false}) {
    return Tab(
      child: Container(
        decoration: BoxDecoration(
          border: Border(
            right: rightBorder
                ? BorderSide(color: Colors.grey.shade400, width: 0.8)
                : BorderSide.none,
          ),
        ),
        alignment: Alignment.center,
        child: Text(label),
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
                date: "06 Jul 2025",
                title:
                    "TRANSFER TO 4897692162094 -\nUPI/DR/554801699627/Mr MAJI/YESB/Q108508118/UPI",
                amount: "₹ 50.00",
                isCredit: false,
              ),
              TransactionTile(
                date: "06 Jul 2025",
                title:
                    "TRANSFER TO 4897692162094 -\nUPI/DR/518297778389/PAWAN KU/YESB/paytmqr5xc/UPI",
                amount: "₹ 60.00",
                isCredit: false,
              ),
              TransactionTile(
                date: "05 Jul 2025",
                title:
                    "TRANSFER FROM 4897734162099 -\nUPI/CR/01643213006/Ankit KU/JIOP/8287712965/Payme",
                amount: "₹ 200.00",
                isCredit: true,
              ),
              TransactionTile(
                date: "04 Jul 2025",
                title:
                    "TRANSFER TO 4897692162094 -\nUPI/DR/518295742391/MANSAB K/YESB/0113456251/UPI",
                amount: "₹ 40.00",
                isCredit: false,
              ),
              TransactionTile(
                date: "02 Jul 2025",
                title:
                    "TRANSFER TO 4897692162094 -\nUPI/DR/518295742391/MANSAB K/YESB/0113456251/UPI",
                amount: "₹ 400.00",
                isCredit: false,
              ),
              TransactionTile(
                date: "01 Jul 2025",
                title:
                    "TRANSFER TO 4897692162094 -\nUPI/DR/518295742391/MANSAB K/YESB/0113456251/UPI",
                amount: "₹ 4000.00",
                isCredit: true,
              ),
              TransactionTile(
                date: "01 Jul 2025",
                title:
                    "TRANSFER TO 4897692162094 -\nUPI/DR/518295742391/MANSAB K/YESB/0113456251/UPI",
                amount: "₹ 60.00",
                isCredit: false,
              ),
              TransactionTile(
                date: "01 Jul 2025",
                title:
                    "TRANSFER TO 4897692162094 -\nUPI/DR/518295742391/MANSAB K/YESB/0113456251/UPI",
                amount: "₹ 90.00",
                isCredit: true,
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
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(date, style: const TextStyle(fontWeight: FontWeight.bold)),
                const SizedBox(height: 4),
                SizedBox(
                    width: MediaQuery.sizeOf(context).width*0.6,
                    child: Text(title, style: const TextStyle(fontSize: 12))),
                const SizedBox(height: 4),
              ],
            ),
            Text(
              (isCredit ? "+ " : "- ") + amount,
              style: TextStyle(
                color: isCredit ? Colors.green : Colors.red,
                fontWeight: FontWeight.bold,
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
            color: Colors.white.withOpacity(0.6),
            margin: const EdgeInsets.symmetric(vertical: 5),
            shape: RoundedRectangleBorder(
              side: BorderSide(
                color: Colors.deepPurple,
                width: 0.5
              ),
              borderRadius: BorderRadius.circular(5),
            ),
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: const [
                  _BalanceRow(label: "Available balance", value: "₹ 92.30"),
                  SizedBox(height: 3,),
                  _BalanceRow(label: "Hold / Lien Amount", value: "₹ 0.00"),
                  SizedBox(height: 3,),
                  _BalanceRow(label: "Uncleared Balance", value: "₹ 0.00"),
                  SizedBox(height: 3,),
                  _BalanceRow(label: "MOD Balance", value: "₹ 0.00"),
                ],
              ),
            ),
          ),
          const SizedBox(height: 8),
          const Text(
            "Account Description",
     style: TextStyle(fontWeight: FontWeight.w300,fontSize: 12)
          ),
          const SizedBox(height: 3),
          const Text("REGULAR SB CHQ-INDIVIDUALS", style: TextStyle(fontWeight: FontWeight.w500,fontSize: 12)),
          const SizedBox(height: 10),
          const Text("Currency", style: TextStyle(fontWeight: FontWeight.w300,fontSize: 12)),
          const SizedBox(height: 3),
          const Text("Rupees",style: TextStyle(fontWeight: FontWeight.w500,fontSize: 12)),
          const SizedBox(height: 10),
          const Text(
            "Mode of Operation",
              style: TextStyle(fontWeight: FontWeight.w300,fontSize: 12)
          ),
          const SizedBox(height: 3),
          const Text("SINGLE",style: TextStyle(fontWeight: FontWeight.w500,fontSize: 12)),
          const SizedBox(height: 10),
          const Text(
            "Rate of Interest",
              style: TextStyle(fontWeight: FontWeight.w300,fontSize: 12)
          ),
          const SizedBox(height: 3),
          const Text("2.50%",style: TextStyle(fontWeight: FontWeight.w500,fontSize: 12)),
          const SizedBox(height: 10),
          // Row(
          //   ],
          // ),
          // const SizedBox(height: 4),
          // const Text("MANDAWA"),
          // const SizedBox(height: 16),
          // const Divider(thickness: 0.5),
          // const SizedBox(height: 10),
          //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //   children: const [
          //     Text(
          //       "Branch Name",
          //       style: TextStyle(fontWeight: FontWeight.bold),
          //     ),
          //     Text(
          //       "View Details",
          //       style: TextStyle(
          //         color: Colors.deepPurple,
          //         fontWeight: FontWeight.bold,
          //       ),
          //     ),
          Row(
            children: const [
              Text("View Nominee Details",style: TextStyle(fontWeight: FontWeight.w500,fontSize: 12)),
              SizedBox(width: 5,),
              Row(
                children: [
                  Icon(Icons.edit, size: 12, color: Colors.deepPurple),
                  SizedBox(width: 4),
                  Text(
                    "Edit",
                    style: TextStyle(
                      fontSize: 12,
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
        Text(label,style: TextStyle(fontSize: 13,fontWeight: FontWeight.w500),),
        Text(value, style: const TextStyle(fontWeight: FontWeight.w500,fontSize: 13)),
      ],
    );
  }
}
