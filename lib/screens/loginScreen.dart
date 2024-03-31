import 'package:flutter/material.dart';
import 'package:pema_la/services/Auth.dart';
import 'package:pema_la/widgets/ESnackBar.dart';

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

  //login function define
  void _login() async {
    await Authentication()
        .login(emailController.text, passwordController.text)
        .then((value) => {
              if (value == true)
                {
                  ESnackBar.showSuccess(context, "Login Successful"),
                  Navigator.pushNamed(context, "/navbar")
                }
              else
                {ESnackBar.showError(context, "Login failed")}
            });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text("LoginScreen")),
        body: Column(
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
                Text('Login'),
                TextFormField(
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
                const SizedBox(
                  height: 10,
                ),
                TextFormField(
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter password';
                    } else {
                      return null;
                    }
                  },

                  obscureText: true, // password hide
                  controller: passwordController,
                  decoration: InputDecoration(
                      labelText: 'Password',
                      hintText: 'Password',
                      border: OutlineInputBorder()),
                ),
                SizedBox(
                  height: 20,
                ),
                ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.black,
                        foregroundColor: Colors.white,
                        minimumSize:
                            Size.fromHeight(50) // screen anu sarko image
                        ),
                    onPressed: () {
                      if (addLoginFormKey.currentState!.validate()) {
                        _login();
                      }
                    },
                    child: Text('Login')),

                //Register
                GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(context, '/register');
                  },
                  child: Center(
                    child: Text(
                      'create new account',
                      style: TextStyle(
                          color: const Color.fromARGB(255, 51, 17, 145),
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ]),
            )
          ],
        ));
  }
}
