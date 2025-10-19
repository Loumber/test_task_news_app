import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';


class CustomNavBar extends StatelessWidget {
  final int currentIndex;
  final ValueChanged<int> onTap;

  const CustomNavBar({
    super.key,
    required this.currentIndex,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 322.w,
      height: 84.h,
      decoration: BoxDecoration(
        color: CupertinoColors.white,
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(color: const Color(0xFFCECECE), width: 0.5),
        boxShadow: const [
          BoxShadow(
            color: Color(0x26000000),
            blurRadius: 12,
            offset: Offset(0, 4),
            spreadRadius: -6,
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          _NavBarItem(
            index: 0,
            isActive: currentIndex == 0,
            iconPath: 'assets/icons/list.svg',
            onTap: () => onTap(0),
          ),
          _NavBarItem(
            index: 1,
            isActive: currentIndex == 1,
            iconPath: 'assets/icons/favorites.svg',
            onTap: () => onTap(1),
          ),
        ],
      ),
    );
  }
}

class _NavBarItem extends StatelessWidget {
  final int index;
  final bool isActive;
  final String iconPath;
  final VoidCallback onTap;

  const _NavBarItem({
    required this.index,
    required this.isActive,
    required this.iconPath,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.translucent,
      child: Padding(
        padding: EdgeInsets.only(top: index == 1 ? 6.h : 0),
        child: SvgPicture.asset(
          iconPath,
          width: index == 0 ? 36.w : 41.w,
          height: index == 0 ? 27.h : 33.h,
          colorFilter: ColorFilter.mode(
            isActive ? const Color(0xFF2F78FF) : const Color(0xFF6A6A6A),
            BlendMode.srcIn,
          ),
        ),
      ),
    );
  }
}
