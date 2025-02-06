import 'package:flutter/material.dart';
import 'package:hemat_yuk/Auth/register.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final _formKey = GlobalKey<FormState>();
  final supabase = Supabase.instance.client;

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  void login() async {
    String email = _emailController.text;
    String password = _passwordController.text;
    _emailController.clear();
    _passwordController.clear();
    try {
      final AuthResponse res = await supabase.auth.signInWithPassword(
        email: email,
        password: password,
      );
      
      showDialog(
          context: context,
          builder: (ctx) => AlertDialog(
            title: const Text("Login Success"),
            content: const Text("Login Success"),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  Navigator.of(ctx).pop();
                },
                child: Container(
                  padding: const EdgeInsets.all(14),
                  child: const Text("okay"),
                ),
              ),
            ],
          ),
        );
              
    } catch (error) {
      if (error is AuthException) {
        showDialog(
          context: context,
          builder: (ctx) => AlertDialog(
            title: const Text("Login Error"),
            content: const Text("Invalid credentials. Please try again!"),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  Navigator.of(ctx).pop();
                },
                child: Container(
                  padding: const EdgeInsets.all(14),
                  child: const Text("okay"),
                ),
              ),
            ],
          ),
        );
      } else {
        // Handle generic errors
        print('An unexpected error occurred: ${error.toString()}');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Login"),
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
                  controller: _emailController,
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
                  controller: _passwordController,
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
                                  login(),
                                }
                            },
                        child: Center(
                          child: Text("Login"),
                        )),
                    MaterialButton(
                        color: Theme.of(context).primaryColor,
                        textColor: Colors.white,
                        onPressed: () => {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => const Register()))
                            },
                        child: Center(
                          child: Text("Register"),
                        ))
                  ],
                )
              ],
            ),
          )),
        ));
  }
}
