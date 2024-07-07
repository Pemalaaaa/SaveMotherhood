import 'package:flutter/material.dart';
import 'package:pema_la/Services/Auth.dart';
import 'package:pema_la/widgets/ESnackBar.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  // controller
  TextEditingController firstnameController = TextEditingController();
  TextEditingController lastnameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  // form key
  final _registerFormKey = GlobalKey<FormState>();

  // register function
  void _register() async {
    await Authentication()
        .register(firstnameController.text, lastnameController.text,
            emailController.text, passwordController.text)
        .then((value) => {
              if (value == true)
                {ESnackBar.showSuccess(context, "Register Successfull!")}
              else
                {ESnackBar.showError(context, "Register Failed!")}
            });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color(0xFFF7E5E7),
        appBar: AppBar(
          centerTitle: true,
          title: Text(
            "Register Now",
            style: TextStyle(fontWeight: FontWeight.w700),
          ),
          elevation: 0,
          backgroundColor: Color(0xFFFFC2CD),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Form(
              key: _registerFormKey,
              child: Column(
                children: [
                  const SizedBox(height: 20),
                  TextFormField(
                    controller: firstnameController,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please enter firstname';
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                        hintText: 'Enter your firstname',
                        border: OutlineInputBorder()),
                  ),
                  const SizedBox(height: 20),
                  TextFormField(
                    controller: lastnameController,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please enter lastname';
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                        hintText: 'Enter your lastname',
                        border: OutlineInputBorder()),
                  ),
                  const SizedBox(height: 20),
                  TextFormField(
                    controller: emailController,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please enter email';
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                       
                        hintText: 'Enter your email',
                        border: OutlineInputBorder()),
                  ),
                  const SizedBox(height: 20),
                  TextFormField(
                    controller: passwordController,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please enter password';
                      }
                      return null;
                    },
                    obscureText: true,
                    decoration: InputDecoration(
                        hintText: 'Enter your password altleast 6 character',
                        border: OutlineInputBorder()),
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Color(0xFFFFC2CD),
                        foregroundColor: Colors.white,
                        minimumSize: Size.fromHeight(50)),
                    onPressed: () {
                      if (_registerFormKey.currentState!.validate()) {
                        _register();
                      }
                    },
                    child: Text('Register'),
                  )
                ],
              ),
            ),
          ),
        ));
  }
}
