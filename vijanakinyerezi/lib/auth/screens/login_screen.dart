import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:http/http.dart' as http;
import 'package:vijanakinyerezi/auth/screens/register_screen.dart';
import 'package:vijanakinyerezi/home/home_page.dart';
import 'package:vijanakinyerezi/utilities/constants/constant.dart';
import 'package:vijanakinyerezi/utilities/localstorage/shared/local_storage.dart';
import 'package:vijanakinyerezi/utilities/widget/alert.dart';
import 'package:vijanakinyerezi/utilities/widget/colors.dart';
import 'package:vijanakinyerezi/utilities/widget/popup_feedback.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key, this.title}) : super(key: key);

  final String? title;

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController phoneController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool isregistered = false;
  late bool showpassword;

  @override
  void initState() {
    super.initState();
    showpassword = false;
  }

  Future<dynamic> login(String phone, String password) async {
    Alerts.showProgressDialog(context, "Please Wait,Checking your info");

    String myApi = "http://vijanakinyerezi.000webhostapp.com/admin/api/login.php";
    String phoneNumber = phone;

    final response = await http.post(Uri.parse(myApi), headers: {
      'Accept': 'application/json'
    }, body: {
      "phone": phoneNumber,
      "password": password,
    });

    if (response.statusCode == 200) {
      var jsonResponse = json.decode(response.body);
      if (jsonResponse != null && jsonResponse != 404 && jsonResponse != 500) {
        var json = jsonDecode(response.body);
        String mydata = jsonEncode(json[0]);

        setState(
          () {
            isregistered = false;
            phoneController.text = "";
            passwordController.text = "";
            accessToken = mydata;
          },
        );

        await LocalStorage.setStringItem("mydata", mydata);
        Navigator.pop(context);

        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const HomePageScreen()),
        );
        return popUpFeedback(
          context,
          message: "Umeingia kwenye akaunti yako",
          title: "Imefanikiwa",
          icon: Icons.check_box_outlined,
          colors: Colors.green,
          position: StyledToastPosition.top,
        );
      } else if (jsonResponse == 404) {
        setState(
          () {
            isregistered = false;
          },
        );
        Navigator.pop(context);
      } else if (jsonResponse == 500) {
        setState(() {
          isregistered = false;
        });
      }
    } else {
      setState(
        () {
          isregistered = false;
        },
      );
    }
  }

  Widget _backButton() {
    return InkWell(
      onTap: () {
        Navigator.pop(context);
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Row(
          children: <Widget>[
            Container(
              padding: const EdgeInsets.only(left: 0, top: 10, bottom: 10),
              child: const Icon(Icons.keyboard_arrow_left, color: Colors.black),
            ),
            const Text('Nyuma', style: TextStyle(fontSize: 12, fontWeight: FontWeight.w500))
          ],
        ),
      ),
    );
  }

  Widget _entryField(String title, TextEditingController textcontroller, {bool isPassword = false}) {
    if (title == "Namba ya simu") {
      return Container(
        decoration: const BoxDecoration(
          color: Color(0xfff3f3f4),
        ),
        margin: const EdgeInsets.symmetric(vertical: 2),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
            ),
            TextField(
              controller: textcontroller,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: 'Namba ya simu',
                border: OutlineInputBorder(
                  borderSide: BorderSide(),
                ),
              ),
              style: GoogleFonts.aBeeZee(
                fontSize: 13,
                fontWeight: FontWeight.normal,
                color: Colors.black,
              ),
              onChanged: (phone) {
                setState(() {});
              },
            )
          ],
        ),
      );
    } else {
      return Container(
        margin: const EdgeInsets.symmetric(vertical: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              title,
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
            ),
            const SizedBox(
              height: 10,
            ),
            TextField(
              controller: textcontroller,
              obscureText: (isPassword && showpassword),
              style: GoogleFonts.aBeeZee(
                fontSize: 13,
                fontWeight: FontWeight.normal,
                color: Colors.black,
              ),
              decoration: InputDecoration(
                border: InputBorder.none,
                fillColor: const Color(0xfff3f3f4),
                filled: true,
                suffixIcon: (isPassword && showpassword)
                    ? InkWell(
                        onTap: () {
                          setState(() {
                            showpassword = true;
                          });
                        },
                        child: InkWell(
                          onTap: () {
                            setState(() {
                              showpassword = false;
                            });
                          },
                          child: Icon(
                            Icons.visibility,
                            color: MyColors.primary,
                          ),
                        ),
                      )
                    : InkWell(
                        onTap: () {
                          setState(() {
                            showpassword = true;
                          });
                        },
                        child: Icon(
                          Icons.visibility_off,
                          color: MyColors.primary,
                        ),
                      ),
              ),
            )
          ],
        ),
      );
    }
  }

  Widget _submitButton() {
    return GestureDetector(
      onTap: () {
        login(phoneController.text, passwordController.text);
      },
      child: Container(
        width: MediaQuery.of(context).size.width,
        padding: const EdgeInsets.symmetric(vertical: 15),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: MyColors.primary,
          borderRadius: const BorderRadius.all(Radius.circular(5)),
          boxShadow: <BoxShadow>[
            BoxShadow(
                color: Colors.grey.shade200,
                offset: const Offset(
                  2,
                  4,
                ),
                blurRadius: 5,
                spreadRadius: 2)
          ],
        ),
        // gradient: LinearGradient(
        //     begin: Alignment.centerLeft, end: Alignment.centerRight, colors: [Color(0xfffbb448), Color(0xfff7892b)])),
        child: const Text(
          'Login',
          style: TextStyle(fontSize: 20, color: Colors.white),
        ),
      ),
    );
  }

  Widget _createAccountLabel() {
    return InkWell(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (context) => const SignUpPage()));
      },
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 20),
        padding: const EdgeInsets.all(15),
        alignment: Alignment.bottomCenter,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const <Widget>[
            Text(
              'Je, Hauna akaunti ?',
              style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600),
            ),
            SizedBox(
              width: 10,
            ),
            Text(
              'Jisajili',
              style: TextStyle(color: Color(0xfff79c4f), fontSize: 13, fontWeight: FontWeight.w600),
            ),
          ],
        ),
      ),
    );
  }

  Widget _title() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: Card(
            elevation: 5,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
            child: SizedBox(
              width: 80,
              height: 80,
              child: Image.asset('assets/images/vijanawa.png'),
            ),
          ),
        ),
        const SizedBox(
          height: 20,
        ),
        Text(
          'APP NAME',
          textAlign: TextAlign.left,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 22,
            letterSpacing: 0.27,
            color: MyColors.primary,
          ),
        ),
        Text(
          'Pamoja katika BWANA!',
          textAlign: TextAlign.left,
          style: GoogleFonts.gochiHand(
            fontSize: 14,
            fontWeight: FontWeight.normal,
            color: Colors.black,
          ),
        ),
      ],
    );
  }

  Widget _emailPasswordWidget() {
    return Column(
      children: <Widget>[
        _entryField("Namba ya simu", phoneController),
        _entryField("Neno la siri", passwordController, isPassword: true),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: SizedBox(
        height: height,
        child: Stack(
          children: <Widget>[
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    SizedBox(height: height * .2),
                    _title(),
                    const SizedBox(height: 50),
                    _emailPasswordWidget(),
                    const SizedBox(height: 20),
                    _submitButton(),
                    Container(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      alignment: Alignment.centerRight,
                      child: const Text('Umesahau neno la siri ?',
                          style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500)),
                    ),
                    // _divider(),
                    // _facebookButton(),
                    const SizedBox(height: 10),
                    _createAccountLabel(),
                  ],
                ),
              ),
            ),
            Positioned(top: 40, left: 0, child: _backButton()),
          ],
        ),
      ),
    );
  }
}
