import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:yono/screens/my_balance_screen.dart';

class RelationshipOverviewScreen extends StatefulWidget {
  @override
  State<RelationshipOverviewScreen> createState() =>
      _RelationshipOverviewScreenState();
}

class _RelationshipOverviewScreenState extends State<RelationshipOverviewScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    _tabController = TabController(length: 3, vsync: this);
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
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      initialIndex: 0,
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          centerTitle: true,
          title: Image.asset(
            "assets/appbarlogo.png",
            height: 25,
            width: 120,
            fit: BoxFit.fill,
          ),
          automaticallyImplyLeading: false,
          leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(
              Icons.arrow_back_ios_new,
              color: Colors.black,
              size: 20,
            ),
          ),
          actions: [
            Padding(
              padding: const EdgeInsets.only(right: 12),
              child: Icon(Icons.power_settings_new, color: Colors.white),
            ),
          ],
          bottom: PreferredSize(
            preferredSize: Size.fromHeight(40),
            child: Container(
              color:  Color(0xFF7523AF),
              width: double.infinity,
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
              child: Text(
                'RELATIONSHIP OVERVIEW',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  letterSpacing: 0.5,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ),
        ),
        body: Column(
          children: [
            PreferredSize(
              preferredSize: Size.fromHeight(48),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(color:  Color(0xFF6C00CB), width: 0.5),
                ),
                child: TabBar(
                  indicatorSize: TabBarIndicatorSize.tab,
                  labelPadding: EdgeInsets.zero,
                  indicator: UnderlineTabIndicator(
                    borderSide: BorderSide(
                      width: 3.0,
                      color:  Colors.blue,
                    ),
                    // insets: EdgeInsets.symmetric(horizontal: 16.0), // Adjust if needed
                  ),
                  labelColor:  Colors.blue,
                  unselectedLabelColor: Colors.black,
                  // indicatorPadding: EdgeInsets.all(2),
                  tabs: [
                    _buildTabWithBorder(
                      'My Balance',
                      '₹ ${balanceController.text}',
                      rightBorder: true,
                    ),
                    _buildTabWithBorder('My Deposits', '', rightBorder: true),
                    _buildTabWithBorder(
                      'My Borrowings',
                      '',
                      rightBorder: false,
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),
            Expanded(
              child: TabBarView(
                children: [
                  buildBalanceTab(),
                  Center(child: Text("My Deposits")),
                  Center(child: Text("My Borrowings")),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Tab _buildTabWithBorder(
    String label,
    String label2, {
    bool rightBorder = false,
  }) {
    return Tab(
      child: Container(
        decoration: BoxDecoration(
          border: Border(
            right: rightBorder
                ? BorderSide(
                    color: Color.fromARGB(255, 241, 235, 237),
                    width: 0.8,
                  )
                : BorderSide.none,
          ),
        ),
        alignment: Alignment.center,
        child: Column(
          children: [
            SizedBox(height: 3,),
            Text(label, style: TextStyle(fontSize: 15,fontWeight: FontWeight.w400)),
            SizedBox(height: 3,),
            Text(
              label2,
              style: TextStyle(fontSize: 12, fontWeight: FontWeight.w400,color: Colors.black),
            ),
          ],
        ),
      ),
    );
  }

  bool isShow = false;
  Widget buildBalanceTab() {
    return Column(
      children: [
        Container(
          height: 90,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
          ),
          padding: EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Icon(
                    Icons.savings_outlined,
                    color:  Colors.blue,
                    size: 28,
                  ),
                  SizedBox(width: 12),
                  Text(
                    "Savings A/c",
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 4),
                      Text(
                        isShow ? "6119594${accountController.text}" : "XXXXXXX${accountController.text}",
                        style: TextStyle(fontSize: 13, color: Colors.black87),
                      ),
                      Text(
                        branchController.text,
                        style: TextStyle(fontSize: 13, color: Colors.black54),
                      ),
                    ],
                  ),
                  GestureDetector(
                    behavior: HitTestBehavior.translucent,
                    onTap: () {
                      setState(() {
                        isShow = !isShow;
                      });
                    },
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 20),
                      child: Icon(
                        !isShow
                            ? Icons.visibility_outlined
                            : Icons.visibility_off_outlined,
                        size: 20,
                        color:  Color(0xFF6C00CB),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 20),
                    child: Text(
                      "₹ ${balanceController.text}",
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                  ),
                  GestureDetector(
                    behavior: HitTestBehavior.translucent,
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => MyBalanceScreen()),
                      );
                    },
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 20),
                      child: Icon(
                        Icons.arrow_forward_ios_outlined,
                        size: 20,
                        color:  Color(0xFF6C00CB),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        Container(height: 8, color: Color.fromARGB(255, 241, 235, 237)),
      ],
    );
  }
}
