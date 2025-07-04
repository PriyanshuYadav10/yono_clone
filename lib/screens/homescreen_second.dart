
import 'package:flutter/material.dart';

class HomescreenSecond extends StatelessWidget {
   HomescreenSecond({super.key});

  final Color primaryColor = const Color(0xFF5B0B8B);
  final Color accentColor = Color(0xFF982282);

  final List<Map<String, dynamic>> topGridItems = const [
    {'icon': Icons.account_balance_wallet_outlined, 'label': 'Accounts'},
    {'icon': Icons.savings_outlined, 'label': 'Deposits'},
    {'icon': Icons.currency_rupee, 'label': 'Loans'},
    {'icon': Icons.show_chart, 'label': 'Investments'},
    {'icon': Icons.health_and_safety, 'label': 'Insurance'},
    {'icon': Icons.credit_card, 'label': 'Cards'},
    {'icon': Icons.currency_exchange, 'label': 'YONO Pay'},
    {'icon': Icons.qr_code_2, 'label': 'YONO Cash'},
  ];

  final List<Map<String, dynamic>> bottomGridItems = const [
    {'icon': Icons.shopping_cart, 'label': 'Shop & Order'},
    {'icon': Icons.receipt_long, 'label': 'Bill Payment'},
    {'icon': Icons.directions_bike, 'label': 'Mobility'},
    {'icon': Icons.train, 'label': 'Train Ticket'},
    {'icon': Icons.agriculture, 'label': 'YONO KRISHI'},
    {'icon': Icons.new_releases, 'label': 'SIP ₹250'},
  ];

  final List<Map<String, dynamic>> bottomNavItems = const [
    {'icon': Icons.settings, 'label': 'Service Request'},
    {'icon': Icons.emoji_events, 'label': 'SBI Rewardz'},
    {'icon': Icons.star, 'label': 'Best Offers'},
    {'icon': Icons.link, 'label': 'Quick Links'},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFF5F8),
      appBar: AppBar(
        title: RichText(
            text: const TextSpan(
              children: [
                TextSpan(
                    text: "yono ",
                    style: TextStyle(color: Colors.purple, fontSize: 22, fontWeight: FontWeight.bold)),
                TextSpan(
                    text: "SBI",
                    style: TextStyle(color: Colors.blueAccent, fontSize: 22, fontWeight: FontWeight.bold)),
              ],
            ),
          ),
          centerTitle: true,
          automaticallyImplyLeading: false,
          leading:   const Icon(Icons.menu, color: Colors.black),
          actions: [
            const Icon(Icons.call_outlined, color: Colors.black),
          const SizedBox(width: 16),
          const Icon(Icons.power_settings_new, color: Colors.black),
          ],
      ),
      bottomNavigationBar:_buildBottomNavBar(),
      body: SafeArea(
        child: ListView(
          children: [
            _buildSearchBar(),
            _buildGrid(topGridItems),
            _buildPromoBanner(),
            _buildGrid(bottomGridItems),
          
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
            // padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(30),
            ),
            child: const Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.headset_mic_outlined, size: 15, color: Colors.deepPurple),
                Text("Chatbot", style: TextStyle(color: Colors.deepPurple,fontSize: 12)),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget _buildGrid(List<Map<String, dynamic>> items) {
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
          return _FeatureCard(
            icon: items[index]['icon'],
            label: items[index]['label'],
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
            Text("Congrats! You are eligible for Life Cover upto ₹200000.",
                style: TextStyle(fontWeight: FontWeight.bold)),
            SizedBox(height: 4),
            Text("Get Policy instantly without Medical test or Documentation."),
            SizedBox(height: 6),
            Text("Tap here to Avail Now!", style: TextStyle(fontWeight: FontWeight.bold)),
          ],
        ),
      ),
    );
  }

  Widget _buildBottomNavBar() {
    return BottomAppBar(
      shape: const CircularNotchedRectangle(),
      // notchMargin: 5.0,
      child: SizedBox(
        height: 50,
        child: Row(
          children: [
            ...bottomNavItems.sublist(0, 2).map((item) => _bottomNavItem(item['icon'], item['label'])),
            const Spacer(),
            ...bottomNavItems.sublist(2).map((item) => _bottomNavItem(item['icon'], item['label'])),
          ],
        ),
      ),
    );
  }

  Widget _bottomNavItem(IconData icon, String label) {
    return InkWell(
      onTap: () {},
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Icon(icon, size: 22, color: Colors.deepPurple),
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

  const _FeatureCard({required this.icon, required this.label});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0.5,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, size: 30, color: Colors.deepPurple),
            const SizedBox(height: 6),
            Text(label, textAlign: TextAlign.center, style: const TextStyle(fontSize: 12)),
          ],
        ),
      ),
    );
  }
}