import 'package:flutter/material.dart';
import 'package:laundryku/src/components/custom_text.dart';
import 'package:laundryku/src/utils/colors.dart' as custom_colors;
import 'package:laundryku/src/utils/helpers.dart';
import 'package:laundryku/src/utils/toast.dart';
import 'package:laundryku/src/screens/detail_history_screen.dart';

class HistoryScreen extends StatefulWidget {
  const HistoryScreen({super.key});

  @override
  State<HistoryScreen> createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen>
    with TickerProviderStateMixin {
  late final TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const CustomText(text: "Riwayat", style: CustomTextStyle.title),
        bottom: TabBar(
          controller: _tabController,
          isScrollable: true,
          labelStyle: CustomTextStyle.tab.style,          
          indicatorColor: custom_colors.Colors.primary,
          unselectedLabelStyle: CustomTextStyle.content.style,

          tabs: const <Widget>[
            Tab(
              text: "Belum Dibayar",
            ),
            Tab(
              text: "Dibatalkan",
            ),
            Tab(
              text: "Akan Datang",
            ),
            Tab(
              text: "Selesai",
            ),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: const <Widget>[
          HistoryList(),
          HistoryList(),
          HistoryList(),
          HistoryList(),
        ],
      ),
    );
  }
}

class HistoryList extends StatefulWidget {
  const HistoryList({super.key});

  @override
  State<HistoryList> createState() => _HistoryListState();
}

class _HistoryListState extends State<HistoryList> {
  @override
  Widget build(BuildContext context) {
    return const SingleChildScrollView(
        child: Padding(
      padding: EdgeInsets.symmetric(horizontal: 4.0),
      child: Column(
        children: <Widget>[
          CardHistory(
            status: "CANCELLED",
          ),
          CardHistory(
            status: "PAID",
          ),
          CardHistory(
            status: "PAID",
          ),
          CardHistory(
            status: "CANCELLED",
          ),
          CardHistory(
            status: "PENDING",
          ),
          CardHistory(
            status: "CANCELLED",
          ),
          CardHistory(
            status: "PAID",
          ),
          CardHistory(
            status: "CANCELLED",
          ),
          CardHistory(
            status: "PENDING",
          ),
        ],
      ),
    ));
  }
}

class CardHistory extends StatelessWidget {
  final String status;
  const CardHistory({super.key, required this.status});

  String statusText() {
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

  Color statusColor() {
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

  @override
  Widget build(BuildContext context) {
    void handleTap() {
      Toast().success(message: status);
      Navigator.of(context).push(
        MaterialPageRoute(
            builder: (context) => const DetailHistoryScreen(
                  reservationName: "Reservasi Mesin Pengering 1",
                )),
      );
    }

    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(12),
        clipBehavior: Clip.antiAlias,
        child: InkWell(
          onTap: handleTap,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const CustomText(
                        text: "Reservasi Mesin Pengering 1",
                        style: CustomTextStyle.subheading2,
                      ),
                      CustomText(
                        text: Helpers.getNamedDate(DateTime.now()),
                        style: CustomTextStyle.content,
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 8, vertical: 4),
                        decoration: BoxDecoration(
                          color: statusColor(),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Text(
                          statusText(),
                          style: const TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                            color: Colors.white,
                            fontFamily: "Poppins",
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.all(8),
                  child: Icon(
                    Icons.arrow_forward_ios,
                    color: custom_colors.Colors.primary,
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
