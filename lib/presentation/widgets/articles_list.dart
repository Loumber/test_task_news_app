import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:test_task_news_app/domain/bloc/headlines_bloc/headlines_bloc.dart';
import 'package:test_task_news_app/presentation/widgets/article_card.dart';

class ArticlesList extends StatefulWidget {
  const ArticlesList({super.key});

  @override
  State<ArticlesList> createState() => _ArticlesListState();
}

class _ArticlesListState extends State<ArticlesList> {
  final _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();

    _scrollController.addListener(() {
      final bloc = context.read<HeadlinesBloc>();
      if (_scrollController.position.maxScrollExtent - _scrollController.position.pixels <= 300) {
        bloc.add(const HeadlinesFetchMoreRequested());
      }
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HeadlinesBloc, HeadlinesState>(
      builder: (context, state) {
        if (state.status == HeadlinesStatus.loading) {
          return const Center(child: CupertinoActivityIndicator());
        }
        if (state.status == HeadlinesStatus.failure) {
          return Center(child: Text(state.errorMessage ?? 'Error'));
        }
        if (state.articles.isEmpty) {
          return const Center(child: Text('No results'));
        }

        return CupertinoScrollbar(
          child: CustomScrollView(
            controller: _scrollController,
            slivers: [
              CupertinoSliverRefreshControl(
                onRefresh: () async => context.read<HeadlinesBloc>().add(const HeadlinesRefreshRequested()),
              ),
              SliverList(
                delegate: SliverChildBuilderDelegate(
                  (context, index) {
                    if (index == state.articles.length) {
                      return const Padding(
                        padding: EdgeInsets.all(16),
                        child: CupertinoActivityIndicator(),
                      );
                    }

                    final article = state.articles[index];
                    return Padding(
                      padding: EdgeInsets.only(left: 19.w, right: 19.w, bottom: 16.h),
                      child: GestureDetector(
                        onTap: () => context.push('/news/details', extra: article),
                        child: ArticleCard(article: article, isFavorite: false),
                      ),
                    );
                  },
                  childCount: state.status == HeadlinesStatus.loadingMore
                      ? state.articles.length + 1
                      : state.articles.length,
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

