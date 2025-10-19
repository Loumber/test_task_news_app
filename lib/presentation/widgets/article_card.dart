import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:shimmer/shimmer.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:test_task_news_app/data/models/news_models.dart';
import 'package:test_task_news_app/domain/bloc/favorites_bloc/favorites_bloc.dart';

class ArticleCard extends StatefulWidget {
  const ArticleCard({
    super.key,
    required this.isFavorite,
    required this.article,
  });

  final Article article;
  final bool isFavorite;

  @override
  State<ArticleCard> createState() => _ArticleCardState();
}

class _ArticleCardState extends State<ArticleCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 322.w,
      height: 114.h,
      decoration: BoxDecoration(
        color: CupertinoColors.white,
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(color: const Color(0xFFCECECE), width: 0.5),
        boxShadow: const [BoxShadow(color: Color(0x1A000000), blurRadius: 12, offset: Offset(0, 4), spreadRadius: -6)],
      ),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.only(topLeft: Radius.circular(16.r), bottomLeft: Radius.circular(16.r)),
            child:
                widget.article.urlToImage == null
                    ? SizedBox(width: 123.w, height: 112.h)
                    : Image.network(
                      widget.article.urlToImage!,
                      width: 123.w,
                      height: 112.h,
                      fit: BoxFit.cover,
                      loadingBuilder: (BuildContext context, Widget child, ImageChunkEvent? loadingProgress) {
                        if (loadingProgress == null) return child;
                        return Shimmer.fromColors(
                          baseColor: const Color.fromARGB(255, 218, 218, 218),
                          highlightColor: const Color(0xFFF5F5F5),
                          child: Container(width: 123.w, height: 112.h, color: const Color(0xFFE0E0E0)),
                        );
                      },
                      errorBuilder: (BuildContext context, Object error, StackTrace? stackTrace) {
                        return Container(
                          width: 123.w,
                          height: 112.h,
                          color: const Color(0xFFEFEFEF),
                          alignment: Alignment.center,
                          child: Icon(CupertinoIcons.photo, color: const Color.fromARGB(0, 0, 0, 0), size: 28.w),
                        );
                      },
                    ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(top: 5, left: 12, right: 11),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.max,
                children: [
                  if (widget.isFavorite) ...[
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            widget.article.title ?? '',
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1,
                            style: TextStyle(fontSize: 24, fontWeight: FontWeight.w700, fontFamily: 'Satoshi'),
                          ),
                        ),
                        BlocBuilder<FavoritesBloc, FavoritesState>(
                          builder: (context, state) {
                            return GestureDetector(
                              onTap: () {
                                context.read<FavoritesBloc>().add(FavoritesToggleRequested(widget.article));
                              },
                              child: SvgPicture.asset(
                                'assets/icons/star_filled.svg',
                                width: 33.w,
                                height: 32.h,
                                colorFilter: const ColorFilter.mode(Color(0xFF6A6A6A), BlendMode.srcIn),
                              ),
                            );
                          },
                        )
                      ],
                    ),
                  ] else ...[
                    Text(
                      widget.article.title ?? '',
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                      style: TextStyle(fontSize: 24, fontWeight: FontWeight.w700, fontFamily: 'Satoshi'),
                    ),
                  ],
                  Text(
                    widget.article.description ?? '',
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                    style: TextStyle(fontSize: 19, fontWeight: FontWeight.w400, fontFamily: 'Satoshi'),
                  ),
                  Spacer(),
                  Align(
                    alignment: Alignment.centerRight,
                    child: Padding(
                      padding: EdgeInsets.only(right: 11.w, bottom: 6.h),
                      child: Text(
                        widget.article.publishedAt != null ? DateFormat('MM.dd.yyyy').format(widget.article.publishedAt!) : '',
                        style: const TextStyle(fontSize: 17, fontFamily: 'Satoshi', fontWeight: FontWeight.w400),
                      ),
                    ),
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
