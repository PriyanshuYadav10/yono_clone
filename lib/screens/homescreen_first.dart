import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:yono/screens/homescreen_second.dart';

class HomescreenFirst extends StatefulWidget {
  const HomescreenFirst({super.key});

  @override
  State<HomescreenFirst> createState() => _HomescreenFirstState();
}

class _HomescreenFirstState extends State<HomescreenFirst>     with SingleTickerProviderStateMixin {
  late ScrollController _scrollController;
  late double _position;
  late Timer _timer;

  final String marqueeText =
      '              Link your Rupay Credit Card to UPI on YONO SBI & enjoy seamless payments. Link now > YONO Pay > UPI > Link Rupay Credit Card';

  @override
  void initState() {
    super.initState();
    SystemChrome.setSystemUIOverlayStyle(
       SystemUiOverlayStyle(
        statusBarColor:  Color(0xFF000000), // Your desired color
        statusBarIconBrightness: Brightness.dark, // For white icons
      ),
    );
    _position = 0.0;
    _scrollController = ScrollController();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      final double maxScroll = _scrollController.position.maxScrollExtent;
      _timer = Timer.periodic(const Duration(milliseconds: 20), (timer) {
        _position += 1;
        if (_position >= maxScroll) {
          _position = 0;
          _scrollController.jumpTo(_position);
        } else {
          _scrollController.animateTo(
            _position,
            duration: const Duration(milliseconds: 20),
            curve: Curves.linear,
          );
        }
      });
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: SizedBox(
        height: 100,
        child: Column(
          children: [
               Container(
                    height: 40,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                    color: Colors.white,
                         boxShadow: [
            BoxShadow(
              color: Colors.black26,
              blurRadius: 4,
              offset: Offset(2,0),
            ),
          ],
                    ),
                    // padding: EdgeInsets.symmetric(vertical: 10),
                    child: SingleChildScrollView(
                      controller: _scrollController,
                      scrollDirection: Axis.horizontal,
                      physics: const NeverScrollableScrollPhysics(),
                      child: Row(
                        children: [
                          Text(
                            marqueeText * 50, 
                            style: const TextStyle(fontSize: 14,letterSpacing: 0.5,fontWeight: FontWeight.w500),
                          ),
                        ],
                      ),
                    ),
                  ),
            _buildBottomBar(),
          ],
        ),
      ),
      backgroundColor: const Color.fromARGB(255, 241, 235, 237),
      body: SafeArea(
        child: ListView(
          children: [
            Stack(
              alignment: Alignment.topCenter,
              children: [_buildHeader(), _buildLoginCard(context)],
            ),
            _buildViewBalanceCard(),
            SizedBox(height: 5),
            _buildQuickPaySection(),
            SizedBox(height: 20),
            _buildQuickActionGrid(),
            SizedBox(height: 40),
            // _buildBanner(),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.only(top: 50),
              child: Image.asset(
                'assets/bottomBanner.png',
                height: 150,
                fit: BoxFit.fill,
              ),
            ),
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
          begin: Alignment.bottomLeft,
          end: Alignment.topRight,
          colors: [
            Color(0xFFFB0C67), // pinkish red
            Color(0xFFCE1FB3), // magenta
            Color(0xFF6C00CB), // violet/purple (top right)
          ],
          stops: [0.0, 0.75, 1.0], // controls how much space each color takes

          // colors: [Color(0xFFD73C6B), Color(0xFF5B2A91)],
         // colors: [Color(0xFFFB0C67),Color(0xFFCE1FB3), Color(0xFF6C00CB)],
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
              Image.asset(
                "assets/logo2.png",
                height: 25,
                width: 140,
                fit: BoxFit.fill,
              ),
              SizedBox(height: 5),
              const Text(
                "HI, AMIT KUMAR",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
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
            BoxShadow(
              color: Colors.black26,
              blurRadius: 4,
              offset: Offset(0, 2),
            ),
          ],
        ),
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Image.asset('assets/login.png', width: 16, height: 16),
                SizedBox(width: 8),
                Text(
                  "LOGIN USING MPIN",
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 13,
                    letterSpacing: 0.5,
                  ),
                ),
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
                  if (value.length == 6) {
                   showDialog(
          context: context,
          barrierDismissible: false,
          builder: (_) => Center(
            child: CircularProgressIndicator(
              color: Colors.deepPurple,
              strokeWidth: 1,
            ),
          ),
        );

        // Delay then navigate
        Future.delayed(Duration(seconds: 2), () {
          Navigator.of(context).pop(); // Close loading dialog
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => HomescreenSecond(),
            ),
          );
        });
                  }
                },
              ),
            ),
            const SizedBox(height: 2),
            Align(
              alignment: Alignment.centerRight,
              child: Text(
                "Forgot MPIN?",
                textAlign: TextAlign.end,
                style: TextStyle(letterSpacing: 0.5, fontSize: 13),
              ),
            ),
            const SizedBox(height: 5),
            Row(
              children: [
                Expanded(child: const Divider()),
                SizedBox(width: 10),
                Text(
                  "OR",
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 11,
                    letterSpacing: 0.5,
                  ),
                ),
                SizedBox(width: 10),
                Expanded(child: const Divider()),
              ],
            ),
            SizedBox(height: 8),
            const Center(
              child: Text(
                "Login using Username",
                style: TextStyle(fontSize: 13, letterSpacing: 0.5),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildViewBalanceCard() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Container(
        padding: EdgeInsets.all(15),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.black26,
              blurRadius: 4,
              offset: Offset(0, 2),
            ),
          ],
        ),

        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(Icons.remove_red_eye_outlined, size: 20, color:Color(0xFFCE1FB3).withOpacity(0.5),),
            SizedBox(width: 8),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "VIEW BALANCE",
                  style: TextStyle(fontWeight: FontWeight.w400, fontSize: 13),
                ),
                Text(
                  "View account balances and recent transactions.",
                  style: TextStyle(fontSize: 12),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildQuickPaySection() {
    return Stack(
      alignment: Alignment.center,
      children: [
        Container(
          margin: const EdgeInsets.all(16),
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 20),
          decoration: BoxDecoration(
            color: Colors.transparent,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: Colors.black45),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const [
              _QuickIcon(
                icon: 'assets/contact.png',
                label: "Mobile or\nContact",
              ),
              _QuickIcon(icon: 'assets/bank.png', label: "Bank A/C"),
              _QuickIcon(icon: 'assets/qrCode.png', label: "My QR"),
              _QuickIcon(icon: 'assets/invoice.png', label: "Bill Pay"),
            ],
          ),
        ),
        Positioned(
          top: 0,
          child: Align(
            alignment: Alignment.topCenter,
            child: Container(
              padding: EdgeInsets.all(8),
              color: Color.fromARGB(255, 241, 235, 237),
              child: Text(
                "QUICK PAY",
                style: TextStyle(fontWeight: FontWeight.w500, fontSize: 13),
              ),
            ),
          ),
        ),


        Positioned(
          bottom: 0,
          child: Container(
            width: 150,
            alignment: Alignment.center,
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [
                 // Color(0xFFFB0C67), // pinkish red
                  Color(0xFFCE1FB3), // magenta
                  Color(0xFF6C00CB), // violet/purple (top right)
                  Color(0xFF6C00CB), // violet/purple (top right)
                ],
               // colors: [Color(0xFF5B0B8B), Color(0xFF982282)],
              ),
              borderRadius: BorderRadius.circular(24),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: const [
                Text("Scan QR", style: TextStyle(color: Colors.white)),
                SizedBox(width: 8),
                Icon(Icons.qr_code_scanner, color: Colors.white),
              ],
            ),
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
          _QuickIcon(icon: 'assets/withdraw.png', label: "YONO Cash"),
          _QuickIcon(icon: 'assets/loan.png', label: "Loans"),
          _QuickIcon(icon: 'assets/investment.png', label: "Investments"),
          _QuickIcon(icon: 'assets/offer.png', label: "Best Offers"),
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
          Text(
            "SBI Mutual Fund JanNivesh SIP",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
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
                         boxShadow: [
            BoxShadow(
              color: Colors.black26,
              blurRadius: 4,
              offset: Offset(2,0),
            ),
          ],
        border: Border(top: BorderSide(color: Colors.black12)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          const _BottomBarIcon(icon: Icons.lock, label: "Lock/Unlock App"),
          Container(height: 15, width: 1, color: Color(0xFF6C00CB)),
          const _BottomBarIcon(icon: Icons.description, label: "T & C"),
          Container(height: 15, width: 1, color: Color(0xFF6C00CB)),
          const _BottomBarIcon(icon: Icons.call, label: "Helpline"),
          Container(height: 15, width: 1, color:Color(0xFF6C00CB)),
          const _BottomBarIcon(icon: Icons.more_vert, label: "More"),
        ],
      ),
    );
  }
}

class _QuickIcon extends StatelessWidget {
  final String icon;
  final String label;

  const _QuickIcon({required this.icon, required this.label});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.asset(icon, height: 30, width: 30,color: Color(0xFFCE1FB3).withOpacity(0.5),),
        const SizedBox(height: 6),
        SizedBox(
          width: 80,
          child: Text(
            label,
            textAlign: TextAlign.center,
            style: const TextStyle(fontSize: 12),
          ),
        ),
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
        Icon(icon, size: 15,color: Color(0xFF6C00CB), ),
        const SizedBox(width: 2),
        Text(
          label,
          textAlign: TextAlign.center,
          style: const TextStyle(fontSize: 10, ),
        ),
      ],
    );
  }
}
