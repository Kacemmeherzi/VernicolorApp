import 'package:flutter/material.dart';
import 'package:vernicolorapp/services/AuthService.dart';

class Loginview extends StatefulWidget {
  final AuthService authService;

  Loginview({required this.authService});

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<Loginview> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _isLoading = false;
  String _errorMessage = '';

  void _login() async {
    setState(() {
      _isLoading = true;
      _errorMessage = '';
    });

    try {
      final response = await widget.authService.login(
        email: _emailController.text,
        password: _passwordController.text,
      );

      if (response['success']) {
         ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Login successful!'),
          backgroundColor: Colors.green,
        ),
      );
        Navigator.pushReplacementNamed(context, '/home');
      } else {
        setState(() {
          _isLoading = false ;
          _errorMessage = response['error'];
            ScaffoldMessenger.of(context).showSnackBar(
         SnackBar(
          content: Text(_errorMessage),
          backgroundColor: Colors.red,
        ));
        });
      }
    } catch (e) {
      setState(() {
        _isLoading = false ; 
        _errorMessage = 'An error occurred. Please try again.';
          ScaffoldMessenger.of(context).showSnackBar(
         SnackBar(
          content: Text(_errorMessage),
          backgroundColor: Colors.red,
        ));
      });
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: <Widget>[
            SizedBox(height: 50) , 
            Image.asset(
              'assets/images/logoverni.png', // Path to your image
              height: 150,  // Adjust the height as needed
            ),
            TextField(
              controller: _emailController,
              decoration:  const InputDecoration(labelText: 'username'),
            ),
            TextField(
              controller: _passwordController,
              decoration:const  InputDecoration(labelText: 'Password'),
              obscureText: true,
            ),
              SizedBox(height: 20),
            if (_isLoading)
              CircularProgressIndicator()
            else
            SizedBox(width: double.infinity,
            child: ElevatedButton(
               style: ElevatedButton.styleFrom(
              foregroundColor: Colors.white, 
              backgroundColor: Colors.green, 
  ),
                onPressed: _login,
                child:  const Text('Login'),
              ),),
             
            if (_errorMessage.isNotEmpty)
              Padding(
                padding: const EdgeInsets.only(top: 20),
                child: Text(
                  _errorMessage,
                  style: TextStyle(color: Colors.red),
                ),
              ),
          ],
        ),
      ),
    );
  }
}