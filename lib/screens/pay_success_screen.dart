import 'package:flutter/material.dart';
import 'package:yono/screens/relationship_overview.dart';

class PaySuccessScreen extends StatefulWidget {
  const PaySuccessScreen({super.key});

  @override
  State<PaySuccessScreen> createState() => _PaySuccessScreenState();
}

class _PaySuccessScreenState extends State<PaySuccessScreen> {
  @override
  void initState() {
    // TODO: implement initState

    WidgetsBinding.instance.addPostFrameCallback((_) {
      showTransactionSuccessDialog(context);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
            color: Colors.deepPurple,
            width: double.infinity,
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
            child: Text(
              'QUICK TRANSFER - OTHER BANK A/C',
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
      bottomSheet:  Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: SizedBox(
          height: 130,
          child: Column(
            children: [
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () => Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context)=>RelationshipOverviewScreen())),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.deepPurple,
                    foregroundColor: Colors.white,
                    minimumSize: Size(100, 40),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(6),
                    ),
                  ),
                  child: Text("Go to Relationships",style: TextStyle(letterSpacing: 0.5,fontSize: 14),),
                ),
              ), 
              SizedBox(height: 8,),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: (){},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    minimumSize: Size(100, 40),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(6),
                      side: BorderSide(
                        color: Colors.deepPurple
                      )
                    ),
                  ),
                  child: Text("Add Beneficiary for Future Payments",style: TextStyle(letterSpacing: 0.5,fontSize: 14),),
                ),
              ),
            ],
          ),
        ),
      ),
      body:  Container(
            padding: const EdgeInsets.symmetric(vertical: 30),
            margin: const EdgeInsets.symmetric(horizontal: 15,vertical: 10),
            width:double.infinity,
            decoration: BoxDecoration(
              color: Color.fromARGB(255, 241, 235, 237),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Icons.check_circle_outline, color: Colors.blue, size: 48),
                SizedBox(height: 12),
                Text(
                  "Successful",
                  style: TextStyle(fontWeight: FontWeight.w500, fontSize: 17),
                ),
                SizedBox(height: 12),
                Text(
                  "You have successfully paid Amit kumar\n₹ 1.00\n\n"
                  "Remaining Balance in A/c\nXXXXXX7317 is ₹ 91.30.",
                  style: TextStyle(fontSize: 14,color: Colors.deepPurple,letterSpacing: 0.5),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
       );
  }

  Future showTransactionSuccessDialog(BuildContext context) {
    return showDialog(
      context: context,
      barrierDismissible: false, // prevent closing by tapping outside
      builder: (context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 15),
            width: MediaQuery.of(context).size.width * 0.8,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Icons.check_circle_outline, color: Colors.blue, size: 48),
                SizedBox(height: 12),
                Text(
                  "Transaction is successful!",
                  style: TextStyle(fontWeight: FontWeight.w500, fontSize: 17),
                ),
                SizedBox(height: 12),
                Text(
                  "You have paid ₹ 1.00\nsuccessfully to Charu.\n"
                  "Remaining Balance in A/c\nXXXXXX7317 is ₹ 90.30\n"
                  "UTR Number: SBIN525183617729",
                  style: TextStyle(fontSize: 14,color: Colors.deepPurple,letterSpacing: 0.5),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 16),

                GestureDetector(
                  behavior: HitTestBehavior.translucent,
                  onTap: () {
                    Navigator.of(context).pop();
                  },
                  child: Container(
                    width: double.infinity,
                    padding: EdgeInsets.only(top: 16),
                    decoration: BoxDecoration(
                      // Top border color
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(10),
                        topRight: Radius.circular(10),
                      ),
                      border: Border(
                        top: BorderSide(
                          color: Color.fromARGB(255, 241, 235, 237),
                          width: 3.0,
                        ),
                      ),
                    ),
                    alignment: Alignment.center,
                    child: Text('OK',style: TextStyle(color: Colors.deepPurple,letterSpacing: 0.5,fontSize: 14),),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
