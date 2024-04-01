//import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:pema_la/widgets/ESnackBar.dart';
import 'package:pema_la/services/Auth.dart';
//import 'package:pema_la/widgets/ESnackBar.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  //controller
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

//form key
  GlobalKey<FormState> addLoginFormKey = GlobalKey<FormState>();

  //to hide the password
  bool showPass = false;
  //login function define
  void _login() async {
    try {
      bool loginResult = await Authentication()
          .login(emailController.text, passwordController.text);
      if (loginResult) {
        ESnackBar.showSuccess(context, "Login Successful!");
        Navigator.pushNamed(context, "/navbar");
      } else {
        ESnackBar.showError(context, "Login Failed!");
      }
    } catch (error) {
      print("Login Error: $error");
      ESnackBar.showError(context, "Error occurred during login.");
      // Return false or handle the error as necessary
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:Color(0xFFF7E5E7) ,
        body: SingleChildScrollView(
      child: Column(
        children: [
          //1. make input field  for email and password
          //2. give a decoration and hint text
          //3. give a padding (wrap Ctrl + .)
          //4. make a button
          //5. validation ko lagi chai first ma we have to keep all the textformfield to form
          //6. controller
          //7/

          Form(
            key: addLoginFormKey,
            child: Column(children: [
              Padding(
                padding: const EdgeInsets.only(top: 100),
                child: Center(
                    child: Column(
                  children: [
                    Text(
                      'Welcome To ',
                      style:
                          TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                    ),
                    Image.asset(
                      "assets/intopics/logo.png",
                      width: 230, // Adjust width as needed
                      height: 230,
                    ),
                  ],
                )),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  controller: emailController,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter email';
                    } else {
                      return null;
                    }
                  },
                  decoration: InputDecoration(
                      labelText: 'Email',
                      hintText: 'Email',
                      border: OutlineInputBorder()),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter password';
                    } else {
                      return null;
                    }
                  },

                  obscureText:
                      !showPass, // Toggle obscureText based on showPass
                  controller: passwordController,
                  decoration: InputDecoration(
                    labelText: 'Password',
                    hintText: 'Password',
                    border: OutlineInputBorder(),
                    suffixIcon: InkWell(
                      onTap: () {
                        setState(() {
                          showPass = !showPass;
                        });
                      },
                      child: Icon(
                        showPass ? Icons.visibility : Icons.visibility_off,
                        size: 20,
                        color: Colors.black,
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xFFFFC2CD),
                      foregroundColor: Colors.white,
                      minimumSize: Size.fromHeight(50) // screen anu sarko image
                      ),
                  onPressed: () {
                    if (addLoginFormKey.currentState!.validate()) {
                      _login();
                    }
                  },
                  child: Text('Login')),
              SizedBox(height: 12,),
              //Register
              GestureDetector(
                onTap: () {
                  Navigator.pushNamed(context, '/register');
                },
                child: Center(
                  child: Text(
                    'create new account',
                    style: TextStyle(
                        color:Colors.black,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ]),
          )
        ],
      ),
    ));
  }
}
