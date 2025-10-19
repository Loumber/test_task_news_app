import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:test_task_news_app/domain/bloc/headlines_bloc/headlines_bloc.dart';
import 'package:test_task_news_app/core/constants/categories.dart';

class CategoryChips extends StatelessWidget {
  const CategoryChips({super.key});

  @override
  Widget build(BuildContext context) {
    final HeadlinesState state = context.watch<HeadlinesBloc>().state;

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      padding: const EdgeInsets.symmetric(horizontal: 12),
      child: Row(
        children: [
          for (int i = 0; i < newsCategories.length; i++)
            Padding(
              padding: EdgeInsets.only(left: i == 0 ? 19.w : 0, right: 7.w),
              child: GestureDetector(
                onTap: () => context.read<HeadlinesBloc>().add(HeadlinesCategoryChanged(newsCategories[i])),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SvgPicture.asset(
                      state.category == newsCategories[i]
                          ? categoryButtons[newsCategories[i]]!.$1
                          : categoryButtons[newsCategories[i]]!.$2,
                      width: 114.w,
                      height: 44.h,
                    ),
                  ],
                ),
              ),
            ),
        ],
      ),
    );
  }
}