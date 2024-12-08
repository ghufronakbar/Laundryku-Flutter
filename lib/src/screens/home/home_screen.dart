import 'package:flutter/material.dart';
import 'package:laundryku/src/components/custom_text.dart';
import 'package:laundryku/src/screens/machine/machine_list_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final String _name = "Rena";

  String getGreeting() {
    var hour = DateTime.now().hour;
    if (hour < 12) {
      return 'Selamat Pagi, $_name';
    } else if (hour < 15) {
      return 'Selamat Siang, $_name';
    } else if (hour < 18) {
      return 'Selamat Sore, $_name';
    } else {
      return 'Selamat Malam, $_name';
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
      appBar: AppBar(
        title: CustomText(text: getGreeting(), style: CustomTextStyle.title),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
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
                          )),
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
                          )),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
