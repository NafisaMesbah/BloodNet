import 'package:bloodnet/common_widgets/async_value_ui.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import '../../../../common_widgets/async_value_widget.dart';
import '../../../../util/appstyles.dart';
import '../../../authentication/domain/app_user.dart';
import '../../data/firestore_repository.dart';
import '../widgets/main_drawer.dart';
import '../widgets/user_item.dart';

class MainScreen extends ConsumerWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {

    final donorsAsyncValue = ref.watch(loadDonorsProvider);

    ref.listen<AsyncValue>(loadDonorsProvider, (_, state) {
      state.showAlertDialogOnError(context);
    });

    return Scaffold(
      appBar: AppBar(
        title:  Text(
          'Blood Donation',
          style: Appstyles.headingTextStyle,
        ), //Text
      ), // AppBar
      drawer: const MainDrawer(),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(children: [
          Expanded(
            child: AsyncValueWidget<List<AppUser>>(
              value: donorsAsyncValue,
              data: (donors) {
                return donors.isEmpty
                    ? const Center(
                  child: Text('No Donors yet!'),
                ) // Center
                    : ListView.builder(
                  itemCount: donors.length,
                  itemBuilder: (ctx, index) {
                    return UserItem(donors[index]);
                  },
                ); // ListView.builder
              },
            ), // AsyncValueWidget
          ), //Expanded

        ],),
      ),
    ); // Scaffold
  }
}


// ignore this comment , wrote to fix the commit issue
