import 'package:flutter/material.dart';
import 'package:hemat_yuk/Auth/login.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class Register extends StatefulWidget {
  const Register({super.key});

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final _formKey = GlobalKey<FormState>();
  final supabase = Supabase.instance.client;

  TextEditingController emailController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  void register() async {
    String email = emailController.text;
    String password = passwordController.text;
    String name = nameController.text;
    emailController.clear();
    passwordController.clear();
    nameController.clear();
    final AuthResponse res = await supabase.auth.signUp(
      email: email,
      password: password,
      data: {"display_name": name}
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Register"),
          centerTitle: true,
        ),
        body: Form(
          key: _formKey,
          child: Center(
              child: Container(
            margin: EdgeInsets.all(10.0),
            child: Column(
              spacing: 30.0,
              children: [
                TextFormField(
                  controller: emailController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Please enter Your Email";
                    }
                    return null;
                  },
                  decoration: const InputDecoration(
                      border: OutlineInputBorder(), labelText: "Email"),
                ),
                TextFormField(
                  controller: nameController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Please enter Your Name";
                    }
                    return null;
                  },
                  decoration: const InputDecoration(
                      border: OutlineInputBorder(), labelText: "Name"),
                ),
                TextFormField(
                  controller: passwordController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Please enter Your Password";
                    }
                    return null;
                  },
                  obscureText: true,
                  decoration: const InputDecoration(
                      border: OutlineInputBorder(), labelText: "Password"),
                ),
                Column(
                  children: [
                    MaterialButton(
                        color: Theme.of(context).primaryColor,
                        textColor: Colors.white,
                        onPressed: () => {
                              if (_formKey.currentState!.validate())
                                {
                                  register(),
                                  showDialog(
                                    context: context,
                                    builder: (ctx) => AlertDialog(
                                      title: const Text("Check Your Email"),
                                      content: const Text(
                                          "Email Confirmation has been sent to your email"),
                                      actions: <Widget>[
                                        TextButton(
                                          onPressed: () {
                                            Navigator.of(ctx).pop();
                                          },
                                          child: Container(
                                            // color: Theme.of(context).primaryColor,
                                            padding: const EdgeInsets.all(14),
                                            child: const Text("okay"),
                                          ),
                                        ),
                                      ],
                                    ),
                                  )
                                }
                            },
                        child: Center(
                          child: Text("Register"),
                        )),
                    MaterialButton(
                        color: Theme.of(context).primaryColor,
                        textColor: Colors.white,
                        onPressed: () => {
                              Navigator.pop(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => const Login()))
                            },
                        child: Center(
                          child: Text("Login"),
                        ))
                  ],
                )
              ],
            ),
          )),
        ));
  }
}
