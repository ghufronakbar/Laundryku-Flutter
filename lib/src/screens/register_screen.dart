import 'package:flutter/material.dart';
import 'package:laundryku/src/components/custom_button.dart';
import 'package:laundryku/src/components/custom_text.dart';
import 'package:laundryku/src/screens/login_screen.dart';
import 'package:laundryku/src/screens/home/main_screen.dart';
import 'package:laundryku/src/services/auth_services.dart';
import 'package:laundryku/src/utils/regex.dart';
import 'package:laundryku/src/utils/toast.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  TextEditingController nameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmatPasswordController = TextEditingController();
  bool _loading = false;

  void setLoading(bool loading) {
    setState(() {
      _loading = loading;
    });
  }

  Future<void> handleRegister() async {
    String name = nameController.text;
    String phone = phoneController.text;
    String email = emailController.text;
    String password = passwordController.text;
    String confirmPassword = confirmatPasswordController.text;

    await AuthServices().register(name, phone, email, password, confirmPassword,
        _loading, setLoading, goToMain);
  }

  void goToMain() {
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(builder: (context) => const MainScreen()),
    );
  }

  void goToLogin() {
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(builder: (context) => const LoginScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
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
                        text: "Register", style: CustomTextStyle.title),
                    const CustomText(
                        text: "Daftar untuk melanjutkan",
                        style: CustomTextStyle.subtitle),
                    const SizedBox(height: 20),
                    SizedBox(
                      height: 50,
                      child: TextFormField(
                        controller: nameController,
                        decoration: InputDecoration(
                          labelText: 'Nama',
                          hintText: 'Masukkan nama',
                          labelStyle: CustomTextStyle.content.style,
                          hintStyle: CustomTextStyle.subtitle.style,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          prefixIcon: const Icon(Icons.person),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    SizedBox(
                      height: 50,
                      child: TextFormField(
                        controller: phoneController,
                        keyboardType: TextInputType.phone,
                        decoration: InputDecoration(
                          labelText: 'Nomor Telepon',
                          hintText: 'Masukkan nomor telepon',
                          labelStyle: CustomTextStyle.content.style,
                          hintStyle: CustomTextStyle.subtitle.style,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          prefixIcon: const Icon(Icons.phone),
                        ),
                      ),
                    ),
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
                        height: 50,
                        child: TextFormField(
                          controller: confirmatPasswordController,
                          obscureText: true,
                          decoration: InputDecoration(
                            labelText: 'Konfirmasi password',
                            hintText: 'Masukkan konfirmasi password',
                            labelStyle: CustomTextStyle.content.style,
                            hintStyle: CustomTextStyle.subtitle.style,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            prefixIcon: const Icon(Icons.lock),
                          ),
                        )),
                    const SizedBox(height: 20),
                    SizedBox(
                      width: screenWidth,
                      child: CustomButton(
                        text: "Register",
                        buttonType: ButtonType.fill,
                        onPressed: handleRegister,
                      ),
                    ),
                    const SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const CustomText(
                          text: "Sudah punya akun?",
                          style: CustomTextStyle.content,
                        ),
                        const SizedBox(width: 5),
                        GestureDetector(
                          onTap: goToLogin,
                          child: const CustomText(
                              text: "Login", style: CustomTextStyle.highlight),
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
