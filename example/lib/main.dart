import 'package:flutter/material.dart';
import 'package:kiosk_keyboard_plus/kiosk_keyboard_plus.dart';

void main() {
  runApp(const KeyboardExampleApp());
}

class KeyboardExampleApp extends StatelessWidget {
  const KeyboardExampleApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Kiosk Keyboard Example',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: 'Roboto',
        useMaterial3: true,
      ),
      home: const ExamplesList(),
    );
  }
}

class ExamplesList extends StatelessWidget {
  const ExamplesList({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF00BCD4),
      appBar: AppBar(
        title: const Text('Kiosk Keyboard Examples'),
        backgroundColor: const Color(0xFF00BCD4),
        foregroundColor: Colors.white,
        elevation: 0,
      ),
      body: Center(
        child: Container(
          margin: const EdgeInsets.all(32),
          padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(
            color: const Color(0xFFE8E8E8),
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
              const Text(
                'Select Keyboard Type',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
              const SizedBox(height: 32),
              _buildExampleButton(
                context,
                'Numeric Keyboard',
                'PIN entry example',
                Icons.pin,
                const NumericKeyboardExample(),
              ),
              const SizedBox(height: 16),
              _buildExampleButton(
                context,
                'Text Keyboard',
                'Name entry example',
                Icons.abc,
                const TextKeyboardExample(),
              ),
              const SizedBox(height: 16),
              _buildExampleButton(
                context,
                'Alphanumeric Keyboard',
                'Registration code example',
                Icons.keyboard,
                const RegistrationScreen(),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildExampleButton(
    BuildContext context,
    String title,
    String subtitle,
    IconData icon,
    Widget screen,
  ) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => screen),
          );
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.white,
          foregroundColor: Colors.black87,
          padding: const EdgeInsets.all(20),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        child: Row(
          children: [
            Icon(icon, size: 32, color: const Color(0xFF00BCD4)),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    subtitle,
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey[600],
                    ),
                  ),
                ],
              ),
            ),
            const Icon(Icons.arrow_forward_ios, size: 20),
          ],
        ),
      ),
    );
  }
}

// Numeric Keyboard Example
class NumericKeyboardExample extends StatefulWidget {
  const NumericKeyboardExample({super.key});

  @override
  State<NumericKeyboardExample> createState() => _NumericKeyboardExampleState();
}

class _NumericKeyboardExampleState extends State<NumericKeyboardExample> {
  final TextEditingController _pinController = TextEditingController();

  @override
  void dispose() {
    _pinController.dispose();
    super.dispose();
  }

  void _handleSubmit() {
    if (_pinController.text.isNotEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('PIN Entered: ${_pinController.text}'),
          backgroundColor: const Color(0xFF8BC34A),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF00BCD4),
      appBar: AppBar(
        title: const Text('Numeric Keyboard'),
        backgroundColor: const Color(0xFF00BCD4),
        foregroundColor: Colors.white,
        elevation: 0,
      ),
      body: Center(
        child: Container(
          margin: const EdgeInsets.all(32),
          padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 24),
          decoration: BoxDecoration(
            color: const Color(0xFFE8E8E8),
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
              const Text(
                'Enter Your PIN',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
              const SizedBox(height: 24),
              Container(
                width: 300,
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.grey.shade300),
                ),
                child: TextField(
                  controller: _pinController,
                  readOnly: true,
                  obscureText: true,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 24,
                    letterSpacing: 8,
                    fontWeight: FontWeight.bold,
                  ),
                  decoration: const InputDecoration(
                    border: InputBorder.none,
                    hintText: '• • • •',
                  ),
                ),
              ),
              const SizedBox(height: 32),
              KioskKeyboard(
                controller: _pinController,
                showInputBoxes: false,
                onSubmit: _handleSubmit,
                spacing: 0,
                keyboardType: KeyboardType.numeric,
                keyboardMaxWidth: 60,
                keyboardVerticalSpacing: 12,
                keyboardFontFamily: 'Roboto',
                keyboardFontSize: 24,
                keyboardBtnSize: 60,
                keyboardButtonShape: KeyboardButtonShape.circular,
                buttonFillColor: Colors.white,
                btnTextColor: Colors.black87,
                btnHasBorder: true,
                buttonBorderColor: Colors.grey.shade300,
                btnElevation: 2,
                btnShadowColor: Colors.grey,
                cancelColor: const Color(0xFF00BCD4),
                maxLength: 6,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// Text Keyboard Example
class TextKeyboardExample extends StatefulWidget {
  const TextKeyboardExample({super.key});

  @override
  State<TextKeyboardExample> createState() => _TextKeyboardExampleState();
}

class _TextKeyboardExampleState extends State<TextKeyboardExample> {
  final TextEditingController _nameController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  void _handleSubmit() {
    if (_nameController.text.isNotEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Name Entered: ${_nameController.text}'),
          backgroundColor: const Color(0xFF8BC34A),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF00BCD4),
      appBar: AppBar(
        title: const Text('Text Keyboard'),
        backgroundColor: const Color(0xFF00BCD4),
        foregroundColor: Colors.white,
        elevation: 0,
      ),
      body: Center(
        child: Container(
          margin: const EdgeInsets.all(32),
          padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 24),
          decoration: BoxDecoration(
            color: const Color(0xFFE8E8E8),
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
              const Text(
                'Enter Your Name',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
              const SizedBox(height: 24),
              Container(
                width: 400,
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.grey.shade300),
                ),
                child: TextField(
                  controller: _nameController,
                  readOnly: true,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w500,
                  ),
                  decoration: const InputDecoration(
                    border: InputBorder.none,
                    hintText: 'Type your name',
                  ),
                ),
              ),
              const SizedBox(height: 32),
              KioskKeyboard(
                controller: _nameController,
                showInputBoxes: false,
                onSubmit: _handleSubmit,
                spacing: 0,
                keyboardType: KeyboardType.text,
                keyboardMaxWidth: 85,
                keyboardVerticalSpacing: 10,
                keyboardFontFamily: 'Roboto',
                keyboardFontSize: 18,
                keyboardBtnSize: 50,
                keyboardButtonShape: KeyboardButtonShape.rounded,
                keyboardBtnBorderRadius: BorderRadius.circular(10),
                buttonFillColor: Colors.white,
                buttonBorderColor: Colors.grey.shade300,
                btnTextColor: Colors.black87,
                btnHasBorder: false,
                btnElevation: 2,
                btnShadowColor: Colors.grey,
                cancelColor: const Color(0xFF00BCD4),
                useLowercase: false,
              ),
            ],
          ),
        ),
      ),
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
        const Flexible(
          flex: 3,
          child: Text(
            'Enter registration code to collect your badge:',
            style: TextStyle(
              fontSize: 14,
              color: Colors.black87,
              fontWeight: FontWeight.w400,
            ),
          ),
        ),
        const SizedBox(width: 12),

        // Text field
        Expanded(
          flex: 2,
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
