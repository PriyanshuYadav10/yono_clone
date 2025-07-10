import 'package:flutter/material.dart';
import 'package:yono/screens/my_balance_screen.dart';
import 'package:yono/screens/relationship_overview.dart';
import 'package:yono/screens/yono_pay_screen.dart';

class HomescreenSecond extends StatelessWidget {
  HomescreenSecond({super.key});

  final Color primaryColor = const Color(0xFF5B0B8B);
  final Color accentColor = Color(0xFF982282);

  final List<Map<String, dynamic>>  topGridItems = const [
    {'icon': 'assets/account.png', 'label': 'Accounts'},
    {'icon': 'assets/safetyBox.png', 'label': 'Deposits'},
    {'icon': 'assets/loan.png', 'label': 'Loans'},
    {'icon':  'assets/investment.png', 'label': 'Investments'},
    {'icon':'assets/umbrella.png', 'label': 'Insurance'},
    {'icon': 'assets/creditCard.png', 'label': 'Cards'},
    {'icon': 'assets/pay.png', 'label': 'YONO Pay'},
    {'icon': 'assets/account.png', 'label': 'YONO Cash'},
  ];

  final List<Map<String, dynamic>> bottomGridItems = const [
    {'icon': 'assets/trolley.png', 'label': 'Shop & Order'},
    {'icon': 'assets/bill.png', 'label': 'Bill Payment'},
    {'icon': 'assets/pay.png', 'label': 'Mobility'},
    {'icon': 'assets/train.png', 'label': 'Train Ticket'},
  ];

  final List<Map<String, dynamic>> bottomNavItems = const [
    {'icon': 'assets/service.png', 'label': 'Service Request'},
    {'icon': 'assets/badge.png', 'label': 'SBI Rewardz'},
    {'icon': 'assets/offer.png', 'label': 'Best Offers'},
    {'icon': 'assets/link.png', 'label': 'Quick Links'},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFF5F8),
      appBar: AppBar(
<<<<<<< HEAD
        title: RichText(
          text: const TextSpan(
            children: [
              TextSpan(
                text: "yono ",
                style: TextStyle(
                  color: Colors.purple,
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
              TextSpan(
                text: "SBI",
                style: TextStyle(
                  color: Colors.blueAccent,
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
=======
        title: Image.asset("assets/appbarlogo.png",height:25,width: 120,fit: BoxFit.fill,),
>>>>>>> 3479e5a69ba9c559880104c913b5e2796954b9db
        centerTitle: true,
        automaticallyImplyLeading: false,
        leading: IconButton(
          icon: Icon(Icons.menu, color: Colors.black),
          onPressed: () {

          },
        ),
        actions: [
          const Icon(Icons.call_outlined, color: Colors.black),
          const SizedBox(width: 16),
          const Icon(Icons.power_settings_new, color: Colors.black),
        ],
      ),
      bottomNavigationBar: _buildBottomNavBar(),
      body: SafeArea(
        child: ListView(
          children: [
            _buildSearchBar(),
            _buildGrid(context, topGridItems),
            _buildPromoBanner(),
            _buildGrid(context, bottomGridItems),
<<<<<<< HEAD
=======
            SizedBox(height:  15),
            Row(
              children: [
                Container(
                  width: MediaQuery.sizeOf(context).width*0.5,
                  height: 100,
                          decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(color: Colors.deepPurple, width: 0.5),
                borderRadius: BorderRadius.circular(8)
                          ),
                          margin: EdgeInsets.symmetric(horizontal: 10),
                          child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.agriculture, size: 26, color: Colors.deepPurple),
                  const SizedBox(height: 8),
                  Text(
                    'YONO KRISHI',
                    textAlign: TextAlign.center,
                    style: const TextStyle(fontSize: 11.5, fontWeight: FontWeight.w500),
                  ),
                ],
                          ),
                        ),
                        Container(
                          height: 100,
                  width: MediaQuery.sizeOf(context).width*0.4,
                          decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(color: Colors.deepPurple, width: 0.5),
                borderRadius: BorderRadius.circular(8)
                          ),
                          child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.new_releases_outlined, size: 26, color: Colors.deepPurple),
                  const SizedBox(height: 8),
                  Text(
                    'SIP stating at ₹ 250',
                    textAlign: TextAlign.center,
                    style: const TextStyle(fontSize: 11.5, fontWeight: FontWeight.w500),
                  ),
                ],
                          ),
                        ),
              ],
            ),
   
>>>>>>> 3479e5a69ba9c559880104c913b5e2796954b9db
          ],
        ),
      ),
    );
  }

  Widget _buildSearchBar() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 8, 16, 16),
      child: Row(
        children: [
          Expanded(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              decoration: BoxDecoration(
                color: Colors.white,
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
          Container(
            height: 45,
            alignment: Alignment.center,
            width: 100,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(30),
            ),
            child: const Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.headset_mic_outlined,
                  size: 15,
                  color: Colors.deepPurple,
                ),
                Text(
                  "Chatbot",
                  style: TextStyle(color: Colors.deepPurple, fontSize: 12),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildGrid(BuildContext context, List<Map<String, dynamic>> items) {
<<<<<<< HEAD
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      child: GridView.builder(
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemCount: items.length,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 4,
          childAspectRatio: 0.85,
        ),
        itemBuilder: (_, index) {
          final label = items[index]['label'];

          return _FeatureCard(
            icon: items[index]['icon'],
            label: label,
            onTap: () {
              if (label == 'YONO Pay') {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => YonoPayScreen()),
                );
              } else if(label=='Accounts') {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => RelationshipOverviewScreen()),
                );
              }else{

              }
            },
          );
        },
=======
  return Container(
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(8),
    color: const Color(0xFFF7F0F0), 
    ),
    padding: const EdgeInsets.symmetric(horizontal: 8),
    child: GridView.builder(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: items.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 4,
        mainAxisSpacing: 1,
        crossAxisSpacing: 1,
        childAspectRatio: 0.88,
>>>>>>> 3479e5a69ba9c559880104c913b5e2796954b9db
      ),
      itemBuilder: (_, index) {
        final label = items[index]['label'];
        final icon = items[index]['icon'];

        return Container(
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(color: Colors.grey.shade300, width: 0.5),
            borderRadius: BorderRadius.circular(8)
          ),
          child: InkWell(
            onTap: () {
              if (label == 'YONO Pay') {
                Navigator.push(context, MaterialPageRoute(builder: (context) => YonoPayScreen()));
              } else if (label == 'Accounts') {
                Navigator.push(context, MaterialPageRoute(builder: (context) => RelationshipOverviewScreen()));
              }
            },
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(icon, height: 26,width: 26, color: Colors.deepPurple),
                const SizedBox(height: 8),
                Text(
                  label,
                  textAlign: TextAlign.center,
                  style: const TextStyle(fontSize: 11.5, fontWeight: FontWeight.w500),
                ),
              ],
            ),
          ),
        );
      },
    ),
  );
}

  Widget _buildPromoBanner() {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Container(
        decoration: BoxDecoration(
          color: const Color(0xFFFCE0F1),
          borderRadius: BorderRadius.circular(16),
        ),
        padding: const EdgeInsets.all(12),
        child: const Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Congrats! You are eligible for Life Cover upto ₹200000.",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 4),
            Text("Get Policy instantly without Medical test or Documentation."),
            SizedBox(height: 6),
            Text(
              "Tap here to Avail Now!",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBottomNavBar() {
    return BottomAppBar(
      shape: const CircularNotchedRectangle(),
      child: SizedBox(
        height: 50,
        child: Row(
          children: [
            ...bottomNavItems
                .sublist(0, 2)
                .map((item) => _bottomNavItem(item['icon'], item['label'])),
            const Spacer(),
            ...bottomNavItems
                .sublist(2)
                .map((item) => _bottomNavItem(item['icon'], item['label'])),
          ],
        ),
      ),
    );
  }

  Widget _bottomNavItem(String icon, String label) {
    return InkWell(
      onTap: () {},
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Image.asset(icon,width: 22 ,height: 22, color: Colors.deepPurple),
            Text(label, style: const TextStyle(fontSize: 11)),
          ],
        ),
      ),
    );
  }
}

class _FeatureCard extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback? onTap;

  const _FeatureCard({required this.icon, required this.label, this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Card(
        elevation: 0.5,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(icon, size: 30, color: Colors.deepPurple),
              const SizedBox(height: 6),
              Text(
                label,
                textAlign: TextAlign.center,
                style: const TextStyle(fontSize: 12),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
