import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:laundryku/src/components/custom_button.dart';
import 'package:laundryku/src/components/custom_text.dart';
import 'package:laundryku/src/models/detail_reservation.dart';
import 'package:laundryku/src/screens/payment_screen.dart';
import 'package:laundryku/src/services/reservation_services.dart';
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
  late Future<DetailReservation?> _detailReservationFuture;
  DetailReservation? _data;
  bool _loading = false;

  void setLoading(bool loading) => setState(() => _loading = loading);

  Future<void> fetchData() async {
    _detailReservationFuture =
        ReservationServices().getDetailHistory(widget.id);
    _detailReservationFuture.then((value) {
      setState(() {
        _data = value;
      });
    });
  }

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  String statusText(String? status) {
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

  Color statusColor(String? status) {
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
        return const Color(0xFFE5E5E5);
    }
  }

  void handlePayment() {
    if (_data?.directUrl != null && _data?.snapToken != null) {
      Navigator.of(context).push(
        MaterialPageRoute(
            builder: (context) => PaymentScreen(
                  directUrl: _data!.directUrl,
                  snapToken: _data!.snapToken,
                )),
      );
    }
  }

  Future<void> cancelPayment() async {
    await ReservationServices()
        .cancelReservation(widget.id, _loading, setLoading, fetchData);
  }

  @override
  Widget build(BuildContext context) {
    bool isShowButton = _data?.customStatus == "UNPAID";
    if (_data == null) {
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
          title: const CustomText(
              text: "Detail Reservasi", style: CustomTextStyle.subheading),
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
                                    data: widget.id,
                                    version: QrVersions.auto,
                                    size: 200.0,
                                  ),
                                  CustomText(
                                      text: widget.id,
                                      style: CustomTextStyle.light),
                                ],
                              ),
                            ),
                            const SizedBox(height: 8),
                            CustomText(
                                text: _data?.title ?? "",
                                style: CustomTextStyle.subheading2),
                            const SizedBox(height: 8),
                            Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 8, vertical: 4),
                              decoration: BoxDecoration(
                                color: statusColor(_data?.status),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Text(
                                statusText(_data?.status),
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
                                text:
                                    "Mulai : ${Helpers.getNamedDate(_data?.reservationDate)}",
                                style: CustomTextStyle.content),
                            CustomText(
                                text:
                                    "Selesai : ${Helpers.getNamedDate(_data?.reservationEnd)}",
                                style: CustomTextStyle.content),
                            const SizedBox(height: 8),
                            const CustomText(
                                text: "Tanggal Checkout:",
                                style: CustomTextStyle.content),
                            CustomText(
                                text: Helpers.getNamedDate(_data?.paidAt),
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
                            CustomText(
                                text:
                                    "Metode Pembayaran: ${_data?.paymentMethod ?? "-"}",
                                style: CustomTextStyle.content),
                            const SizedBox(height: 4),
                            CustomText(
                                text:
                                    "Dibayar pada: ${Helpers.getNamedDate(_data?.paidAt)}",
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

            isShowButton
                ? Align(
                    alignment: Alignment.bottomCenter,
                    child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            SizedBox(
                              width: double.infinity,
                              child: CustomButton(
                                text: "Batalkan Reservasi",
                                buttonType: ButtonType.outline,
                                onPressed: cancelPayment,
                                loading: _loading,
                              ),
                            ),
                            SizedBox(
                              width: double.infinity,
                              child: CustomButton(
                                text: "Bayar Tagihan",
                                buttonType: ButtonType.fill,
                                onPressed: handlePayment,
                              ),
                            ),
                          ],
                        )),
                  )
                : const SizedBox(),
          ],
        ),
      );
    }
  }
}
