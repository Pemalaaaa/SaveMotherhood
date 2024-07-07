import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:pema_la/widgets/ESnackBar.dart';


class ChangePasswordScreen extends StatefulWidget {
  const ChangePasswordScreen({super.key});

  @override
  State<ChangePasswordScreen> createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen> {
   bool showPass = false; 
  final TextEditingController _oldPasswordController = TextEditingController();
  final TextEditingController _newPasswordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();
  final _PswValidFormKey = GlobalKey<FormState>();
  

  @override
  void dispose() {
    _oldPasswordController.dispose();
    _newPasswordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
 void changePassword() async {
      final oldPassword = _oldPasswordController.text;
      final newPassword = _newPasswordController.text;
      final confirmPassword = _confirmPasswordController.text;

      if (newPassword == confirmPassword) {
        try {
          User? user = FirebaseAuth.instance.currentUser;
          if (user != null) {
            AuthCredential credential = EmailAuthProvider.credential(
                email: user.email!, password: oldPassword);
            await user.reauthenticateWithCredential(credential);
            await user.updatePassword(newPassword);
            ESnackBar.showSuccess(context, "Successfully Changed Password");//.show(context, 'Successfully Changed Password');
          }
        } catch (e) {
          ESnackBar.showError(context, "Failed to change Password");
        }
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Passwords do not match'),
           backgroundColor:Color(0xFFFFC2CD),
          ),
        );
      }
      _oldPasswordController.clear();
      _newPasswordController.clear();
      _confirmPasswordController.clear();
    }

   return Scaffold(
     backgroundColor:Color(0xFFF7E5E7),
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          'Set New Password',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w700,
          ),
        ),
        backgroundColor: Color(0xFFFFC2CD),
        elevation: 0,
      ),
      body: ListView(
        children: [
          const SizedBox(height: 60),
          const Align(
            alignment: Alignment.center,
            child: SizedBox(
              height: 150,
              width: 200,
              child: Center(
                child: CircleAvatar(
                  maxRadius: 75,
                  backgroundImage: AssetImage('assets/images/2tr-removebg-preview.png'),
                ),
              ),
            ),
          ),
 const SizedBox(height: 40),
          Form(
            key: _PswValidFormKey,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Column(
                children: [
                  TextFormField(
                    obscureText: !showPass,
                    decoration: InputDecoration(
                      labelStyle: const TextStyle(
                        color: Colors.black,
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                      ),
                      border: OutlineInputBorder(
                        borderSide: const BorderSide(color: Color(0xFFFFC2CD)),
                        borderRadius: BorderRadius.circular(12),
                      ),
 suffixIcon: InkWell(
                        onTap: () {
                          setState(() {
                            showPass = !showPass;
                          });
                        },
                        child: Icon(
                          showPass ? Icons.visibility : Icons.visibility_off,
                          size: 20,
                         color: Color(0xFFFFC2CD)
                        ),
                      ),
                      hintText: '*',
                      labelText: 'Old Password',
                    ),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please enter your Old password';
                      }            return null;
                    },
                    controller: _oldPasswordController,
                  ),
                  const SizedBox(height: 20),
                  TextFormField(
                    obscureText: !showPass,
                    decoration: InputDecoration(
                      labelStyle: const TextStyle(
                        color: Colors.black,
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                      ),
                      border: OutlineInputBorder(
                        borderSide: const BorderSide(color: Color(0xFFFFC2CD)),
  borderRadius: BorderRadius.circular(12),
                      ),
                      suffixIcon: InkWell(
                        onTap: () {
                          setState(() {
                            showPass = !showPass;
                          });
                        },
                        child: Icon(
                          showPass ? Icons.visibility : Icons.visibility_off,
                          size: 20,
                          color: Color(0xFFFFC2CD),
                        ),
                      ),
                      hintText: '*',
                      labelText: 'New Password',
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your new password';
                      }
  if (value.length < 8) {
                        return 'Password length should be at least 8 characters';
                      }

                      return null;
                    },
                    controller: _newPasswordController,
                  ),
                  const SizedBox(height: 20),
                  TextFormField(
                    obscureText: !showPass,
                    decoration: InputDecoration(
                      labelStyle: const TextStyle(
                        color: Colors.black,
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                      ),
 border: OutlineInputBorder(
                        borderSide: const BorderSide(color: Color(0xFFFFC2CD)),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      suffixIcon: InkWell(
                        onTap: () {
                          setState(() {
                            showPass = !showPass;
                          });
                        },
                        child: Icon(
                          showPass ? Icons.visibility : Icons.visibility_off,
                          size: 20,
                         color: Color(0xFFFFC2CD),
                        ),
                      ),
                      hintText: '*',
                      labelText: 'Confirm Password',
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your confirm password';
                      }
if (value.length < 8) {
                        return 'Password length should be at least 8 characters';
                      }

                      return null;
                    },
                    controller: _confirmPasswordController,
                  ),
                  const SizedBox(height: 40),
                  SizedBox(
                    height: 50,
                    width: 250,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        backgroundColor:Color(0xFFFFC2CD),
                        foregroundColor: Colors.black,
                        textStyle: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
 onPressed: () {
                        if (_PswValidFormKey.currentState!.validate()) {
                          changePassword();
                        }
                      },
                      child: const Text('Change Password'),
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
}
