import 'package:flutter/material.dart';
import 'package:laundryku/src/components/custom_text.dart';
import 'package:laundryku/src/services/reservation_services.dart';
import 'package:laundryku/src/utils/colors.dart' as custom_colors;
import 'package:laundryku/src/utils/helpers.dart';
import 'package:laundryku/src/screens/detail_history_screen.dart';
import 'package:laundryku/src/models/reservation.dart';
import 'package:skeletonizer/skeletonizer.dart';

class HistoryScreen extends StatefulWidget {
  const HistoryScreen({super.key});

  @override
  State<HistoryScreen> createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen>
    with TickerProviderStateMixin {
  late final TabController _tabController;
  late List<Reservation> _unpaid = [];
  late List<Reservation> _cancelled = [];
  late List<Reservation> _onGoing = [];
  late List<Reservation> _completed = [];
  bool _loading = true;

  void setLoading(bool loading) => setState(() => _loading = loading);

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
    fetchData();
  }

  Future<void> fetchData() async {
    setLoading(true);
    final reservationData = await ReservationServices().getHistories();
    setState(() {
      _unpaid = reservationData.unpaid;
      _cancelled = reservationData.cancelled;
      _onGoing = reservationData.onGoing;
      _completed = reservationData.completed;
    });
    setLoading(false);
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
        title: const Center(
          child: CustomText(text: "Riwayat", style: CustomTextStyle.subheading),
        ),
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
        children: <Widget>[
          RefreshableHistoryList(
            reservations: _unpaid,
            loading: _loading,
            onRefresh: fetchData,
          ),
          RefreshableHistoryList(
            reservations: _cancelled,
            loading: _loading,
            onRefresh: fetchData,
          ),
          RefreshableHistoryList(
            reservations: _onGoing,
            loading: _loading,
            onRefresh: fetchData,
          ),
          RefreshableHistoryList(
            reservations: _completed,
            loading: _loading,
            onRefresh: fetchData,
          ),
        ],
      ),
    );
  }
}

class HistoryList extends StatelessWidget {
  final List<Reservation> reservations;
  final bool loading;

  const HistoryList(
      {super.key, required this.reservations, required this.loading});

  @override
  Widget build(BuildContext context) {
    if (loading) {
      return ListView.builder(
        padding: const EdgeInsets.symmetric(horizontal: 4.0),
        itemCount: 10,
        itemBuilder: (context, index) {
          return const Skeletonizer(
            enabled: true,
            child: CardHistory(
              id: "",
              status: "            ",
              title: "Reservasi Mesin Cuci Pengering",
              date: "2020-01-01T00:00:00.000Z",
            ),
          );
        },
      );
    } else if (reservations.isEmpty) {
      return const Center(
        child: CustomText(
          text: "Tidak ada data ditemukan",
          style: CustomTextStyle.content,
        ),
      );
    } else {
      return SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 4.0),
          child: Column(
            children: reservations
                .map((reservation) => CardHistory(
                      id: reservation.id,
                      status: reservation.status,
                      title: reservation.title,
                      date: reservation.reservationDate.toString(),
                    ))
                .toList(),
          ),
        ),
      );
    }
  }
}

class CardHistory extends StatelessWidget {
  final String id;
  final String title;
  final String status;
  final String date;

  const CardHistory(
      {super.key,
      required this.id,
      required this.title,
      required this.status,
      required this.date});

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
        return status;
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
        return const Color(0xFFE5E5E5);
    }
  }

  @override
  Widget build(BuildContext context) {
    void handleTap() {
      Navigator.of(context).push(
        MaterialPageRoute(
            builder: (context) => DetailHistoryScreen(
                  id: id,
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
                      CustomText(
                        text: title,
                        style: CustomTextStyle.subheading2,
                      ),
                      CustomText(
                        text: Helpers.getNamedDate(date),
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
                    color: Colors.black,
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

class RefreshableHistoryList extends StatelessWidget {
  final List<Reservation> reservations;
  final bool loading;
  final Future<void> Function() onRefresh;

  const RefreshableHistoryList({
    super.key,
    required this.reservations,
    required this.loading,
    required this.onRefresh,
  });

  @override
  Widget build(BuildContext context) {
    if (loading) {
      return ListView.builder(
        padding: const EdgeInsets.symmetric(horizontal: 4.0),
        itemCount: 10,
        itemBuilder: (context, index) {
          return const Skeletonizer(
            enabled: true,
            child: CardHistory(
              id: "",
              status: "            ",
              title: "Reservasi Mesin Cuci Pengering",
              date: "2020-01-01T00:00:00.000Z",
            ),
          );
        },
      );
    }
    return RefreshIndicator(
      onRefresh: onRefresh,
      child: reservations.isEmpty
          ? ListView(
              physics: const AlwaysScrollableScrollPhysics(),
              children: const [
                SizedBox(height: 100),
                Center(
                  child: Padding(
                    padding: EdgeInsets.all(16.0),
                    child: CustomText(
                      text: "Tidak ada data ditemukan",
                      style: CustomTextStyle.content,
                    ),
                  ),
                ),
              ],
            )
          : ListView.builder(
              physics: const AlwaysScrollableScrollPhysics(),
              padding: const EdgeInsets.symmetric(horizontal: 4.0),
              itemCount: reservations.length,
              itemBuilder: (context, index) {
                return CardHistory(
                  id: reservations[index].id,
                  status: reservations[index].status,
                  title: reservations[index].title,
                  date: reservations[index].reservationDate.toString(),
                );
              },
            ),
    );
  }
}
