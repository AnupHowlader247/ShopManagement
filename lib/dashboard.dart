import 'package:flutter/material.dart';
import 'package:shomvob/Constant/appbar.dart';
import 'package:shomvob/Widget/top_selling.dart';
import 'Constant/color.dart';
import 'Widget/header_card.dart';
import 'Widget/monthly_sell.dart';
import 'Widget/today_selling.dart';



class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});
  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {


  final int dailyTarget = 50000;
  final int todaysSell = 20000;
  late final double progress;



  @override
  void initState() {
    super.initState();
    progress = (todaysSell / dailyTarget).clamp(0, 1).toDouble();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.kBg,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildTopBar(),
              const SizedBox(height: 14),
              HeaderCard(),
              const SizedBox(height: 30),
              TodaySelling(),
              const SizedBox(height: 30),
              TopSellingPage(),
              const SizedBox(height: 30),
              MonthlySell(),
              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }



  Widget _buildTopBar() {
    return Column(
      children: [
        Row(
          children: [
            Container(
                width: 26, height: 26,
                decoration: const BoxDecoration(
                    shape: BoxShape.circle, color: AppColors.kAccent),
                child:  ImageIcon(AssetImage("assets/dashboard/logo.png"))

            ),
            const SizedBox(width: 8),
            Text("shombhob.com",
                style: TextStyle(color: AppColors.kTextMuted,
                    fontSize: 14,
                    fontWeight: FontWeight.w600)),
          ],
        ),

        Appbar(title: "Dashboard",isnotificaion: true, isback: false,)

      ],
    );
  }

}


