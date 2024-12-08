import 'package:flutter/material.dart';
import 'package:intl/intl.dart'; // Untuk memformat tanggal
import 'package:laundryku/src/components/custom_button.dart';
import 'package:laundryku/src/components/custom_text.dart';
import 'package:laundryku/src/utils/colors.dart' as custom_colors;

class MachineReservationScreen extends StatefulWidget {
  final String machineName;

  const MachineReservationScreen({
    super.key,
    required this.machineName,
  });

  @override
  MachineReservationScreenState createState() =>
      MachineReservationScreenState();
}

class MachineReservationScreenState extends State<MachineReservationScreen> {
  // Variabel untuk menyimpan tanggal yang dipilih
  DateTime? selectedDate;

  // Variabel untuk menyimpan pilihan dropdown
  String? selectedMachineNumber = '1'; // Default mesin nomor 1

  @override
  Widget build(BuildContext context) {
    final String machineType =
        widget.machineName == "Reservasi Mesin Pencuci" ? "MACHINE" : "DRYING";

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
                      });
                    },
                    items: ['1', '2', '3', '4', '5']
                        .map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text('Mesin $value'),
                      );
                    }).toList(),
                  ),
                  const SizedBox(height: 20),
                  const CustomText(
                    text: "Pilih tanggal",
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
                        });
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
                      children: List.generate(
                        24,
                        (index) => const ButtonTime(
                          text: "22:30",
                          isSelected: true,
                          isAvailable: true,
                        ),
                      ),
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
                      children: List.generate(
                        24,
                        (index) => const ButtonTime(
                          text: "22:00",
                          isSelected: false,
                          isAvailable: true,
                        ),
                      ),
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
                      children: List.generate(
                        24,
                        (index) => const ButtonTime(
                          text: "22:00",
                          isSelected: false,
                          isAvailable: false,
                        ),
                      ),
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
                                text: selectedDate.toString(),
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
                    buttonType: ButtonType.fill,
                    onPressed: () {
                      // Logic untuk tombol reservasi
                    },
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
  final VoidCallback? onPressed;
  final bool isSelected;
  final bool isAvailable;

  const ButtonTime(
      {super.key,
      required this.text,
      this.onPressed,
      this.isSelected = false,
      this.isAvailable = false});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: isAvailable ? onPressed : null,
      child: Padding(
        padding: const EdgeInsets.only(right: 8.0),
        child: CustomButton(
          text: text,
          buttonType: !isAvailable
              ? ButtonType.disabled
              : isSelected
                  ? ButtonType.fill
                  : ButtonType.outline,
        ),
      ),
    );
  }
}
