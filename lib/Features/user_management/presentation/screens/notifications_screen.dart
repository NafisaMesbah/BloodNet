import 'package:bloodnet/common_widgets/async_value_ui.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';

import '../../../../common_widgets/async_value_widget.dart';
import '../../../../util/appstyles.dart';
import '../../../../util/date_formatter.dart';
import '../../../authentication/data/auth_repository.dart';
import '../../../authentication/domain/app_user.dart';
import '../../data/firestore_repository.dart';
import '../../domain/app_notification.dart';

class NotificationScreen extends ConsumerWidget {
  const NotificationScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {

    final userId = ref.watch(currentUserProvider)!.uid;
    final notificationAsyncValue = ref.watch(loadNotificationsProvider(userId));
    ref.listen<AsyncValue>(loadNotificationsProvider(userId), (_, state){
      state.showAlertDialogOnError(context);
    }
    );
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Notifications',
          style: Appstyles.headingTextStyle,
        ), // Text
      ), // AppBar
      body: AsyncValueWidget<List<AppNotification>>(
        value: notificationAsyncValue,
        data: (notifications) {
          return notifications.isEmpty
              ? const Center(child: Text('No Notifications Yet'))
              : ListView.builder(
            itemCount: notifications.length,
            itemBuilder: (ctx, index) {
              final notification = notifications[index];
              final userDataAsync = ref.watch(
                  loadUserInformationProvider(notification.donorId));
              return AsyncValueWidget<AppUser>(
                  value: userDataAsync,
                  data: (userData) {
                    return ListTile(
                        title: Text(userData.name),
                        subtitle: Text(notification.text),
                        leading: userData.type == 'Donor'
                            ? Image.asset('assets/donor.png',
                            height: 50, width: 50) // Image.asset
                            :  Image.asset('assets/recipient.png',
                    height: 50, width: 50), // Image.asset
                    trailing: Text(formattedDate(notification.date)),
                    ); // ListTile
                  }); // AsyncValueWidget
            },
          ); //ListView.builder
        },
      ), // AsyncValueWidget

    ); // Scaffold
  }
}