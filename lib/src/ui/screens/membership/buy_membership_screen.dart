import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';

class BuyMembershipScreen extends StatelessWidget {
  const BuyMembershipScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: true,
      child: Scaffold(
        appBar: AppBar(title: const Text("Unlock Premium")),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Icon(Icons.star_rate_outlined,
                size: 80, color: Colors.amber),
            const SizedBox(height: 24),
            Text(
              "Become a Lifetime Member",
              textAlign: TextAlign.center,
              style: GoogleFonts.ptSerif(
                fontSize: 28,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            const Text(
              "Get exclusive access to features like instant quotes, unlimited boards, and more!",
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 16, color: Colors.black54),
            ),
            const SizedBox(height: 48),
            Align(
              alignment: Alignment.center,
              child: SizedBox(
                width: 300,
                child: ElevatedButton(
                  onPressed: () {
                    launchUrl(Uri.parse('https://members.daginawala.in'));
                    debugPrint("Redirecting to daginawala.in...");
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.black,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                  child: const Text(
                    "Buy Now - Lifetime Access",
                    style: TextStyle(fontSize: 18, color: Colors.white),
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