enum InputRule {
  autoTrim,
  required,
  email,
  password,
  showhidebutton,
  numbersOnly,
  noSymbols,
  minLength,
  maxLength,
  regex,
}

class ValidationConfig {
  final List<InputRule> rules;
  final int? minLength;
  final int? maxLength;
  final RegExp? regex;
  Map<InputRule, String>? customMessages; // custom error messages
  final bool Function(String value)? customValidator;

   ValidationConfig({
    this.rules = const [],
    this.minLength,
    this.maxLength,
    this.regex,
    this.customMessages,
    this.customValidator,
  });
}

class InputValidator {
  static String? validate(String value, ValidationConfig config) {
    if (config.rules.contains(InputRule.autoTrim)) {
      value = value.trim();
    }

    for (final rule in config.rules) {
      switch (rule) {
        case InputRule.autoTrim:
          break;

        case InputRule.noSymbols:
          final allowed = RegExp(r'^[a-zA-Z0-9]+$');
          if (!allowed.hasMatch(value)) {
            return config.customMessages?[InputRule.noSymbols] ?? "Only English letters and numbers allowed";
          }
          break;
        case InputRule.required:
          print("checking if requeired $value");
          if (value.isEmpty) {
            return config.customMessages?[InputRule.required] ?? "This field is required";
          }
          break;

        case InputRule.email:
          final emailRegex = RegExp(
              r'^(?!.*\.\.)[A-Za-z0-9]+@[A-Za-z0-9]+(\.[A-Za-z0-9]+)+$'
          );

          if (!emailRegex.hasMatch(value)) {
           String message = config.customMessages?[InputRule.email] ?? "Invalid email format";
            return message;
          }
          break;


        case InputRule.numbersOnly:
          if (!RegExp(r'^[0-9]+$').hasMatch(value)) {
            return config.customMessages?[InputRule.numbersOnly] ?? "Only numbers allowed";
          }
          break;

        case InputRule.minLength:
          print("checking minimumlenght $value");

          if (value.length < (config.minLength ?? 0)) {
            return config.customMessages?[InputRule.minLength]??
                "Minimum length is ${config.minLength}";
          }
          break;

        case InputRule.maxLength:
          if (value.length > (config.maxLength ?? 99999)) {
            return config.customMessages?[InputRule.maxLength] ??
                "Maximum length is ${config.maxLength}";
          }
          break;

        case InputRule.regex:
          if (config.regex != null && !config.regex!.hasMatch(value)) {
            return config.customMessages?[InputRule.regex] ?? "Invalid format";
          }
          break;
        case InputRule.password:

          break;
        case InputRule.showhidebutton:

          break;
      }
    }

 //   if (config.customValidator != null) {
 //     final ok = config.customValidator!(value);
 //     if (!ok) return config.customMessages?[InputRule.customValidator] ?? "Invalid value";
 //   }

    return null; // all good
  }
}

class InputControl {
  String value = "";
  String? error;

  final ValidationConfig config;

  InputControl({required this.config, this.value = "", this.error}) {
    error ??= config.rules.contains(InputRule.required) && value.isEmpty
        ? (config.customMessages?[InputRule.required] ?? "This field is required")
        : null;
  }

  void update(String newValue) {
    value = newValue;
    error = InputValidator.validate(value, config);
  }

  InputControl copyWith({String? value, String? error}) {
    if (value != null) {
      return InputControl(
        config: config,
        value: value,
        error: error ?? InputValidator.validate(value, config),
      );
    } else {
      return InputControl(
        config: config,
        value: value ?? this.value,
        error: error ?? this.error,
      );
    }
  }

  bool get isValid => error == null;
}
