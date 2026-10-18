import 'package:ecommerce/features/auth/presentation/provider/auth_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class UserDetails extends ConsumerWidget {
  const UserDetails({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(authProvider).value;
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: Colors.white,
      appBar: AppBar(title: const Text("Profile")),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Center(
            child: Padding(
              padding: const EdgeInsets.all(35),
              child: Form(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Name *",
                      style: TextStyle(
                        color: Color(0xFF3B0168),
                        fontWeight: FontWeight.w600,
                        fontSize: 20,
                      ),
                    ),
                    const SizedBox(height: 10),
                    TextFormField(
                      initialValue: user!.username,
                      enabled: false,
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Color(0xFFE9E1EE),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide(color: Color(0xFFE9E1EE)),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    Text(
                      "Mobile Number *",
                      style: TextStyle(
                        color: Color(0xFF3B0168),
                        fontWeight: FontWeight.w600,
                        fontSize: 20,
                      ),
                    ),
                    const SizedBox(height: 10),
                    TextFormField(
                      initialValue: "575556745",
                      enabled: false,
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Color(0xFFE9E1EE),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide(color: Color(0xFFE9E1EE)),
                        ),
                      ),

                      style: TextStyle(color: Color(0xFFA08CAF)),
                    ),
                    const SizedBox(height: 20),
                    Text(
                      "Email Address *",
                      style: TextStyle(
                        color: Color(0xFF3B0168),
                        fontWeight: FontWeight.w600,
                        fontSize: 20,
                      ),
                    ),
                    const SizedBox(height: 10),
                    TextFormField(
                      initialValue: user.email,
                      enabled: false,
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Color(0xFFE9E1EE),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide(color: Color(0xFFE9E1EE)),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
