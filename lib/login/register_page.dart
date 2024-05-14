import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:voiceassistant/components/button.dart';
import 'package:voiceassistant/components/common_text_fields.dart';
import 'package:voiceassistant/Services/auth_service.dart';
import 'package:voiceassistant/components/pallete.dart';

class RegisterPage extends StatefulWidget {
  final void Function()? onTap;

  const RegisterPage({Key? key, required this.onTap}) : super(key: key);

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  void signUp() async {
    if (passwordController.text != confirmPasswordController.text) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Passwords did not match")),
      );
      return;
    }
    final authService = Provider.of<AuthService>(context, listen: false);
    try {
      await authService.signUpWithEmailandPassword(
          emailController.text, passwordController.text);
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(e.toString())),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color.fromARGB(255, 239, 236, 236),
        body: SafeArea(
            child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child:
                Column(mainAxisAlignment: MainAxisAlignment.center, children: [
              Container(
                padding: EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Pallete.whiteColor,
                  borderRadius: BorderRadius.circular(15),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black12,
                      blurRadius: 10,
                      offset: Offset(0, 5),
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    const SizedBox(height: 20),
                    Text(
                      "Create Your Account !!",
                      style: TextStyle(fontSize: 16, fontFamily: "Cera Pro"),
                    ),
                    const SizedBox(height: 20),
                    CommonTextField(
                      controller: emailController,
                      hintText: "Email",
                      obscureText: false,
                    ),
                    const SizedBox(height: 20),
                    CommonTextField(
                      controller: passwordController,
                      hintText: 'Password',
                      obscureText: true,
                    ),
                    const SizedBox(height: 20),
                    CommonTextField(
                      controller: confirmPasswordController,
                      hintText: 'Confirm Password',
                      obscureText: true,
                    ),
                    const SizedBox(height: 20),
                    CommonButton(onTap: signUp, text: "Sign Up"),
                    const SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("Already a User? ",
                            style: TextStyle(
                              fontFamily: "Cera Pro",
                            )),
                        GestureDetector(
                          child: Text(
                            "Login Now",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Pallete.blackColor),
                          ),
                          onTap: widget.onTap,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ]),
          ),
        )));
  }
}
