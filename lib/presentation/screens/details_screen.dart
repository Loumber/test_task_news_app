import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:shimmer/shimmer.dart';
import 'package:test_task_news_app/data/models/news_models.dart';
import 'package:test_task_news_app/domain/bloc/favorites_bloc/favorites_bloc.dart';

class DetailsScreen extends StatelessWidget {
  const DetailsScreen({super.key, required this.article});

  final Article article;

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: context.read<FavoritesBloc>()..add(FavoritesCheckRequested(article)),
      child: BlocListener<FavoritesBloc, FavoritesState>(
        listener: (context, state) {
          if (state.status == FavoritesStatus.failure) {
            showCupertinoDialog(
              context: context,
              builder:
                  (_) => CupertinoAlertDialog(
                    title: const Text('Error'),
                    content: const Text('Couldn\'t update favorites'),
                    actions: [
                      CupertinoDialogAction(
                        isDefaultAction: true,
                        child: const Text('OK'),
                        onPressed: () => Navigator.pop(context),
                      ),
                    ],
                  ),
            );
          }
        },
        child: SafeArea(
          child: CupertinoPageScaffold(
            child: Padding(
              padding: EdgeInsets.only(left: 16.w, right: 16.w, top: 20.h),
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(parent: ClampingScrollPhysics()),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding: EdgeInsets.only(top: 8.h),
                          child: GestureDetector(
                            onTap: () => context.pop(),
                            child: SvgPicture.asset(
                              'assets/icons/back_arrow.svg',
                              width: 28.w,
                              height: 24.35.h,
                              colorFilter: const ColorFilter.mode(Color(0xFF6A6A6A), BlendMode.srcIn),
                            ),
                          ),
                        ),
                        BlocBuilder<FavoritesBloc, FavoritesState>(
                          builder: (context, state) {
                            return GestureDetector(
                              onTap: () {
                                context.read<FavoritesBloc>().add(FavoritesToggleRequested(article));
                              },
                              child: SvgPicture.asset(
                                state.isFavorite ? 'assets/icons/star_filled.svg' : 'assets/icons/star_outlined.svg',
                                width: 43.w,
                                height: 41.h,
                                colorFilter: const ColorFilter.mode(Color(0xFF6A6A6A), BlendMode.srcIn),
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                    SizedBox(height: 12.h),
                    Text(
                      article.title ?? '',
                      style: TextStyle(
                        fontSize: 33,
                        fontWeight: FontWeight.w700,
                        fontFamily: 'Satoshi',
                        height: 1.1,
                      ),
                    ),
                    SizedBox(height: 6.h),
                    Text(
                      article.description ?? '',
                      style: TextStyle(
                        fontSize: 27,
                        fontWeight: FontWeight.w400,
                        fontFamily: 'Satoshi',
                        height: 1.2,
                      ),
                    ),
                    SizedBox(height: 24.h),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          article.source?.name ?? '',
                          style: TextStyle(
                            fontSize: 19,
                            fontWeight: FontWeight.w400,
                            fontFamily: 'Satoshi',
                            height: 1.2,
                          ),
                        ),
                        Text(
                          article.publishedAt != null ? DateFormat('MM.dd.yyyy').format(article.publishedAt!) : '',
                          style: TextStyle(
                            fontSize: 19,
                            fontWeight: FontWeight.w400,
                            fontFamily: 'Satoshi',
                            height: 1.2,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 10.h),
                    if (article.urlToImage != null)
                      ClipRRect(
                        borderRadius: BorderRadius.circular(27.r),
                        child: Image.network(
                          article.urlToImage!,
                          width: 328.w,
                          height: 265.h,
                          fit: BoxFit.cover,
                          loadingBuilder: (context, child, loadingProgress) {
                            if (loadingProgress == null) return child;
                            return Shimmer.fromColors(
                              baseColor: const Color(0xFFDADADA),
                              highlightColor: const Color(0xFFF5F5F5),
                              child: Container(width: 328.w, height: 265.h, color: const Color(0xFFE0E0E0)),
                            );
                          },
                          errorBuilder: (context, error, stackTrace) => const SizedBox(),
                        ),
                      ),

                    SizedBox(height: 18.h),
                    Text(
                      article.content ?? '',
                      style: TextStyle(
                        fontSize: 26,
                        fontFamily: 'Satoshi',
                        fontWeight: FontWeight.w400,
                        height: 1.2,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
