import 'package:firebase/auth/sign_up_screen.dart';
import 'package:firebase/home/post_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});
  @override
  Widget build(BuildContext context) {
    final _formKey = GlobalKey<FormState>();
    final emailController = TextEditingController();
    final passwordController = TextEditingController();
    FirebaseAuth _auth = FirebaseAuth.instance;
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text(
          'Login',
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(18.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextFormField(
                  keyboardType: TextInputType.emailAddress,
                  controller: emailController,
                  decoration: const InputDecoration(
                    hintText: 'Enter email',
                    prefixIcon: Icon(
                      Icons.email_outlined,
                      size: 30,
                    ),
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Enter valid email';
                    }
                    return null;
                  },
                ),
                const SizedBox(
                  height: 10,
                ),
                TextFormField(
                  obscureText: true,
                  keyboardType: TextInputType.emailAddress,
                  controller: passwordController,
                  decoration: const InputDecoration(
                    alignLabelWithHint: true,
                    hintText: 'Password',
                    prefixIcon: Icon(
                      Icons.lock_outline,
                      size: 30,
                    ),
                  ),
                  validator: (value) {
                    if (value!.isEmpty || value == null) {
                      return 'Enter password';
                    }
                    return null;
                  },
                ),
                const SizedBox(
                  height: 50,
                ),
                ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      _auth
                          .signInWithEmailAndPassword(
                              email: emailController.text.toString(),
                              password: passwordController.text.toString())
                          .then((Value) {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (ctx) => const PostScreen()));
                        ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text(Value.toString())));
                      }).onError((error, t) {
                        ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text(error.toString())));
                      });
                    }
                  },
                  style: ElevatedButton.styleFrom(
                      textStyle: const TextStyle(
                          fontSize: 18, fontWeight: FontWeight.bold),
                      fixedSize: const Size(130, 30),
                      foregroundColor: Colors.white,
                      backgroundColor: Colors.deepPurple),
                  child: const Text('Login'),
                ),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Text('Don`t have an account?'),
                    TextButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (ctx) => const SignUpScreen()));
                        },
                        child: const Text('Sign up'))
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
