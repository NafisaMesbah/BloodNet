import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';


import '../../../../util/appstyles.dart';
import '../../../../util/size_config.dart';
import '../../../authentication/domain/app_user.dart';

class UserItem extends ConsumerWidget {
  const UserItem(this.appUser, {super.key});

  final AppUser appUser;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    SizeConfig.init(context);
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
          onPressed: () {},
          style: ElevatedButton.styleFrom(
            backgroundColor: Appstyles.mainColor,
          ),
          child:  Text(
            'EMAIL',
            style: Appstyles.normalTextStyle,
          ), // Text
        ), // ElevatedButton
      ), // ListTile
    ); // Card
  }
}