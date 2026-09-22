import 'package:flutter/material.dart';
import 'package:nutriguardapp/forgetpassword.dart';
import 'package:nutriguardapp/health.dart';
import 'package:nutriguardapp/signup_page.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    final primaryBlue = Theme.of(context).primaryColor;

    return Scaffold(
      backgroundColor: Colors.white,
      // The AppBar automatically gives us a clean back button!
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: IconThemeData(color: primaryBlue),
      ),
      body: Center(
        // Makes the screen scrollable when the keyboard appears
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(height: 20),
              
              // 1. Headers
              Text(
                'Welcome Back!',
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: primaryBlue,
                ),
              ),
              const SizedBox(height: 8),
              const Text(
                'Login to continue',
                style: TextStyle(fontSize: 16, color: Colors.grey),
              ),
              const SizedBox(height: 40),
              
              // 2. Input Fields
              _buildTextField('Email Address', false),
              const SizedBox(height: 16),
              _buildTextField('Password', true),
              
              // 3. Forgot Password Link
              Align(
                alignment: Alignment.centerRight,
                child: TextButton(
                  onPressed: () {
                  Navigator.push(context,MaterialPageRoute(builder: (context) => ForgotPasswordScreen()));

                  },
                  child: Text(
                    'Forgot Password?',
                    style: TextStyle(color: primaryBlue),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              
              // 4. Login Button
              ElevatedButton(
                onPressed: () {
                  Navigator.push(context,MaterialPageRoute(builder: (context) => HealthProfileScreen()));
                },
                child: const Text(
                  'Login',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ),
              const SizedBox(height: 40),
              
              // 5. Social Login Section
              const Text('Or continue with', style: TextStyle(color: Colors.grey)),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _buildSocialButton(Icons.g_mobiledata),
                  const SizedBox(width: 16),
                  _buildSocialButton(Icons.apple),
                  const SizedBox(width: 16),
                  _buildSocialButton(Icons.facebook),
                ],
              ),
              const SizedBox(height: 30),
            
              // 6. Footer Link
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text("Don't have an account? ", style: TextStyle(color: Colors.grey)),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(context,MaterialPageRoute(builder: (context) => signup_page()));
                    },
                    child: Text(
                      'Sign Up',
                      style: TextStyle(color: primaryBlue, fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Helper method to create clean, rounded input fields
  Widget _buildTextField(String hint, bool isPassword) {
    return TextFormField(
      obscureText: isPassword,
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: const TextStyle(color: Colors.grey),
        filled: true,
        fillColor: const Color(0xFFF9FAFB), // Very light grey background
        contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: Colors.grey.shade300),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: Colors.grey.shade300),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: Theme.of(context).primaryColor),
        ),
      ),
    );
  }

  // Helper method for social buttons (reused from Welcome Screen)
  Widget _buildSocialButton(IconData icon) {
    return Container(
      width: 60, height: 60,
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey.shade300),
        borderRadius: BorderRadius.circular(16),
      ),
      child: IconButton(
        icon: Icon(icon, color: const Color(0xFF1E3A8A), size: 32),
        onPressed: () {},
      ),
    );
  }
}