import 'package:flutter/material.dart';
import 'package:laundryku/src/components/custom_button.dart';
import 'package:laundryku/src/components/custom_text.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:laundryku/src/screens/login_screen.dart';
import 'package:laundryku/src/services/auth_services.dart';

class AccountScreen extends StatefulWidget {
  const AccountScreen({super.key});

  @override
  State<AccountScreen> createState() => _AccountScreenState();
}

class _AccountScreenState extends State<AccountScreen> {
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    TextEditingController nameController = TextEditingController();
    TextEditingController phoneController = TextEditingController();
    TextEditingController emailController = TextEditingController();

    void handleSave() {
      // Implement update profile logic here
    }

    void goToLogin() {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => const LoginScreen()),
      );
    }

    void showLogoutConfirmation() {
      showDialog(
        context: context,
        barrierDismissible: false, // Prevent closing dialog by tapping outside
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Konfirmasi Logout'),
            content: const Text('Apakah Anda yakin ingin keluar?'),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text('Batal'),
              ),
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                  AuthServices().logout(goToLogin);
                },
                child: const Text('Ya'),
              ),
            ],
          );
        },
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Center(
          child: Padding(
            padding: EdgeInsets.all(16.0),
            child: CustomText(
                text: "Pengaturan Profil", style: CustomTextStyle.title),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const ClipOval(
                child: ProfileImage(imageUrl: null),
              ),
              const SizedBox(height: 40),
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
                width: screenWidth,
                child: CustomButton(
                  text: "Simpan Profil",
                  buttonType: ButtonType.fill,
                  onPressed: handleSave,
                ),
              ),
              const SizedBox(height: 4),
              SizedBox(
                width: screenWidth,
                child: CustomButton(
                  text: "Logout",
                  buttonType: ButtonType.outline,
                  onPressed: showLogoutConfirmation, // Show logout dialog
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ProfileImage extends StatelessWidget {
  final String? imageUrl;

  const ProfileImage({super.key, this.imageUrl});

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      width: 120,
      height: 120,
      fit: BoxFit.cover,
      imageUrl: imageUrl ?? "",
      progressIndicatorBuilder: (context, url, downloadProgress) => Image.asset(
        'assets/images/profile.jpg',
      ),
      errorWidget: (context, url, error) => Image.asset(
        'assets/images/profile.jpg',
      ),
    );
  }
}
