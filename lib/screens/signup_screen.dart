// ignore_for_file: use_build_context_synchronously

import 'package:amazon_clone/resources/authentication.dart';
import 'package:amazon_clone/screens/signIn_screens.dart';
import 'package:amazon_clone/utils/functions_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../utils/constants.dart';
import '../utils/utils.dart';
import '../widgets/custom_main_botton.dart';
import '../widgets/widgets.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size screenSize = Utils().getScreenSize();
    TextEditingController emailController = TextEditingController();
    TextEditingController passwordController = TextEditingController();
    TextEditingController nameController = TextEditingController();
    TextEditingController addressController = TextEditingController();
    AuthenticationMethods authenticationMethods = AuthenticationMethods();

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
                    height: screenSize.height * 0.85,
                    width: screenSize.width * 0.8,
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey, width: 1)),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'Sign-Up',
                          style: TextStyle(
                              fontSize: 33, fontWeight: FontWeight.w500),
                        ),
                        TextFieldWidget(
                            title: 'Name',
                            hintText: 'Enter Your Name',
                            controller: nameController,
                            obscureText: false),
                        TextFieldWidget(
                            title: 'Address',
                            hintText: 'Enter Your Address',
                            controller: addressController,
                            obscureText: false),
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
                              isLoading: Provider.of<TextFieldProvider>(context)
                                  .isLoading,
                              onPressed: () async {
                                Provider.of<TextFieldProvider>(context,
                                        listen: false)
                                    .getIsLoading();
                                Future.delayed(const Duration(seconds: 2));
                                String? output =
                                    await authenticationMethods.signUpUser(
                                        name: nameController.text,
                                        address: addressController.text,
                                        email: emailController.text,
                                        password: passwordController.text);
                                Provider.of<TextFieldProvider>(context,
                                        listen: false)
                                    .getIsLoading();
                                
                                if (output == 'success') {
                                  Navigator.pushReplacement(context, MaterialPageRoute(
                                    builder: (BuildContext context) {
                                  return const SignInScreen();
                                }));
                                } else {
                                  Utils().showSnackBar(
                                      context: context, content: output!);
                                }
                                
                              },
                              child: const Text(
                                'Sign-Up', 
                                style: TextStyle(letterSpacing: 0.6),
                              )),
                        )
                      ],
                    ),
                  ),
                  CustomMainBotton(
                      color: Colors.grey,
                      isLoading: false,
                      onPressed: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (BuildContext context) {
                          return const SignUpScreen();
                        }));
                      },
                      child: const Text('Back'))
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
