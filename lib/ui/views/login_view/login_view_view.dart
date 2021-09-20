import 'package:arm_test/app/router/router.dart';
import 'package:arm_test/app/utils/res.dart';
import 'package:arm_test/app/utils/size.dart';
import 'package:arm_test/app/utils/theme.dart';
import 'package:arm_test/ui/widgets/dumb/button.dart';
import 'package:arm_test/ui/widgets/dumb/skeleton.dart';
import 'package:arm_test/ui/widgets/smart/textfield.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:stacked/stacked.dart';

import './login_view_view_model.dart';

class LoginView extends StatelessWidget {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final form = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<LoginViewModel>.reactive(
      viewModelBuilder: () => LoginViewModel(),
      onModelReady: (LoginViewModel model) async {
        await model.init();
      },
      builder: (
        BuildContext context,
        LoginViewModel model,
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
                    IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: Icon(
                        Icons.arrow_back_ios,
                        size: 20,
                      ),
                    ),
                    verticalSpaceSmall(context),
                    Text(
                      'Sign In',
                      style: CustomThemeData.generateStyle(
                          fontSize: McGyver.textSize(context, 3),
                          color: Theme.of(context).primaryColor,
                          fontWeight: FontWeight.bold),
                    ),
                    verticalSpaceXSmall(context),
                    Text(
                      'Please sign into your account.',
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
                      labelText: 'Password',
                      password: true,
                      controller: passwordController,
                      keyboardType: TextInputType.visiblePassword,
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
                            User? user = await model.login(
                                email: emailController.text,
                                password: passwordController.text);

                            if (user != null) {
                              model.navigateTo(HomeRoute());
                            }
                          }
                        },
                        text: 'Sign In'),
                    Center(
                      child: TextButton(
                        child: Text(
                          'New User? Sign Up',
                          style: GoogleFonts.dmSans(
                            color: Colors.black,
                          ),
                        ),
                        onPressed: () {
                          model.navigateTo(SignUpRoute());
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
