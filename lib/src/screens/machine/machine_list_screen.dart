import 'package:flutter/material.dart';
import 'package:laundryku/src/components/custom_button.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:laundryku/src/components/custom_text.dart';
import 'package:laundryku/src/models/machine.dart';
import 'package:laundryku/src/screens/machine/machine_reservation_screen.dart';
import 'package:laundryku/src/services/machine_services.dart';
import 'package:skeletonizer/skeletonizer.dart';

class MachineListScreen extends StatefulWidget {
  final String machineName;

  const MachineListScreen({
    super.key,
    required this.machineName,
  });

  @override
  MachineListScreenState createState() => MachineListScreenState();
}

class MachineListScreenState extends State<MachineListScreen> {
  bool _loading = true;

  late Future<MachineData> _machinesFuture;

  List<Machine> _data = [];

  bool isWashingMachine = false;

  @override
  void initState() {
    super.initState();
    isWashingMachine = widget.machineName == "Mesin Pencuci";
    fetchData();
  }

  Future<void> fetchData() async {
    _machinesFuture = MachineServices().getStatusMachine();
    _machinesFuture.then((value) {
      setState(() {
        _data = isWashingMachine ? value.washingMachines : value.dryingMachines;
        _loading = false;
      });
    });
  }

  void onGoReservation() {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => MachineReservationScreen(
          machineName: 'Reservasi ${widget.machineName}',
          totalMachine: _data.length,
        ),
      ),
    );
  }

  List<Widget> onLoading() {
    return List.generate(11, (index) {
      return StaggeredGridTile.count(
        crossAxisCellCount: 1,
        mainAxisCellCount: 1.15,
        child: Skeletonizer(
          enabled: true,
          child: CardMachine(
            isAvailable: true,
            name: "Machine ${index + 1}",
            type: widget.machineName == "Mesin Pencuci"
                ? MachineType.washing
                : MachineType.drying,
          ),
        ),
      );
    });
  }

  List<Widget> onFetched() {
    return _data
        .map((item) => StaggeredGridTile.count(
              crossAxisCellCount: 1,
              mainAxisCellCount: 1.15,
              child: CardMachine(
                isAvailable: item.isAvailable,
                name: item.name,
                type: widget.machineName == "Mesin Pencuci"
                    ? MachineType.washing
                    : MachineType.drying,
              ),
            ))
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.machineName),
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
                    children: _loading ? onLoading() : onFetched(),
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
