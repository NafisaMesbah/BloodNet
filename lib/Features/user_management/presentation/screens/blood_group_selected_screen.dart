import 'package:bloodnet/Features/user_management/data/firestore_repository.dart';
import 'package:bloodnet/common_widgets/async_value_ui.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';

import '../../../../common_widgets/async_value_widget.dart';
import '../../../../util/appstyles.dart';
import '../../../../util/size_config.dart';
import '../../../authentication/domain/app_user.dart';
import '../widgets/user_item.dart';


class BloodGroupSelectedScreen extends ConsumerWidget {
  const BloodGroupSelectedScreen(this.bloodGroup,{super.key});

  final String bloodGroup;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    SizeConfig.init(context);

    final donorsAsyncValue = ref.watch(loadSpecificBloodGroupDonorsProvider(bloodGroup));
    ref.listen<AsyncValue>(loadSpecificBloodGroupDonorsProvider(bloodGroup), (_, state){
      state.showAlertDialogOnError(context);
    });

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Same Blood Group As Me',
          style: Appstyles.titleTextStyle,
        ), // Text
      ), // AppBar
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