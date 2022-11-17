import 'package:asbar/Constants/colors.dart';
import 'package:asbar/Constants/styles.dart';
import 'package:asbar/Providers/MainProvider.dart';
import 'package:asbar/Scaffolds/TabsScaffold.dart';
import 'package:asbar/Services/AuthServices.dart';
import 'package:asbar/Services/CommonServices.dart';
import 'package:asbar/Widgets/TextFieldWidget.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:provider/provider.dart';

class AuthScaffold extends StatelessWidget {
  AuthScaffold({Key? key}) : super(key: key);

  static const id = 'auth_scaffold';

  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  final _commonServices = CommonServices();
  final _authServices = AuthServices();

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.shortestSide;
    double height = MediaQuery.of(context).size.longestSide;

    MainProvider mainProvider = Provider.of<MainProvider>(context);
    MainProvider mainProviderFalse =
        Provider.of<MainProvider>(context, listen: false);

    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [kBlue1, kBlue2],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
      ),
      child: ModalProgressHUD(
        inAsyncCall: mainProvider.showSpinner,
        child: Scaffold(
          backgroundColor: kTransparent,
          body: Stack(
            children: [
              ///Dialog
              Center(
                child: Container(
                  width: width * .45,
                  height: height * .5,
                  decoration: BoxDecoration(
                    color: kWhite,
                    borderRadius: BorderRadius.circular(18),
                  ),
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: width * .05),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ///Sign In
                        const Center(
                            child: Text("Sign In", style: kSemiBold24)),
                        const SizedBox(height: 24),

                        ///Email
                        const Text("Email", style: kMedium12),
                        const SizedBox(height: 8),
                        TextFieldWidget(controller: _emailController),
                        const SizedBox(height: 24),

                        ///Password
                        const Text("Password", style: kMedium12),
                        const SizedBox(height: 8),
                        TextFieldWidget(
                            controller: _passwordController, isPassword: true),
                        const SizedBox(height: 20),

                        ///Sign In Button
                        InkWell(
                          onTap: () async {
                            String email = _emailController.text.trim();
                            String password = _passwordController.text.trim();

                            if (email.isEmpty) {
                              _commonServices
                                  .showToast("Please enter an email");
                              return;
                            }

                            if (password.isEmpty) {
                              _commonServices
                                  .showToast("Please enter a password");
                              return;
                            }
                            mainProviderFalse.changeShowSpinner(true);

                            bool result = await _authServices.signIn(
                                email: email, password: password);

                            mainProviderFalse.changeShowSpinner(false);

                            ///
                            if (result) {
                              Navigator.pushReplacementNamed(
                                  context, TabsScaffold.id);
                            }
                          },
                          child: Container(
                            alignment: Alignment.center,
                            padding: const EdgeInsets.symmetric(vertical: 16),
                            decoration: BoxDecoration(
                              color: kDarkBlue,
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Text("Sign In",
                                style: kMedium12.copyWith(color: kWhite)),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),

              ///Top Circle
              Positioned(
                top: -width / 5,
                left: -width / 6,
                child: Opacity(
                  opacity: 0.5,
                  child: Container(
                    width: width / 2,
                    height: width / 2,
                    decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        gradient: LinearGradient(
                          colors: [kBlue2, kWhite],
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                        )),
                  ),
                ),
              ),

              ///Bottom Circle
              Positioned(
                bottom: -width / 12,
                right: -width / 12,
                child: Opacity(
                  opacity: 0.5,
                  child: Container(
                    width: width / 4,
                    height: width / 4,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      gradient: LinearGradient(
                        colors: [kWhite, kBlue2],
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
