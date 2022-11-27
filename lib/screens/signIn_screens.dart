import 'package:amazon_clone/layout/screen_layout.dart';
import 'package:amazon_clone/resources/authentication.dart';
import 'package:amazon_clone/screens/signup_screen.dart';
import 'package:amazon_clone/utils/constants.dart';
import 'package:amazon_clone/utils/utils.dart';
import 'package:amazon_clone/widgets/custom_main_botton.dart';
import 'package:amazon_clone/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../utils/functions_provider.dart';

class SignInScreen extends StatelessWidget {
  const SignInScreen({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size screenSize = Utils().getScreenSize();
    TextEditingController emailController = TextEditingController();
    TextEditingController passwordController = TextEditingController();
    AuthenticationMethods authenticationMethods = AuthenticationMethods();
    bool isLoading = false;

    return Scaffold(
      body: SizedBox(
        height: screenSize.height,
        width: screenSize.width,
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 10,
            vertical: 20,
          ),
          child: Center(
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Image.network(
                    amazonLogo,
                    height: screenSize.height * 0.1,
                  ),
                  Container(
                    padding: const EdgeInsets.all(25),
                    height: screenSize.height * 0.6,
                    width: screenSize.width * 0.8,
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey, width: 1)),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'Sign-In',
                          style: TextStyle(
                              fontSize: 33, fontWeight: FontWeight.w500),
                        ),
                        TextFieldWidget(
                            title: 'Email',
                            hintText: 'Enter Your Email',
                            controller: emailController,
                            obscureText: false),
                        TextFieldWidget(
                            title: 'Password',
                            hintText: 'Enter Your Password',
                            controller: passwordController,
                            obscureText: true),
                        Center(
                          child: CustomMainBotton(
                              color: Colors.orange,
                              isLoading: Provider.of<TextFieldProvider>(context,
                                      listen: false)
                                  .isLoading,
                              onPressed: () async {
                                Provider.of<TextFieldProvider>(context,
                                        listen: false)
                                    .getIsLoading();
                                String? output =
                                    await authenticationMethods.signInUser(
                                        email: emailController.text,
                                        password: passwordController.text);
                                Provider.of<TextFieldProvider>(context,listen: false)
                                    .getIsLoading();
                                if (output == 'success') {
                                   Navigator.pushReplacement(context,
                                    MaterialPageRoute(
                                        builder: (BuildContext context) {
                                  return const ScreenLayout();
                                }));
                                } else {
                                  Utils().showSnackBar(
                                      context: context, content: output!);
                                }
                               
                              },
                              child: const Text(
                                'Sign-In',
                                style: TextStyle(letterSpacing: 0.6),
                              )),
                        )
                      ],
                    ),
                  ),
                  Row(children: [
                    Expanded(
                      child: Container(height: 1, color: Colors.grey),
                    ),
                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 10),
                      child: Text('New To Amazon?'),
                    ),
                    Expanded(
                      child: Container(height: 1, color: Colors.grey),
                    ),
                  ]),
                  CustomMainBotton(
                    color: Colors.grey,
                    isLoading: false,
                    onPressed: () {
                      Navigator.pushReplacement(context,
                          MaterialPageRoute(builder: (BuildContext context) {
                        return const SignUpScreen();
                      }));
                    },
                    child: const Text('Create an Amazon Account'),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
