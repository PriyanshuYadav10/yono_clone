import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/services.dart' show rootBundle;
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'package:pdf/widgets.dart' as pw;
import 'package:pdf/pdf.dart';
import 'package:path_provider/path_provider.dart';
import 'package:open_file/open_file.dart';
import 'package:printing/printing.dart';
import 'package:shared_preferences/shared_preferences.dart';
class MyBalanceScreen extends StatefulWidget {
  const MyBalanceScreen({super.key});

  @override
  State<MyBalanceScreen> createState() => _MyBalanceScreenState();
}

class _MyBalanceScreenState extends State<MyBalanceScreen> {

  @override
  void initState() {
    // TODO: implement initState
    _loadBranchData();
    super.initState();
  }
  Future<void> _loadBranchData() async {
    final prefs = await SharedPreferences.getInstance();

    // Default values
    const defaultBranchName = "MANDAWA";
    const defaultIfscCode = "SBIN0031742";
    const defaultAddress = "WARD NO 6 BISSAU \nCIRCLE, MANDAWA,DISTT.JHUNJHUNU";
    const defaultEmail = "sbi.31742@sbi.co.in";
    const defaultBalance = "92.30";

    // Check each key: if missing OR empty, set default
    if (!prefs.containsKey('branchName') || (prefs.getString('branchName')?.isEmpty ?? true)) {
      await prefs.setString('branchName', defaultBranchName);
    }

    if (!prefs.containsKey('ifscCode') || (prefs.getString('ifscCode')?.isEmpty ?? true)) {
      await prefs.setString('ifscCode', defaultIfscCode);
    }

    if (!prefs.containsKey('address') || (prefs.getString('address')?.isEmpty ?? true)) {
      await prefs.setString('address', defaultAddress);
    }

    if (!prefs.containsKey('email') || (prefs.getString('email')?.isEmpty ?? true)) {
      await prefs.setString('email', defaultEmail);
    }

    if (!prefs.containsKey('balance') || (prefs.getString('balance')?.isEmpty ?? true)) {
      await prefs.setString('balance', defaultBalance);
    }

    // Set controllers from shared prefs
    setState(() {
      branchController.text = prefs.getString('branchName') ?? defaultBranchName;
      ifscController.text = prefs.getString('ifscCode') ?? defaultIfscCode;
      addressController.text = prefs.getString('address') ?? defaultAddress;
      emailController.text = prefs.getString('email') ?? defaultEmail;
      balanceController.text = prefs.getString('balance') ?? defaultBalance;
    });
  }



  _saveBranchData() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('branchName', branchController.text);
    await prefs.setString('ifscCode', ifscController.text);
    await prefs.setString('address', addressController.text);
    await prefs.setString('email', emailController.text);
    await prefs.setString('balance', balanceController.text.toString());
    await _loadBranchData(); // reload to update UI
  }
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
                  color: Color(0xFFD8BAF3).withOpacity(0.1),
                  border: Border.all(color: Colors.deepPurple, width: 0.2),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                        width:250,
                        child: Row(
                          children: [
                            Text('₹',style: TextStyle(
                                fontWeight: FontWeight.w500,
                                fontSize:25,
                                letterSpacing: 0.5,
                                color:  Colors.black
                            ),),SizedBox(width: 2,),
                            SizedBox(
                                width:230,
                                child: _buildTextField(balanceController,25,(value) => _saveBranchData())),
                          ],
                        )),
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
                      color: Color(0xFFD8BAF3).withOpacity(0.1),
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
              Expanded(
                child: TabBarView(
                  children: [
                    AccountTab(),
                    const TransactionTab(),
                    const Center(child: Text("Spend Analysis Placeholder")),
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
                ? BorderSide(color: Colors.grey.shade400, width: 0.9)
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

  String findEarliestTransactionDate(List<TransactionTile> transactions) {
    final dateFormat = DateFormat('dd MMM yyyy');

    // Convert string dates to DateTime and find the minimum
    transactions.sort((a, b) =>
        dateFormat.parse(a.date).compareTo(dateFormat.parse(b.date)));

    return transactions.last.date; // The earliest date
  }

  Future<pw.ImageProvider> loadAssetImage(String path) async {
    final ByteData data = await rootBundle.load(path);
    final Uint8List bytes = data.buffer.asUint8List();
    return pw.MemoryImage(bytes);
  }
  void generatePDF(Map<String, dynamic> accountInfo) async {
    final pdf = pw.Document();
    final logo = await loadAssetImage('assets/pdflogo.png');
    pdf.addPage(
      pw.MultiPage(
        pageFormat: PdfPageFormat.a4,
        margin: pw.EdgeInsets.all(20),
        build: (pw.Context context) => [
          pw.Row(
            mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
            children: [
              pw.Text(''),
              pw.Text(
                'State Bank of India',
                style: pw.TextStyle(
                  fontSize: 22,
                  fontWeight: pw.FontWeight.bold,
                  color: PdfColors.blue,
                ),
              ),
              pw.Image(logo, width: 70),
            ]
          ),
          pw.SizedBox(height: 20),

          // Account details section
          pw.Row(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            children: [
              pw.Column(
                  crossAxisAlignment: pw.CrossAxisAlignment.start,
                  children: [
                    pw.Text("Account Name"),
                    pw.SizedBox(height: 15),
                    pw.Text("Address"),
                    pw.Text("-"),
                    pw.SizedBox(height: 15),
                    pw.Text("Date"),
                    pw.SizedBox(height: 15),
                    pw.Text("Account Number"),
                    pw.SizedBox(height: 15),
                    pw.Text("Account Description"),
                    pw.SizedBox(height: 15),
                    pw.Text("Branch"),
                    pw.SizedBox(height: 15),
                    pw.Text("Drawing Power"),
                    pw.SizedBox(height: 15),
                    pw.Text("Interest Rate(%p.a.)"),
                    pw.SizedBox(height: 15),
                    pw.Text("CIF No."),
                    pw.SizedBox(height: 15),
                    pw.Text("IFSC Code"),
                    pw.SizedBox(height: 15),
                    pw.Text("MICR Code"),
                    pw.SizedBox(height: 15),
                    pw.Text("CKYC No."),
                    pw.SizedBox(height: 15),
                    pw.Text("Nomination Registered"),
                    pw.SizedBox(height: 15),
                    pw.Text("Balance as on"),
                    pw.SizedBox(height: 15),
                    pw.Text("Search for"),
                    pw.SizedBox(height: 15),
                  ],
                ),
                  pw.SizedBox(width: 70),
                  pw.Expanded(
                    child: pw.Column(
                      crossAxisAlignment: pw.CrossAxisAlignment.start,
                      children: [
                        pw.Text("${accountInfo['name']}"),
                        pw.SizedBox(height: 15),
                        pw.Text("${accountInfo['address']}"),
                        pw.SizedBox(height: 15),
                        pw.Text("${accountInfo['date']}"),
                        pw.SizedBox(height: 15),
                        pw.Text("${accountInfo['accountNumber']}"),
                        pw.SizedBox(height: 15),
                        pw.Text("${accountInfo['description']}"),
                        pw.SizedBox(height: 15),
                        pw.Text("${accountInfo['branch']}"),
                        pw.SizedBox(height: 15),
                        pw.Text("0.00"),
                        pw.SizedBox(height: 15),
                        pw.Text("2.5000"),
                        pw.SizedBox(height: 15),
                        pw.Text("71176933309"),
                        pw.SizedBox(height: 15),
                        pw.Text("${accountInfo['ifsc']}"),
                        pw.SizedBox(height: 15),
                        pw.Text("${accountInfo['micr']}"),
                        pw.SizedBox(height: 15),
                        pw.Text("XXXXXXXXwords"),
                        pw.SizedBox(height: 15),
                        pw.Text("Yes"),
                        pw.SizedBox(height: 15),
                        pw.Text("${accountInfo['balanceDate']} INR ${accountInfo['balance']}"),
                        pw.SizedBox(height: 15),
                        pw.Text("${accountInfo['searchDate']}"),
                        pw.SizedBox(height: 15),
                      ],
                    ),
                  ),

            ],
          ),
          pw.SizedBox(height: 20),
          pw.Table.fromTextArray(
            headers: ['Date', 'Details', 'Ref No./Cheque No.', 'Debit', 'Credit', 'Balance'],
            data: _transactions.map((txn) {
              return [
                txn.date,
                txn.title,
                '',
                txn.isCredit ? '-' : '₹${txn.amount}',
                txn.isCredit ? '₹${txn.amount}' : '-',
                '₹${11638.05}',
              ];
            }).toList(),
            headerStyle: pw.TextStyle(fontWeight: pw.FontWeight.bold),
            cellStyle: pw.TextStyle(fontSize: 9),
            border: pw.TableBorder.all(color: PdfColors.black),
            cellAlignment: pw.Alignment.centerLeft,
            headerDecoration: pw.BoxDecoration(color:PdfColor.fromInt(0xFFF1EBED)),
          ),
        ],
      ),
    );

    await Printing.layoutPdf(onLayout: (PdfPageFormat format) async => pdf.save());
  }

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
          headers: ['Date', 'Details', 'Ref No./Cheque No.', 'Debit', 'Credit', 'Balance'],
          data: transactions.map((txn) => [
            txn.date,
            txn.title,
            '',
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
                    var earliest= '';
                    if (_transactions.isEmpty) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('No transactions available')),
                      );
                      return;
                    }else{
                      earliest = findEarliestTransactionDate(_transactions);
                    }

                    String? earliestDate = earliest;
                      Map<String, dynamic> accountInfo = {
                        "name": nameController.text,
                        "address": addressController.text,
                        "description": "Savings",
                        "accountNumber": "61195947317",
                        "branch": branchController.text,
                        "ifsc": ifscController.text,
                        "micr": "333002019",
                        "balance": balanceController.text,
                        "balanceDate": DateFormat('dd MMM yyyy').format(DateTime.now()),
                        "date": DateFormat('dd MMM yyyy').format(DateTime.now()),
                        "searchDate":
                        '${DateFormat('dd MMM yyyy').format(DateFormat('dd MMM yyyy').parse(earliestDate))} to ${DateFormat('dd MMM yyyy').format(DateTime.now())}',
                      };
                      generatePDF(accountInfo);


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
              bottom: BorderSide(color: Color.fromARGB(255, 241, 235, 237), width: 3.0)
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
    return  Padding(
      padding: const EdgeInsets.all(5.0),
      child: Column(
        children: [
          Row(
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
          Divider(color:  Color.fromARGB(255, 241, 235, 237),)
        ],
      ),
    );
  }
}

TextEditingController branchController = TextEditingController();
TextEditingController ifscController = TextEditingController();
TextEditingController addressController = TextEditingController();
TextEditingController emailController = TextEditingController();
TextEditingController balanceController = TextEditingController();
TextEditingController nameController = TextEditingController();
class AccountTab extends StatefulWidget {
   AccountTab({super.key});

  @override
  State<AccountTab> createState() => _AccountTabState();
}

class _AccountTabState extends State<AccountTab> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Card(
           // margin: const EdgeInsets.symmetric(vertical: 5),
            shape: RoundedRectangleBorder(
             // side: BorderSide(color: Colors.deepPurple, width: 0.5),
              borderRadius: BorderRadius.circular(5),
            ),
            child: Container(
                decoration: BoxDecoration(
                  color: Color(0xFFD8BAF3).withOpacity(0.1),

                  borderRadius: BorderRadius.circular(5.8),

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
                  SizedBox(
                    width: MediaQuery.sizeOf(context).width*0.65,
                      child: _buildTextField(branchController,14,(value) => _saveBranchData())),
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
                          insetPadding: EdgeInsets.all(13),

                          backgroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(6)
                          ),
                          content: SizedBox(
                            height: 250,
                            width: MediaQuery.of(context).size.width,
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
                                      _buildTextField(branchController,14,(value) => _saveBranchData()),
                                      const SizedBox(height: 10),
                                      const Text(
                                        "IFSC Code",
                                        style: TextStyle(fontWeight: FontWeight.w400, fontSize: 13,letterSpacing: 0.5),
                                      ),
                                      const SizedBox(height: 3),
                                _buildTextField(ifscController,14,(value) => _saveBranchData()),
                                      const SizedBox(height: 10),
                                      const Text(
                                        "Address",
                                        style:  TextStyle(fontWeight: FontWeight.w400, fontSize: 13,letterSpacing: 0.5),
                                      ),
                                      const SizedBox(height: 3),

                                _buildTextField(addressController,14,(value) => _saveBranchData(),maxLines: 2),
                                      const SizedBox(height: 10),
                                      const Text(
                                        "Email ID",
                                        style: TextStyle(fontWeight: FontWeight.w400, fontSize: 13,letterSpacing: 0.5),
                                      ),
                                      const SizedBox(height: 3),

                                _buildTextField(emailController,14,(value) => _saveBranchData(),color: Colors.deepPurple),
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
  @override
  void initState() {
    // TODO: implement initState
    _loadBranchData();
    super.initState();
  }
  Future<void> _loadBranchData() async {
    final prefs = await SharedPreferences.getInstance();

    // Default values
    const defaultBranchName = "MANDAWA";
    const defaultIfscCode = "SBIN0031742";
    const defaultAddress = "WARD NO 6 BISSAU \nCIRCLE, MANDAWA,DISTT.JHUNJHUNU";
    const defaultEmail = "sbi.31742@sbi.co.in";

    // Check each key: if missing OR empty, set default
    if (!prefs.containsKey('branchName') || (prefs.getString('branchName')?.isEmpty ?? true)) {
      await prefs.setString('branchName', defaultBranchName);
    }

    if (!prefs.containsKey('ifscCode') || (prefs.getString('ifscCode')?.isEmpty ?? true)) {
      await prefs.setString('ifscCode', defaultIfscCode);
    }

    if (!prefs.containsKey('address') || (prefs.getString('address')?.isEmpty ?? true)) {
      await prefs.setString('address', defaultAddress);
    }

    if (!prefs.containsKey('email') || (prefs.getString('email')?.isEmpty ?? true)) {
      await prefs.setString('email', defaultEmail);
    }

    // Set controllers from shared prefs
    setState(() {
      branchController.text = prefs.getString('branchName') ?? defaultBranchName;
      ifscController.text = prefs.getString('ifscCode') ?? defaultIfscCode;
      addressController.text = prefs.getString('address') ?? defaultAddress;
      emailController.text = prefs.getString('email') ?? defaultEmail;
    });
  }



  _saveBranchData() async {
     final prefs = await SharedPreferences.getInstance();
     await prefs.setString('branchName', branchController.text);
     await prefs.setString('ifscCode', ifscController.text);
     await prefs.setString('address', addressController.text);
     await prefs.setString('email', emailController.text);
     await _loadBranchData(); // reload to update UI
   }
}

Widget _buildTextField(TextEditingController controller,dynamic fontSize, onTap, {int maxLines = 1,Color? color,}) {
  return TextField(
    controller: controller,
    maxLines: maxLines,
    decoration: const InputDecoration(
      isDense: true,
      contentPadding: EdgeInsets.zero,
      border: InputBorder.none, // removes border
      enabledBorder: InputBorder.none,
      focusedBorder: InputBorder.none,
      fillColor: Colors.transparent, // no background
      filled: true,
      hintStyle: TextStyle(color: Colors.grey),
    ),
    onSubmitted:onTap,
    style: TextStyle(
      fontWeight: FontWeight.w500,
      fontSize:fontSize?.toDouble(),
      letterSpacing: 0.5,
      color: color?? Colors.black
    ),
  );
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
