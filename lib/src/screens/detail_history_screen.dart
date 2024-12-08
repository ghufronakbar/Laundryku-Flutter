import 'package:flutter/material.dart';
import 'package:laundryku/src/components/custom_button.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:laundryku/src/components/custom_text.dart';
import 'package:laundryku/src/screens/machine/machine_reservation_screen.dart';

class DetailHistoryScreen extends StatefulWidget {
  final String reservationName;

  const DetailHistoryScreen({
    super.key,
    required this.reservationName,
  });

  @override
  DetailHistoryScreenState createState() => DetailHistoryScreenState();
}

class DetailHistoryScreenState extends State<DetailHistoryScreen> {
  // Fungsi untuk navigasi ke halaman reservasi
  void onGoReservation() {
    
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.reservationName),
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
                        mainAxisCellCount: 1.15,
                        child: CardMachine(
                          isAvailable: true,
                          name: "Machine ${index + 1}",
                          type: widget.reservationName == "Mesin Pencuci"
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

          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: SizedBox(
                  width: double.infinity,
                  child: CustomButton(
                    text: "Reservasi Sekarang",
                    buttonType: ButtonType.fill,
                    onPressed: onGoReservation,
                  ),
                )),
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
              style: CustomTextStyle.subheading2,
            ),
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
