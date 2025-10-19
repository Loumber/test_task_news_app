import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:go_router/go_router.dart';

import 'package:test_task_news_app/presentation/widgets/custom_nav_bar.dart';



class HomeScreen extends StatelessWidget {
  final StatefulNavigationShell navigationShell;

  const HomeScreen({super.key, required this.navigationShell});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: navigationShell, 
      bottomNavigationBar: Padding(
        padding: EdgeInsets.only(bottom: 20.h, left: 19.w, right: 19.w),
        child: CustomNavBar(
          currentIndex: navigationShell.currentIndex,
          onTap: (index) => navigationShell.goBranch(index),
        ),
      ),
    );
  }
}
