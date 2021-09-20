import 'package:arm_test/app/router/router.dart';
import 'package:arm_test/app/services/snackBar.dart';
import 'package:arm_test/app/utils/res.dart';
import 'package:arm_test/app/utils/size.dart';
import 'package:arm_test/app/utils/theme.dart';
import 'package:arm_test/ui/widgets/dumb/button.dart';
import 'package:arm_test/ui/widgets/dumb/skeleton.dart';
import 'package:arm_test/ui/widgets/smart/textfield.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/utils.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:stacked/stacked.dart';

import './sign_up_view_model.dart';

class SignUpView extends StatelessWidget {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final firstName = TextEditingController();
  final lastName = TextEditingController();
  final form = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<SignUpViewModel>.reactive(
      viewModelBuilder: () => SignUpViewModel(),
      onModelReady: (SignUpViewModel model) async {
        await model.init();
      },
      builder: (
        BuildContext context,
        SignUpViewModel model,
        Widget? child,
      ) {
        return Skeleton(
          isBusy: model.isBusy,
          body: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: McGyver.rsDoubleW(context, 3),
            ),
            child: SingleChildScrollView(
              child: Form(
                key: form,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    verticalSpaceMedium(context),
                    verticalSpaceSmall(context),
                    verticalSpaceSmall(context),
                    Text(
                      'Create a new account',
                      style: CustomThemeData.generateStyle(
                          fontSize: McGyver.textSize(context, 3),
                          color: Theme.of(context).primaryColor,
                          fontWeight: FontWeight.bold),
                    ),
                    verticalSpaceXSmall(context),
                    Text(
                      'Please create a new account by filling\nyour details.',
                      style: CustomThemeData.generateStyle(
                        fontSize: McGyver.textSize(context, 2.1),
                        color: Colors.black54,
                      ),
                    ),
                    verticalSpaceMedium(context),
                    CustomTextField(
                      labelText: 'Email',
                      controller: emailController,
                      keyboardType: TextInputType.emailAddress,
                      validator: (String? value) {
                        if (GetUtils.isEmail(value!) == false) {
                          return 'Please enter a valid email';
                        }
                      },
                    ),
                    verticalSpaceSmall(context),
                    CustomTextField(
                      labelText: 'FirstName',
                      controller: firstName,
                      keyboardType: TextInputType.text,
                      validator: (String? value) {
                        if (value == null || value.isEmpty) {
                          return 'Field cannot be empty';
                        }
                      },
                    ),
                    verticalSpaceSmall(context),
                    CustomTextField(
                      labelText: 'SurName',
                      controller: lastName,
                      keyboardType: TextInputType.text,
                      validator: (String? value) {
                        if (value == null || value.isEmpty) {
                          return 'Field cannot be empty';
                        }
                      },
                    ),
                    verticalSpaceSmall(context),
                    CustomTextField(
                      labelText: 'Password',
                      controller: passwordController,
                      keyboardType: TextInputType.visiblePassword,
                      password: true,
                      validator: (String? value) {
                        if (value == null || value.isEmpty) {
                          return 'Field cannot be empty';
                        }
                      },
                    ),
                    verticalSpaceMedium(context),
                    CustomButtons.generalButton(
                        context: context,
                        onTap: () async {
                          final formKey = form.currentState;
                          if (formKey!.validate()) {
                            User? user = await model.signUp(
                                email: emailController.text,
                                password: passwordController.text,
                                firstName: firstName.text,
                                lastName: lastName.text);
                            if (user != null) {
                              model.navigateTo(HomeRoute());
                            }
                          }
                        },
                        text: 'Sign Up'),
                    Center(
                      child: TextButton(
                        child: Text(
                          'Already have an account? Sign In',
                          style: GoogleFonts.dmSans(
                            color: Colors.black,
                          ),
                        ),
                        onPressed: () {
                          model.navigateTo(LoginRoute());
                        },
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
