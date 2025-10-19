import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:test_task_news_app/domain/bloc/headlines_bloc/headlines_bloc.dart';

class SearchBar extends StatefulWidget {
  const SearchBar({super.key});

  @override
  State<SearchBar> createState() => _SearchBarState();
}

class _SearchBarState extends State<SearchBar> {
  final TextEditingController _controller = TextEditingController();
  String _lastSearchQuery = '';
  Timer? _debounce;

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _onSearchChanged(String query) {
    if (_debounce?.isActive ?? false) _debounce!.cancel();

    _debounce = Timer(const Duration(milliseconds: 500), () {
      _performSearch(query);
    });
  }

  void _performSearch(String query) {
    setState(() {
      if (query.trim().isNotEmpty && query.trim() != _lastSearchQuery) {
        _lastSearchQuery = query.trim();
        context.read<HeadlinesBloc>().add(HeadlinesSearchRequested(query.trim()));
      } else if (query.trim().isEmpty && _lastSearchQuery.isNotEmpty) {
        _lastSearchQuery = '';
        context.read<HeadlinesBloc>().add(const HeadlinesFetchRequested());
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 26.w, right: 26.w, top: 28.h),
      child: Row(
        children: [
          Expanded(
            child: CupertinoTextField(
              controller: _controller,
              prefix: SvgPicture.asset(
                'assets/icons/search.svg',
                width: 32.w,
                height: 32.h,
                colorFilter: const ColorFilter.mode(Color(0xFF6A6A6A), BlendMode.srcIn),
              ),
              decoration: BoxDecoration(color: Colors.transparent),
              style: TextStyle(
                fontSize: 30.sp,
                fontWeight: FontWeight.w500,
                fontFamily: 'Satoshi',
                color: Colors.black,
              ),
              onChanged: _onSearchChanged,
              onSubmitted: _performSearch,
            ),
          ),
        ],
      ),
    );
  }
}
