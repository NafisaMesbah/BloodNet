import 'package:bloodnet/Features/authentication/data/auth_repository.dart';
import 'package:bloodnet/Features/user_management/domain/app_notification.dart';
import 'package:bloodnet/Features/user_management/presentation/controller/mail_controller.dart';
import 'package:bloodnet/common_widgets/async_value_ui.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';


import '../../../../common_widgets/async_value_widget.dart';
import '../../../../util/appstyles.dart';
import '../../../../util/size_config.dart';
import '../../../authentication/domain/app_user.dart';
import '../controller/firestore_controller.dart';

class UserItem extends ConsumerWidget {
  const UserItem(this.appUser, {super.key});

  final AppUser appUser;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    SizeConfig.init(context);
    final userId = ref.watch(currentUserProvider)!.uid;
    final userDataAsync= ref.watch(loadUserInformationProvider(userId));

    final state = ref.watch(mailControllerProvider);
    ref.listen<AsyncValue>(mailControllerProvider,(_, state){
      state.showAlertDialogOnError(context);
    });


    return AsyncValueWidget<AppUser>(value: userDataAsync, data: (userData){
      return Card(
        child: ListTile(
          leading: Image.asset(
            appUser.type == 'Donor' ? 'assets/donor.png' : 'assets/recipient.png',
            height: SizeConfig.getProportionateScreenHeight(100),
            width: SizeConfig.getProportionateScreenWidth(100),
          ), //Image.asset
          title: Column(
            children: [
              Text(
                appUser.type.toUpperCase(),
                style:Appstyles.normalTextStyle.copyWith(color: Colors.black),
              ), // Text
              Text(
                'Name: ${appUser.name}',
                overflow: TextOverflow.ellipsis,
                style:Appstyles.normalTextStyle.copyWith(color: Colors.black),
              ), // Text
              Text(
                'Email: ${appUser.email}',
                overflow: TextOverflow.ellipsis,
                style:Appstyles.normalTextStyle.copyWith(color: Colors.black),
              ), // Text
              Text(
                'Phone: ${appUser.phoneNumber}',
                overflow: TextOverflow.ellipsis,
                style:Appstyles.normalTextStyle.copyWith(color: Colors.black),
              ), // Text
              Text(
                'Blood Group: ${appUser.bloodGroup}',
                overflow: TextOverflow.ellipsis,
                style:Appstyles.normalTextStyle.copyWith(color: Colors.black),
              ), // Text
            ],
          ), // Column
          trailing: ElevatedButton(
            onPressed: () async {
              final result =await ref
                  .read(mailControllerProvider.notifier)
                  .sendEmail(
                  donorEmail: appUser.email,
                  recipientEmail: userData.email,
                  recipientName: userData.name,
                  recipientPhone: userData.phoneNumber,
                  recipientBloodGroup: userData.bloodGroup);

              if (result) {
                ref.read(firestoreControllerProvider.notifier)
                    .saveIdsToDatabase(
                    recipientId: userData.userId,
                    donorId: appUser.userId);

                final date = DateTime.now().toString();
                final myNotification = AppNotification(
                    text:'Requested Blood Donation',
                    date: date,
                    donorId: appUser.userId,
                    recipientId: userData.userId);

                ref.read(firestoreControllerProvider.notifier)
                    .addNotifications(
                    recipientId: userData.userId,
                    donorId: appUser.userId,
                    appNotification: myNotification);

                showDialog(context: context, builder: (context){
                  return AlertDialog(
                    title: const Text(
                      'Donor Emailed Successfully',
                      style:
                      TextStyle(color: Colors.black, fontSize: 20),
                    ),

                    icon: const Icon(
                      Icons.check_circle,
                      color: Colors.green,
                      size: 120,
                    ),
                    alignment: Alignment.center,
                    actions: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          ElevatedButton(
                            style: ElevatedButton.styleFrom( backgroundColor: Appstyles.mainColor),
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            child: Text(
                              'OK',
                              style: Appstyles.normalTextStyle,
                            ),
                          )
                        ]
                      )
                    ]
                  );
                });

              }
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Appstyles.mainColor,
            ),
            child:  Text(
              'EMAIL',
              style: Appstyles.normalTextStyle,
            ), // Text
          ), // ElevatedButton
        ), // ListTile
      );
    });
  }
}
