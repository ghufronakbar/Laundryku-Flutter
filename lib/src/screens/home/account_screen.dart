import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:laundryku/src/components/custom_button.dart';
import 'package:laundryku/src/components/custom_text.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:laundryku/src/models/user.dart';
import 'package:laundryku/src/screens/login_screen.dart';
import 'package:laundryku/src/services/auth_services.dart';
import 'package:laundryku/src/services/account_services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:laundryku/src/utils/colors.dart' as custom_colors;
import 'dart:io';

class AccountScreen extends StatefulWidget {
  const AccountScreen({super.key});

  @override
  State<AccountScreen> createState() => _AccountScreenState();
}

class _AccountScreenState extends State<AccountScreen> {
  late TextEditingController nameController;
  late TextEditingController phoneController;
  late TextEditingController emailController;
  bool _loading = false;
  String? _imageUrl;
  bool _fetching = false;

  void setLoading(bool loading) {
    setState(() {
      _loading = loading;
    });
  }

  void setImageUrl(String? imageUrl) {
    setState(() {
      _imageUrl = imageUrl;
    });
  }

  @override
  void initState() {
    super.initState();
    nameController = TextEditingController();
    phoneController = TextEditingController();
    emailController = TextEditingController();

    fetchData();
  }

  Future<void> fetchData() async {
    setState(() {
      _fetching = true;
    });
    final user = await AccountServices().getProfle();
    setState(() {
      nameController.text = user.name;
      phoneController.text = user.phone;
      emailController.text = user.email;
      _imageUrl = user.imageUrl;
      _fetching = false;
    });
  }

  @override
  void dispose() {
    nameController.dispose();
    phoneController.dispose();
    emailController.dispose();
    super.dispose();
  }

  Future<void> handleEditProfile() async {
    String name = nameController.text;
    String phone = phoneController.text;
    String email = emailController.text;

    AccountServices().editProfile(name, phone, email, _loading, setLoading);
  }

  @override
  Widget build(BuildContext context) {
    if (_fetching) {
      return Container(
        color: Colors.white,
        child: const Center(
          child: CupertinoActivityIndicator(
            color: custom_colors.Colors.primary,
            radius: 16.0,
          ),
        ),
      );
    } else {
      return Scaffold(
        appBar: AppBar(
          title: const Center(
            child: Padding(
              padding: EdgeInsets.all(16.0),
              child: CustomText(
                text: "Pengaturan Profil",
                style: CustomTextStyle.subheading,
              ),
            ),
          ),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                ClipOval(
                  child: ProfileImage(
                    imageUrl: _imageUrl,
                    setImageUrl: setImageUrl,
                    fetchData: () => {},
                  ),
                ),
                const SizedBox(height: 40),
                buildTextField(
                  controller: nameController,
                  label: 'Nama',
                  hint: 'Masukkan nama',
                  icon: Icons.person,
                ),
                const SizedBox(height: 20),
                buildTextField(
                  controller: phoneController,
                  label: 'Nomor Telepon',
                  hint: 'Masukkan nomor telepon',
                  icon: Icons.phone,
                  keyboardType: TextInputType.phone,
                ),
                const SizedBox(height: 20),
                buildTextField(
                  controller: emailController,
                  label: 'Email',
                  hint: 'Masukkan alamat email',
                  icon: Icons.email,
                ),
                const SizedBox(height: 20),
                SizedBox(
                  width: MediaQuery.of(context).size.width,
                  child: CustomButton(
                    text: "Simpan Profil",
                    buttonType: ButtonType.fill,
                    onPressed: handleEditProfile,
                    loading: _loading,
                  ),
                ),
                const SizedBox(height: 4),
                SizedBox(
                  width: MediaQuery.of(context).size.width,
                  child: CustomButton(
                    text: "Logout",
                    buttonType: ButtonType.outline,
                    onPressed: showLogoutConfirmation,
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    }
  }

  Widget buildTextField({
    required TextEditingController controller,
    required String label,
    required String hint,
    required IconData icon,
    TextInputType keyboardType = TextInputType.text,
  }) {
    return SizedBox(
      height: 50,
      child: TextFormField(
        controller: controller,
        keyboardType: keyboardType,
        decoration: InputDecoration(
          labelText: label,
          hintText: hint,
          labelStyle: CustomTextStyle.content.style,
          hintStyle: CustomTextStyle.subtitle.style,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          prefixIcon: Icon(icon),
        ),
      ),
    );
  }

  void showLogoutConfirmation() {
    showDialog(
      context: context,
      barrierDismissible: false,
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
                AuthServices().logout(() {
                  Navigator.of(context).pushReplacement(
                    MaterialPageRoute(
                        builder: (context) => const LoginScreen()),
                  );
                });
              },
              child: const Text('Ya'),
            ),
          ],
        );
      },
    );
  }
}

class ProfileImage extends StatelessWidget {
  final String? imageUrl;
  final Function(String? imageUrl) setImageUrl;
  final Function() fetchData;

  const ProfileImage(
      {super.key,
      this.imageUrl,
      required this.setImageUrl,
      required this.fetchData});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => _showImageOptionsDialog(context),
      child: ClipOval(
        child: CachedNetworkImage(
          width: 120,
          height: 120,
          fit: BoxFit.cover,
          imageUrl: imageUrl ?? '',
          progressIndicatorBuilder: (context, url, downloadProgress) =>
              Image.asset('assets/images/profile.jpg'),
          errorWidget: (context, url, error) =>
              Image.asset('assets/images/profile.jpg'),
        ),
      ),
    );
  }

  void _showImageOptionsDialog(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Pilih Opsi Gambar'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (imageUrl != null)
                ListTile(
                  title: const Text("Hapus Gambar"),
                  onTap: () {
                    Navigator.of(context).pop();
                    AccountServices().deletePicture(setImageUrl);
                  },
                ),
              ListTile(
                title: const Text("Kamera"),
                onTap: () {
                  Navigator.of(context).pop();
                  _pickImage(ImageSource.camera, context, setImageUrl);
                },
              ),
              ListTile(
                title: const Text("Galeri"),
                onTap: () {
                  Navigator.of(context).pop();
                  _pickImage(ImageSource.gallery, context, setImageUrl);
                },
              ),
              ListTile(
                title: const Text("Batal"),
                onTap: () => Navigator.of(context).pop(),
              ),
            ],
          ),
        );
      },
    );
  }

  // Fungsi untuk memilih gambar dari galeri atau kamera
  Future<void> _pickImage(ImageSource source, BuildContext context,
      Function(String imageUrl) setImageUrl) async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: source);

    if (pickedFile != null) {
      File imageFile = File(pickedFile.path);
      AccountServices().editPicture(imageFile, setImageUrl, fetchData);
    }
  }
}
