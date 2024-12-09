import 'package:flutter/material.dart';
import 'package:laundryku/src/components/custom_button.dart';
import 'package:laundryku/src/components/custom_text.dart';
import 'package:laundryku/src/screens/home/main_screen.dart';
import 'package:laundryku/src/screens/register_screen.dart';
import 'package:laundryku/src/services/auth_services.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool _loading = false;

  void setLoading(bool loading) {
    setState(() {
      _loading = loading;
    });
  }

  Future<void> handleLogin() async {
    String email = emailController.text;
    String password = passwordController.text;

    await AuthServices().login(email, password, _loading, setLoading, goToMain);
  }

  void goToMain() {
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(builder: (context) => const MainScreen()),
    );
  }

  void goToRegister() {
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(builder: (context) => const RegisterScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
            // Menggunakan min-height yang setara dengan tinggi layar
            constraints: BoxConstraints(minHeight: screenHeight),
            child: Center(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Center(
                      child: Image.asset(
                        'assets/images/logo.png',
                        width: 150,
                        height: 150,
                      ),
                    ),
                    const CustomText(
                        text: "Login", style: CustomTextStyle.title),
                    const CustomText(
                        text: "Masuk untuk melanjutkan",
                        style: CustomTextStyle.subtitle),
                    const SizedBox(height: 20),
                    SizedBox(
                      height: 50,
                      child: TextFormField(
                        controller: emailController,
                        decoration: InputDecoration(
                          labelText: 'Email',
                          hintText: 'Masukkan alamat email',
                          labelStyle: CustomTextStyle.content.style,
                          hintStyle: CustomTextStyle.subtitle.style,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          prefixIcon: const Icon(Icons.email),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    SizedBox(
                      height: 50,
                      child: TextFormField(
                        controller: passwordController,
                        obscureText: true,
                        decoration: InputDecoration(
                          labelText: 'Password',
                          hintText: 'Masukkan password',
                          labelStyle: CustomTextStyle.content.style,
                          hintStyle: CustomTextStyle.subtitle.style,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          prefixIcon: const Icon(Icons.lock),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    SizedBox(
                      width: screenWidth,
                      child: CustomButton(
                        text: "Login",
                        buttonType: ButtonType.fill,
                        onPressed: handleLogin,
                        loading: _loading,
                      ),
                    ),
                    const SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const CustomText(
                          text: "Belum punya akun?",
                          style: CustomTextStyle.content,
                        ),
                        const SizedBox(width: 5),
                        GestureDetector(
                          onTap: goToRegister,
                          child: const CustomText(
                              text: "Daftar", style: CustomTextStyle.highlight),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            )),
      ),
    );
  }
}
