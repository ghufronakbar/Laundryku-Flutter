import 'package:flutter/material.dart';
import 'package:laundryku/src/components/custom_button.dart';
import 'package:laundryku/src/components/custom_text.dart';
import 'package:cached_network_image/cached_network_image.dart';

class AccountScreen extends StatefulWidget {
  const AccountScreen({super.key});

  @override
  State<AccountScreen> createState() => _AccountScreenState();
}

class _AccountScreenState extends State<AccountScreen> {
  final String _name = "Rena";

  String getGreeting() {
    var hour = DateTime.now().hour;
    if (hour < 12) {
      return 'Selamat Pagi, $_name';
    } else if (hour < 18) {
      return 'Selamat Siang, $_name';
    } else {
      return 'Selamat Malam, $_name';
    }
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    TextEditingController nameController = TextEditingController();
    TextEditingController phoneController = TextEditingController();
    TextEditingController emailController = TextEditingController();

    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 80),
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
                  onPressed: () {},
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
