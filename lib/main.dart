import 'package:flutter/material.dart';
import 'package:test_task_news_app/app.dart';
import 'package:test_task_news_app/core/di.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await configureDependencies();
  runApp(const NewsApp());
}