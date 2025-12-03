import 'package:ecommerce_admin_app/controllers/auth_service.dart';
import 'package:flutter/material.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({super.key});

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  final formkey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        key: formkey,
        child: Column(
          children: [
            const SizedBox(height: 120),

            SizedBox(
              width: MediaQuery.of(context).size.width * .9,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Signup",
                    style: TextStyle(fontSize: 40, fontWeight: FontWeight.w700),
                  ),
                  Text("Create a new account and get started"),
                  SizedBox(height: 10),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * .9,
                    child: TextFormField(
                      validator: (value) =>
                          value!.isEmpty ? "email cannot be empty." : null,
                      controller: _emailController,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        label: Text("Email"),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 10),

            SizedBox(
              width: MediaQuery.of(context).size.width * .9,
              child: TextFormField(
                validator: (value) => value!.length < 8
                    ? "password cannot have less than 8 characters"
                    : null,
                controller: _passwordController,
                obscureText: true,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  label: Text("Password"),
                ),
              ),
            ),
            SizedBox(height: 10),

            SizedBox(
              height: 60,
              width: MediaQuery.of(context).size.width * .9,
              child: ElevatedButton(
                onPressed: () {
                  if (formkey.currentState!.validate()) {
                    AuthService()
                        .createAccountWithEmail(
                          _emailController.text,
                          _passwordController.text,
                        )
                        .then((value) {
                          if (value == "Account Created") {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text("Account Created")),
                            );
                            Navigator.restorablePushNamedAndRemoveUntil(
                              context,
                              "/home",
                              (route) => false,
                            );
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text(
                                  value,
                                  style: TextStyle(color: Colors.white),
                                ),
                              ),
                            );
                          }
                        });
                  }
                },
                child: Text("Sign up", style: TextStyle(fontSize: 16)),
              ),
            ),
            SizedBox(height: 10),

            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Already have an account?"),
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text("Login"),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
