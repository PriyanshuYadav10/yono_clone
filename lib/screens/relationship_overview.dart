import 'package:flutter/material.dart';

class RelationshipOverviewScreen extends StatefulWidget {
  @override
  State<RelationshipOverviewScreen> createState() => _RelationshipOverviewScreenState();
}

class _RelationshipOverviewScreenState extends State<RelationshipOverviewScreen> with SingleTickerProviderStateMixin {
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
    return Scaffold(
      backgroundColor: Colors.pink[50],
      appBar: AppBar(
        backgroundColor: Colors.deepPurple[700],
        leading: Icon(Icons.arrow_back, color: Colors.white),
        title: Row(
          children: [
            Text('yono', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 18)),
            SizedBox(width: 4),
            Text('🔵 SBI', style: TextStyle(color: Colors.white, fontSize: 14)),
          ],
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 12),
            child: Icon(Icons.power_settings_new, color: Colors.white),
          )
        ],
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(80),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                child: Text(
                  'RELATIONSHIP OVERVIEW',
                  style: TextStyle(color: Colors.white, fontSize: 14, fontWeight: FontWeight.w500),
                ),
              ),
              Container(
                color: Colors.white,
                child: TabBar(
                  controller: _tabController,
                  indicatorColor: Colors.blue,
                  indicatorWeight: 3,
                  labelColor: Colors.black,
                  unselectedLabelColor: Colors.black54,
                  tabs: [
                    Tab(child: Column(
                      children: [
                        Text('My Balance', style: TextStyle(fontSize: 13)),
                        Text('₹ 92.30', style: TextStyle(fontSize: 12, fontWeight: FontWeight.w500))
                      ],
                    )),
                    Tab(child: Text('My Deposits', style: TextStyle(fontSize: 13))),
                    Tab(child: Text('My Borrowings', style: TextStyle(fontSize: 13))),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          _buildBalanceTab(),
          Center(child: Text("No Deposits Found")),
          Center(child: Text("No Borrowings Found")),
        ],
      ),
    );
  }

  Widget _buildBalanceTab() {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.pink[50],
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: Colors.grey.shade300),
        ),
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(Icons.savings, color: Colors.deepPurple, size: 28),
            SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Savings A/c", style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500)),
                  SizedBox(height: 4),
                  Text("XXXXXXX7317", style: TextStyle(fontSize: 13, color: Colors.black87)),
                  Text("MANDAWA", style: TextStyle(fontSize: 13, color: Colors.black54)),
                ],
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Icon(Icons.visibility_off_outlined, size: 20, color: Colors.grey),
                SizedBox(height: 8),
                Text("₹ 92.30", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
              ],
            )
          ],
        ),
      ),
    );
  }
}
