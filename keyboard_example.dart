import 'package:flutter/material.dart';
import 'keyboard.dart';

void main() {
  runApp(const KeyboardExampleApp());
}

class KeyboardExampleApp extends StatelessWidget {
  const KeyboardExampleApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Registration Keyboard',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: 'Roboto',
        useMaterial3: true,
      ),
      home: const RegistrationScreen(),
    );
  }
}

class RegistrationScreen extends StatefulWidget {
  const RegistrationScreen({super.key});

  @override
  State<RegistrationScreen> createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  final TextEditingController _textController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _textController.dispose();
    super.dispose();
  }

  void _handleSubmit() {
    if (_textController.text.isNotEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Submitted: ${_textController.text}'),
          backgroundColor: const Color(0xFF8BC34A),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF00BCD4), // Cyan background
      body: Center(
        child: Container(
          margin: const EdgeInsets.all(32),
          padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 24),
          decoration: BoxDecoration(
            color: const Color(0xFFE8E8E8), // Light gray card
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.15),
                blurRadius: 20,
                offset: const Offset(0, 10),
              ),
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Input row with label, text field, and OK button
              _buildInputRow(),
              const SizedBox(height: 16),

              // Registration button
              _buildRegistrationButton(),
              const SizedBox(height: 24),

              // Custom keyboard
              KioskKeyboard(
                controller: _textController,
                showInputBoxes: false,
                onSubmit: _handleSubmit,
                spacing: 0,
                keyboardType: KeyboardType.alphanumeric,
                keyboardMaxWidth: 90,
                keyboardVerticalSpacing: 10,
                keyboardFontFamily: 'Roboto',
                keyboardFontSize: 18,
                keyboardBtnSize: 45,
                keyboardButtonShape: KeyboardButtonShape.rounded,
                keyboardBtnBorderRadius: BorderRadius.circular(10),
                buttonFillColor: Colors.white,
                buttonBorderColor: Colors.grey.shade300,
                btnTextColor: Colors.black87,
                btnHasBorder: false,
                btnElevation: 2,
                btnShadowColor: Colors.grey,
                cancelColor: Colors.black54,
                useLowercase: true,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildInputRow() {
    return Row(
      children: [
        // Label
        const Text(
          'Enter registration code to collect your badge:',
          style: TextStyle(
            fontSize: 14,
            color: Colors.black87,
            fontWeight: FontWeight.w400,
          ),
        ),
        const SizedBox(width: 12),

        // Text field
        Expanded(
          child: Container(
            height: 40,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: Colors.grey.shade300),
            ),
            child: TextField(
              controller: _textController,
              readOnly: true,
              decoration: const InputDecoration(
                border: InputBorder.none,
                contentPadding:
                    EdgeInsets.symmetric(horizontal: 16, vertical: 10),
              ),
              style: const TextStyle(fontSize: 14),
            ),
          ),
        ),
        const SizedBox(width: 12),

        // OK button
        ElevatedButton(
          onPressed: _handleSubmit,
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFF8BC34A), // Green button
            foregroundColor: Colors.white,
            elevation: 0,
            padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 12),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
          child: const Text(
            'Ok',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildRegistrationButton() {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: () {
          // Navigate to registration
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFF00BCD4), // Cyan button
          foregroundColor: Colors.white,
          elevation: 0,
          padding: const EdgeInsets.symmetric(vertical: 14),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(25),
          ),
        ),
        child: const Text(
          "If you haven't registered press here to begin",
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w400,
          ),
        ),
      ),
    );
  }
}
