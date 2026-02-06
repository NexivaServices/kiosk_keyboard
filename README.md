# Kiosk Keyboard Plus

A highly customizable on-screen keyboard widget for Flutter kiosk applications. Perfect for touch-screen applications, registration systems, and any scenario where you need a custom keyboard interface.

[![pub package](https://img.shields.io/pub/v/kiosk_keyboard_plus.svg)](https://pub.dev/packages/kiosk_keyboard_plus)

## Features

✨ **Three Keyboard Types:**

- **Numeric**: Traditional number pad layout (0-9)
- **Text**: QWERTY text keyboard layout
- **Alphanumeric**: Combined numbers and letters

🎨 **Highly Customizable:**

- Customize button shapes (circular, rounded, default)
- Customize input field shapes and styles
- Full control over colors, sizes, and fonts
- Configurable spacing and elevation
- Custom icons for backspace and submit buttons

🔒 **Security Features:**

- Optional input hiding (show \* instead of characters)
- Maximum length validation
- Error handling and display

📱 **Responsive Design:**

- Intelligent device detection (mobile, tablet, desktop, large screens)
- Automatic breakpoint-based sizing (600px, 900px, 1200px)
- Adaptive button sizes and spacing for each screen size
- Orientation-aware layout adjustments
- Optimized font sizes and icon scaling
- LayoutBuilder-based responsive behavior
- Consistent appearance across all devices

## Screenshots

### Numeric Keyboard

![Numeric Keyboard](https://raw.githubusercontent.com/NexivaServices/kiosk_keyboard_plus/main/screenshots/numeric_keyboard.png)

### Text Keyboard

![Text Keyboard](https://raw.githubusercontent.com/NexivaServices/kiosk_keyboard_plus/main/screenshots/text_keyboard.png)

### Alphanumeric Keyboard

![Alphanumeric Keyboard](https://raw.githubusercontent.com/NexivaServices/kiosk_keyboard_plus/main/screenshots/alphanumeric_keyboard.png)

## Installation

Add this to your package's `pubspec.yaml` file:

```yaml
dependencies:
  kiosk_keyboard_plus: ^1.0.0
```

Then run:

```bash
flutter pub get
```

## Usage

### Basic Example with Pin Boxes

```dart
import 'package:flutter/material.dart';
import 'package:kiosk_keyboard_plus/kiosk_keyboard_plus.dart';

class MyKeyboardScreen extends StatefulWidget {
  @override
  _MyKeyboardScreenState createState() => _MyKeyboardScreenState();
}

class _MyKeyboardScreenState extends State<MyKeyboardScreen> {
  late KioskKeyboardController _controller;

  @override
  void initState() {
    super.initState();
    _controller = KioskKeyboardController(length: 6);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _handleSubmit() {
    print('Submitted: ${_controller.text}');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: KioskKeyboard(
          pinInputController: _controller,
          onSubmit: _handleSubmit,
          spacing: 20,
          keyboardType: KeyboardType.numeric,
          keyboardFontFamily: 'Roboto',
        ),
      ),
    );
  }
}
```

### Using with TextField (TextEditingController)

```dart
import 'package:flutter/material.dart';
import 'package:kiosk_keyboard_plus/kiosk_keyboard_plus.dart';

class TextFieldKeyboardExample extends StatefulWidget {
  @override
  _TextFieldKeyboardExampleState createState() => _TextFieldKeyboardExampleState();
}

class _TextFieldKeyboardExampleState extends State<TextFieldKeyboardExample> {
  final TextEditingController _controller = TextEditingController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _handleSubmit() {
    print('Submitted: ${_controller.text}');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: TextField(
              controller: _controller,
              readOnly: true,
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 24),
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Enter value',
              ),
            ),
          ),
          KioskKeyboard(
            controller: _controller,
            showInputBoxes: false, // Don't show pin-style boxes
            onSubmit: _handleSubmit,
            spacing: 20,
            keyboardType: KeyboardType.numeric,
            keyboardFontFamily: 'Roboto',
          ),
        ],
      ),
    );
  }
}
```

### Numeric Keyboard

```dart
KioskKeyboard(
  pinInputController: _controller,
  onSubmit: _handleSubmit,
  spacing: 20,
  keyboardType: KeyboardType.numeric,
  keyboardButtonShape: KeyboardButtonShape.rounded,
  buttonFillColor: Colors.white,
  btnTextColor: Colors.black87,
  keyboardFontFamily: 'Roboto',
)
```

### Text Keyboard

```dart
KioskKeyboard(
  pinInputController: _controller,
  onSubmit: _handleSubmit,
  spacing: 20,
  keyboardType: KeyboardType.text,
  useLowercase: true,
  keyboardFontFamily: 'Roboto',
)
```

### Alphanumeric Keyboard

```dart
KioskKeyboard(
  pinInputController: _controller,
  onSubmit: _handleSubmit,
  spacing: 20,
  keyboardType: KeyboardType.alphanumeric,
  keyboardMaxWidth: 90,
  keyboardFontFamily: 'Roboto',
)
```

### With Custom Styling

```dart
KioskKeyboard(
  pinInputController: _controller,
  onSubmit: _handleSubmit,
  spacing: 15,
  keyboardType: KeyboardType.numeric,

  // Keyboard button styling
  keyboardButtonShape: KeyboardButtonShape.circular,
  buttonFillColor: Colors.blue,
  buttonBorderColor: Colors.blue.shade700,
  btnTextColor: Colors.white,
  btnHasBorder: true,
  btnBorderThickness: 2,
  btnElevation: 4,
  keyboardBtnSize: 50,

  // Input field styling
  inputShape: InputShape.rounded,
  inputFillColor: Colors.grey.shade200,
  inputBorderColor: Colors.blue,
  inputTextColor: Colors.black,
  inputType: InputType.box,
  focusColor: Colors.green,

  keyboardFontFamily: 'Roboto',
)
```

### Hidden Input (for PINs/Passwords)

```dart
KioskKeyboard(
  pinInputController: _controller,
  onSubmit: _handleSubmit,
  spacing: 20,
  keyboardType: KeyboardType.numeric,
  isInputHidden: true, // Shows * instead of numbers
  inputHiddenColor: Colors.black,
  keyboardFontFamily: 'Roboto',
)
```

### With Maximum Length

```dart
KioskKeyboard(
  pinInputController: _controller,
  onSubmit: _handleSubmit,
  spacing: 20,
  keyboardType: KeyboardType.alphanumeric,
  maxLength: 10, // Limits input to 10 characters
  errorColor: Colors.red,
  keyboardFontFamily: 'Roboto',
)
```

## API Reference

### KioskKeyboard

Main widget for displaying the keyboard.

#### Required Parameters

| Parameter            | Type                      | Description                             |
| -------------------- | ------------------------- | --------------------------------------- |
| `pinInputController` | `KioskKeyboardController` | Controller for managing input state     |
| `onSubmit`           | `Function()`              | Callback when submit is pressed         |
| `spacing`            | `double`                  | Space between input fields and keyboard |
| `keyboardFontFamily` | `String?`                 | Font family for keyboard buttons        |

#### Keyboard Appearance

| Parameter                 | Type                  | Default        | Description                   |
| ------------------------- | --------------------- | -------------- | ----------------------------- |
| `keyboardType`            | `KeyboardType`        | `numeric`      | Type of keyboard layout       |
| `keyboardButtonShape`     | `KeyboardButtonShape` | `defaultShape` | Shape of keyboard buttons     |
| `keyboardMaxWidth`        | `double`              | `80`           | Max width as % of screen      |
| `keyboardVerticalSpacing` | `double`              | `8`            | Vertical spacing between rows |
| `keyboardBtnSize`         | `double?`             | `null`         | Custom button size            |
| `keyboardFontSize`        | `double?`             | `null`         | Font size for keyboard text   |
| `keyboardBtnBorderRadius` | `BorderRadius?`       | `null`         | Custom border radius          |
| `useLowercase`            | `bool`                | `true`         | Use lowercase letters         |

#### Button Styling

| Parameter            | Type      | Default | Description                  |
| -------------------- | --------- | ------- | ---------------------------- |
| `buttonFillColor`    | `Color?`  | `null`  | Background color of buttons  |
| `buttonBorderColor`  | `Color?`  | `null`  | Border color of buttons      |
| `btnTextColor`       | `Color?`  | `null`  | Text color of buttons        |
| `btnHasBorder`       | `bool`    | `true`  | Whether buttons have borders |
| `btnBorderThickness` | `double?` | `null`  | Border thickness             |
| `btnElevation`       | `double?` | `null`  | Button elevation/shadow      |
| `btnShadowColor`     | `Color?`  | `null`  | Shadow color                 |
| `cancelColor`        | `Color?`  | `null`  | Color for backspace icon     |
| `backButton`         | `Icon?`   | `null`  | Custom backspace icon        |
| `doneButton`         | `Icon?`   | `null`  | Custom submit icon           |

#### Input Field Styling

| Parameter              | Type            | Default        | Description                 |
| ---------------------- | --------------- | -------------- | --------------------------- |
| `inputShape`           | `InputShape`    | `defaultShape` | Shape of input fields       |
| `inputType`            | `InputType`     | `box`          | Type of input display       |
| `inputsMaxWidth`       | `double`        | `70`           | Max width as % of screen    |
| `inputWidth`           | `double?`       | `null`         | Width of each input field   |
| `inputHeight`          | `double?`       | `null`         | Height of each input field  |
| `inputFillColor`       | `Color?`        | `null`         | Background color            |
| `inputBorderColor`     | `Color?`        | `null`         | Border color                |
| `inputTextColor`       | `Color?`        | `null`         | Text color                  |
| `inputHasBorder`       | `bool`          | `true`         | Whether inputs have borders |
| `inputBorderThickness` | `double?`       | `null`         | Border thickness            |
| `inputBorderRadius`    | `BorderRadius?` | `null`         | Custom border radius        |
| `inputElevation`       | `double?`       | `null`         | Input elevation/shadow      |
| `inputShadowColor`     | `Color?`        | `null`         | Shadow color                |
| `inputTextStyle`       | `TextStyle?`    | `null`         | Custom text style           |
| `focusColor`           | `Color?`        | `null`         | Border color when filled    |

#### Input Behavior

| Parameter          | Type    | Default        | Description               |
| ------------------ | ------- | -------------- | ------------------------- |
| `isInputHidden`    | `bool`  | `false`        | Hide input characters     |
| `inputHiddenColor` | `Color` | `Colors.black` | Color of hidden character |
| `maxLength`        | `int?`  | `null`         | Maximum input length      |
| `errorColor`       | `Color` | `Colors.red`   | Color for error messages  |

#### Custom Widgets

| Parameter              | Type      | Default | Description                      |
| ---------------------- | --------- | ------- | -------------------------------- |
| `leftExtraInputWidget` | `Widget?` | `null`  | Custom widget in place of submit |
| `extraInput`           | `String?` | `null`  | Extra input option               |

### KioskKeyboardController

Controller for managing keyboard input state.

```dart
KioskKeyboardController({
  required int length,  // Number of input fields
  String text = '',     // Initial text
})
```

#### Methods

- `changeText(String text)` - Update the input text
- `clear()` - Clear all input

#### Properties

- `text` - Current input text
- `length` - Number of input fields

### Enums

#### KeyboardType

- `KeyboardType.numeric` - Numeric keyboard (0-9)
- `KeyboardType.text` - Text keyboard (QWERTY)
- `KeyboardType.alphanumeric` - Combined numbers and letters

#### KeyboardButtonShape

- `KeyboardButtonShape.circular` - Circular buttons
- `KeyboardButtonShape.rounded` - Rounded corner buttons
- `KeyboardButtonShape.defaultShape` - Standard rounded corners

#### InputShape

- `InputShape.circular` - Circular input fields
- `InputShape.rounded` - Rounded input fields
- `InputShape.defaultShape` - Standard input fields

#### InputType

- `InputType.box` - Box style input fields
- `InputType.dash` - Underline style input fields
- `InputType.none` - No visual input fields

## Example App

Check out the [example](example/) directory for a complete working example of a registration kiosk application.

To run the example:

```bash
cd example
flutter run
```

## Contributing

Contributions are welcome! Please feel free to submit a Pull Request.

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## Author

Created for kiosk and touch-screen applications.

## Issues

Please file any issues, bugs, or feature requests on the [GitHub issues page](https://github.com/yourusername/kiosk_keyboard/issues).
