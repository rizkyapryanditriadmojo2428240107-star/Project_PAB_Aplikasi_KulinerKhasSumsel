import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<bool> ensureLoggedIn(BuildContext context) async {
  final prefs = await SharedPreferences.getInstance();
  final isLoggedIn = prefs.getBool('is_logged_in') ?? false;

  if (!isLoggedIn) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Silakan login terlebih dahulu untuk fitur ini.'),
      ),
    );

    Navigator.pushNamed(context, '/sign_in');
  }

  return isLoggedIn;
}
