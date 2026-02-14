import 'package:ShopCraft/main.dart';
import 'package:ShopCraft/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'for_reverpod.dart';
import 'input_provider.dart';
import 'l10n/app_localizations.dart';




class LoginNotifier extends AsyncNotifier<void> {
  @override
  Future<void> build() async {
    // initial state: nothing to do
  }

  Future<void> login(String email, String password) async {
    state = const AsyncValue.loading();
    await Future.delayed(const Duration(seconds: 1));
    print('the entered email is $email');
    print('the entered password is $password');
    if (email == "test@example.com" && password == "1234") {
      ref.read(authProvider.notifier).state = true;
      state = const AsyncValue.data(null);
    } else {
      state = AsyncValue.error("invalid credentials", StackTrace.current);
    }
  }
}

final loginProvider = AsyncNotifierProvider<LoginNotifier, void>(
  () => LoginNotifier(),
);

class LoginScreen extends ConsumerWidget {
  const LoginScreen({super.key});

  // Make configs static/final so they aren't recreated on every build
  static final emailConfig = ValidationConfig(
    rules: [InputRule.required, InputRule.autoTrim, InputRule.email],
  );

  static final passwordConfig = ValidationConfig(
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

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final loginState = ref.watch(loginProvider);

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

    // Current input values

    final locale = ref.watch(
      localProvider,
    ); // watch locale changes, so reverpod rebuilds this when the language changes(to solve the problem of caching another language error meesagges)

    ref.read(inputProvider(emailConfig).notifier).recomputeError();
    ref.read(inputProvider(passwordConfig).notifier).recomputeError();

    final emailValue = ref.watch(inputProvider(emailConfig)).value;
    final passwordValue = ref.watch(inputProvider(passwordConfig)).value;

    final emailValid = ref.read(inputProvider(emailConfig)).isValid;
    final passwordValid = ref.read(inputProvider(passwordConfig)).isValid;

    // Determine if login button should be enabled
    final canLogin = emailValid && passwordValid && !loginState.isLoading;

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
            maxHeight: MediaQuery.of(context).size.height * 0.6,
          ),
          child: Hero(
            tag: "form background login",
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
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      // App name
                      Text(
                        AppLocalizations.of(context)!.signIn,
                        style: Theme.of(context).textTheme.headlineLarge,
                      ),
                      const SizedBox(height: 20),

                      // Email field
                      SmartTextField(
                        key: ValueKey('email_${locale.toString()}'),
                        label: AppLocalizations.of(context)!.email,
                        config: emailConfig,
                      ),
                      const SizedBox(height: 16),

                      // Password field
                      SmartTextField(
                        key: ValueKey('password_${locale.toString()}'),
                        label: AppLocalizations.of(context)!.password,
                        config: passwordConfig,
                      ),
                      const SizedBox(height: 22),

                      // Login button or loading indicator
                      AnimatedTextButton(
                        onPressed: canLogin
                            ? () {
                                ref
                                    .read(loginProvider.notifier)
                                    .login(emailValue, passwordValue);
                              }
                            : null,
                        child: loginState.isLoading
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
                            : Text(AppLocalizations.of(context)!.signIn),
                      ),

                      // Error display
                      loginState.maybeWhen(
                        error: (err, _) => Text(
                          err == "invalid credentials"
                              ? AppLocalizations.of(
                                  context,
                                )!.invalidCreditionals
                              : "Something went wrong",

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
