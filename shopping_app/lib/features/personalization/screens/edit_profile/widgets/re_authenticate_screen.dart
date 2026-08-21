import 'package:flutter/material.dart';
import 'package:shopping_app/features/personalization/screens/edit_profile/widgets/re_auth_form.dart';
import 'package:shopping_app/utils/constants/sizes.dart';

class ReAuthenticateScreen extends StatelessWidget {
  const ReAuthenticateScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Re-Authenticate User'),),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(USizes.defaultSpace),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Form
              ReAuthForm(),
            ],
          ),
        ),
      ),
    );
  }
}
