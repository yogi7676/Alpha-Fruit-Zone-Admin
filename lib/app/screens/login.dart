import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:foodbuddy/app/helper/assets_path.dart';
import 'package:foodbuddy/app/provider/repository.dart';
import 'package:foodbuddy/app/screens/dashboard.dart';
import 'package:get/get.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  bool hidePassword = true;
  var emailController = TextEditingController();
  var passController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  togglePassword() {
    setState(() {
      hidePassword = !hidePassword;
    });
  }

  @override
  void dispose() {
    emailController.dispose();
    passController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Stack(
          alignment: Alignment.center,
          children: [
            Stack(
              children: const [
                SizedBox(
                  height: 200,
                  child: Align(
                      alignment: Alignment.topLeft,
                      child: Image(
                        image: AssetImage(AssetsPath.image3),
                        fit: BoxFit.fill,
                      )),
                ),
                Align(
                    alignment: Alignment.bottomRight,
                    child: Image(image: AssetImage(AssetsPath.image2)))
              ],
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40),
              child: Form(
                  key: formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text('Signin to continue to'),
                      const SizedBox(
                        height: 5,
                      ),
                      const Text(
                        'Alpha Fruit Zone',
                        style: TextStyle(
                            fontSize: 25, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      const Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            'Email',
                            style: TextStyle(fontWeight: FontWeight.w600),
                          )),
                      const SizedBox(
                        height: 5,
                      ),
                      TextFormField(
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        controller: emailController,
                        keyboardType: TextInputType.emailAddress,
                        textInputAction: TextInputAction.next,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          prefixIcon: Icon(Icons.email),
                          contentPadding: EdgeInsets.symmetric(horizontal: 10),
                          hintText: 'email address',
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Email is Required';
                          }
                          const pattern =
                              r"^[a-zA-Z0-9_!#$%&'*+/=?`{|}~^.-]+@[a-zA-z0-9.-]+$";
                          final regExp = RegExp(pattern);

                          if (!regExp.hasMatch(value)) {
                            return 'Enter a valid email address';
                          }

                          return null;
                        },
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      const Align(
                          alignment: Alignment.centerLeft,
                          child: Text('Password',
                              style: TextStyle(fontWeight: FontWeight.w600))),
                      const SizedBox(
                        height: 5,
                      ),
                      TextFormField(
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        controller: passController,
                        obscureText: hidePassword,
                        textInputAction: TextInputAction.done,
                        decoration: InputDecoration(
                          border: const OutlineInputBorder(),
                          suffix: InkWell(
                              onTap: togglePassword,
                              child: Icon(hidePassword
                                  ? Icons.visibility_off
                                  : Icons.visibility_off)),
                          prefixIcon: const Icon(Icons.lock),
                          contentPadding:
                              const EdgeInsets.symmetric(horizontal: 10),
                          hintText: 'password',
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Password is Required';
                          } else if (value.length < 8) {
                            return 'Password must be 8 characters long.';
                          }
                          return null;
                        },
                      ),
                      Align(
                          alignment: Alignment.centerRight,
                          child: TextButton(
                              onPressed: () {},
                              child: const Text('Forgot Password ?'))),
                      SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                              onPressed: () async {
                                if (formKey.currentState!.validate()) {
                                  UserCredential credential = await Repository()
                                      .login(emailController.text.trim(),
                                          passController.text.trim());
                                  if(credential.user != null){
                                    Get.off(const DashBoard(),);
                                  }
                                }
                                //await new Repository().signin(email, password)
                              },
                              child: const Text('Login')))
                    ],
                  )),
            )
          ],
        ),
      ),
    );
  }
}
