import 'package:bloodnet/common_widgets/common_button.dart';
import 'package:bloodnet/common_widgets/common_text_field.dart';
import 'package:bloodnet/routes/routes.dart';
import 'package:bloodnet/util/appstyles.dart';
import 'package:bloodnet/util/size_config.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class SignInScreen extends ConsumerStatefulWidget {
  const SignInScreen({super.key});

  @override
  ConsumerState createState() => _SignInScreenState();
}

class _SignInScreenState extends ConsumerState<SignInScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Appstyles.mainColor,
      body: Padding(
        padding: EdgeInsets.fromLTRB(
          SizeConfig.getProportionateScreenWidth(10),
          SizeConfig.getProportionateScreenHeight(50),
          SizeConfig.getProportionateScreenWidth(10),
          0,
        ),
        child: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
            ),

            child: Column(
              children: [
                Image.asset(
                  'assets/bloodnet2.png',
                  height: SizeConfig.getProportionateScreenHeight(100),
                  width: SizeConfig.getProportionateScreenWidth(100),
                  fit: BoxFit.cover,
                ),
                Text(
                  'Sign In to your account',
                  style: Appstyles.titleTextStyle.copyWith(color: Colors.black),
                ),
                SizedBox(height: SizeConfig.getProportionateScreenHeight(25)),
                CommonTextField(
                  hintText: 'Enter Email',
                  textInputType: TextInputType.emailAddress,
                  controller: _emailController,
                ),
                SizedBox(height: SizeConfig.getProportionateScreenHeight(10)),
                CommonTextField(
                  hintText: 'Enter Password',
                  textInputType: TextInputType.text,
                  controller: _passwordController,
                ),
                SizedBox(height: SizeConfig.getProportionateScreenHeight(10)),

                CommonButton(
                  onTap: () {
                    // Handle sign-in logic here
                    // print('Email: ${_emailController.text}');
                    // print('Password: ${_passwordController.text}');
                  },
                  title: 'Sign In',
                  isLoading: false, // Change to true if loading state is needed
                ),

                SizedBox(height: SizeConfig.getProportionateScreenHeight(15)),
                Text(
                  'OR',
                  style: Appstyles.titleTextStyle.copyWith(color: Colors.black),
                ),
                SizedBox(height: SizeConfig.getProportionateScreenHeight(15)),
                GestureDetector(
                  onTap: () {
                    context.goNamed(
                      AppRoutes.register.name,
                      extra: 'Recipient',
                    );
                    // Handle navigation to registration screen
                    // Navigator.push(context, MaterialPageRoute(builder: (context) => RegisterScreen()));
                  },
                  child: Container(
                    padding: const EdgeInsets.all(10),
                    width: SizeConfig.screenWidth,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(
                        color: Colors.black,
                        width: 2.0,
                        style: BorderStyle.solid,
                      ),
                    ),

                    child: Text(
                      'Register as Recipient',
                      style: Appstyles.normalTextStyle.copyWith(
                        color: Colors.black,
                      ),
                    ),
                  ),
                ),

                SizedBox(height: SizeConfig.getProportionateScreenHeight(10)),
                GestureDetector(
                  onTap: () {
                    context.goNamed(AppRoutes.register.name, extra: 'Donor');
                    // Handle navigation to registration screen
                    // Navigator.push(context, MaterialPageRoute(builder: (context) => RegisterScreen()));
                  },
                  child: Container(
                    padding: const EdgeInsets.all(10),
                    width: SizeConfig.screenWidth,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(
                        color: Colors.black,
                        width: 2.0,
                        style: BorderStyle.solid,
                      ),
                    ),

                    child: Text(
                      'Register as Donor',
                      style: Appstyles.normalTextStyle.copyWith(
                        color: Colors.black,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: SizeConfig.getProportionateScreenHeight(10)),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
