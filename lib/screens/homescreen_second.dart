import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar/persistent_bottom_nav_bar.dart';
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
    {'icon': 'assets/UPI.png', 'label': ''},
    {'icon': 'assets/offer.png', 'label': 'Best Offers'},
    {'icon': 'assets/link.png', 'label': 'Quick Links'},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFF5F8),
      appBar: AppBar(
        title: Image.asset("assets/appbarlogo.png",height:25,width: 120,fit: BoxFit.fill,),
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
      // bottomNavigationBar: _buildBottomNavBar(),
      body: PersistentTabView(
        context,
        // controller: _controller,
        screens:   [
            SingleChildScrollView(
              child: Column(
                children: [
                  _buildSearchBar(),
                  _buildGrid(context, topGridItems),
                  _buildPromoBanner(),
                  _buildGrid(context, bottomGridItems),
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
                ],
              ),
            ),
          SizedBox(),
          SizedBox(),
          SizedBox(),
          SizedBox(),

          ],
        items: _navBarsItems(),
        handleAndroidBackButtonPress: true,
        resizeToAvoidBottomInset:false,
        stateManagement: true,
        hideNavigationBarWhenKeyboardAppears: true,
        popBehaviorOnSelectedNavBarItemPress: PopBehavior.none,
        hideOnScrollSettings: HideOnScrollSettings(
          hideNavBarOnScroll: true,
          // scrollControllers: _scrollControllers,
        ),
        padding: const EdgeInsets.only(top: 8),
        onWillPop: (context) async {
          await showDialog(
            context: context! ,
            useSafeArea: true,
            builder: (final context) => Container(
              height: 50,
              width: 50,
              color: Colors.white,
              child: ElevatedButton(
                child: const Text("Close"),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
            ),
          );
          return false;
        },
        navBarStyle:  NavBarStyle.style15,
        selectedTabScreenContext: (final context) {
          // testContext = context;
        },
         // backgroundColor: Colors.grey ,
        animationSettings: const NavBarAnimationSettings(
          navBarItemAnimation: ItemAnimationSettings(
            // Navigation Bar's items animation properties.
            duration: Duration(milliseconds: 400),
            curve: Curves.ease,
          ),
          screenTransitionAnimation: ScreenTransitionAnimationSettings(
            // Screen transition animation on change of selected tab.
            animateTabTransition: true,
            duration: Duration(milliseconds: 300),
            screenTransitionAnimationType:
            ScreenTransitionAnimationType.fadeIn,
          ),
          onNavBarHideAnimation: OnHideAnimationSettings(
            duration: Duration(milliseconds: 100),
            curve: Curves.bounceInOut,
          ),
        ),
        confineToSafeArea: true,
        navBarHeight: kBottomNavigationBarHeight,
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
    const int crossAxisCount = 4;

    return Container(
      margin: EdgeInsets.all(10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: Colors.white.withOpacity(0.8),
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
              childAspectRatio: 0.88,
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
                        Navigator.push(context, MaterialPageRoute(builder: (context) => YonoPayScreen()));
                      } else if (label == 'Accounts') {
                        Navigator.push(context, MaterialPageRoute(builder: (context) => RelationshipOverviewScreen()));
                      }
                    },
                    child: Container(
                      alignment: Alignment.center,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset(icon, height: 26, width: 26, color: Colors.deepPurple),
                          const SizedBox(height: 8),
                          Text(
                            label,
                            textAlign: TextAlign.center,
                            style: const TextStyle(fontSize: 11.5, fontWeight: FontWeight.w500),
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
                      child: Container(height: 0.7, color: Colors.grey.shade300),
                    ),
                ],
              );
            },
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

            ...bottomNavItems
                .sublist(2)
                .map((item) => _bottomNavItem(item['icon'], item['label'])),
          ],
        ),
      ),
    );
  }
  List<PersistentBottomNavBarItem>  _navBarsItems() => [
    PersistentBottomNavBarItem(
      icon:Image.asset(bottomNavItems[0]['icon']),
      title:bottomNavItems[0]['label'],
  activeColorPrimary: Colors.white,
  inactiveColorPrimary: Colors.grey,
  activeColorSecondary:  Colors.deepPurple,
      routeAndNavigatorSettings: RouteAndNavigatorSettings(
        initialRoute: "/",
        routes: {
        },
      ),
      textStyle: TextStyle(fontSize: 11),
      iconSize: 20
    ),
    PersistentBottomNavBarItem(
        icon:Image.asset(bottomNavItems[1]['icon']),
        title:bottomNavItems[1]['label'],
        activeColorPrimary: Colors.white,
        inactiveColorPrimary: Colors.grey,
        activeColorSecondary:  Colors.deepPurple,
        textStyle: TextStyle(fontSize: 11),
      iconSize: 20
    ),
    PersistentBottomNavBarItem(
      icon: CircleAvatar(
        backgroundColor: Colors.white,
        radius: 50,
        child:Container(
          height: 40,
            width: 40,
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(
                color: Colors.deepPurple,
              ),
              image: DecorationImage(
                image: AssetImage(bottomNavItems[2]['icon'])
              ),
              borderRadius: BorderRadius.circular(50)
            ),
            padding: EdgeInsets.all(5),
            // child: Image.asset(bottomNavItems[2]['icon'])
        )
      ),
        title:bottomNavItems[2]['label'],
        activeColorPrimary: Colors.white,
        inactiveColorPrimary: Colors.grey,
        activeColorSecondary:  Colors.deepPurple,
        textStyle: TextStyle(fontSize: 11),
      iconSize: 20
    ),
    PersistentBottomNavBarItem(
        icon:Image.asset(bottomNavItems[3]['icon']),
        title:bottomNavItems[3]['label'],
        activeColorPrimary: Colors.white,
        inactiveColorPrimary: Colors.grey,
        activeColorSecondary:  Colors.deepPurple,
        textStyle: TextStyle(fontSize: 11),
      iconSize: 20
    ),
    PersistentBottomNavBarItem(
        icon:Image.asset(bottomNavItems[4]['icon']),
        title:bottomNavItems[4]['label'],
      activeColorPrimary: Colors.white,
      inactiveColorPrimary: Colors.grey,
      activeColorSecondary:  Colors.deepPurple,
        textStyle: TextStyle(fontSize: 11),
      iconSize: 20
    ),
  ];
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
