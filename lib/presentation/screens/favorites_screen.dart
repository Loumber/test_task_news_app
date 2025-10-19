import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:test_task_news_app/data/models/news_models.dart';
import 'package:test_task_news_app/domain/bloc/favorites_bloc/favorites_bloc.dart';
import 'package:test_task_news_app/presentation/widgets/article_card.dart';

class FavoritesScreen extends StatelessWidget {
  const FavoritesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<FavoritesBloc, FavoritesState>(
      listener: (context, state) {
        if (state.status == FavoritesStatus.failure) {}
      },
      child: CupertinoPageScaffold(
        child: SafeArea(
          bottom: false,
          child: Padding(
            padding: EdgeInsets.only(top: 109.h),
            child: Column(
              children: [
                Expanded(
                  child: BlocBuilder<FavoritesBloc, FavoritesState>(
                    builder: (context, state) {
                      if (state.status == FavoritesStatus.loading) {
                        return const Center(child: CupertinoActivityIndicator());
                      }

                      if (state.status == FavoritesStatus.failure) {
                        return Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'Error loading favorites',
                                style: TextStyle(fontSize: 18.sp, fontFamily: 'Satoshi', color: Colors.red),
                              ),
                              SizedBox(height: 16.h),
                              CupertinoButton(
                                onPressed: () {
                                  context.read<FavoritesBloc>().add(const FavoritesLoadRequested());
                                },
                                child: const Text('Retry'),
                              ),
                            ],
                          ),
                        );
                      }

                      if (state.articles.isEmpty) {
                        return Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'No favorites yet',
                                style: TextStyle(
                                  fontSize: 24.sp,
                                  fontWeight: FontWeight.w600,
                                  fontFamily: 'Satoshi',
                                  color: const Color(0xFF6A6A6A),
                                ),
                              ),
                              SizedBox(height: 8.h),
                              Text(
                                'Add articles to favorites to see them here',
                                style: TextStyle(
                                  fontSize: 16.sp,
                                  fontFamily: 'Satoshi',
                                  color: const Color(0xFF6A6A6A),
                                ),
                              ),
                            ],
                          ),
                        );
                      }

                      return ListView.builder(
                        padding: EdgeInsets.symmetric(horizontal: 16.w),
                        itemCount: state.articles.length,
                        itemBuilder: (context, index) {
                          final Article article = state.articles[index];
                          return Padding(
                            padding: EdgeInsets.only(bottom: 16.h),
                            child: GestureDetector(
                              onTap: () {
                                context.push('/favorites/details', extra: article);
                              },
                              child: ArticleCard(
                                isFavorite: true,
                                article: article,
                              ),
                            ),
                          );
                        },
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
