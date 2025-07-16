import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar/persistent_bottom_nav_bar.dart';
import 'package:yono/screens/my_balance_screen.dart';
import 'package:yono/screens/relationship_overview.dart';
import 'package:yono/screens/yono_pay_screen.dart';

class HomescreenSecond extends StatelessWidget {
  HomescreenSecond({super.key});

  final Color primaryColor = const  Color(0xFF6C00CB);
  final Color accentColor =  Color(0xFFFB0C67);

  final List<Map<String, dynamic>> topGridItems = const [
    {'icon': 'assets/account.png', 'label': 'Accounts'},
    {'icon': 'assets/safetyBox.png', 'label': 'Deposits'},
    {'icon': 'assets/loan.png', 'label': 'Loans'},
    {'icon': 'assets/investment.png', 'label': 'Investments'},
    {'icon': 'assets/umbrella.png', 'label': 'Insurance'},
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
    {'icon': 'assets/UPI.png', 'label': ''},
    {'icon': 'assets/offer.png', 'label': 'Best Offers'},
    {'icon': 'assets/link.png', 'label': 'Quick Links'},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
       backgroundColor: const Color.fromARGB(255, 241, 235, 237),
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Image.asset(
          "assets/appbarlogo.png",
          height: 25,
          width: 120,
          fit: BoxFit.fill,
        ),
        centerTitle: true,
        automaticallyImplyLeading: false,
        leading: IconButton(
          icon: Icon(Icons.menu, color: Colors.black),
          onPressed: () {},
        ),
        actions: [
          const Icon(Icons.call_outlined, color: Colors.black),
          const SizedBox(width: 16),
          const Icon(Icons.power_settings_new, color: Colors.black),
        ],
      ),
      body: PersistentTabView(
        context,
        screens: [
          _buildHomeScreen(context),
          SizedBox(),
          SizedBox(),
          SizedBox(),
          SizedBox(),
        ],
        items: _navBarsItems(),
        handleAndroidBackButtonPress: true,
        resizeToAvoidBottomInset: true,
        stateManagement: true,
        hideNavigationBarWhenKeyboardAppears: true,
        popBehaviorOnSelectedNavBarItemPress: PopBehavior.none,
        padding: const EdgeInsets.only(top: 8),
        navBarStyle: NavBarStyle.style15,
        navBarHeight: 65,
        onWillPop: (context) async {
          await showDialog(
            context: context!,
            builder: (final context) => AlertDialog(
              content: const Text("Do you want to exit?"),
              actions: [
                TextButton(
                  onPressed: () => Navigator.of(context).pop(),
                  child: const Text("No"),
                ),
                TextButton(
                  onPressed: () => Navigator.of(context).pop(true),
                  child: const Text("Yes"),
                ),
              ],
            ),
          );
          return false;
        },
        animationSettings: const NavBarAnimationSettings(
          navBarItemAnimation: ItemAnimationSettings(
            duration: Duration(milliseconds: 300),
            curve: Curves.ease,
          ),
          screenTransitionAnimation: ScreenTransitionAnimationSettings(
            animateTabTransition: true,
            duration: Duration(milliseconds: 300),
            screenTransitionAnimationType: ScreenTransitionAnimationType.fadeIn,
          ),
          onNavBarHideAnimation: OnHideAnimationSettings(
            duration: Duration(milliseconds: 100),
            curve: Curves.bounceInOut,
          ),
        ),
      ),

    );
  }
  Widget _buildHomeScreen(BuildContext context) {
    return Container(
      color: const Color.fromARGB(255, 241, 235, 237),
      child: SingleChildScrollView(
        child: Column(
          children: [
            _buildSearchBar(),
            _buildGrid(context, topGridItems),
            _buildPromoBanner(),
            _buildGrid2(context, bottomGridItems),
            _buildPromoBanner2(),
            // Add other widgets as needed
          ],
        ),
      ),
    );
  }

  Widget _buildSearchBar() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
      child: Row(
        children: [
          Expanded(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(30),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black26,
                    blurRadius: 4,
                    offset: Offset(0,2),
                  ),
                ]
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
                boxShadow: [
                  BoxShadow(
                    color: Colors.black26,
                    blurRadius: 4,
                    offset: Offset(0,2),
                  ),
                ]
            ),
            child:  Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.headset_mic_outlined,
                  size: 15,
                  color: Color(0xFFCE1FB3).withOpacity(0.5),
                ),
                Text(
                  "Chatbot",
                  style: TextStyle(color: Colors.grey, fontSize: 12),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildGrid(BuildContext context, List<Map<String, dynamic>> items) {
    const int crossAxisCount = 4;

    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16,vertical: 6),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black26,
              blurRadius: 4,
              offset: Offset(0,2),
            ),
          ]
      ),
      padding: const EdgeInsets.all(4),
      child: LayoutBuilder(
        builder: (context, constraints) {
          final width = constraints.maxWidth;
          final itemWidth = width / crossAxisCount;
          final itemHeight = itemWidth / 0.88;

          return GridView.builder(
            padding: EdgeInsets.zero,
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: items.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: crossAxisCount,
              childAspectRatio: 1,
            ),
            itemBuilder: (_, index) {
              final label = items[index]['label'];
              final icon = items[index]['icon'];

              // Calculate row/column
              final row = index ~/ crossAxisCount;
              final col = index % crossAxisCount;

              final isLastCol = col == crossAxisCount - 1;
              final isLastRow = index >= items.length - crossAxisCount;

              return Stack(
                children: [
                  InkWell(
                    onTap: () {
                      if (label == 'YONO Pay') {
                        PersistentNavBarNavigator.pushNewScreen(
                          context,
                          withNavBar: false,
                          pageTransitionAnimation: PageTransitionAnimation.fade,
                          screen: YonoPayScreen(),
                        );
                      } else if (label == 'Accounts') {
                        PersistentNavBarNavigator.pushNewScreen(
                          context,
                          withNavBar: false,
                          pageTransitionAnimation: PageTransitionAnimation.fade,
                          screen: RelationshipOverviewScreen(),
                        );
                      }
                    },
                    child: Container(
                      alignment: Alignment.center,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset(
                            icon,
                            height: 30,
                            width: 30,
                            color: Color(0xFFCE1FB3).withOpacity(0.5),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            label,
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                              fontSize: 11.5,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                  // Add right border if not last column
                  if (!isLastCol)
                    Positioned(
                      right: 0,
                      top: 8,
                      bottom: 8,
                      child: Container(width: 0.7, color: Colors.grey.shade300),
                    ),

                  // Add bottom border if not last row
                  if (!isLastRow)
                    Positioned(
                      left: 8,
                      right: 8,
                      bottom: 0,
                      child: Container(
                        height: 0.7,
                        color: Colors.grey.shade300,
                      ),
                    ),
                ],
              );
            },
          );
        },
      ),
    );
  }
  Widget _buildGrid2(BuildContext context, List<Map<String, dynamic>> items) {
    const int crossAxisCount = 4;

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
      ),
      padding: const EdgeInsets.all(4),
      child: LayoutBuilder(
        builder: (context, constraints) {
          final width = constraints.maxWidth;
          final itemWidth = width / crossAxisCount;
          final itemHeight = itemWidth / 0.88;

          return GridView.builder(
            padding: EdgeInsets.zero,
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: items.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: crossAxisCount,
              childAspectRatio: 1.25,
              crossAxisSpacing: 12,
              mainAxisSpacing: 12,
            ),
            itemBuilder: (_, index) {
              final label = items[index]['label'];
              final icon = items[index]['icon'];

              return InkWell(
                onTap: () {
                  // handle tap
                },
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color:Color(0xFFCE1FB3).withOpacity(0.5), width: 0.5),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black26,
                        blurRadius: 4,
                        offset: Offset(0, 2),
                      ),
                    ],
                  ),

                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        icon,
                        height: 26,
                        width: 26,
                        color: const Color(0xFFCE1FB3).withOpacity(0.5),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        label,
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          fontSize: 11.5,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }

  Widget _buildPromoBanner() {
    return Padding(
      padding:  EdgeInsets.symmetric(horizontal: 16,vertical: 8),
      child: Container(
        decoration: BoxDecoration(
          color:  Color(0xFFFFFFFF),
          borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: Colors.black26,
                blurRadius: 4,
                offset: Offset(0,2),
              ),
            ]
        ),
        padding:  EdgeInsets.all(4),
        child: Row(

          children: [
            Container(
              width: 60,
              height: 80,
            ),
            const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Congrats! You are eligible for Life Cover upto ₹200000.",
                  style: TextStyle(fontWeight: FontWeight.w400,fontSize: 11),
                ),
                SizedBox(height: 4),
                Text("Get Policy instantly without Medical test or Documentation.",
                  style: TextStyle(fontWeight: FontWeight.w300,fontSize: 11),),
                SizedBox(height: 3),
                Text(
                  "Tap here to Avail Now!",
                  style: TextStyle(fontWeight: FontWeight.w400,fontSize: 11),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPromoBanner2() {
    return Padding(
      padding:  EdgeInsets.symmetric(horizontal: 16,vertical: 8),
      child: Row(
        children: [
          Expanded(
            child: Container(
              height: 110,
              padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                    color:  Color(0xFFFFFFFF),
                    borderRadius: BorderRadius.circular(5),
                    border: Border.all(color:Color(0xFFCE1FB3).withOpacity(0.5), width: 0.5),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black26,
                        blurRadius: 4,
                        offset: Offset(0,2),
                      ),
                    ]
                ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                         Icon(Icons.agriculture, size: 50, color: Color(0xFFCE1FB3).withOpacity(0.5)),
                      Text(
                        'YONO KRISHI',
                        style: TextStyle(fontSize: 14),
                      ),
                    ],
                  ),
                  const SizedBox(width: 10),
                  const Expanded(
                    child: Text(
                      'YONO KRISHI\nGrow your Agri Business',
                      style: TextStyle(fontSize: 12),
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Container(
              height: 110,
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                  color:  Color(0xFFFFFFFF),
                  borderRadius: BorderRadius.circular(5),
                  border: Border.all(color:Color(0xFFCE1FB3).withOpacity(0.5), width: 0.5),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black26,
                      blurRadius: 4,
                      offset: Offset(0,2),
                    ),
                  ]
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Align(
                    alignment:Alignment.centerRight,
                    child: Container(
                      decoration: BoxDecoration(
                          color: Colors.green,
                          borderRadius: BorderRadius.circular(3)
                      ),
                      padding: EdgeInsets.symmetric(horizontal: 8,vertical: 5),
                      child:  Text(
                        'New',
                        style: TextStyle(fontSize: 12, color: Colors.white),
                      ),
                    ),
                  ),
                  Text(
                    'Jan Nivesh SIP',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                      color: Colors.black,
                    ),
                  ),
                  Text(
                    'Jan Jan Ka Nivesh',
                    style: TextStyle(
                      fontWeight: FontWeight.w400,
                      fontSize: 13,
                      letterSpacing: 2,
                      color: Colors.black54,
                    ),
                  ),
                  const SizedBox(height: 5),
                  const Text(
                    'SIP starting at ₹250',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.black87,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
  List<PersistentBottomNavBarItem> _navBarsItems() => [
    PersistentBottomNavBarItem(
      icon: Image.asset(
        bottomNavItems[0]['icon'],
        height: 28,
      ),
      title: bottomNavItems[0]['label'],
      activeColorPrimary: Colors.white,
      inactiveColorPrimary: Colors.grey,
      activeColorSecondary: Color(0xFFCE1FB3).withOpacity(0.5),
      textStyle: TextStyle(fontSize: 12, fontWeight: FontWeight.w500,overflow: TextOverflow.ellipsis),
      iconSize: 28,
    ),
    PersistentBottomNavBarItem(
      icon: Image.asset(
        bottomNavItems[1]['icon'],
        height: 28,
      ),
      title: bottomNavItems[1]['label'],
      activeColorPrimary: Colors.white,
      inactiveColorPrimary: Colors.grey,
      activeColorSecondary: Color(0xFFCE1FB3).withOpacity(0.5),
      textStyle: TextStyle(fontSize: 12, fontWeight: FontWeight.w500),
      iconSize: 28,
    ),
    PersistentBottomNavBarItem(
      icon: Container(
        height: 80,
        width: 80,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.white,
          border: Border.all(
            color: Color(0xFFCE1FB3).withOpacity(0.6),
            width: 2,
          ),
          image: DecorationImage(
            image: AssetImage(bottomNavItems[2]['icon']),
            fit: BoxFit.contain,
          ),
        ),
      ),
      title: bottomNavItems[2]['label'],
      activeColorPrimary: Colors.white,
      inactiveColorPrimary: Colors.grey,
      activeColorSecondary: Color(0xFFCE1FB3).withOpacity(0.5),
      textStyle: TextStyle(fontSize: 12, fontWeight: FontWeight.w500),
      iconSize: 80,
    ),
    PersistentBottomNavBarItem(
      icon: Image.asset(
        bottomNavItems[3]['icon'],
        height: 28,
      ),
      title: bottomNavItems[3]['label'],
      activeColorPrimary: Colors.white,
      inactiveColorPrimary: Colors.grey,
      activeColorSecondary: Color(0xFFCE1FB3).withOpacity(0.5),
      textStyle: TextStyle(fontSize: 12, fontWeight: FontWeight.w500),
      iconSize: 28,
    ),
    PersistentBottomNavBarItem(
      icon: Image.asset(
        bottomNavItems[4]['icon'],
        height: 28,
      ),
      title: bottomNavItems[4]['label'],
      activeColorPrimary: Colors.white,
      inactiveColorPrimary: Colors.grey,
      activeColorSecondary: Color(0xFF6C00CB),
      textStyle: TextStyle(fontSize: 12, fontWeight: FontWeight.w500),
      iconSize: 28,
    ),
  ];


}
