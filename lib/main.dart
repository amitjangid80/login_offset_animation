import 'package:flutter/material.dart';
import 'package:login_offset_animation/offset_animation.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(title: 'Flutter Demo', theme: ThemeData(primarySwatch: Colors.blue), home: LoginScreen());
  }
}

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> with TickerProviderStateMixin {
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  AnimationController _usernameAnimationController;
  AnimationController _passwordAnimationController;

  @override
  void initState() {
    super.initState();

    _usernameAnimationController = AnimationController(vsync: this, duration: const Duration(seconds: 1));
    _passwordAnimationController = AnimationController(vsync: this, duration: const Duration(seconds: 1));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Form(
          key: _formKey, // key is required for validating text fields
          child: Padding(
            padding: const EdgeInsets.all(0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                OffsetAnimation(
                  end: 16,
                  animationController: _usernameAnimationController,
                  widget: TextFormField(
                    decoration: InputDecoration(labelText: 'Username'),
                    validator: (_username) {
                      if (_username.isEmpty) {
                        _usernameAnimationController.forward();
                        return 'Please enter valid Username.';
                      }

                      return null;
                    },
                  ),
                ),
                const SizedBox(height: 12),
                OffsetAnimation(
                  end: 16,
                  animationController: _passwordAnimationController,
                  widget: TextFormField(
                    decoration: InputDecoration(labelText: 'Password'),
                    validator: (_password) {
                      if (_password.isEmpty) {
                        _passwordAnimationController.forward();
                        return 'Please enter valid Password.';
                      }

                      return null;
                    },
                  ),
                ),
                const SizedBox(height: 12),
                ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState.validate()) {
                      _formKey.currentState.save();
                    }
                  },
                  child: Text('Login', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700)),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _usernameAnimationController.dispose();


    super.dispose();
  }
}
