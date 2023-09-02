import 'package:flutter/material.dart';
import 'package:flutter_finalproject/pages/phoneVerify_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:country_code_picker/country_code_picker.dart';

class RegisterPage extends StatefulWidget{
  const RegisterPage({Key? key}) : super(key:key);
  static String verify="";
  @override
  State<StatefulWidget> createState() => _RegisterPageState();

}

class _RegisterPageState extends State<RegisterPage>{
  final TextEditingController _controllerName = TextEditingController();
  final TextEditingController _controllerPhoneNum = TextEditingController();
  final TextEditingController _controllerEmail = TextEditingController();
  final TextEditingController _controllerAddress = TextEditingController();
  final TextEditingController _controllerPassword = TextEditingController();
  bool _nameValidate = false;
  bool _phoneValidate = false;
  bool _emailValidate = false;
  bool _passwordValidate = false;
  String _emailError = '';
  String _phoneError = '';
  String _passwordError = '';
  CountryCode selectedCountry = CountryCode(name: "Việt Nam", flagUri: "flags/vn.png", code: "VN", dialCode: "+84");

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          gradient: RadialGradient(
              radius: 0.6,
              focalRadius: 0.17,
              focal: Alignment(0.3, -0.3),
              tileMode: TileMode.mirror,
              colors: [Theme.of(context).colorScheme.tertiary,
                Theme.of(context).colorScheme.onTertiary]
          )
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
        ),
        body: SingleChildScrollView(
          child: Container(
            margin: EdgeInsets.symmetric(horizontal: 20),
            padding: EdgeInsets.symmetric(horizontal: 5),

            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 100,),
                Text(
                  'Create \nAccount',
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.onTertiaryContainer,
                    fontSize:  55,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                SizedBox(height: 50,),

                //Full name
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 10),
                  child: Text(
                    'Full Name',
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.onTertiaryContainer,
                      fontSize:  20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                SizedBox(height: 5,),
                TextField(
                  controller: _controllerName,
                  style: TextStyle(color: Theme.of(context).colorScheme.onTertiaryContainer),
                  decoration: InputDecoration(
                      errorText: _nameValidate ? 'This field cannot be empty' : null,
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                        borderSide: BorderSide(color: Theme.of(context).colorScheme.onPrimaryContainer,
                            width: 2),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                        borderSide: BorderSide(color: Theme.of(context).colorScheme.onSurface,
                            width: 2),
                      ),
                      hintText: 'Name',
                      hintStyle: TextStyle(color: Theme.of(context).colorScheme.onTertiaryContainer),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                      )
                  ),
                ),

                SizedBox(height: 20,),
                //Your phone
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 10),
                  child: Text(
                    'Your Phone',
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.onTertiaryContainer,
                      fontSize:  20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                SizedBox(height: 5,),
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(
                      color: Theme.of(context).colorScheme.onPrimaryContainer,
                      width: 2.0, // Adjust the width as needed
                    ),
                  ),
                  child: Row(children: [
                    Container(
                      child: CountryCodePicker(
                        initialSelection: 'VN',
                        favorite: ['+84', 'VN'],
                        showCountryOnly: true,
                        onChanged: (CountryCode countryCode) {
                          setState(() {
                            selectedCountry = countryCode;
                          });
                        },
                      ),
                    ),
                    Expanded(
                      child: TextField(
                        controller: _controllerPhoneNum,
                        keyboardType: TextInputType.phone,
                        style: TextStyle(
                            color: Theme.of(context)
                                .colorScheme
                                .onTertiaryContainer),
                        decoration: InputDecoration(
                          errorText: _phoneValidate ? _phoneError : null,
                          hintText: 'Phone',
                          hintStyle: TextStyle(
                              color: Theme.of(context)
                                  .colorScheme
                                  .onTertiaryContainer),
                          border: InputBorder.none, // Remove the default border
                          contentPadding:
                          EdgeInsets.symmetric(horizontal: 10.0),
                        ),
                      ),
                    ),
                  ]),
                ),

                SizedBox(height: 20,),
                // Email
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 10),
                  child: Text(
                    'Email',
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.onTertiaryContainer,
                      fontSize:  20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                SizedBox(height: 5,),
                TextField(
                  controller: _controllerEmail,
                  style: TextStyle(color: Theme.of(context).colorScheme.onTertiaryContainer),
                  decoration: InputDecoration(
                      errorText: _emailValidate ? _emailError : null,
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                        borderSide: BorderSide(color: Theme.of(context).colorScheme.onPrimaryContainer,
                            width: 2),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                        borderSide: BorderSide(color: Theme.of(context).colorScheme.onSurface,
                            width: 2),
                      ),
                      fillColor: Theme.of(context).colorScheme.tertiaryContainer,
                      hintText: 'Email',
                      hintStyle: TextStyle(color: Theme.of(context).colorScheme.onTertiaryContainer),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                      )
                  ),
                ),

                SizedBox(height: 20,),
                //Address
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 10),
                  child: Text(
                    'Address',
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.onTertiaryContainer,
                      fontSize:  20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                SizedBox(height: 5,),
                TextField(
                  controller: _controllerAddress,
                  style: TextStyle(color: Theme.of(context).colorScheme.onTertiaryContainer),
                  decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                        borderSide: BorderSide(color: Theme.of(context).colorScheme.onPrimaryContainer,
                            width: 2),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                        borderSide: BorderSide(color: Theme.of(context).colorScheme.onSurface,
                            width: 2),
                      ),
                      fillColor: Theme.of(context).colorScheme.tertiaryContainer,
                      hintText: 'Address',
                      hintStyle: TextStyle(color: Theme.of(context).colorScheme.onTertiaryContainer),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                      )
                  ),
                ),

                SizedBox(height: 20,),
                //Password
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 10),
                  child: Text(
                    'Password',
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.onTertiaryContainer,
                      fontSize:  20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                SizedBox(height: 5,),
                TextField(
                  controller: _controllerPassword,
                  obscureText: true,
                  style: TextStyle(color: Theme.of(context).colorScheme.onTertiaryContainer),
                  decoration: InputDecoration(
                      errorText: _passwordValidate ? _passwordError : null,
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                        borderSide: BorderSide(color: Theme.of(context).colorScheme.onPrimaryContainer,
                            width: 2),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                        borderSide: BorderSide(color: Theme.of(context).colorScheme.onSurface,
                            width: 2),
                      ),
                      fillColor: Theme.of(context).colorScheme.tertiaryContainer,
                      hintText: 'Password',
                      hintStyle: TextStyle(color: Theme.of(context).colorScheme.onTertiaryContainer),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                      )
                  ),
                ),

                SizedBox(height: 20,),
                Container(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                    Align(
                    alignment: Alignment.centerRight, // Align the button to the right
                      child:Directionality(
                          textDirection: TextDirection.rtl,
                          child: ElevatedButton.icon(
                            onPressed: () async {
                              QuerySnapshot querySnapshot = await FirebaseFirestore.instance
                                  .collection('users')
                                  .where('email', isEqualTo: _controllerEmail.text)
                                  .get();
                              if (!querySnapshot.docs.isEmpty) {
                                _emailValidate = true;
                                _emailError = "This email is already used for another account";
                              } else {
                                _emailValidate = false;
                              }
                              querySnapshot = await FirebaseFirestore.instance
                                  .collection('users')
                                  .where('phone', isEqualTo: _controllerPhoneNum.text)
                                  .get();
                              if (!querySnapshot.docs.isEmpty) {
                                _phoneValidate = true;
                                _phoneError = "This phone number is already used for another account";
                              } else {
                                _phoneValidate = false;
                              }

                              setState(() {
                                _controllerName.text.isEmpty? _nameValidate = true :  _nameValidate = false;
                                if(_controllerEmail.text.isEmpty){
                                  _emailValidate = true;
                                  _emailError = 'This field cannot be empty';
                                }
                                else _emailValidate = false;

                                if (_controllerPassword.text.length < 6) {
                                  _passwordValidate = true;
                                  _passwordError = "Password length must be at least 6 characters";
                                }
                                else _passwordValidate = false;

                              });

                              String phoneNum = "";
                              if(_controllerPhoneNum.text.startsWith('0'))
                                phoneNum = selectedCountry.dialCode.toString() + _controllerPhoneNum.text.substring(1);
                              else phoneNum = selectedCountry.dialCode.toString() + _controllerPhoneNum.text;

                              if(!_nameValidate && !_phoneValidate && !_passwordValidate && !_emailValidate) {
                                await FirebaseAuth.instance.verifyPhoneNumber(
                                  phoneNumber: phoneNum,
                                  verificationCompleted: (PhoneAuthCredential credential){},
                                  verificationFailed: (FirebaseAuthException e) {},
                                  codeSent: (String verificationID, int? resendToken) {
                                    RegisterPage.verify = verificationID;

                                    Navigator.push(context,
                                        MaterialPageRoute(builder: (context) =>
                                            PhoneVerify.withData(_controllerName.text,
                                                phoneNum,
                                                _controllerEmail.text,
                                                _controllerAddress.text,
                                                _controllerPassword.text)
                                        )
                                    );
                                  },
                                  codeAutoRetrievalTimeout: (String verificationID) {},
                                );
                              }
                              else Fluttertoast.showToast(msg: 'Please check the fields\' conditions again');



                            },
                            icon: Icon(Icons.arrow_circle_right),
                            label: Text("Let's sign up"),
                            style: ElevatedButton.styleFrom(
                              padding: EdgeInsets.all(5),
                              fixedSize: Size(150, 50),
                              shadowColor: Theme.of(context).colorScheme.onBackground,
                              side: BorderSide(color: Theme.of(context).colorScheme.onSurface, width: 2),
                              backgroundColor: Theme.of(context).colorScheme.onSurface,
                            ),
                          ),
                      ),
                    ),
                    ],
                  ),
                )
              ],
            ),
          ),
        )
      ),
    );
  }

}