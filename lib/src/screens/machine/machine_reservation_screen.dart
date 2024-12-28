import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:laundryku/src/components/custom_button.dart';
import 'package:laundryku/src/components/custom_text.dart';
import 'package:laundryku/src/models/detail_machine.dart';
import 'package:laundryku/src/screens/detail_history_screen.dart';
import 'package:laundryku/src/screens/home/main_screen.dart';
import 'package:laundryku/src/services/machine_services.dart';
import 'package:laundryku/src/services/reservation_services.dart';
import 'package:laundryku/src/utils/colors.dart' as custom_colors;
import 'package:skeletonizer/skeletonizer.dart';

class MachineReservationScreen extends StatefulWidget {
  final String machineName;
  final int totalMachine;

  const MachineReservationScreen({
    super.key,
    required this.machineName,
    required this.totalMachine,
  });

  @override
  MachineReservationScreenState createState() =>
      MachineReservationScreenState();
}

class MachineReservationScreenState extends State<MachineReservationScreen> {
  DateTime? selectedDate;
  String? selectedMachineNumber = '1';
  String? selectedTime;
  bool _loading = true;
  bool _pending = false;

  void setPending(bool pending) {
    setState(() {
      _pending = pending;
    });
  }

  late Future<DetailMachineData> _machinesFuture;
  List<DetailMachine> _morning = [];
  List<DetailMachine> _afternoon = [];
  List<DetailMachine> _night = [];

  void afterReservation(String id) {
    Navigator.of(context)
        .push(
      MaterialPageRoute(
        builder: (context) => DetailHistoryScreen(id: id),
      ),
    )
        .then((_) {
      Navigator.of(context).pop();
    }).then((_) {
      Navigator.of(context).pop();
    });
  }

  void setLoading(bool loading) {
    setState(() {
      _loading = loading;
    });
  }

  @override
  Widget build(BuildContext context) {
    final String machineType =
        widget.machineName == "Reservasi Mesin Pencuci" ? "WASHING" : "DRYING";

    Future<void> onReservationPressed() async {
      if (selectedDate != null &&
          selectedMachineNumber != null &&
          selectedTime != null) {
        var res = await ReservationServices().checkout(
            machineType,
            selectedMachineNumber.toString(),
            selectedDate.toString(),
            selectedTime.toString(),
            _pending,
            setPending);
        if (res != null) {
          afterReservation(res);
        }
      }
    }

    Future<void> fetchData() async {
      if (selectedDate != null && selectedMachineNumber != null) {
        setLoading(true);
        _machinesFuture = MachineServices().getStatusPerMachineDate(
            machineType, selectedDate.toString(), selectedMachineNumber!);
        _machinesFuture.then((value) {
          setState(() {
            _morning = value.morning;
            _afternoon = value.afternoon;
            _night = value.night;
          });
          setLoading(false);
        });
      }
    }

    List<Widget> onLoading = List.generate(
      24,
      (index) {
        return Skeletonizer(
          enabled: _loading,
          child: ButtonTime(
            text: "00:00",
            isSelected: true, // Set this according to your logic later
            isAvailable: true,
            onPressed: () {},
          ),
        );
      },
    );

    void onPressedButtonTime(String time) {
      print("hitted");
      print(time);
      setState(() {
        selectedTime = time;
      });
    }

    List<Widget> onFetchedMorning = _morning
        .map(
          (item) => ButtonTime(
            text: item.time,
            isSelected: item.time == selectedTime,
            isAvailable: item.isAvailable,
            onPressed: () => onPressedButtonTime(item.time),
          ),
        )
        .toList();
    List<Widget> onFetchedAfternoon = _afternoon
        .map(
          (item) => ButtonTime(
            text: item.time,
            isSelected: item.time == selectedTime,
            isAvailable: item.isAvailable,
            onPressed: () => onPressedButtonTime(item.time),
          ),
        )
        .toList();
    List<Widget> onFetchedNight = _night
        .map(
          (item) => ButtonTime(
            text: item.time,
            isSelected: item.time == selectedTime,
            isAvailable: item.isAvailable,
            onPressed: () => onPressedButtonTime(item.time),
          ),
        )
        .toList();

    List<String> listMachine =
        List.generate(widget.totalMachine, (index) => (index + 1).toString());

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
          // Konten Scrollable
          SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  const CustomText(
                    text: "Pilih Nomor Mesin",
                    style: CustomTextStyle.subheading2,
                  ),
                  // DROPDOWN NO MESIN ([1,2,3,4,5])
                  DropdownButton<String>(
                    value: selectedMachineNumber,
                    onChanged: (String? newValue) {
                      setState(() {
                        selectedMachineNumber = newValue;
                        selectedTime = null;
                      });

                      fetchData();
                    },
                    items: listMachine
                        .map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text('Mesin $value'),
                      );
                    }).toList(),
                  ),
                  const SizedBox(height: 20),
                  const CustomText(
                    text: "Pilih Tanggal",
                    style: CustomTextStyle.subheading2,
                  ),
                  // DATEPICKER dan ambil VALUE dengan format YYYY-MM-DD
                  const SizedBox(height: 10),
                  GestureDetector(
                    onTap: () async {
                      DateTime? pickedDate = await showDatePicker(
                        context: context,
                        initialDate: selectedDate ?? DateTime.now(),
                        firstDate: DateTime(2020),
                        lastDate: DateTime(2101),
                      );
                      if (pickedDate != null && pickedDate != selectedDate) {
                        setState(() {
                          selectedDate = pickedDate;
                          selectedTime = null;
                        });
                        fetchData();
                      }
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 12, vertical: 10),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(color: Colors.grey),
                      ),
                      child: Row(
                        children: [
                          const Icon(Icons.calendar_today,
                              color: custom_colors.Colors.primary),
                          const SizedBox(width: 8),
                          Text(
                            selectedDate == null
                                ? 'Pilih tanggal'
                                : DateFormat('yyyy-MM-dd')
                                    .format(selectedDate!),
                            style: const TextStyle(
                                fontSize: 14, fontFamily: "Poppins"),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  const CustomText(
                    text: "Pilih Waktu",
                    style: CustomTextStyle.subheading2,
                  ),
                  const SizedBox(height: 10),
                  const CustomText(
                    text: "Pagi (03:00 - 12:00)",
                    style: CustomTextStyle.content,
                  ),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: _loading ? onLoading : onFetchedMorning,
                    ),
                  ),
                  const SizedBox(height: 5),
                  const CustomText(
                    text: "Siang (12:00 - 18:00)",
                    style: CustomTextStyle.content,
                  ),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: _loading ? onLoading : onFetchedAfternoon,
                    ),
                  ),
                  const SizedBox(height: 5),
                  const CustomText(
                    text: "Malam (18:00 - 03:00)",
                    style: CustomTextStyle.content,
                  ),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: _loading ? onLoading : onFetchedNight,
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Card(
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const CustomText(
                            text: "Reservasi",
                            style: CustomTextStyle.subheading2,
                          ),
                          const SizedBox(height: 8),
                          Row(
                            children: [
                              const Icon(
                                Icons.assignment,
                                color: custom_colors.Colors.primary,
                              ),
                              const SizedBox(width: 8),
                              CustomText(
                                text: widget.machineName,
                                style: CustomTextStyle.content,
                              ),
                            ],
                          ),
                          const SizedBox(height: 8),
                          Row(
                            children: [
                              const Icon(
                                Icons.numbers,
                                color: custom_colors.Colors.primary,
                              ),
                              const SizedBox(width: 8),
                              CustomText(
                                text: "Nomor mesin: $selectedMachineNumber",
                                style: CustomTextStyle.content,
                              ),
                            ],
                          ),
                          const SizedBox(height: 8),
                          Row(
                            children: [
                              const Icon(
                                Icons.calendar_today,
                                color: custom_colors.Colors.primary,
                              ),
                              const SizedBox(width: 8),
                              CustomText(
                                text: selectedDate == null
                                    ? 'Belum dipilih'
                                    : DateFormat('yyyy-MM-dd')
                                        .format(selectedDate!),
                                style: CustomTextStyle.content,
                              ),
                            ],
                          ),
                          const SizedBox(height: 8),
                          Row(
                            children: [
                              const Icon(
                                Icons.access_time,
                                color: custom_colors.Colors.primary,
                              ),
                              const SizedBox(width: 8),
                              CustomText(
                                text: selectedTime ?? "-",
                                style: CustomTextStyle.content,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 100),
                ],
              ),
            ),
          ),
          // Tombol fixed di bawah
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: SizedBox(
                  width: double.infinity,
                  child: CustomButton(
                    text: "Reservasi Sekarang",
                    loading: _pending,
                    buttonType: selectedDate == null || selectedTime == null
                        ? ButtonType.disabled
                        : ButtonType.fill,
                    onPressed: onReservationPressed,
                  ),
                )),
          ),
        ],
      ),
    );
  }
}

class ButtonTime extends StatelessWidget {
  final String text;
  final Function onPressed;
  final bool isSelected;
  final bool isAvailable;

  const ButtonTime({
    super.key,
    required this.text,
    required this.onPressed,
    this.isSelected = false,
    this.isAvailable = false,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 8.0),
      child: CustomButton(
        text: text,
        onPressed: isAvailable ? () => onPressed() : null,
        buttonType: !isAvailable
            ? ButtonType.disabled
            : isSelected
                ? ButtonType.fill
                : ButtonType.outline,
      ),
    );
  }
}
