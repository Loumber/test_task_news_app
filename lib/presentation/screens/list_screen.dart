import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:test_task_news_app/core/di.dart';
import 'package:test_task_news_app/domain/bloc/headlines_bloc/headlines_bloc.dart';
import 'package:test_task_news_app/domain/repositories/news_repository.dart';
import 'package:test_task_news_app/presentation/widgets/articles_list.dart';
import 'package:test_task_news_app/presentation/widgets/category_chips.dart';
import 'package:test_task_news_app/presentation/widgets/search_bar.dart';

class ListScreen extends StatelessWidget {
  const ListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => HeadlinesBloc(serviceLocator<INewsRepository>())..add(const HeadlinesFetchRequested()),
      child: CupertinoPageScaffold(
        child: SafeArea(
          bottom: false,
          child: Column(
            children: <Widget>[
              const SearchBar(),
              SizedBox(height: 34.h),
              const CategoryChips(),
              SizedBox(height: 22.h),
              Expanded(child: ArticlesList()),
            ],
          ),
        ),
      ),
    );
  }
}
