import 'dart:io';

import 'package:flutter/material.dart';

import 'package:pdf/widgets.dart' as pw;
import 'package:pdf/pdf.dart';
import 'package:path_provider/path_provider.dart';
import 'package:open_file/open_file.dart';
class MyBalanceScreen extends StatelessWidget {
  const MyBalanceScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      initialIndex: 1,
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0.5,
          title: Text(
            "My Balance",
            style: TextStyle(color: Colors.blue.shade900, fontSize: 15),
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
                  color: Color.fromARGB(255, 241, 235, 237),
                  border: Border.all(color: Colors.deepPurple, width: 0.2),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      "₹ 92.30",
                      style: TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.w600,
                      ),
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
                    color: Colors.white, // light gray tab bar background
                    borderRadius: BorderRadius.circular(5),
                    border: Border.all(color: Colors.deepPurple, width: 0.5),
                  ),
                  child: TabBar(
                    indicatorSize: TabBarIndicatorSize.tab,
                    labelPadding: EdgeInsets.zero,
                    indicator: BoxDecoration(
                      color: Color.fromARGB(255, 241, 235, 237),
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

class TransactionTab extends StatefulWidget {
  const TransactionTab({super.key});

  @override
  State<TransactionTab> createState() => _TransactionTabState();
}

class _TransactionTabState extends State<TransactionTab> {
  final List<TransactionTile> _transactions = [];
  void _showTransactionBottomSheet() {
    final titleController = TextEditingController();
    final amountController = TextEditingController();
    final dateController = TextEditingController();
    bool isCredit = false;

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setStateDialog) {
            return Padding(
              padding: EdgeInsets.only(
                left: 16,
                right: 16,
                bottom: MediaQuery.of(context).viewInsets.bottom + 16,
                top: 24,
              ),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Text(
                      "Add New Transaction",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 20),
                    TextField(
                      controller: titleController,
                      decoration: InputDecoration(
                        labelText: "Title",
                        prefixIcon: const Icon(Icons.text_fields),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                    ),
                    const SizedBox(height: 12),
                    TextField(
                      controller: amountController,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        labelText: "Amount",
                        prefixIcon: const Icon(Icons.currency_rupee),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                    ),
                    const SizedBox(height: 12),
                    GestureDetector(
                      onTap: () async {
                        final picked = await showDatePicker(
                          context: context,
                          initialDate: DateTime.now(),
                          firstDate: DateTime(2000),
                          lastDate: DateTime(2100),
                        );
                        if (picked != null) {
                          dateController.text =
                              "${picked.day.toString().padLeft(2, '0')} ${_monthName(picked.month)} ${picked.year}";
                        }
                      },
                      child: AbsorbPointer(
                        child: TextField(
                          controller: dateController,
                          decoration: InputDecoration(
                            labelText: "Date",
                            hintText: "Tap to select date",
                            prefixIcon: const Icon(Icons.calendar_today),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 12),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          "Is Credit?",
                          style: TextStyle(fontSize: 16),
                        ),
                        Switch(
                          value: isCredit,
                          onChanged: (val) {
                            setStateDialog(() => isCredit = val);
                          },
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    Row(
                      children: [
                        Expanded(
                          child: OutlinedButton(
                            onPressed: () => Navigator.pop(context),
                            child: const Text("Cancel"),
                          ),
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: ElevatedButton(
                            onPressed: () {
                              if (titleController.text.isNotEmpty &&
                                  amountController.text.isNotEmpty &&
                                  dateController.text.isNotEmpty) {
                                setState(() {
                                  _transactions.add(
                                    TransactionTile(
                                      date: dateController.text.trim(),
                                      title: titleController.text.trim(),
                                      amount:
                                          "₹ ${amountController.text.trim()}",
                                      isCredit: isCredit,
                                    ),
                                  );
                                });
                                Navigator.pop(context);
                              }
                            },
                            child: const Text("Add"),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }
 Map<String, dynamic> accountInfo = {
    "name": "AMIT KUMAR",
    "address": "S/O SUBHASH CHANDRA, VILL- PIPAL KA \nBASS, VIA- MANDAWA, 333704",
    "accountNumber": "61195947317",
    "branch": "MANDAWA",
    "ifsc": "SBIN0031742",
    "micr": "333002019",
    "balance": "11638.05",
    "balanceDate": "03 Jun 2025",
    "date": "03 Jul 2025",
  };

void generateBankStatementPDF(Map<String, dynamic> accountInfo, List<TransactionTile> transactions) async {
  final pdf = pw.Document();
pdf.addPage(
  pw.MultiPage(
    pageFormat: PdfPageFormat.a4,
    build: (pw.Context context) {
      return [
        pw.Center(
          child: pw.Text(
            "State Bank of India",
            style: pw.TextStyle(fontSize: 20, fontWeight: pw.FontWeight.bold, color: PdfColors.blue),
          ),
        ),
        pw.SizedBox(height: 10),
        pw.Row(
          crossAxisAlignment: pw.CrossAxisAlignment.start,
          mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
          children: [
            pw.Column(
              crossAxisAlignment: pw.CrossAxisAlignment.start,
              children: [
                pw.Text("Account Name: ${accountInfo['name']}", style: pw.TextStyle()),
                pw.Text("Address: ${accountInfo['address']}", style: pw.TextStyle()),
                pw.Text("Account Number: ${accountInfo['accountNumber']}", style: pw.TextStyle()),
                pw.Text("Branch: ${accountInfo['branch']}", style: pw.TextStyle()),
                pw.Text("IFS Code: ${accountInfo['ifsc']}", style: pw.TextStyle()),
                pw.Text("MICR Code: ${accountInfo['micr']}", style: pw.TextStyle()),
                pw.Text("Balance as on: ${accountInfo['balanceDate']} ₹${accountInfo['balance']}", style: pw.TextStyle()),
              ],
            ),
            pw.Column(
              crossAxisAlignment: pw.CrossAxisAlignment.end,
              children: [
                pw.Text("Date: ${accountInfo['date']}", style: pw.TextStyle()),
                pw.Text("Account Description: Savings", style: pw.TextStyle()),
                pw.Text("Drawing Power: 0.00", style: pw.TextStyle()),
                pw.Text("Interest Rate: 2.5%", style: pw.TextStyle()),
                pw.Text("Nomination Registered: Yes", style: pw.TextStyle()),
              ],
            ),
          ],
        ),
        pw.SizedBox(height: 20),
        pw.Text("Transaction Statement", style: pw.TextStyle(fontSize: 16, fontWeight: pw.FontWeight.bold)),
        pw.SizedBox(height: 10),
        pw.Table.fromTextArray(
          headers: ["Date", "Details", "Debit", "Credit", "Balance"],
          data: transactions.map((txn) => [
            txn.date,
            txn.title,
            txn.isCredit == false ? "₹${txn.amount}" : "-",
            txn.isCredit == true ? "₹${txn.amount}" : "-",
            "₹92.30"
          ]).toList(),
          headerStyle: pw.TextStyle(fontWeight: pw.FontWeight.bold),
          cellStyle: pw.TextStyle(),
          border: pw.TableBorder.all(),
          cellPadding: const pw.EdgeInsets.all(5),
        ),
      ];
    },
  ),
);


  final output = await getTemporaryDirectory();
  final file = File("${output.path}/bank_statement.pdf");
  await file.writeAsBytes(await pdf.save());

  // Open the PDF
  await OpenFile.open(file.path);
}
  String _monthName(int month) {
    const months = [
      'Jan',
      'Feb',
      'Mar',
      'Apr',
      'May',
      'Jun',
      'Jul',
      'Aug',
      'Sep',
      'Oct',
      'Nov',
      'Dec',
    ];
    return months[month - 1];
  }

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
        _buildSearchBar( _showTransactionBottomSheet),
        const SizedBox(height: 10),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
             Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "Transactions Details",
                style: TextStyle(fontWeight: FontWeight.bold,fontSize: 15,letterSpacing: 0.5),
              ),),
              Row(children: [
                GestureDetector(
                  behavior: HitTestBehavior.translucent,
                  onTap: (){
                    generateBankStatementPDF(accountInfo, _transactions);
                  },
                  child: Image.asset('assets/download.png',width: 30,)),
                SizedBox(width: 20,),
                Image.asset('assets/mail.png',width: 30,),
              ],)
          ],
        ),
        const SizedBox(height: 8),
        Expanded(
          child: ListView.builder(
            itemCount: _transactions.length,
            itemBuilder: (context, index) {
              final tx = _transactions[index];
              return TransactionTile(
                date: tx.date,
                title: tx.title,
                amount: tx.amount,
                isCredit: tx.isCredit,
              );
            },
          ),
        ),
      ],
    );
  }
}

  Widget _buildSearchBar( showTransactionBottomSheet) {
    return Row(
      children: [
        Expanded(
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border(
              bottom: BorderSide(
                color: Color.fromARGB(255, 241, 235, 237),
                width: 3.0,          
              ),
            ),
              borderRadius: BorderRadius.circular(30),
            ),
            height: 45,
            child: Row(
              children: const [
                Text("Search....", style: TextStyle(color: Colors.grey)),
                Spacer(),
                Icon(Icons.search, color: Colors.grey),
              ],
            ),
          ),
        ),
        const SizedBox(width: 10),
         IconButton(
                icon: const Icon(
                  Icons.filter_list,
                  size: 20,
                  color: Colors.grey,
                ),
                onPressed: showTransactionBottomSheet,
              ),
      ],
    );
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
                  width: MediaQuery.sizeOf(context).width * 0.6,
                  child: Text(title, style: const TextStyle(fontSize: 12)),
                ),
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
            color: Color.fromARGB(255, 241, 235, 237),
            margin: const EdgeInsets.symmetric(vertical: 5),
            shape: RoundedRectangleBorder(
              side: BorderSide(color: Colors.deepPurple, width: 0.5),
              borderRadius: BorderRadius.circular(5),
            ),
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: const [
                  _BalanceRow(label: "Available balance", value: "₹ 92.30"),
                  SizedBox(height: 3),
                  _BalanceRow(label: "Hold / Lien Amount", value: "₹ 0.00"),
                  SizedBox(height: 3),
                  _BalanceRow(label: "Uncleared Balance", value: "₹ 0.00"),
                  SizedBox(height: 3),
                  _BalanceRow(label: "MOD Balance", value: "₹ 0.00"),
                ],
              ),
            ),
          ),
          const SizedBox(height: 8),
          const Text(
            "Account Description",
            style: TextStyle(fontWeight: FontWeight.w300, fontSize: 12),
          ),
          const SizedBox(height: 3),
          const Text(
            "REGULAR SB CHQ-INDIVIDUALS",
            style: TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: 14,
              letterSpacing: 0.5,
            ),
          ),
          const SizedBox(height: 10),
          const Text(
            "Currency",
            style: TextStyle(fontWeight: FontWeight.w300, fontSize: 12),
          ),
          const SizedBox(height: 3),
          const Text(
            "Rupees",
            style: TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: 14,
              letterSpacing: 0.5,
            ),
          ),
          const SizedBox(height: 10),
          const Text(
            "Mode of Operation",
            style: TextStyle(fontWeight: FontWeight.w300, fontSize: 12),
          ),
          const SizedBox(height: 3),
          const Text(
            "SINGLE",
            style: TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: 14,
              letterSpacing: 0.5,
            ),
          ),
          const SizedBox(height: 10),
          const Text(
            "Rate of Interest",
            style: TextStyle(fontWeight: FontWeight.w300, fontSize: 12),
          ),
          const SizedBox(height: 3),
          const Text(
            "2.50%",
            style: TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: 14,
              letterSpacing: 0.5,
            ),
          ),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Branch Name",
                    style: TextStyle(fontWeight: FontWeight.w300, fontSize: 12),
                  ),
                  SizedBox(height: 3),
                  Text(
                    "MANDAWA",
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 14,
                      letterSpacing: 0.5,
                    ),
                  ),
                ],
              ),
              GestureDetector(
                behavior: HitTestBehavior.translucent,
                onTap: () {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return WillPopScope(
                        onWillPop: ()async{
                          return false;
                        },
                        child: AlertDialog(
                          backgroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(6)
                          ),
                          content: SizedBox(
                            height: 260,
                            width: double.infinity,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                        "Branch Details",
                                        style: TextStyle(fontWeight: FontWeight.w500, fontSize: 14,letterSpacing: 0.5),
                                      ),
                                      GestureDetector(
                                        onTap: (){
                                          Navigator.of(context).pop();
                                        },
                                        child: Icon(Icons.close_rounded,color: Colors.deepPurple,))
                                  ],
                                ),
                                SizedBox(height: 15),
                                 const Text(
                                        "Branch Name",
                                        style: TextStyle(fontWeight: FontWeight.w400, fontSize: 13,letterSpacing: 0.5),
                                      ),
                                      const SizedBox(height: 3),
                                      const Text(
                                        "MANDAWA",
                                        style: TextStyle(
                                          fontWeight: FontWeight.w500,
                                          fontSize: 14,
                                          letterSpacing: 0.5,
                                        ),
                                      ),
                                      const SizedBox(height: 10),
                                      const Text(
                                        "IFSC Code",
                                        style: TextStyle(fontWeight: FontWeight.w400, fontSize: 13,letterSpacing: 0.5),
                                      ),
                                      const SizedBox(height: 3),
                                      const Text(
                                        "SBIN0031742",
                                        style: TextStyle(
                                          fontWeight: FontWeight.w500,
                                          fontSize: 14,
                                          letterSpacing: 0.5,
                                        ),
                                      ),
                                      const SizedBox(height: 10),
                                      const Text(
                                        "Address",
                                        style:  TextStyle(fontWeight: FontWeight.w400, fontSize: 13,letterSpacing: 0.5),
                                      ),
                                      const SizedBox(height: 3),
                                      const Text(
                                        "WARD NO 6 BISSAU \nCIRCLE, MANDAWA,DISTT.JHUNJHUNU",
                                        style: TextStyle(
                                          fontWeight: FontWeight.w500,
                                          fontSize: 14,
                                          letterSpacing: 0.5,
                                        ),
                                      ),
                                      const SizedBox(height: 10),
                                      const Text(
                                        "Email ID",
                                        style: TextStyle(fontWeight: FontWeight.w400, fontSize: 13,letterSpacing: 0.5),
                                      ),
                                      const SizedBox(height: 3),
                                      const Text(
                                        "sbi.31742@sbi.co.in",
                                        style: TextStyle(
                                          color: Colors.deepPurple,
                                          fontWeight: FontWeight.w500,
                                          fontSize: 14,
                                          letterSpacing: 0.5,
                                        ),
                                      ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  );
                },
                child: Text(
                  "View Details",
                  style: TextStyle(
                    color: Colors.deepPurple,
                    fontWeight: FontWeight.w500,
                    fontSize: 14,
                    letterSpacing: 0.5,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          const Divider(color: Color.fromARGB(255, 241, 235, 237)),
          const SizedBox(height: 15),
          Row(
            children: [
              Text(
                "View Nominee Details",
                style: TextStyle(fontWeight: FontWeight.w500, fontSize: 12),
              ),
              SizedBox(width: 5),
              Row(
                children: [
                  Image.asset('assets/edit.png', height: 16),
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

          const SizedBox(height: 15),
          const Divider(color: Color.fromARGB(255, 241, 235, 237)),
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
        Text(
          label,
          style: TextStyle(fontSize: 13, fontWeight: FontWeight.w500),
        ),
        Text(
          value,
          style: const TextStyle(fontWeight: FontWeight.w500, fontSize: 13),
        ),
      ],
    );
  }
}
