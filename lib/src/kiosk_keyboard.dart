import 'package:flutter/material.dart';

/// Shape options for input field display.
enum InputShape {
  /// Circular shape for input fields.
  circular,

  /// Rounded corners for input fields.
  rounded,

  /// Default shape with subtle rounded corners.
  defaultShape
}

/// Display type for input fields.
enum InputType {
  /// Underline style with dash underneath.
  dash,

  /// Box style with border around each input.
  box,

  /// No visual input fields displayed.
  none
}

/// Shape options for keyboard buttons.
enum KeyboardButtonShape {
  /// Circular buttons.
  circular,

  /// Rounded corner buttons.
  rounded,

  /// Default button shape with standard rounded corners.
  defaultShape
}

/// Type of keyboard layout to display.
enum KeyboardType {
  /// Numeric keypad layout (0-9).
  numeric,

  /// Text keyboard with alphabetic characters only.
  text,

  /// Combined alphanumeric keyboard with numbers and letters.
  alphanumeric
}

/// Controller for managing keyboard input state.
///
/// This controller manages the input text and notifies listeners when the text changes.
/// It can be used with the [KioskKeyboard] widget's [pinInputController] parameter
/// to display pin-style input boxes.
///
/// Example:
/// ```dart
/// final controller = KioskKeyboardController(length: 6);
/// ```
class KioskKeyboardController extends ChangeNotifier {
  /// The maximum number of characters/input boxes to display.
  int length;

  /// The current input text.
  String text;

  /// Creates a [KioskKeyboardController].
  ///
  /// The [length] parameter specifies the number of input boxes to display.
  /// The [text] parameter sets the initial text value.
  KioskKeyboardController({required this.length, this.text = ''});

  /// Updates the text and notifies all listeners.
  void changeText(String text) {
    this.text = text;
    notifyListeners();
  }

  /// Clears the text and notifies all listeners.
  void clear() {
    text = '';
    notifyListeners();
  }
}

/// A customizable on-screen keyboard widget for kiosk applications.
///
/// This widget provides a fully customizable keyboard that can be used in
/// touch-screen kiosk applications. It supports three keyboard types:
/// - [KeyboardType.numeric]: Number pad layout
/// - [KeyboardType.text]: QWERTY text keyboard
/// - [KeyboardType.alphanumeric]: Combined numbers and letters
///
/// The keyboard can work in two modes:
/// 1. With pin-style input boxes using [pinInputController]
/// 2. With any [TextEditingController] using [controller] and [showInputBoxes] = false
///
/// Example with TextEditingController:
/// ```dart
/// final controller = TextEditingController();
///
/// KioskKeyboard(
///   controller: controller,
///   showInputBoxes: false,
///   onSubmit: () => print(controller.text),
///   spacing: 20,
///   keyboardType: KeyboardType.numeric,
///   keyboardFontFamily: 'Roboto',
/// )
/// ```
///
/// Example with pin boxes:
/// ```dart
/// final pinController = KioskKeyboardController(length: 6);
///
/// KioskKeyboard(
///   pinInputController: pinController,
///   showInputBoxes: true,
///   onSubmit: () => print(pinController.text),
///   spacing: 20,
///   keyboardType: KeyboardType.numeric,
///   keyboardFontFamily: 'Roboto',
/// )
/// ```
class KioskKeyboard extends StatefulWidget {
  /// Shape of keyboard buttons.
  final KeyboardButtonShape keyboardButtonShape;

  /// Shape of input fields (only applies when [showInputBoxes] is true).
  final InputShape inputShape;

  /// Maximum width of the keyboard as a percentage of screen width (0-100).
  final double keyboardMaxWidth;

  /// Vertical spacing between keyboard button rows.
  final double keyboardVerticalSpacing;

  /// Spacing between input fields and keyboard.
  final double spacing;

  /// Background color of keyboard buttons.
  final Color? buttonFillColor;

  /// Border color of keyboard buttons.
  final Color? buttonBorderColor;

  /// Text color of keyboard buttons.
  final Color? btnTextColor;

  /// Whether keyboard buttons have borders.
  final bool btnHasBorder;

  /// Thickness of keyboard button borders.
  final double? btnBorderThickness;

  /// Elevation/shadow depth of keyboard buttons.
  final double? btnElevation;

  /// Shadow color of keyboard buttons.
  final Color? btnShadowColor;

  /// Width of individual input boxes (only when [showInputBoxes] is true).
  final double? inputWidth;

  /// Whether to hide input characters (show asterisks instead).
  final bool isInputHidden;

  /// Color of hidden input characters.
  final Color inputHiddenColor;

  /// Maximum width of input row as a percentage of screen width (0-100).
  final double inputsMaxWidth;

  /// Controller for pin-style input boxes. Use either this or [controller].
  final KioskKeyboardController? pinInputController;

  /// Standard text editing controller. Use either this or [pinInputController].
  final TextEditingController? controller;

  /// Whether to show pin-style input boxes. Set to false when using with TextField.
  final bool showInputBoxes;

  /// Callback function triggered when submit/done is pressed.
  final Function() onSubmit;

  /// Background color of input fields.
  final Color? inputFillColor;

  /// Border color of input fields.
  final Color? inputBorderColor;

  /// Text color inside input fields.
  final Color? inputTextColor;

  /// Whether input fields have borders.
  final bool inputHasBorder;

  /// Thickness of input field borders.
  final double? inputBorderThickness;

  /// Elevation/shadow depth of input fields.
  final double? inputElevation;

  /// Shadow color of input fields.
  final Color? inputShadowColor;

  /// Color for error messages.
  final Color errorColor;

  /// Font size for keyboard button text.
  final double? keyboardFontSize;

  /// Custom border radius for input fields.
  final BorderRadius? inputBorderRadius;

  /// Height of input fields.
  final double? inputHeight;

  /// Color of the backspace/cancel icon.
  final Color? cancelColor;

  /// Extra input option (currently unused).
  final String? extraInput;

  /// Custom icon for the backspace button.
  final Icon? backButton;

  /// Custom icon for the done/submit button.
  final Icon? doneButton;

  /// Display type for input fields.
  final InputType inputType;

  /// Custom border radius for keyboard buttons.
  final BorderRadius? keyboardBtnBorderRadius;

  /// Custom text style for input field text.
  final TextStyle? inputTextStyle;

  /// Custom widget to replace the submit button.
  final Widget? leftExtraInputWidget;

  /// Size of keyboard buttons (width and height).
  final double? keyboardBtnSize;

  /// Border color when an input field has focus/value.
  final Color? focusColor;

  /// Font family for keyboard button text.
  final String? keyboardFontFamily;

  /// Type of keyboard layout to display.
  final KeyboardType keyboardType;

  /// Maximum number of characters allowed. When reached, shows error message.
  final int? maxLength;

  /// Whether to use lowercase letters (true) or uppercase (false).
  final bool useLowercase;

  /// Creates a [KioskKeyboard] widget.
  ///
  /// Either [pinInputController] or [controller] must be provided.
  /// The [spacing], [onSubmit], and [keyboardFontFamily] parameters are required.
  const KioskKeyboard({
    super.key,
    this.keyboardButtonShape = KeyboardButtonShape.defaultShape,
    this.inputShape = InputShape.defaultShape,
    this.keyboardMaxWidth = 80,
    this.keyboardVerticalSpacing = 8,
    required this.spacing,
    this.buttonFillColor,
    this.buttonBorderColor,
    this.btnHasBorder = true,
    this.btnTextColor,
    this.btnBorderThickness,
    this.btnElevation,
    this.btnShadowColor,
    this.inputWidth,
    this.isInputHidden = false,
    this.inputHiddenColor = Colors.black,
    this.inputsMaxWidth = 70,
    this.pinInputController,
    this.controller,
    this.showInputBoxes = true,
    required this.onSubmit,
    this.inputFillColor,
    this.inputBorderColor,
    this.inputTextColor,
    this.inputHasBorder = true,
    this.inputBorderThickness,
    this.inputElevation,
    this.inputShadowColor,
    this.errorColor = Colors.red,
    this.keyboardFontSize,
    this.inputBorderRadius,
    this.inputHeight,
    this.cancelColor,
    required this.keyboardFontFamily,
    this.extraInput,
    this.backButton,
    this.doneButton,
    this.inputType = InputType.box,
    this.keyboardBtnBorderRadius,
    this.inputTextStyle,
    this.leftExtraInputWidget,
    this.keyboardBtnSize,
    this.focusColor,
    this.keyboardType = KeyboardType.numeric,
    this.maxLength,
    this.useLowercase = true,
  });

  @override
  State<KioskKeyboard> createState() => _KioskKeyboardState();
}

class _KioskKeyboardState extends State<KioskKeyboard> {
  List<int> inputNumbers = [];
  late VoidCallback _listener;
  String res = '';
  String errorText = '';

  // Responsive breakpoints
  static const double _mobileBreakpoint = 600;
  static const double _tabletBreakpoint = 900;
  static const double _desktopBreakpoint = 1200;

  // Keyboard layout constants
  static const List<String> _numericRow = [
    '1',
    '2',
    '3',
    '4',
    '5',
    '6',
    '7',
    '8',
    '9'
  ];
  static const List<String> _topRow = [
    'q',
    'w',
    'e',
    'r',
    't',
    'y',
    'u',
    'i',
    'o',
    'p'
  ];
  static const List<String> _middleRow = [
    'a',
    's',
    'd',
    'f',
    'g',
    'h',
    'j',
    'k',
    'l'
  ];
  static const List<String> _bottomRow = ['z', 'x', 'c', 'v', 'b', 'n', 'm'];

  @override
  void initState() {
    super.initState();
    _initializeInputNumbers();
    _setupListener();
    _initializeText();
  }

  void _initializeInputNumbers() {
    if (widget.pinInputController != null) {
      for (int i = 0; i < widget.pinInputController!.length; i++) {
        inputNumbers.add(i);
      }
    }
  }

  void _setupListener() {
    _listener = () {
      inputNumbers.clear();
      _initializeInputNumbers();
      if (mounted) setState(() {});
    };
    widget.pinInputController?.addListener(_listener);
  }

  void _initializeText() {
    if (widget.pinInputController != null &&
        widget.pinInputController!.text.isNotEmpty) {
      res = widget.pinInputController!.text;
    } else if (widget.controller != null) {
      res = widget.controller!.text;
    }
  }

  @override
  void dispose() {
    widget.pinInputController?.removeListener(_listener);
    super.dispose();
  }

  void _handleKeyPress(String btnText) {
    if (widget.maxLength != null && res.length >= widget.maxLength!) {
      setState(() => errorText = 'Maximum length reached');
      return;
    }

    setState(() {
      res = res + btnText;
      widget.pinInputController?.changeText(res);
      widget.controller?.text = res;
      errorText = '';
    });

    if (widget.maxLength == null &&
        widget.pinInputController != null &&
        res.length >= widget.pinInputController!.length) {
      widget.onSubmit();
    }
  }

  void _handleBackspace() {
    if (res.isNotEmpty) {
      setState(() {
        res = res.substring(0, res.length - 1);
        widget.pinInputController?.changeText(res);
        widget.controller?.text = res;
        errorText = '';
      });
    }
  }

  void _handleSubmit() {
    if (res.isNotEmpty) {
      widget.onSubmit();
      setState(() => errorText = '');
    } else {
      setState(() => errorText = 'Please fill all fields');
    }
  }

  // Get responsive sizing based on screen dimensions
  _ResponsiveSize _getResponsiveSize(BoxConstraints constraints) {
    final width = constraints.maxWidth;
    final height = constraints.maxHeight;

    // Determine device category
    final deviceCategory = width < _mobileBreakpoint
        ? _DeviceCategory.mobile
        : width < _tabletBreakpoint
            ? _DeviceCategory.tablet
            : width < _desktopBreakpoint
                ? _DeviceCategory.desktop
                : _DeviceCategory.large;

    // Use the smaller dimension for base calculations to handle orientation
    final baseDimension = width < height ? width : width * 0.6;

    // Calculate button size based on device and constraints
    double buttonSize;
    double fontSize;
    double iconSize;
    double spacing;

    switch (deviceCategory) {
      case _DeviceCategory.mobile:
        buttonSize = baseDimension * 0.12;
        fontSize = baseDimension * 0.045;
        iconSize = baseDimension * 0.025;
        spacing = 4.0;
        break;
      case _DeviceCategory.tablet:
        buttonSize = baseDimension * 0.10;
        fontSize = baseDimension * 0.038;
        iconSize = baseDimension * 0.022;
        spacing = 6.0;
        break;
      case _DeviceCategory.desktop:
        buttonSize = baseDimension * 0.085;
        fontSize = baseDimension * 0.035;
        iconSize = baseDimension * 0.020;
        spacing = 8.0;
        break;
      case _DeviceCategory.large:
        buttonSize = baseDimension * 0.075;
        fontSize = baseDimension * 0.032;
        iconSize = baseDimension * 0.018;
        spacing = 10.0;
        break;
    }

    return _ResponsiveSize(
      buttonSize: buttonSize,
      fontSize: fontSize,
      iconSize: iconSize,
      horizontalSpacing: spacing,
      verticalSpacing: spacing * 0.8,
      inputSize: buttonSize * 0.9,
      deviceCategory: deviceCategory,
    );
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final size = MediaQuery.of(context).size;

        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (widget.showInputBoxes) _buildInputRow(size, constraints),
            if (widget.showInputBoxes && errorText.isNotEmpty)
              _buildErrorText(),
            SizedBox(height: widget.spacing),
            _buildKeyboard(size, constraints),
          ],
        );
      },
    );
  }

  Widget _buildInputRow(Size size, BoxConstraints parentConstraints) {
    final responsiveSize = _getResponsiveSize(parentConstraints);
    final spacing =
        responsiveSize.deviceCategory == _DeviceCategory.mobile ? 4.0 : 8.0;

    return Container(
      constraints: BoxConstraints(
        maxWidth: size.width * (widget.inputsMaxWidth / 100),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: inputNumbers
            .map((e) => Padding(
                  padding: EdgeInsets.all(spacing),
                  child: _buildInputWidget(e, responsiveSize),
                ))
            .toList(),
      ),
    );
  }

  Widget _buildErrorText() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Text(
        errorText,
        style: TextStyle(color: widget.errorColor),
      ),
    );
  }

  Widget _buildKeyboard(Size size, BoxConstraints constraints) {
    switch (widget.keyboardType) {
      case KeyboardType.numeric:
        return _buildNumericKeyboard(size, constraints);
      case KeyboardType.text:
        return _buildTextKeyboard(size, constraints);
      case KeyboardType.alphanumeric:
        return _buildAlphanumericKeyboard(size, constraints);
    }
  }

  Widget _buildAlphanumericKeyboard(Size size, BoxConstraints constraints) {
    final responsiveSize = _getResponsiveSize(constraints);

    return Container(
      constraints: BoxConstraints(
        maxWidth: size.width * (widget.keyboardMaxWidth / 100),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          // Numbers row: 1-9 + backspace
          _buildKeyboardRow([..._numericRow, 'backspace'], responsiveSize),
          // Top letter row: q-p
          _buildKeyboardRow(_topRow, responsiveSize),
          // Middle letter row: a-l
          _buildKeyboardRow(_middleRow, responsiveSize),
          // Bottom letter row: z-m
          _buildKeyboardRow(_bottomRow, responsiveSize),
        ],
      ),
    );
  }

  Widget _buildTextKeyboard(Size size, BoxConstraints constraints) {
    final responsiveSize = _getResponsiveSize(constraints);

    return Container(
      constraints: BoxConstraints(
        maxWidth: size.width * (widget.keyboardMaxWidth / 100),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          _buildKeyboardRow(_topRow, responsiveSize),
          _buildKeyboardRow(_middleRow, responsiveSize),
          _buildKeyboardRow(_bottomRow, responsiveSize),
          _buildSpaceAndSubmitRow(responsiveSize),
        ],
      ),
    );
  }

  Widget _buildNumericKeyboard(Size size, BoxConstraints constraints) {
    final responsiveSize = _getResponsiveSize(constraints);

    return Container(
      constraints: BoxConstraints(
        maxWidth: size.width * (widget.keyboardMaxWidth / 100),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          _buildKeyboardRow(['1', '2', '3'], responsiveSize),
          _buildKeyboardRow(['4', '5', '6'], responsiveSize),
          _buildKeyboardRow(['7', '8', '9'], responsiveSize),
          _buildNumericBottomRow(responsiveSize),
        ],
      ),
    );
  }

  Widget _buildKeyboardRow(List<String> keys, _ResponsiveSize responsiveSize) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: responsiveSize.verticalSpacing),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: keys.map((key) {
          if (key == 'backspace') {
            return _buildBackspaceButton(responsiveSize);
          }
          return _buildKeyButton(key, responsiveSize);
        }).toList(),
      ),
    );
  }

  Widget _buildNumericBottomRow(_ResponsiveSize responsiveSize) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: responsiveSize.verticalSpacing),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _buildBackspaceButton(responsiveSize),
          _buildKeyButton('0', responsiveSize),
          widget.leftExtraInputWidget ?? _buildSubmitButton(responsiveSize),
        ],
      ),
    );
  }

  Widget _buildSpaceAndSubmitRow(_ResponsiveSize responsiveSize) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: responsiveSize.verticalSpacing),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Expanded(child: _buildKeyButton(' ', responsiveSize)),
          widget.leftExtraInputWidget ?? _buildSubmitTextButton(responsiveSize),
        ],
      ),
    );
  }

  Widget _buildKeyButton(String text, _ResponsiveSize responsiveSize) {
    final displayText =
        widget.useLowercase ? text.toLowerCase() : text.toUpperCase();

    return Padding(
      padding:
          EdgeInsets.symmetric(horizontal: responsiveSize.horizontalSpacing),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () => _handleKeyPress(displayText),
          borderRadius: _getButtonBorderRadius(responsiveSize.buttonSize),
          child: Container(
            alignment: Alignment.center,
            width: widget.keyboardBtnSize ?? responsiveSize.buttonSize,
            height: widget.keyboardBtnSize ?? responsiveSize.buttonSize,
            decoration: _getButtonDecoration(responsiveSize.buttonSize),
            child: Text(
              displayText,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontFamily: widget.keyboardFontFamily ??
                    Theme.of(context).textTheme.titleMedium?.fontFamily,
                color: widget.btnTextColor ?? Colors.black87,
                fontSize: widget.keyboardFontSize ?? responsiveSize.fontSize,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildBackspaceButton(_ResponsiveSize responsiveSize) {
    return Padding(
      padding:
          EdgeInsets.symmetric(horizontal: responsiveSize.horizontalSpacing),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: _handleBackspace,
          borderRadius: _getButtonBorderRadius(responsiveSize.buttonSize),
          child: Container(
            alignment: Alignment.center,
            width: widget.keyboardBtnSize ?? responsiveSize.buttonSize,
            height: widget.keyboardBtnSize ?? responsiveSize.buttonSize,
            decoration: _getButtonDecoration(responsiveSize.buttonSize),
            child: widget.backButton ??
                Icon(
                  Icons.backspace_outlined,
                  color: widget.cancelColor ?? Colors.black54,
                  size: responsiveSize.iconSize,
                ),
          ),
        ),
      ),
    );
  }

  Widget _buildSubmitButton(_ResponsiveSize responsiveSize) {
    return Padding(
      padding:
          EdgeInsets.symmetric(horizontal: responsiveSize.horizontalSpacing),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: _handleSubmit,
          borderRadius: _getButtonBorderRadius(responsiveSize.buttonSize),
          child: Container(
            alignment: Alignment.center,
            width: widget.keyboardBtnSize ?? responsiveSize.buttonSize,
            height: widget.keyboardBtnSize ?? responsiveSize.buttonSize,
            decoration: _getButtonDecoration(responsiveSize.buttonSize),
            child: widget.doneButton ??
                Icon(
                  Icons.done,
                  color: widget.btnTextColor ?? Colors.black,
                  size: responsiveSize.iconSize * 1.5,
                ),
          ),
        ),
      ),
    );
  }

  Widget _buildSubmitTextButton(_ResponsiveSize responsiveSize) {
    return TextButton(
      onPressed: () {
        widget.onSubmit();
        setState(() => errorText = '');
      },
      child: Text(
        'Submit',
        style: TextStyle(
          color:
              widget.inputFillColor ?? widget.inputBorderColor ?? Colors.black,
          fontFamily: widget.keyboardFontFamily,
          fontWeight: FontWeight.bold,
          fontSize: responsiveSize.fontSize,
        ),
      ),
    );
  }

  BorderRadius _getButtonBorderRadius(double sizeW) {
    if (widget.keyboardBtnBorderRadius != null) {
      return widget.keyboardBtnBorderRadius!;
    }

    switch (widget.keyboardButtonShape) {
      case KeyboardButtonShape.circular:
        return BorderRadius.circular(sizeW);
      case KeyboardButtonShape.rounded:
        return BorderRadius.circular(12);
      case KeyboardButtonShape.defaultShape:
        return BorderRadius.circular(8);
    }
  }

  BoxDecoration _getButtonDecoration(double sizeW) {
    final isCircular =
        widget.keyboardButtonShape == KeyboardButtonShape.circular;

    return BoxDecoration(
      color: widget.buttonFillColor ?? Colors.white,
      border: widget.btnHasBorder
          ? Border.all(
              color: widget.buttonBorderColor ?? Colors.grey.shade300,
              width: widget.btnBorderThickness ?? 1,
            )
          : null,
      borderRadius: isCircular ? null : _getButtonBorderRadius(sizeW),
      boxShadow: [
        BoxShadow(
          color: widget.btnElevation == null
              ? Colors.grey.withValues(alpha: 0.15)
              : widget.btnShadowColor?.withValues(alpha: 0.3) ??
                  widget.buttonFillColor?.withValues(alpha: 0.3) ??
                  Colors.grey.withValues(alpha: 0.3),
          spreadRadius: 1,
          blurRadius: 4,
          offset: Offset(0, widget.btnElevation ?? 2),
        ),
      ],
      shape: isCircular ? BoxShape.circle : BoxShape.rectangle,
    );
  }

  Widget _buildInputWidget(int position, _ResponsiveSize responsiveSize) {
    final width = widget.inputWidth ?? responsiveSize.inputSize;
    final height = widget.inputHeight ?? width;

    final hasValue = res.length > position;
    final displayChar =
        hasValue ? (widget.isInputHidden ? '*' : res[position]) : '';

    return Container(
      height: height,
      width: width,
      decoration: _getInputDecoration(hasValue),
      child: Center(
        child: Text(
          displayChar,
          style: widget.inputTextStyle ??
              TextStyle(
                color: widget.inputTextColor ?? Colors.black,
                fontSize: height * 0.5,
                fontWeight: FontWeight.w500,
              ),
        ),
      ),
    );
  }

  BoxDecoration _getInputDecoration(bool hasValue) {
    final borderColor = hasValue
        ? (widget.focusColor ?? widget.inputBorderColor ?? Colors.black)
        : (widget.inputBorderColor ?? Colors.grey.shade400);

    Border? border;
    if (widget.inputType == InputType.dash) {
      border = Border(
        bottom: BorderSide(
          color: borderColor,
          width: widget.inputBorderThickness ?? 2,
        ),
      );
    } else if (widget.inputHasBorder) {
      border = Border.all(
        color: borderColor,
        width: widget.inputBorderThickness ?? 1,
      );
    }

    BorderRadius? borderRadius;
    if (widget.inputType != InputType.dash) {
      borderRadius = widget.inputBorderRadius ??
          (widget.inputShape == InputShape.rounded
              ? const BorderRadius.all(Radius.circular(100))
              : widget.inputShape == InputShape.circular
                  ? null
                  : BorderRadius.circular(8));
    }

    return BoxDecoration(
      color: widget.inputFillColor ?? Colors.transparent,
      border: border,
      borderRadius:
          widget.inputShape == InputShape.circular ? null : borderRadius,
      boxShadow: widget.inputElevation != null
          ? [
              BoxShadow(
                color: widget.inputShadowColor?.withValues(alpha: 0.3) ??
                    widget.inputFillColor?.withValues(alpha: 0.3) ??
                    Colors.grey.withValues(alpha: 0.3),
                spreadRadius: 1,
                blurRadius: 4,
                offset: Offset(0, widget.inputElevation!),
              ),
            ]
          : null,
      shape: widget.inputShape == InputShape.circular
          ? BoxShape.circle
          : BoxShape.rectangle,
    );
  }
}

/// Device category for responsive sizing
enum _DeviceCategory {
  mobile,
  tablet,
  desktop,
  large,
}

/// Responsive size configuration
class _ResponsiveSize {
  final double buttonSize;
  final double fontSize;
  final double iconSize;
  final double horizontalSpacing;
  final double verticalSpacing;
  final double inputSize;
  final _DeviceCategory deviceCategory;

  const _ResponsiveSize({
    required this.buttonSize,
    required this.fontSize,
    required this.iconSize,
    required this.horizontalSpacing,
    required this.verticalSpacing,
    required this.inputSize,
    required this.deviceCategory,
  });
}
