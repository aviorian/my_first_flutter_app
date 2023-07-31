import 'package:flutter/material.dart';

import 'constants/routes.dart';

class LoggedOutView extends StatelessWidget {
  const LoggedOutView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(children: [
          const Text(
            "You logged out successfully",
            style: TextStyle(fontSize: 40),
          ),
          ElevatedButton(
              onPressed: () {
                Navigator.of(context)
                    .pushNamedAndRemoveUntil(Routes.getLoginRoute, (route) => false);
              },
              child: const Text("Proceed"))
        ]),
      ),
    );
  }
}
