import 'package:bloodnet/common_widgets/async_value_ui.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';

import '../../../../common_widgets/async_value_widget.dart';
import '../../../../util/appstyles.dart';
import '../../../authentication/data/auth_repository.dart';
import '../../../authentication/domain/app_user.dart';
import '../../data/firestore_repository.dart';

class UsersEmailedScreen extends ConsumerWidget {
  const UsersEmailedScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {

    final userId = ref.watch(currentUserProvider)!.uid;
    final emailedAsyncValue =
    ref.watch(loadEmailedUserIdsProvider(userId));
    ref.listen<AsyncValue>(loadEmailedUserIdsProvider(userId), (_, state){
      state.showAlertDialogOnError(context);
    }
    );
    return Scaffold(
      appBar: AppBar(
        title:  Text(
          'Emailed Users',
          style: Appstyles.headingTextStyle,
        ), // Text
      ), // AppBar
      body: AsyncValueWidget<List<String>>(
        value: emailedAsyncValue,
        data: (idList) {
          return idList.isEmpty
              ? const Center(child: Text('No one emailed yet'))
              : ListView.builder(
            itemCount: idList.length,
            itemBuilder: (ctx, index) {
              final uId = idList[index];
              final userDataAsync =
              ref.watch(loadUserInformationProvider(uId));
              return AsyncValueWidget<AppUser>(
                  value: userDataAsync,
                  data: (userData) {
                    return ListTile(
                        title: Text(userData.name),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(userData.email),
                            Text('Blood Group: ${userData.bloodGroup}'),
                          ],
                        ), // Column
                        leading: userData.type == 'Donor'
                            ? Image.asset('assets/donor.png',
                            width: 50, height: 50) // Image.asset
                            : Image.asset('assets/recipient.png',
                    height: 50, width: 50), // Image.asset
                    trailing: Text(
                    userData.type,
                    style: Appstyles.normalTextStyle
                        .copyWith(color: Colors.black),
                    ), // Text
                    ); // ListTile
                  }); // AsyncValueWidget

            },
          ); // ListView.builder
        },
      ), // AsyncValueWidget
    ); // Scaffold
  }
}