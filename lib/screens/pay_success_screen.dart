import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:yono/screens/my_balance_screen.dart';
import 'package:yono/screens/relationship_overview.dart';

class PaySuccessScreen extends StatefulWidget {
  const PaySuccessScreen({super.key});

  @override
  State<PaySuccessScreen> createState() => _PaySuccessScreenState();
}

class _PaySuccessScreenState extends State<PaySuccessScreen> {
  TextEditingController successMsgCtrl = TextEditingController();
  @override
  void initState() {
    // TODO: implement initState

    _loadBranchData();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      showTransactionSuccessDialog(context);
    });
    super.initState();
  }
  Future<void> _loadBranchData() async {
    final prefs = await SharedPreferences.getInstance();

    // Default values
    const defaultBranchName = "MANDAWA";
    const defaultIfscCode = "SBIN0031742";
    const defaultAddress = "WARD NO 6 BISSAU \nCIRCLE, MANDAWA,DISTT.JHUNJHUNU";
    const defaultEmail = "sbi.31742@sbi.co.in";
    const defaultAccount = '7317';
    const defaultBalance = "92.30";

    // Set defaults if missing
    if (!prefs.containsKey('branchName') || (prefs.getString('branchName')?.isEmpty ?? true)) {
      await prefs.setString('branchName', defaultBranchName);
    }
    if (!prefs.containsKey('ifscCode') || (prefs.getString('ifscCode')?.isEmpty ?? true)) {
      await prefs.setString('ifscCode', defaultIfscCode);
    }
    if (!prefs.containsKey('address') || (prefs.getString('address')?.isEmpty ?? true)) {
      await prefs.setString('address', defaultAddress);
    }
    if (!prefs.containsKey('email') || (prefs.getString('email')?.isEmpty ?? true)) {
      await prefs.setString('email', defaultEmail);
    }
    if (!prefs.containsKey('balance') || (prefs.getString('balance')?.isEmpty ?? true)) {
      await prefs.setString('balance', defaultBalance);
    }
    if (!prefs.containsKey('account') || (prefs.getString('account')?.isEmpty ?? true)) {
      await prefs.setString('account', defaultAccount);
    }

    // NOW get fresh values from prefs
    final account = prefs.getString('account') ?? defaultAccount;
    final balance = prefs.getString('balance') ?? defaultBalance;

    final defaultSuccessMsg =
        "You have paid ₹1.00 successfully to Charu. Remaining Balance in A/c XXXXXX$account is ₹$balance UTR Number: SBIN525183617729";

    // Set successMsg if missing
    if (!prefs.containsKey('successMsg') || (prefs.getString('successMsg')?.isEmpty ?? true)) {
      await prefs.setString('successMsg', defaultSuccessMsg);
    }

    // Set controllers
    setState(() {
      branchController.text = prefs.getString('branchName') ?? defaultBranchName;
      ifscController.text = prefs.getString('ifscCode') ?? defaultIfscCode;
      addressController.text = prefs.getString('address') ?? defaultAddress;
      emailController.text = prefs.getString('email') ?? defaultEmail;
      balanceController.text = balance;
      accountController.text = account;
      successMsgCtrl.text = (prefs.getString('successMsg') ?? defaultSuccessMsg).replaceAll('\u200B', '').trim();
      successMsgCtrl.text = prefs.getString('successMsg') ?? defaultSuccessMsg;

    });
  }


  _saveBranchData() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('branchName', branchController.text);
    await prefs.setString('ifscCode', ifscController.text);
    await prefs.setString('address', addressController.text);
    await prefs.setString('email', emailController.text);
    await prefs.setString('balance', balanceController.text.toString());
    await prefs.setString('account', accountController.text.toString());
    await prefs.setString('successMsg', successMsgCtrl.text.toString());
    await _loadBranchData(); // reload to update UI
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
            color: Color(0xFF6C00CB),
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
      bottomSheet:  Container(
        color: Colors.white,
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: SizedBox(
          height: 140,
          child: Column(
            children: [
              Text('SBI Helpline : 1800111101 (toll-free)',style: TextStyle(fontSize: 14,color: Colors.black.withOpacity(0.7),letterSpacing: 0.5)),
              SizedBox(height: 10,),
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
              SizedBox(height: 8,),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () => Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context)=>RelationshipOverviewScreen())),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xFF6C00CB),
                    foregroundColor: Colors.white,
                    minimumSize: Size(100, 40),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(6),
                    ),
                  ),
                  child: Text("Go to Relationships",style: TextStyle(letterSpacing: 0.5,fontSize: 14),),
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
                Icon(Icons.check_circle_outline, color: Colors.green, size: 48),
                SizedBox(height: 12),
                Text(
                  "Successful",
                  style: TextStyle(fontWeight: FontWeight.w400, fontSize: 17,color: Colors.black),
                ),
                SizedBox(height: 12),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 60),
                  child: _buildTextField(successMsgCtrl,14,(value) => _saveBranchData(),maxLines: 5,color:Colors.black.withOpacity(0.7) ),
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
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30),
                  child: _buildTextField(successMsgCtrl,14,(value) => _saveBranchData(),maxLines: 5),
                ),
                SizedBox(height: 16),

                GestureDetector(
                  behavior: HitTestBehavior.translucent,
                  onTap: () {
                    _saveBranchData();
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
                    child: Text('OK',style: TextStyle(color: Color(0xFF6C00CB),letterSpacing: 0.5,fontSize: 14),),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildTextField(TextEditingController controller,dynamic fontSize, onTap, {int maxLines = 1,int? maxLength,Color? color,}) {
    return TextField(
      controller: controller,
      maxLines: maxLines,
      maxLength: maxLength,
      decoration: const InputDecoration(
        isDense: true,
        counterText: '',
        contentPadding: EdgeInsets.zero,
        border: InputBorder.none, // removes border
        enabledBorder: InputBorder.none,
        focusedBorder: InputBorder.none,
        fillColor: Colors.transparent, // no background
        filled: true,
        hintStyle: TextStyle(color: Colors.grey),
      ),
      onSubmitted:onTap,
      textAlign: TextAlign.center,
      style: TextStyle(
        height: 1.8,
          color:color?? Color(0xFF6C00CB),
        letterSpacing: 0.5,
          fontWeight: FontWeight.w500,
          fontSize:fontSize?.toDouble(),
      ),
    );
  }

}
