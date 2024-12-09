import 'package:flutter/material.dart';
import 'package:laundryku/src/components/custom_button.dart';
import 'package:laundryku/src/components/custom_text.dart';
import 'package:laundryku/src/utils/colors.dart' as custom_colors;
import 'package:laundryku/src/utils/helpers.dart';
import 'package:qr_flutter/qr_flutter.dart';

class DetailHistoryScreen extends StatefulWidget {
  final String id;

  const DetailHistoryScreen({
    super.key,
    required this.id,
  });

  @override
  DetailHistoryScreenState createState() => DetailHistoryScreenState();
}

class DetailHistoryScreenState extends State<DetailHistoryScreen> {
  String statusText(status) {
    switch (status) {
      case "PENDING":
        return "Belum Dibayar";
      case "CANCELLED":
        return "Dibatalkan";
      case "EXPIRED":
        return "Kadaluarsa";
      case "PAID":
        return "Dibayar";
      default:
        return "";
    }
  }

  Color statusColor(status) {
    switch (status) {
      case "PENDING":
        return custom_colors.Colors.pending;
      case "CANCELLED":
        return custom_colors.Colors.cancelled;
      case "EXPIRED":
        return custom_colors.Colors.expired;
      case "PAID":
        return custom_colors.Colors.paid;
      default:
        return custom_colors.Colors.expired;
    }
  }

  void handlePayment() {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.id),
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
              padding:
                  const EdgeInsets.only(left: 16.0, right: 16.0, top: 16.0),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    const CustomText(
                        text: "Detail Reservasi",
                        style: CustomTextStyle.heading),
                    const SizedBox(height: 8),
                    SizedBox(
                      width: double.infinity,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Center(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                QrImageView(
                                  data: '#2c21r-125vk-1212-3531',
                                  version: QrVersions.auto,
                                  size: 200.0,
                                ),
                                const CustomText(
                                    text: "#2c21r-125vk-1212-3531",
                                    style: CustomTextStyle.light),
                              ],
                            ),
                          ),
                          const SizedBox(height: 4),
                          const CustomText(
                              text: "Reservasi Mesin Pengering 1",
                              style: CustomTextStyle.subheading2),
                          const SizedBox(height: 8),
                          Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 8, vertical: 4),
                            decoration: BoxDecoration(
                              color: statusColor("PENDING"),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Text(
                              statusText("PENDING"),
                              style: const TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w500,
                                color: Colors.white,
                                fontFamily: "Poppins",
                              ),
                            ),
                          ),
                          const SizedBox(height: 8),
                          const CustomText(
                              text: "Tanggal Reservasi:",
                              style: CustomTextStyle.content),
                          CustomText(
                              text: "Mulai :" +
                                  Helpers.getNamedDate(DateTime.now()),
                              style: CustomTextStyle.content),
                          CustomText(
                              text: "Selesai :" +
                                  Helpers.getNamedDate(DateTime.now()),
                              style: CustomTextStyle.content),
                          const SizedBox(height: 8),
                          const CustomText(
                              text: "Tanggal Checkout:",
                              style: CustomTextStyle.content),
                          CustomText(
                              text: Helpers.getNamedDate(DateTime.now()),
                              style: CustomTextStyle.content),
                          const SizedBox(height: 8),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    SizedBox(
                      width: double.infinity,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const CustomText(
                              text: "Detail Pembayaran",
                              style: CustomTextStyle.subheading2),
                          const SizedBox(height: 8),
                          CustomText(
                              text: Helpers.formatRupiah(20000),
                              style: CustomTextStyle.tab),
                          const SizedBox(height: 8),
                          const CustomText(
                              text: "Metode Pembayaran: -",
                              style: CustomTextStyle.content),
                          const SizedBox(height: 4),
                          CustomText(
                              text: "Dibayar pada: " +
                                  Helpers.getNamedDate(DateTime.now()),
                              style: CustomTextStyle.content),
                          const SizedBox(height: 8),
                        ],
                      ),
                    ),
                  ],
                ),
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
                    text: "Bayar Tagihan",
                    buttonType: ButtonType.fill,
                    onPressed: handlePayment,
                  ),
                )),
          ),
        ],
      ),
    );
  }
}
