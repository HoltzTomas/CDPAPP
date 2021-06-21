import 'package:cdp_app/Company/providers/auth_providers.dart';
import 'package:cdp_app/Company/repository/auth_repository.dart';
import 'package:cdp_app/Company/ui/screens/WelcomeScreen/welcome_screen.dart';
import 'package:cdp_app/Company/ui/screens/verify_email_handler.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SignInHandler extends ConsumerWidget {
  const SignInHandler({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, ScopedReader watch) {
    final AuthRepository authRepository = AuthRepository();
    return StreamBuilder(
      stream: watch(authChanges).state,
      builder: (context, snapshot) {
        if (!snapshot.hasData || snapshot.hasError) {
          return const WelcomeScreen();
        } else {
          return Scaffold(
            body: Center(
              child: TextButton(
                onPressed: () {
                  authRepository.signOut();
                },
                child: const VerifyEmailHandler(),
              ),
            ),
          );
        }
      },
    );
  }
}
