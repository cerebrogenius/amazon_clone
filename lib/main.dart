

import 'package:amazon_clone/providers/review_model_provider.dart';
import 'package:amazon_clone/screens/signIn_screens.dart';
import 'package:amazon_clone/utils/color_themes.dart';
import 'package:amazon_clone/utils/functions_provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'layout/screen_layout.dart';
import 'providers/user_details_provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const AmazonClone());
}

class AmazonClone extends StatelessWidget {
  const AmazonClone({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => TextFieldProvider()),
        ChangeNotifierProvider(create: (_) => UserDetailsProvider()),
        ChangeNotifierProvider(create: (_)=> ReviewModelProvider())
      ],
      child: MaterialApp(
        theme: ThemeData.light()
            .copyWith(scaffoldBackgroundColor: backgroundColor),
        title: 'Amazon Clone',
        debugShowCheckedModeBanner: false,
        home: StreamBuilder(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (context, AsyncSnapshot<User?> user) {
            if (user.connectionState == ConnectionState.waiting) {
              return const Center(
                  child: CircularProgressIndicator(
                color: Colors.orange,
              ));
            } else if (user.hasData) {
              return const ScreenLayout();
              
            } else {
              return const SignInScreen();
            }
          },
        ),
      ),
    );
  }
}
