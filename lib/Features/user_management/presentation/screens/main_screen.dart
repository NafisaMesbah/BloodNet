import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import '../../../../util/appstyles.dart';
import '../widgets/main_drawer.dart';

class MainScreen extends ConsumerWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Blood Net',
          style: Appstyles.headingTextStyle,
        ), //Text
      ), // AppBar
      drawer: const MainDrawer(),
    ); // Scaffold
  }
}

// ignore this comment , wrote to fix the commit issue
