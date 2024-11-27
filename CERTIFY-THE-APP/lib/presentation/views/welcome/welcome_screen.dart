import 'package:certify/presentation/views/welcome/components/auth_buttons.dart';
import 'package:certify/presentation/views/welcome/components/welcome_image.dart';
import 'package:flutter/material.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          WelcomeImage(),
          Row(
            children: [
              Spacer(),
              Expanded(
                flex: 8,
                child: AuthFieldBtn(),
              ),
              Spacer(),
            ],
          ),
        ],
      ),
    );
  }
}
