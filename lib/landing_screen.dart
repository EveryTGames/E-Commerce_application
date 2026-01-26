import 'package:ShopCraft/l10n/app_localizations.dart';
import 'package:ShopCraft/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class LandScreen extends ConsumerWidget {
  const LandScreen({super.key});


  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return  Column(
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

            Wrap(
              spacing: 24,
              runSpacing: 30,
              children: [
                HoverImage(imagePath: 'assets/cat2.png'),
                HoverImage(imagePath: 'assets/cat.png'),
              ],
            ),

            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Wrap(
                spacing: 12,
                runSpacing: 12,
                children: [
                  Hero(
                    tag: "form background login",
                    child: AnimatedTextButton(
                      onPressed: () {
                        print("signing in");
                        //ref.read(authProvider.notifier).state=true;
                        context.push('/login');
                      },
                      text: AppLocalizations.of(context)!.signIn,
                    ),
                  ),
                  Hero(
                    tag: "form background signup",
                    child: AnimatedTextButton(
                      onPressed: () {
                        print('signing up');
                        context.push('/signup');
                      },
                      text: AppLocalizations.of(context)!.signUp,
                    ),
                  ),
                ],
              ),
            ),
          ],
    );
  }
}
