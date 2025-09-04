import 'package:bloodnet/common_widgets/async_value_ui.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';

import '../../../../common_widgets/async_value_widget.dart';
import '../../../../common_widgets/common_button.dart';
import '../../../../routes/routes.dart';
import '../../../../util/appstyles.dart';
import '../../../../util/size_config.dart';
import '../../domain/app_user.dart';
import '../../data/auth_repository.dart';



class AccountScreen extends ConsumerWidget {
  const AccountScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    SizeConfig.init(context);

    final userId = ref.watch(currentUserProvider)!.uid;

    final  userDataAsync = ref.watch(loadUserInformationProvider(userId));

    ref.listen<AsyncValue>(loadUserInformationProvider(userId), (_, state){
      state.showAlertDialogOnError(context);
    });


    void logOut(){
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('Are you sure?'),
          icon: const Icon(
            Icons.logout,
            size: 50,
            color: Appstyles.mainColor,
          ), //Icon
          actions: [
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Appstyles.mainColor,
              ),
              child:  Text(
                'Cancel',
                style: Appstyles.normalTextStyle,
              ), //Text
            ), //ElevatedButton
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
                ref.read(authRepositoryProvider).signOut();
                ref.read(goRouterProvider).refresh();
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Appstyles.mainColor,
              ),
              child:  Text(
                'Log Out',
                style: Appstyles.normalTextStyle,
              ), //Text
            ), //ElevatedButton
          ],
        ), //AlerDialog
      );
    }

    return Scaffold(
      appBar: AppBar(
        title:  Text(
          'My Profile Information',
          style: Appstyles.headingTextStyle,
        ), // Text
      ), // AppBar
      body: AsyncValueWidget<AppUser> (
          value: userDataAsync,
          data: (userData){
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                children: [
                  Text(
                    'Type: ${userData.type}',
                    style: Appstyles.titleTextStyle.copyWith(color: Colors.black),
                  ), //Text
                  SizedBox(height: SizeConfig.getProportionateScreenHeight(20)),
                  Image.asset(
                    userData.type == 'Donor'
                        ? 'assets/donor.png'
                        : 'assets/recipient.png',
                    height: SizeConfig.getProportionateScreenHeight(100),
                    width: SizeConfig.getProportionateScreenWidth(100),
                    fit: BoxFit.cover,
                  ), //Image.asset
                  SizedBox(height: SizeConfig.getProportionateScreenHeight(20)),
                  Text(
                    'Name: ${userData.name}',
                    style:
                    Appstyles.normalTextStyle.copyWith(color: Colors.black),
                  ), // Text
                  Text(
                    'Blood Group: ${userData.bloodGroup}',
                    style:
                    Appstyles.normalTextStyle.copyWith(color: Colors.black),
                  ), // Text
                  Text(
                    'Email: ${userData.email}',
                    style:
                    Appstyles.normalTextStyle.copyWith(color: Colors.black),
                  ), // Text
                  Text(
                    'Phone: ${userData.phoneNumber}',
                    style:
                    Appstyles.normalTextStyle.copyWith(color: Colors.black),
                  ), // Text
                  SizedBox(height: SizeConfig.getProportionateScreenHeight(20)),
                  CommonButton(
                    onTap: (){
                      logOut();
                    },
                    title: 'Sign Out',
                    isLoading: false,
                  ), //CommonButton
                ],
              ), //Column
            ); // Padding
          }
      ), // AsyncValueWidget
    ); // Scaffold
  }
}

