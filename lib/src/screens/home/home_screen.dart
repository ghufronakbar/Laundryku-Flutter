import 'package:flutter/material.dart';
import 'package:laundryku/src/components/custom_text.dart';
import 'package:laundryku/src/models/user.dart';
import 'package:laundryku/src/screens/machine/machine_list_screen.dart';
import 'package:laundryku/src/services/account_services.dart';
import 'package:laundryku/src/utils/constants.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:laundryku/src/utils/toast.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String _name = "Loading...";
  late Future<User> _userProfileFuture;

  // Lokasi pusat untuk peta
  final String _locationUrl = "${Constants.baseUrl}/map";

  late WebViewController _webViewController;

  @override
  void initState() {
    super.initState();
    _userProfileFuture = AccountServices().getProfle();
    _userProfileFuture.then((user) {
      setState(() {
        _name = user.name;
      });
    });

    // Inisialisasi WebView
    _webViewController = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setNavigationDelegate(
        NavigationDelegate(
          onProgress: (int progress) {
            // Update loading bar.
          },
          onPageStarted: (String url) {},
          onPageFinished: (String url) {},
          onHttpError: (HttpResponseError error) {},
          onWebResourceError: (WebResourceError error) {},
          onNavigationRequest: (NavigationRequest request) {
            if (request.url.startsWith(_locationUrl)) {
              return NavigationDecision.prevent;
            }
            return NavigationDecision.navigate;
          },
        ),
      )
      ..loadRequest(Uri.parse(_locationUrl));
  }

  // Fungsi untuk membuka URL di browser
  void _openUrl(String url) async {
    if (await canLaunchUrl(Uri.parse(url))) {
      await launchUrl(Uri.parse(url));
    } else {
      Toast().err(message: "Tidak dapat membuka peta");
      throw 'Tidak dapat membuka $url';
    }
  }

  String getGreeting() {
    var hour = DateTime.now().hour;
    if (hour < 12) {
      return 'Selamat Pagi,';
    } else if (hour < 15) {
      return 'Selamat Siang,';
    } else if (hour < 18) {
      return 'Selamat Sore,';
    } else {
      return 'Selamat Malam,';
    }
  }

  void onGoMachine(String machineName) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => MachineListScreen(
          machineName: machineName,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 30),
              CustomText(text: getGreeting(), style: CustomTextStyle.heading),
              CustomText(text: _name, style: CustomTextStyle.heading),
              const SizedBox(height: 10),
              ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: Center(
                  child: Image.asset(
                    'assets/images/banner.png',
                    width: double.infinity,
                  ),
                ),
              ),
              const SizedBox(height: 30),
              const CustomText(
                  text: "Pilih Mesin", style: CustomTextStyle.heading),
              const SizedBox(height: 12),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  GestureDetector(
                    onTap: () => onGoMachine("Mesin Pencuci"),
                    child: Card(
                      color: Colors.white,
                      elevation: 8,
                      child: SizedBox(
                        width: screenWidth * 0.40,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(children: [
                            Image.asset(
                              "assets/images/washing.png",
                              width: screenWidth * 0.40,
                            ),
                            const CustomText(
                                text: "Pencuci",
                                style: CustomTextStyle.subheading),
                          ]),
                        ),
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () => onGoMachine("Mesin Pengering"),
                    child: Card(
                      color: Colors.white,
                      elevation: 8,
                      child: SizedBox(
                        width: screenWidth * 0.40,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(children: [
                            Image.asset(
                              "assets/images/drying.png",
                              width: screenWidth * 0.40,
                            ),
                            const CustomText(
                                text: "Pengering",
                                style: CustomTextStyle.subheading),
                          ]),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              const CustomText(
                  text: "Lihat Lokasi", style: CustomTextStyle.heading),
              SizedBox(
                height: 250, // Atur ukuran peta
                width: double.infinity,
                child: Stack(
                  children: [
                    WebViewWidget(
                      controller: _webViewController,
                    ),
                    Positioned.fill(
                      child: GestureDetector(
                        onTap: () => _openUrl(Constants.mapUrl), // Menangani klik untuk membuka URL
                        child: Container(
                          color: Colors.transparent,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
