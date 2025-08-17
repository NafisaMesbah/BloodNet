import 'package:flutter/cupertino.dart%20';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../common_widgets/common_button.dart';
import '../../../../common_widgets/common_text_field.dart';
import '../../../../routes/routes.dart';
import '../../../../util/appstyles.dart';
import '../../../../util/size_config.dart';


class RegistrationScreen extends ConsumerStatefulWidget{
  const RegistrationScreen(this.type,{super.key});

  final String type;
  
  @override
  ConsumerState createState() => _RegistrationScreenState();

}

class _RegistrationScreenState extends ConsumerState<RegistrationScreen>{

  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _nameController = TextEditingController();
  final _phoneNumberController = TextEditingController();

  String? _selectedBloodGroup;

  final List<String> _bloodGroups = [
    'A+',
    'A-',
    'B+',
    'B-',
    'AB+',
    'AB-',
    'O+',
    'O-',
  ];



  @override
  void dispose(){
    _emailController.dispose();
    _passwordController.dispose();
    _nameController.dispose();
    _phoneNumberController.dispose();
    super.dispose();


  }


  @override
  Widget build(BuildContext context) {
    SizeConfig.init(context);
    return Scaffold( // Wrap with Scaffold
      backgroundColor: Appstyles.mainColor, // Set backgroundColor here
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.fromLTRB(
            SizeConfig.getProportionateScreenWidth(10),
            SizeConfig.getProportionateScreenHeight(50),
            SizeConfig.getProportionateScreenWidth(10),
            0,
          ),
          child: SingleChildScrollView(
            child: Container(
              padding: const EdgeInsets.all(10),
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
                    '${widget.type} Registration',
                    style: Appstyles.titleTextStyle.copyWith(color: Colors.black),
                  ),
                  SizedBox(height: SizeConfig.getProportionateScreenHeight(25)),
                  CommonTextField(
                    hintText: 'Enter name',
                    textInputType: TextInputType.text,
                    controller: _nameController,
                  ),
                  SizedBox(height: SizeConfig.getProportionateScreenHeight(10)),
                  CommonTextField(
                    hintText: 'Enter Phone number',
                    textInputType: TextInputType.number,
                    controller: _phoneNumberController,
                  ),
                  SizedBox(height: SizeConfig.getProportionateScreenHeight(10)),

                  DropdownButtonFormField<String>(
                    value: _selectedBloodGroup,
                    decoration: InputDecoration(
                      labelText: 'Select Blood Group',
                      labelStyle: Appstyles.normalTextStyle.copyWith(color: Colors.black),
                      border: OutlineInputBorder(
                        borderSide: const BorderSide(
                          color: Colors.black,
                          style: BorderStyle.solid,
                        ),
                          borderRadius: BorderRadius.circular(20.0),
                      ),

                    ),

                    items: _bloodGroups.map((String group) {
                      return DropdownMenuItem<String>(
                        value: group,
                        child: Text(
                          group,
                          style: Appstyles.normalTextStyle.copyWith(
                              color: Colors.black,
                          ),
                        ),
                      );

                    }).toList(),
                    onChanged: (String? newValue) {
                      setState(() {
                        _selectedBloodGroup = newValue;

                      });
                    },
                  ),
                  SizedBox(height: SizeConfig.getProportionateScreenHeight(10)),

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
                    onTap: () {},
                    title: 'Register Me Now',
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
                        AppRoutes.signIn.name,
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
                        'Sign In to my account',
                        style: Appstyles.normalTextStyle.copyWith(
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: SizeConfig.getProportionateScreenHeight(10)),

                  SizedBox(height: SizeConfig.getProportionateScreenHeight(10)),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

