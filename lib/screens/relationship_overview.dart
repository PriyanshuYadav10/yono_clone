import 'package:flutter/material.dart';
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
    super.initState();
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
              color:  Color(0xFF6C00CB),
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
                      '₹ 92.30',
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
          height: 70,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
          ),
          padding: EdgeInsets.symmetric(horizontal: 16),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Icon(
                    Icons.savings_outlined,
                    color:  Colors.blue,
                    size: 28,
                  ),
                  SizedBox(width: 12),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Savings A/c",
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      SizedBox(height: 4),
                      Text(
                        isShow ? "61195947317" : "XXXXXXX7317",
                        style: TextStyle(fontSize: 13, color: Colors.black87),
                      ),
                      Text(
                        "MANDAWA",
                        style: TextStyle(fontSize: 13, color: Colors.black54),
                      ),
                    ],
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
                  "₹ 92.30",
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
        ),
        Container(height: 8, color: Color.fromARGB(255, 241, 235, 237)),
      ],
    );
  }
}
