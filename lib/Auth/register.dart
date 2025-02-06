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
  final String email = emailController.text;
  final String password = passwordController.text;
  final String name = nameController.text;

  emailController.clear();
  passwordController.clear();
  nameController.clear();

  try {
    final AuthResponse res = await supabase.auth.signUp(
      email: email,
      password: password,
      data: {"display_name": name},
    );

    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text("Check Your Email"),
        content: const Text("An email confirmation has been sent to your email."),
        actions: <Widget>[
          TextButton(
            onPressed: () {
              Navigator.of(ctx).pop();
            },
            child: Container(
              padding: const EdgeInsets.all(14),
              child: const Text("Okay"),
            ),
          ),
        ],
      ),
    );
  } on AuthException catch (error) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text("Register Failed"),
        content: Text(error.message),
        actions: <Widget>[
          TextButton(
            onPressed: () {
              Navigator.of(ctx).pop();
            },
            child: Container(
              padding: const EdgeInsets.all(14),
              child: const Text("Okay"),
            ),
          ),
        ],
      ),
    );
  } catch (error) {
    print('An unexpected error occurred: ${error.toString()}');
  }
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
                                {register()}
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
