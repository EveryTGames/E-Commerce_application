import 'package:ShopCraft/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'for_reverpod.dart';
import 'input_provider.dart';
import 'l10n/app_localizations.dart';

class SignUpNotifier extends AsyncNotifier<void> {
  @override
  Future<void> build() async {
    // initial state: nothing to do
  }

  Future<void> signup(String email, String password) async {
    state = const AsyncValue.loading();
    await Future.delayed(const Duration(seconds: 1));

    if (email == "test@example.com" && password == "1234") {
      state = const AsyncValue.data(null);
    } else {
      state = AsyncValue.error("invalid credentials", StackTrace.current);
    }
  }
}

final signUpProvider = AsyncNotifierProvider<SignUpNotifier, void>(
  () => SignUpNotifier(),
);

class SignupScreen extends ConsumerWidget {
  const SignupScreen({super.key});

 static  final passwordConfig = ValidationConfig(
    rules: [
      InputRule.required,
      InputRule.autoTrim,
      InputRule.minLength,
      InputRule.noSymbols,
      InputRule.password,
      InputRule.showhidebutton,
    ],
    minLength: 4,
  );
  static final emailConfig = ValidationConfig(
    rules: [InputRule.required, InputRule.autoTrim, InputRule.email],
  );
  static final firstNameConfig = ValidationConfig(
    rules: [InputRule.required, InputRule.autoTrim, InputRule.noSymbols],
  );
  static final lastNameConfig = ValidationConfig(
    rules: [InputRule.required, InputRule.autoTrim, InputRule.noSymbols],
  );

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final signupState = ref.watch(signUpProvider);
    final customMessage = {
      InputRule.minLength: "${AppLocalizations.of(context)!.minimumLenghtIs} 4",
      InputRule.noSymbols: AppLocalizations.of(
        context,
      )!.onlyLettersAndNumbersAllowed,
      InputRule.required: AppLocalizations.of(context)!.thisFieldIsrequired,
      InputRule.email: AppLocalizations.of(context)!.invalidEmailFormat,
    };

    passwordConfig.customMessages = customMessage;
    emailConfig.customMessages = customMessage;
    firstNameConfig.customMessages = customMessage;
    lastNameConfig.customMessages = customMessage;



    ref.read(inputProvider(emailConfig).notifier).recomputeError();
    ref.read(inputProvider(passwordConfig).notifier).recomputeError();
    ref.read(inputProvider(firstNameConfig).notifier).recomputeError();
    ref.read(inputProvider(lastNameConfig).notifier).recomputeError();

    // Current input values
    final firstNameValue = ref.watch(inputProvider(firstNameConfig)).value;
    final lastNameValue = ref.watch(inputProvider(lastNameConfig)).value;
    final emailValue = ref.watch(inputProvider(emailConfig)).value;
    final passwordValue = ref.watch(inputProvider(passwordConfig)).value;

    final firstNameValid = ref.read(inputProvider(firstNameConfig)).isValid;
    final lastNameValid = ref.read(inputProvider(lastNameConfig)).isValid;
    final emailValid = ref.read(inputProvider(emailConfig)).isValid;
    final passwordValid = ref.read(inputProvider(passwordConfig)).isValid;

    // Determine if login button should be enabled
    final canLogin =
        firstNameValid &&
        lastNameValid &&
        emailValid &&
        passwordValid &&
        !signupState.isLoading;

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.all(12.0),
          child: Hero(
            tag: "appTitle",
            child: Text(
              AppLocalizations.of(context)!.appName,
              style: Theme.of(context).textTheme.titleLarge,
            ),
          ),
        ),
        ConstrainedBox(
          constraints: BoxConstraints(
            maxWidth: MediaQuery.of(context).size.height * 0.7,
            maxHeight: MediaQuery.of(context).size.height * 0.8,
          ),
          child: Hero(
            tag: "form background signup",
            child: Container(
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.surface,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 24,
                  vertical: 12,
                ),
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    spacing: 16,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      // App name
                      Text(
                        AppLocalizations.of(context)!.signUp,
                        style: Theme.of(context).textTheme.headlineLarge,
                      ),
                      const SizedBox(height: 5),

                      // Email field
                      SmartTextField(
                        label: AppLocalizations.of(context)!.email,
                        config: emailConfig,
                      ),

                      // Password field
                      SmartTextField(
                        label: AppLocalizations.of(context)!.password,
                        config: passwordConfig,
                      ),
                      SmartTextField(
                        label: AppLocalizations.of(context)!.firstName,
                        config: firstNameConfig,
                      ),
                      SmartTextField(
                        label: AppLocalizations.of(context)!.lastName,
                        config: lastNameConfig,
                      ),

                      // Login button or loading indicator
                      AnimatedTextButton(
                        onPressed: canLogin
                            ? () {
                                ref
                                    .read(signUpProvider.notifier)
                                    .signup(emailValue, passwordValue);
                              }
                            : null,
                        child: signupState.isLoading
                            ? SizedBox(
                                width: 24,
                                height: 24,
                                child: CircularProgressIndicator(
                                  color: Theme.of(
                                    context,
                                  ).colorScheme.onSurface,
                                  strokeWidth: 2,
                                ),
                              )
                            : Text(AppLocalizations.of(context)!.signUp),
                      ),

                      // Error display
                      signupState.maybeWhen(
                        error: (err, _) => Text(
                          err ==
                                  AppLocalizations.of(
                                    context,
                                  )!.invalidCreditionals
                              ? AppLocalizations.of(
                                  context,
                                )!.invalidCreditionals
                              : AppLocalizations.of(context)!.error,
                          style: Theme.of(context).textTheme.labelSmall,
                        ),
                        orElse: () => const SizedBox.shrink(),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
