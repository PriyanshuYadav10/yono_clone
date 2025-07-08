import 'package:flutter/material.dart';

class YonoPayScreen extends StatelessWidget {
  const YonoPayScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFF5F8),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0.5,
        centerTitle: false,
        title: Text("YONO PAY", style: TextStyle(color: Colors.deepPurple,fontSize: 15),),
        automaticallyImplyLeading: false,
        leadingWidth: 80,
        leading: Row(
          children: [
            IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: const Icon(
                Icons.arrow_back_ios_new,
                color: Colors.black,
                size: 18,
              ),
            ),
            const SizedBox(width: 8),
            const Icon(Icons.menu, color: Colors.black),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: const [
                  YonoPayTopCard(
                    icon: Icons.currency_rupee_rounded,
                    title: "Quick Transfer",
                    subtitle: "Upto ₹50000",
                  ),
                  SizedBox(width: 8),
                  YonoPayTopCard(
                    icon: Icons.account_balance_rounded,
                    title: "Bank Transfer",
                    subtitle: "to own/other account",
                  ),
                  SizedBox(width: 8),
                  YonoPayTopCard(
                    icon: Icons.currency_exchange_rounded,
                    title: "International\nFunds Transfer",
                    subtitle: "",
                  ),
                ],
              ),
              const SizedBox(height: 16),
              Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.pink.shade50,
                  borderRadius: BorderRadius.circular(12),
                ),
                padding: const EdgeInsets.all(16),
                child: Row(
                  children: [
                    const Icon(
                      Icons.qr_code_2,
                      size: 50,
                      color: Colors.deepPurple,
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: const [
                          Text(
                            "Scan & Pay, Pay to Contacts,",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          Text("Send or receive money, and\nmore..."),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              const Text(
                "Payments & Contribution",
                style: TextStyle(fontWeight: FontWeight.bold,color: Colors.deepPurple),
              ),
              const SizedBox(height: 12),
              Row(
                children: const [
                  YonoPayTopCard(
                    icon: Icons.receipt_long,
                    title: "Bill Payments",
                    subtitle: '',
                  ),
                  SizedBox(width: 8),
                  YonoPayTopCard(
                    icon: Icons.credit_card,
                    title: "SBI Credit Card\nBills",
                    subtitle: '',
                  ),
                  SizedBox(width: 8),
                  YonoPayTopCard(
                    icon: Icons.account_balance_wallet_outlined,
                    title: "NPS Contribution",
                    subtitle: '',
                  ),
                ],
              ),
              const SizedBox(height: 16),
              InfoTile(
                icon: Icons.volunteer_activism,
                title: "Donations",
                subtitle: "Donate and create Impact that lasts a lifetime",
              ),
              const SizedBox(height: 12),
              InfoTile(
                icon: Icons.settings,
                title: "Manage Transaction Limit",
                subtitle: "Set secure limits for efficient transactions.",
              ),
              const SizedBox(height: 20),
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.black.withOpacity(0.03),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.deepPurple,width: 0.5),
                  boxShadow: const [
                    BoxShadow(
                      color: Colors.black12,
                      blurRadius: 4,
                      offset: Offset(0, 2),
                    ),
                  ],
                ),
                child: const Text(
                  "For a hassle-free transaction experience, please make sure your total limit per day for Third-Party Transfer (TPT) transactions is sufficiently set for all your transactions planned through the day.\n\nYou can change TPT limit anytime from above Manage Transaction Limit.",
                  style: TextStyle(fontSize: 11,color: Colors.deepPurple),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class YonoPayTopCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final VoidCallback? onTap;

  const YonoPayTopCard({
    super.key,
    required this.icon,
    required this.title,
    required this.subtitle,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          height: 90,
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            boxShadow: const [
              BoxShadow(
                color: Colors.black12,
                blurRadius: 4,
                offset: Offset(0, 2),
              ),
            ],
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        title,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 10,
                          color: Colors.deepPurple
                        ),
                      ),
                      Icon(Icons.arrow_forward_ios_rounded,size: 15,color: Colors.deepPurple,)
                    ],
                  ),
                  const SizedBox(height: 4),
                  Text(
                    subtitle,
                    style: const TextStyle(fontSize: 9, color: Colors.grey),
                  ),
                ],
              ),
              Align(
                  alignment: Alignment.bottomRight,
                  child: Icon(icon, size: 26, color: Colors.deepPurple)),
            ],
          ),
        ),
      ),
    );
  }
}

class PaymentOption extends StatelessWidget {
  final IconData icon;
  final String label;

  const PaymentOption({super.key, required this.icon, required this.label});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        height: 90,
        margin: const EdgeInsets.symmetric(horizontal: 4),
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: const [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 4,
              offset: Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Icon(icon, size: 24, color: Colors.deepPurple),
            Text(
              label,
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w500),
            ),
          ],
        ),
      ),
    );
  }
}

class InfoTile extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;

  const InfoTile({
    super.key,
    required this.icon,
    required this.title,
    required this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: const [
          BoxShadow(color: Colors.black12, blurRadius: 4, offset: Offset(0, 2)),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, size: 24, color: Colors.deepPurple),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(fontWeight: FontWeight.bold,fontSize: 12,color: Colors.deepPurple),
                ),
                const SizedBox(height: 4),
                Text(
                  subtitle,
                  style: const TextStyle(fontSize: 10, color: Colors.grey),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
