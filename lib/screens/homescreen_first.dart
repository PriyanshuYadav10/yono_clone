
import 'package:flutter/material.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:yono/screens/homescreen_second.dart';

class HomescreenFirst extends StatelessWidget {

  const HomescreenFirst({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        bottomNavigationBar: 
            _buildBottomBar(),
        backgroundColor:  Color(0xFFFFF5F8),
        body: ListView(
          children: [
            Stack(
              alignment: Alignment.topCenter,
              children: [
            _buildHeader(),
            _buildLoginCard(context),
              ],
            ),
            _buildViewBalanceCard(),
            _buildQuickPaySection(),
            SizedBox(height: 10),
            _buildQuickActionGrid(),
            // _buildBanner(),
            // Spacer(),
            Padding(
          padding: const EdgeInsets.only(top:50),
              child: Image.asset('assets/bottomBanner.png',height: 140,fit: BoxFit.fill,),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      height: 200,
      padding: const EdgeInsets.fromLTRB(16, 10, 16, 10),
      decoration: const BoxDecoration(
         gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [Color(0xFF5B2A91), Color(0xFFD73C6B)],
                ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(Icons.menu, color: Colors.white),
          SizedBox(width: 10),
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Image.asset("assets/appbarlogo.png",height:30,width: 150,fit: BoxFit.fill,), 
              SizedBox(height: 5,),
      const Text(
        "HI, AMIT KUMAR",
        style: TextStyle(color: Colors.white, fontSize: 14, fontWeight: FontWeight.w500),
      ),
            ],
          ),
         Spacer(),
          Icon(Icons.location_on, color: Colors.white),
        ],
      ),
    );
  }

  Widget _buildLoginCard(context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 100, 16, 16),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(color: Colors.black12, blurRadius: 4, offset: Offset(0, 2)),
          ],
        ),
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: const [
                Icon(Icons.arrow_forward_ios, size: 16,color: Colors.deepPurple,),
                SizedBox(width: 8),
                Text("LOGIN USING MPIN", style: TextStyle(fontWeight: FontWeight.bold,color: Colors.deepPurple)),
              ],
            ),
            
Padding(
  padding: const EdgeInsets.symmetric(horizontal: 30),
  child: PinCodeTextField(
    appContext: context,
    length: 6,
    obscureText: true,
    obscuringCharacter: '●',
    animationType: AnimationType.fade,
    pinTheme: PinTheme(
      shape: PinCodeFieldShape.underline,
      borderRadius: BorderRadius.circular(5),
      fieldHeight: 45,
      fieldWidth: 30,
      activeColor: Colors.deepPurple,
      inactiveColor: Colors.grey,
      selectedColor: Colors.purple,
    ),
    animationDuration: Duration(milliseconds: 300),
    enableActiveFill: false,
    keyboardType: TextInputType.number,
    onChanged: (value) {
      if(value.length==6){
              Navigator.push(context, MaterialPageRoute(builder: (context)=>HomescreenSecond()));
      }
    },
  ),
),
            const SizedBox(height: 8),
           Align(
            alignment:Alignment.centerRight,child:  Text("Forgot MPIN?",textAlign: TextAlign.end, style: TextStyle(color: Colors.purple,fontSize: 13))),
            const SizedBox(height: 5),
            const Divider(),
            const Center(child: Text("Login using Username")),
          ],
        ),
      ),
    );
  }

  Widget _buildViewBalanceCard() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(color: Colors.black12, blurRadius: 4, offset: Offset(0, 2)),
          ],
        ),
        child: const ListTile(
          leading: Icon(Icons.remove_red_eye_outlined),
          title: Text("VIEW BALANCE", style: TextStyle(fontWeight: FontWeight.w400,color: Colors.deepPurple,fontSize: 13)),
          subtitle: Text("View account balances and recent transactions.",style: TextStyle(fontSize: 12),),
        ),
      ),
    );
  }

  Widget _buildQuickPaySection() {
    return Stack(
      alignment: Alignment.bottomCenter,
      children: [
        Container(
          margin: const EdgeInsets.all(16),
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 2)],
            border: Border.all(color: Colors.deepPurple.shade50),
          ),
          child: SizedBox(
            height: 120,
            child: Column(
              children: [
                  const Text("QUICK PAY", style: TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(height: 12),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: const [
                    _QuickIcon(icon: Icons.phone, label: "Mobile or\nContact"),
                    _QuickIcon(icon: Icons.account_balance, label: "Bank A/C"),
                    _QuickIcon(icon: Icons.qr_code, label: "My QR"),
                    _QuickIcon(icon: Icons.receipt, label: "Bill Pay"),
                  ],
                ),
              ],
            ),
          ),
        ),
      
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 10),
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [Color(0xFF5B0B8B), Color(0xFF982282)],
              ),
              borderRadius: BorderRadius.circular(24),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: const [
                Icon(Icons.qr_code_scanner, color: Colors.white),
                SizedBox(width: 8),
                Text("Scan QR", style: TextStyle(color: Colors.white)),
              ],
            ),
          ),
        
      ],
    );
  }

  Widget _buildQuickActionGrid() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: const [
          _QuickIcon(icon: Icons.money, label: "YONO Cash"),
          _QuickIcon(icon: Icons.currency_rupee, label: "Loans"),
          _QuickIcon(icon: Icons.bar_chart, label: "Investments"),
          _QuickIcon(icon: Icons.local_offer, label: "Best Offers"),
        ],
      ),
    );
  }

  Widget _buildBanner() {
    return Container(
      margin: const EdgeInsets.all(16),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: const Color(0xFFF5D1E8),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: const [
          Text("SBI Mutual Fund JanNivesh SIP", style: TextStyle(fontWeight: FontWeight.bold)),
          SizedBox(height: 4),
          Text("VIKSIT BHARAT HOGA DESH, JAB HAR KOI KARE NIVESH."),
          SizedBox(height: 6),
          Text("Ab ₹250 se karain apna bada sapno ki shuruaat!"),
        ],
      ),
    );
  }

  Widget _buildBottomBar() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 15),
      decoration: const BoxDecoration(
        color: Colors.white,
        border: Border(top: BorderSide(color: Colors.black12)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          const _BottomBarIcon(icon: Icons.lock, label: "Lock/Unlock App"),
          Container(height:25,width: 1,color: Colors.deepPurple,),
          const _BottomBarIcon(icon: Icons.description, label: "T & C"),
          Container(height:25,width: 1,color: Colors.deepPurple,),
          const _BottomBarIcon(icon: Icons.call, label: "Helpline"),
          Container(height:25,width: 1,color: Colors.deepPurple,),
          const _BottomBarIcon(icon: Icons.more_vert, label: "More"),
        ],
      ),
    );
  }
}

class _QuickIcon extends StatelessWidget {
  final IconData icon;
  final String label;

  const _QuickIcon({required this.icon, required this.label});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Icon(icon, size: 30, color: Colors.deepPurple),
        const SizedBox(height: 6),
        SizedBox(width: 80, child: Text(label, textAlign: TextAlign.center, style: const TextStyle(fontSize: 12))),
      ],
    );
  }
}

class _BottomBarIcon extends StatelessWidget {
  final IconData icon;
  final String label;

  const _BottomBarIcon({required this.icon, required this.label});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon, size: 22, color: Colors.purple),
        const SizedBox(width: 2),
        Text(label, textAlign: TextAlign.center, style: const TextStyle(fontSize: 11,color: Colors.deepPurple)),
      ],
    );
  }
}
