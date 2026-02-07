import 'package:d_movie_app/pages/json_movie_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginPage extends StatefulWidget{
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Login page"),
        backgroundColor: Colors.lightGreen,
        shadowColor: Colors.black,
      ),
      body: Padding(
        padding: const EdgeInsets.all(32.0),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextFormField(
                controller: _usernameController,
                decoration: const InputDecoration(
                  label: Text("Username")
                ),
                validator: (text){
                  if (text != null && text.length >= 6)
                  {
                    return null;
                  }
                  return "Username must contain atleast 6 characters.";
                },
              ),
              SizedBox(height: 16.0),
              TextFormField(
                controller: _passwordController,
                decoration: const InputDecoration(
                  label: Text("Password")
                ),
                validator: (text){
                  if (text != null && text.length >= 8)
                  {
                    return null;
                  }
                  return "Password must contain atleast 8 characters.";
                },
              ),
              SizedBox(height: 16.0),
              ElevatedButton(
                  onPressed: () {
                    validateAndLogin();
                  },
                  child: const Text("Login")
              ),
            ],
          ),
        ),
      ),
    );
  }

  void validateAndLogin()
  {
    final isFormValid = _formKey.currentState?.validate();
    print("Form Valid = $isFormValid");

    if(isFormValid ?? false)
    {
      saveAuth();
    }
  }

  void saveAuth() async
  {
    final pref = await SharedPreferences.getInstance();
    final authSaved = await pref.setBool("IS_AUTHENTICATED", true);

    if(authSaved)
    {
      if(!mounted) return;
      Navigator.pushReplacement((context), MaterialPageRoute(builder: (context){
        return const JsonMoviePage();
      }));
    }
  }
}