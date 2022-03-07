import 'package:flutter/material.dart';
import 'package:flutter_slide/Screens/HomeScreen.dart';
import 'package:flutter_slide/api.dart';
import 'package:flutter_slide/register.dart';
import 'package:get_storage/get_storage.dart';

final Username_controller= TextEditingController();
final Email_controller= TextEditingController();
final Password_controller= TextEditingController();


class MyLogin extends StatefulWidget {
  const MyLogin({Key key}) : super(key: key);

  @override
  _MyLoginState createState() => _MyLoginState();
}

class _MyLoginState extends State<MyLogin> {
  final _formKey = GlobalKey<FormState>();
  String email, password;
  bool isLoading = false;
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();
  ScaffoldMessengerState scaffoldMessenger;

  @override
  Widget build(BuildContext context) {
    scaffoldMessenger = ScaffoldMessenger.of(context);
    return Scaffold(
      key: _scaffoldKey,
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage('assets/login.png'), fit: BoxFit.cover),
        ),
        child: Scaffold(
          backgroundColor: Colors.transparent,
          body: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Container(
                padding: EdgeInsets.only(
                    top: MediaQuery.of(context).size.height * 0.3),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      margin: EdgeInsets.only(left: 35, right: 35),
                      child: Column(
                        children: [
                          TextFormField(
                            controller: Email_controller,
                            validator: (value) {
                              // Check if this field is empty
                              if (value == null || value.isEmpty) {
                                return 'This field is required';
                              }

                              // using regular expression
                              if (RegExp(r'\S+@\S+\.\S+').hasMatch(value)) {
                                return "Please enter a valid email address";
                              }

                              // the email is valid
                              return null;
                            },
                            style: TextStyle(color: Colors.black),
                            decoration: InputDecoration(
                                fillColor: Colors.grey.shade100,
                                filled: true,
                                hintText: "Email",
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                )),
                          ),
                          SizedBox(
                            height: 30,
                          ),
                          TextFormField(
                            controller: Password_controller,
                            validator: (value) {
                              // Check if this field is empty
                              if (value == null || value.isEmpty) {
                                return 'This field is required';
                              }

                              // the email is valid
                              return null;
                            },
                            style: TextStyle(),
                            obscureText: true,
                            decoration: InputDecoration(
                                fillColor: Colors.grey.shade100,
                                filled: true,
                                hintText: "Password",
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                )),
                          ),
                          SizedBox(
                            height: 40,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Sign in',
                                style: TextStyle(
                                    fontSize: 27, fontWeight: FontWeight.w700),
                              ),
                              Stack(
                                children: [
                                  GestureDetector(
                                    onTap: () {
                                      if (isLoading) {
                                        return;
                                      }
                                      if (Email_controller.text.isEmpty ||
                                          Password_controller.text.isEmpty) {
                                        scaffoldMessenger.showSnackBar(SnackBar(
                                            content: Text(
                                                "Please Fill all fields")));
                                        return;
                                      }
                                      setState(() {
                                        isLoading = true;
                                      });
                                    },
                                    child: CircleAvatar(
                                      radius: 30,
                                      backgroundColor: Color(0xff4c505b),
                                      child: IconButton(
                                          color: Colors.white,
                                          onPressed: () {
                                            final userdata = GetStorage();
                                            String email = Email_controller.text;
                                            String password = Password_controller.text;
                                            userdata.write('Email', email);
                                            userdata.write('Password', password);
                                            String emailread =
                                                '${userdata.read('Email'.trim())}';
                                            String passwordread =
                                                '${userdata.read('Password'.trim())}';
                                            print("Email:" + emailread);
                                            print("Password:" + passwordread);
                                            APIService()
                                                .LoginUser(
                                                '${userdata.read('Email'.trim())}',
                                                '${userdata.read('Password'.trim())}')
                                                .then((value) {

                                              print('Success!!');
                                              Navigator.of(context).push(
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          HomeScreen()));
                                            }).onError((error, stackTrace) {
                                              print('failure ');
                                              print('${error.toString()}');
                                            });
                                          },
                                          icon: Icon(
                                            Icons.arrow_forward,
                                          )),
                                    ),
                                  ),
                                ],
                              )
                            ],
                          ),
                          SizedBox(
                            height: 40,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              TextButton(
                                onPressed: () {

                                  Navigator.of(context).push(MaterialPageRoute(
                                      builder: (context) => MyRegister()));
                                },
                                child: Text(
                                  'Sign Up',
                                  textAlign: TextAlign.left,
                                  style: TextStyle(
                                      decoration: TextDecoration.underline,
                                      color: Color(0xff4c505b),
                                      fontSize: 18),
                                ),
                                style: ButtonStyle(),
                              ),
                              TextButton(
                                  onPressed: () {},
                                  child: Text(
                                    'Forgot Password',
                                    style: TextStyle(
                                      decoration: TextDecoration.underline,
                                      color: Color(0xff4c505b),
                                      fontSize: 18,
                                    ),
                                  )),
                            ],
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
