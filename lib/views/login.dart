import 'package:drivers/models/auth_model.dart';
import 'package:drivers/providers/auth_provider.dart';
import 'package:drivers/views/home.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final GlobalKey<FormState> _formKey = GlobalKey();
  final _data = {};
  bool _isLoading = false;
  Future _login() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }
    _formKey.currentState!.save();

    try {
      setState(() {
        _isLoading = true;
      });
      await Provider.of<AuthProvider>(context, listen: false).login(
          loginReq: LoginReq(
        email: _data['email'],
        password: _data['password'],
      ));

      // ignore: use_build_context_synchronously
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (ctx) => const Home(),
          ));
      setState(() {
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.withOpacity(0.9),
      body: SafeArea(
        child: Center(
          child: Form(
            key: _formKey,
            child: Card(
              elevation: 2,
              margin: const EdgeInsets.all(20),
              child: Container(
                padding: const EdgeInsets.all(30),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    TextFormField(
                      controller: TextEditingController(
                          text: 'jones_indie@mailinator.com'),
                      decoration: const InputDecoration(
                        hintText: 'Email',
                      ),
                      onSaved: (val) {
                        _data['email'] = val;
                      },
                    ),
                    const SizedBox(height: 30),
                    TextFormField(
                      controller: TextEditingController(text: 'password123'),
                      decoration: const InputDecoration(
                        hintText: 'Password',
                      ),
                      onSaved: (val) {
                        _data['password'] = val;
                      },
                    ),
                    const SizedBox(height: 30),
                    _isLoading
                        ? const CupertinoActivityIndicator()
                        : ElevatedButton(
                            onPressed: _login,
                            child: const Text('Login'),
                          )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
