import 'package:flutter/material.dart';
import 'package:laundryku/src/components/custom_button.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:laundryku/src/components/custom_text.dart';

class MachineListScreen extends StatelessWidget {
  final String machineName;

  const MachineListScreen({
    super.key,
    required this.machineName,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(machineName),
        titleTextStyle: const TextStyle(
          color: Colors.black,
          fontSize: 18,
          fontWeight: FontWeight.bold,
          fontFamily: "Poppins",
        ),
      ),
      body: Stack(
        children: [
          // Konten utama
          SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  StaggeredGrid.count(
                    crossAxisCount: 2,
                    mainAxisSpacing: 4,
                    crossAxisSpacing: 4,
                    children: List.generate(11, (index) {
                      return StaggeredGridTile.count(
                        crossAxisCellCount: 1,
                        mainAxisCellCount: 1.2,
                        child: CardMachine(
                          isAvailable: true,
                          name: "Machine $index",
                          type: machineName == "Mesin Pencuci"
                              ? MachineType.washing
                              : MachineType.drying,
                        ),
                      );
                    }),
                  ),
                  const SizedBox(height: 100),
                ],
              ),
            ),
          ),

          // Tombol floating di bagian bawah
          Positioned(
            bottom: 16, // Jarak dari bawah layar
            left: 16, // Jarak dari sisi kiri layar
            right: 16, // Jarak dari sisi kanan layar
            child: SizedBox(
              width: double.infinity,
              child: CustomButton(
                text: "Reservasi Sekarang",
                buttonType: ButtonType.fill,
                onPressed: () {},
              ),
            ),
          ),
        ],
      ),
    );
  }
}

enum MachineType { washing, drying }

class CardMachine extends StatelessWidget {
  final MachineType type;
  final String name;
  final bool isAvailable;

  const CardMachine({
    super.key,
    required this.type,
    required this.name,
    required this.isAvailable,
  });

  @override
  Widget build(BuildContext context) {
    String assetName;
    switch (type) {
      case MachineType.washing:
        assetName = 'assets/images/washing.png';
        break;
      case MachineType.drying:
        assetName = 'assets/images/drying.png';
        break;
    }

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Image.asset(
              assetName,
              width: 100,
              height: 100,
            ),
            const SizedBox(height: 8),
            CustomText(
              text: name,
              style: CustomTextStyle.subheading,
            ),
            const SizedBox(height: 8),
            CustomText(
              text: isAvailable ? 'Tersedia' : 'Tidak Tersedia',
              style: isAvailable
                  ? CustomTextStyle.highlight
                  : CustomTextStyle.content,
            ),
          ],
        ),
      ),
    );
  }
}
