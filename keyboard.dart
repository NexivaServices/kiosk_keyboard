import 'package:flutter/material.dart';

enum InputShape { circular, rounded, defaultShape }

enum InputType { dash, box, none }

enum KeyboardButtonShape { circular, rounded, defaultShape }

enum KeyboardType { numeric, text, alphanumeric }

class KioskKeyboardController extends ChangeNotifier {
  int length;
  String text;
  KioskKeyboardController({required this.length, this.text = ''});

  void changeText(String text) {
    this.text = text;
    notifyListeners();
  }

  void clear() {
    text = '';
    notifyListeners();
  }
}

class KioskKeyboard extends StatefulWidget {
  final KeyboardButtonShape keyboardButtonShape;
  final InputShape inputShape;
  final double keyboardMaxWidth;
  final double keyboardVerticalSpacing;
  final double spacing;
  final Color? buttonFillColor;
  final Color? buttonBorderColor;
  final Color? btnTextColor;
  final bool btnHasBorder;
  final double? btnBorderThickness;
  final double? btnElevation;
  final Color? btnShadowColor;
  final double? inputWidth;
  final bool isInputHidden;
  final Color inputHiddenColor;
  final double inputsMaxWidth;
  final KioskKeyboardController? pinInputController;
  final TextEditingController? controller;
  final bool showInputBoxes;
  final Function() onSubmit;
  final Color? inputFillColor;
  final Color? inputBorderColor;
  final Color? inputTextColor;
  final bool inputHasBorder;
  final double? inputBorderThickness;
  final double? inputElevation;
  final Color? inputShadowColor;
  final Color errorColor;
  final double? keyboardFontSize;
  final BorderRadius? inputBorderRadius;
  final double? inputHeight;
  final Color? cancelColor;
  final String? extraInput;
  final Icon? backButton;
  final Icon? doneButton;
  final InputType inputType;
  final BorderRadius? keyboardBtnBorderRadius;
  final TextStyle? inputTextStyle;
  final Widget? leftExtraInputWidget;
  final double? keyboardBtnSize;
  final Color? focusColor;
  final String? keyboardFontFamily;
  final KeyboardType keyboardType;
  final int? maxLength;
  final bool useLowercase;

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

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        if (widget.showInputBoxes) _buildInputRow(size),
        if (widget.showInputBoxes && errorText.isNotEmpty) _buildErrorText(),
        SizedBox(height: widget.spacing),
        _buildKeyboard(size),
      ],
    );
  }

  Widget _buildInputRow(Size size) {
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
                  padding: const EdgeInsets.all(8.0),
                  child: _buildInputWidget(e),
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

  Widget _buildKeyboard(Size size) {
    switch (widget.keyboardType) {
      case KeyboardType.numeric:
        return _buildNumericKeyboard(size);
      case KeyboardType.text:
        return _buildTextKeyboard(size);
      case KeyboardType.alphanumeric:
        return _buildAlphanumericKeyboard(size);
    }
  }

  Widget _buildAlphanumericKeyboard(Size size) {
    return Container(
      constraints: BoxConstraints(
        maxWidth: size.width * (widget.keyboardMaxWidth / 100),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          // Numbers row: 1-9 + backspace
          _buildKeyboardRow([..._numericRow, 'backspace']),
          // Top letter row: q-p
          _buildKeyboardRow(_topRow),
          // Middle letter row: a-l
          _buildKeyboardRow(_middleRow),
          // Bottom letter row: z-m
          _buildKeyboardRow(_bottomRow),
        ],
      ),
    );
  }

  Widget _buildTextKeyboard(Size size) {
    return Container(
      constraints: BoxConstraints(
        maxWidth: size.width * (widget.keyboardMaxWidth / 100),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          _buildKeyboardRow(_topRow),
          _buildKeyboardRow(_middleRow),
          _buildKeyboardRow([..._bottomRow, 'backspace']),
          _buildSpaceAndSubmitRow(),
        ],
      ),
    );
  }

  Widget _buildNumericKeyboard(Size size) {
    return Container(
      constraints: BoxConstraints(
        maxWidth: size.width * (widget.keyboardMaxWidth / 100),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          _buildKeyboardRow(['1', '2', '3']),
          _buildKeyboardRow(['4', '5', '6']),
          _buildKeyboardRow(['7', '8', '9']),
          _buildNumericBottomRow(),
        ],
      ),
    );
  }

  Widget _buildKeyboardRow(List<String> keys) {
    return Padding(
      padding:
          EdgeInsets.symmetric(vertical: widget.keyboardVerticalSpacing / 2),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: keys.map((key) {
          if (key == 'backspace') {
            return _buildBackspaceButton();
          }
          return _buildKeyButton(key);
        }).toList(),
      ),
    );
  }

  Widget _buildNumericBottomRow() {
    return Padding(
      padding:
          EdgeInsets.symmetric(vertical: widget.keyboardVerticalSpacing / 2),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          _buildBackspaceButton(),
          _buildKeyButton('0'),
          widget.leftExtraInputWidget ?? _buildSubmitIconButton(),
        ],
      ),
    );
  }

  Widget _buildSpaceAndSubmitRow() {
    return Padding(
      padding:
          EdgeInsets.symmetric(vertical: widget.keyboardVerticalSpacing / 2),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Expanded(child: _buildKeyButton(' ')),
          widget.leftExtraInputWidget ?? _buildSubmitTextButton(),
        ],
      ),
    );
  }

  Widget _buildKeyButton(String text) {
    final sizeW = MediaQuery.of(context).size.width;
    final displayText =
        widget.useLowercase ? text.toLowerCase() : text.toUpperCase();

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: sizeW * 0.005),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () => _handleKeyPress(displayText),
          borderRadius: _getButtonBorderRadius(sizeW),
          child: Container(
            alignment: Alignment.center,
            width: widget.keyboardBtnSize ?? sizeW * 0.08,
            height: widget.keyboardBtnSize ?? sizeW * 0.08,
            decoration: _getButtonDecoration(sizeW),
            child: Text(
              displayText,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontFamily: widget.keyboardFontFamily ??
                    Theme.of(context).textTheme.titleMedium?.fontFamily,
                color: widget.btnTextColor ?? Colors.black87,
                fontSize: widget.keyboardFontSize ?? sizeW * 0.035,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildBackspaceButton() {
    final sizeW = MediaQuery.of(context).size.width;

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: sizeW * 0.005),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: _handleBackspace,
          borderRadius: _getButtonBorderRadius(sizeW),
          child: Container(
            alignment: Alignment.center,
            width: widget.keyboardBtnSize ?? sizeW * 0.08,
            height: widget.keyboardBtnSize ?? sizeW * 0.08,
            decoration: _getButtonDecoration(sizeW),
            child: widget.backButton ??
                Icon(
                  Icons.backspace_outlined,
                  color: widget.cancelColor ?? Colors.black54,
                  size: sizeW * 0.02,
                ),
          ),
        ),
      ),
    );
  }

  Widget _buildSubmitIconButton() {
    return Expanded(
      child: IconButton(
        onPressed: _handleSubmit,
        icon: widget.doneButton ??
            Icon(
              Icons.done,
              color: widget.inputFillColor ??
                  widget.inputBorderColor ??
                  Colors.black,
            ),
      ),
    );
  }

  Widget _buildSubmitTextButton() {
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

  Widget _buildInputWidget(int position) {
    final size = MediaQuery.of(context).size;
    final width = widget.inputWidth ?? size.width * 0.1;
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
