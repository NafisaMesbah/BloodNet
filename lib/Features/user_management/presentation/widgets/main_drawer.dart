import 'package:bloodnet/common_widgets/async_value_ui.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../common_widgets/async_value_widget.dart';
import '../../../../routes/routes.dart';
import '../../../../util/appstyles.dart';
import '../../../../util/size_config.dart';
import '../../../authentication/data/auth_repository.dart';
import '../../../authentication/domain/app_user.dart';

class MainDrawer extends ConsumerWidget{
  const MainDrawer({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {

    final userId = ref.watch(currentUserProvider)!.uid;
    final  userDataAsync = ref.watch(loadUserInformationProvider(userId));

    ref.listen<AsyncValue>(loadUserInformationProvider(userId), (_, state){
      state.showAlertDialogOnError(context);
    });

    return AsyncValueWidget<AppUser>(
        value: userDataAsync,
        data: (userData) {
          return SafeArea(
            child: Drawer(
              child: ListView(
                padding: EdgeInsets.all(15),
                children: [
                  Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: Appstyles.mainColor,
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(
                          color: Colors.white,
                          style: BorderStyle.solid,
                          width: 2,
                        ), //Border.all
                      ), //BoxDecoration
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset(
                            'assets/bloodnet2.png',
                            height: SizeConfig.getProportionateScreenHeight(40),
                            width: SizeConfig.getProportionateScreenWidth(40),
                            fit: BoxFit.cover,
                          ), //Image.asset
                           Text(
                            'Blood Donation App',
                            style: Appstyles.titleTextStyle,
                          ), //Text
                          Text(
                            userData.name,
                            style: Appstyles.normalTextStyle,
                          ), //Text
                           Text(
                            userData.email,
                            style: Appstyles.normalTextStyle,
                          ), //Text
                        ],
                      ), // Column
                    ), // Container
                   // DrawerHeader
                  Expanded(
                    child: Container(
                      width: double.infinity,
                      margin: EdgeInsets.all(15),
                      decoration: BoxDecoration(
                        color: Appstyles.mainColor,
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(
                          color: Colors.white,
                          style: BorderStyle.solid,
                          width: 2,
                        ), //Border.all
                      ), //BoxDecoration
                      child: SingleChildScrollView(
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(5,0,0,0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children:[
                              ListTile(
                                leading: const Icon(
                                  Icons.home,
                                  color: Colors.black,
                                  size: 30,
                                ), // Icon
                                title: Text(
                                  'Home',
                                  style: Appstyles.headingTextStyle.copyWith(
                                      color: Colors.white,
                                      fontSize: 17.0
                                  ),
                                ), // Text
                                onTap:() {
                                  context.goNamed(AppRoutes.main.name);
                                },
                              ), // ListTile
                              ListTile(
                                leading: const Icon(
                                  Icons.check_circle,
                                  color: Colors.black,
                                  size: 30,
                                ), // Icon
                                title: Text(
                                  'Donors Emailed!',
                                  style: Appstyles.headingTextStyle.copyWith(
                                      color: Colors.white,
                                      fontSize: 17.0
                                  ),
                                ), // Text
                                onTap:() {
                                  context.goNamed(
                                      AppRoutes.emailedUser.name
                                  );
                                },
                              ), // ListTile
                              ListTile(
                                leading: const Icon(
                                  Icons.handshake,
                                  color: Colors.black,
                                  size: 30,
                                ), // Icon
                                title: Text(
                                  'Same BG as me',
                                  style: Appstyles.headingTextStyle.copyWith(
                                      color: Colors.white,
                                      fontSize: 17.0
                                  ),
                                ), // Text
                                onTap:() {
                                  context.goNamed(
                                      AppRoutes.bloodGroupSelected.name,
                                      extra: userData.bloodGroup,
                                  );
                                },
                              ), //ListTile
                              const Divider(
                                color: Colors.white,
                                height: 2,
                              ), // Divider
                               Text(
                                'Blood Groups',
                                style: Appstyles.normalTextStyle,
                              ), //Text
                              ListTile(
                                onTap:() {
                                  context.goNamed(
                                      AppRoutes.bloodGroupSelected.name,
                                      extra: 'A+');
                                },
                                leading: Image.asset(
                                  'assets/aplus.png',
                                  height: 40.0,
                                  width: 40.0,
                                ), //Image.asset
                                title:  Text(
                                  'A Positive',
                                  style: Appstyles.headingTextStyle.copyWith(
                                    color: Colors.white,
                                    fontSize: 17.0,
                                  ),
                                ), // Text
                              ), // ListTile
                              ListTile(
                                onTap:() {
                                  context.goNamed(
                                      AppRoutes.bloodGroupSelected.name,
                                      extra: 'A-');
                                },
                                leading: Image.asset(
                                  'assets/aminus.png',
                                  height: 45.0,
                                  width: 40.0,
                                ), //Image.asset
                                title:  Text(
                                  'A Negative',
                                  style: Appstyles.headingTextStyle.copyWith(
                                    color: Colors.white,
                                    fontSize: 17.0,
                                  ),
                                ), // Text
                              ), // ListTile
                              ListTile(
                                onTap:() {
                                  context.goNamed(
                                      AppRoutes.bloodGroupSelected.name,
                                      extra: 'B+');
                                },
                                leading: Image.asset(
                                  'assets/bplus.png',
                                  height: 40.0,
                                  width: 40.0,
                                ), //Image.asset
                                title:  Text(
                                  'B Positive',
                                  style: Appstyles.headingTextStyle.copyWith(
                                    color: Colors.white,
                                    fontSize: 17.0,
                                  ),
                                ), // Text
                              ), // ListTile
                              ListTile(
                                onTap:() {
                                  context.goNamed(
                                      AppRoutes.bloodGroupSelected.name,
                                      extra: 'B-');
                                },
                                leading: Image.asset(
                                  'assets/bminus.png',
                                  height: 60.0,
                                  width: 40.0,
                                ), //Image.asset
                                title:  Text(
                                  'B Negative',
                                  style: Appstyles.headingTextStyle.copyWith(
                                    color: Colors.white,
                                    fontSize: 17.0,
                                  ),
                                ), // Text
                              ), // ListTile
                              ListTile(
                                onTap:() {
                                  context.goNamed(
                                      AppRoutes.bloodGroupSelected.name,
                                      extra: 'AB+');
                                },
                                leading: Image.asset(
                                  'assets/abplus.png',
                                  height: 70.0,
                                  width: 40.0,
                                ), //Image.asset
                                title:  Text(
                                  'AB Positive',
                                  style: Appstyles.headingTextStyle.copyWith(
                                    color: Colors.white,
                                    fontSize: 17.0,
                                  ),
                                ), // Text
                              ), // ListTile
                              ListTile(
                                onTap:() {
                                  context.goNamed(
                                      AppRoutes.bloodGroupSelected.name,
                                      extra: 'AB-');
                                },
                                leading: Image.asset(
                                  'assets/abminus.png',
                                  height: 90.0,
                                  width: 40.0,
                                ), //Image.asset
                                title:  Text(
                                  'AB Negative',
                                  style: Appstyles.headingTextStyle.copyWith(
                                    color: Colors.white,
                                    fontSize: 17.0,
                                  ),
                                ), // Text
                              ), // ListTile
                              ListTile(
                                onTap:() {
                                  context.goNamed(
                                      AppRoutes.bloodGroupSelected.name,
                                      extra: 'O+');
                                },
                                leading: Image.asset(
                                  'assets/oplus.png',
                                  height: 50.0,
                                  width: 40.0,
                                ), //Image.asset
                                title:  Text(
                                  'O Positive',
                                  style: Appstyles.headingTextStyle.copyWith(
                                    color: Colors.white,
                                    fontSize: 17.0,
                                  ),
                                ), // Text
                              ), // ListTile
                              ListTile(
                                onTap:() {
                                  context.goNamed(
                                      AppRoutes.bloodGroupSelected.name,
                                      extra: 'O-');
                                },
                                leading: Image.asset(
                                  'assets/ominus.png',
                                  height: 45.0,
                                  width: 38.0,
                                ), //Image.asset
                                title:  Text(
                                  'O Negative',
                                  style: Appstyles.headingTextStyle.copyWith(
                                    color: Colors.white,
                                    fontSize: 17.0,
                                  ),
                                ), // Text
                              ), // ListTile
                              const Divider(
                                color: Colors.white,
                                height: 2,
                              ), // Divider
                               Text(
                                'Actions',
                                style: Appstyles.normalTextStyle,
                              ), //Text
                              ListTile(
                                onTap:() {
                                  context.goNamed(
                                    AppRoutes.notification.name,
                                  );
                                },
                                leading: const Icon(
                                  Icons.notifications,
                                  color: Colors.black,
                                  size: 30,
                                ), //Icon
                                title: Text(
                                  'Notifications',
                                  style: Appstyles.headingTextStyle.copyWith(
                                    color: Colors.white,
                                    fontSize: 17.0,
                                  ),
                                ), //Text
                              ), //ListTile
                              ListTile(
                                onTap:() {
                                  context.goNamed(
                                    AppRoutes.account.name,
                                  );
                                },
                                leading: const Icon(
                                  Icons.account_circle,
                                  color: Colors.black,
                                  size: 30,
                                ), //Icon
                                title: Text(
                                  'My Account',
                                  style: Appstyles.headingTextStyle.copyWith(
                                    color: Colors.white,
                                    fontSize: 17.0,
                                  ),
                                ), //Text
                              ), //ListTile
                              /*const Divider(
                                color: Colors.white,
                                height: 2,
                              ), // Divider
                               Text(
                                'Communicate',
                                style: Appstyles.normalTextStyle,
                              ), //Text
                              ListTile(
                                leading: const Icon(
                                  Icons.info,
                                  color: Colors.black,
                                  size: 30,
                                ), //Icon
                                title: Text(
                                  'About',
                                  style: Appstyles.headingTextStyle.copyWith(
                                    color: Colors.white,
                                    fontSize: 17.0,
                                  ),
                                ), //Text
                              ), //ListTile
                              ListTile(
                                leading: const Icon(
                                  Icons.share,
                                  color: Colors.black,
                                  size: 30,
                                ), //Icon
                                title: Text(
                                  'Share',
                                  style: Appstyles.headingTextStyle.copyWith(
                                    color: Colors.white,
                                    fontSize: 17.0,
                                  ),
                                ), //Text
                              ),*/ //ListTile
                            ],
                          ), // Column
                        ), // Padding
                      ), // SingleChildScrollView
                    ), // Container
                  ), // Expanded
                ],
              ), // Column
            ), // Drawer
          ); //SafeArea
        }
    );	 // AsyncValueWidget
  }
}


// ignore this comment wrote only to fix the commit