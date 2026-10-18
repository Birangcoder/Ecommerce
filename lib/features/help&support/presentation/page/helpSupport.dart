import 'package:flutter/material.dart';

class HelpSupport extends StatelessWidget {
  const HelpSupport({super.key});


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Help & Support",
          style: TextStyle(fontWeight: FontWeight.w700),
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(20),
        child: Column(
          spacing: 10,
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(
              "Contact Us",
              style: TextStyle(fontWeight: FontWeight.w700, fontSize: 20),
            ),
            contactCard(
              icon: Icons.phone,
              iconColor: Colors.green,
              title: "Call Us",
              subTitle: "+91 9307816479",
              // destination: () {},
              context: context,
            ),
            contactCard(
              icon: Icons.email_outlined,
              iconColor: Colors.blue,
              title: "Email Us",
              subTitle: "ecommercehelp@support.com",
              // destination: () => sendEmail(email),
              context: context,
            ),
            Text(
              "Help Categories",
              style: TextStyle(fontWeight: FontWeight.w700, fontSize: 20),
            ),
          ],
        ),
      ),
    );
  }

  Widget contactCard({
    required IconData icon,
    required Color iconColor,
    required String title,
    required String subTitle,
    // required Future<void> Function() destination,
    required BuildContext context,
  }) {
    return Card(
      elevation: 1,
      color: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: InkWell(
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Row(
            spacing: 13,
            children: [
              CircleAvatar(
                radius: 26,
                backgroundColor: iconColor.withValues(alpha: .15),
                child: Icon(icon),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(fontWeight: FontWeight.w700, fontSize: 17),
                  ),
                  Text(subTitle),
                ],
              ),
            ],
          ),
        ),
        onTap: ()  {
          // await destination();
        },
      ),
    );
  }
}
