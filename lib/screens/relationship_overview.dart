import 'package:flutter/material.dart';
import 'package:yono/screens/my_balance_screen.dart';

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
    return DefaultTabController(
      length: 3,
      initialIndex: 0,
      child: Scaffold(
        backgroundColor: Colors.pink[50],
        appBar: AppBar(
          backgroundColor: Colors.white,
          centerTitle: true,
          title:Image.asset("assets/appbarlogo.png",height:25,width: 120,fit: BoxFit.fill,),
          automaticallyImplyLeading: false,
            leading:IconButton(
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
            )
          ],
          bottom: PreferredSize(
            preferredSize: Size.fromHeight(40),
            child: Container(
              color: Colors.deepPurple,
              width: double.infinity,
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
              child: Text(
                'RELATIONSHIP OVERVIEW',
                style: TextStyle(color: Colors.white, fontSize: 15, fontWeight: FontWeight.w500),
              ),
            ),
          ),
        ),
        body:Column(
          children: [
                 PreferredSize(
                  preferredSize: Size.fromHeight(48),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Color(0xFFEFEFEF), 
                      border: Border.all(color: Colors.deepPurple,width: 0.5)
                    ),
                    child: TabBar(
                      indicatorSize: TabBarIndicatorSize.tab,
                      labelPadding: EdgeInsets.zero,
                      indicator: UnderlineTabIndicator(
    borderSide: BorderSide(width: 3.0, color: Colors.deepPurple),
   // insets: EdgeInsets.symmetric(horizontal: 16.0), // Adjust if needed
  ),
                      labelColor: Colors.deepPurple,
                      unselectedLabelColor: Colors.black,
                      // indicatorPadding: EdgeInsets.all(2),
                      tabs: [
                        _buildTabWithBorder('Account','₹ 92.30', rightBorder: true),
                        _buildTabWithBorder('Transaction','', rightBorder: true),
                        _buildTabWithBorder('Spend Analysis','',rightBorder: false),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                Expanded(
                  child: TabBarView(
                    children: [
                     buildBalanceTab(),
                      Center(child: Text("Spend Analysis Placeholder")),
                      Center(child: Text("Spend Analysis Placeholder")),
                    ],
                  ),
                ),
          ],
        )
      ),
    );
  }
  
  Tab _buildTabWithBorder(String label,String label2,  {bool rightBorder = false}) {
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
        child: Column(
          children: [
            Text(label, style: TextStyle(fontSize: 15)),
            Text(label2, style: TextStyle(fontSize: 12, fontWeight: FontWeight.w500)),
          ],
        ),
      ),
    );
  }

  Widget buildBalanceTab() {
    return InkWell(
      onTap: (){
        Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => MyBalanceScreen()),
                );
      },
      child: Container(
        height: 100,
        decoration: BoxDecoration(
          color: Colors.pink[50],
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: Colors.grey.shade300),
        ),
        padding: EdgeInsets.symmetric(horizontal: 16),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(Icons.savings_outlined, color: Colors.deepPurple, size: 28),
                SizedBox(width: 12),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Savings A/c", style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500)),
                    SizedBox(height: 4),
                    Text("XXXXXXX7317", style: TextStyle(fontSize: 13, color: Colors.black87)),
                    Text("MANDAWA", style: TextStyle(fontSize: 13, color: Colors.black54)),
                  ],
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 20),
              child: Icon(Icons.visibility_outlined, size: 20, color: Colors.deepPurple),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 20),
              child: Text("₹ 92.30", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 20),
              child: Icon(Icons.arrow_forward_ios_outlined, size: 20, color: Colors.deepPurple),
            ),
          ],
        ),
      ),
    );
  }
}
