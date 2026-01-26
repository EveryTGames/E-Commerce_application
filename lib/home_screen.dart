import 'package:ShopCraft/l10n/app_localizations.dart';
import 'package:ShopCraft/utils.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'main.dart';

class HomeScreen extends ConsumerWidget {
  HomeScreen({super.key});

  final List<Map<String, String>> featuredProducts = [
    {
      'title': 'Premium Laptop Collection',
      'image':
          'https://images.unsplash.com/photo-1526374965328-7f61d4dc18c5?w=400&h=300&fit=crop',
    },
    {
      'title': 'Professional Workspace',
      'image':
          'https://images.unsplash.com/photo-1581091226825-a6a2a5aee158?w=400&h=300&fit=crop',
    },
    {
      'title': 'Ambient Lighting',
      'image':
          'https://images.unsplash.com/photo-1500673922987-e212871fec22?w=400&h=300&fit=crop',
    },
  ];

  final List<Map<String, String>> products = [
    {
      'title': 'MacBook Pro 16"',
      'price': '\$2,399',
      'image':
          'https://images.unsplash.com/photo-1488590528505-98d2b5aba04b?w=300&h=200&fit=crop',
    },
    {
      'title': 'Wireless Headphones',
      'price': '\$299',
      'image': 'https:200&fit=crop',
    },
    {
      'title': 'Smart Watch',
      'price': '\$399',
      'image':
          'https://images.unsplash.com/photo-1506744038136-46273834b3fb?w=300&h=200&fit=crop',
    },
    {
      'title': 'Designer Backpack',
      'price': '\$129',
      'image':
          'https://images.unsplash.com/photo-1500673922987-e212871fec22?w=300&h=200&fit=crop',
    },
    {
      'title': 'Premium Keyboard',
      'price': '\$199',
      'image':
          'https://images.unsplash.com/photo-1649972904349-6e44c42644a7?w=300&h=200&fit=crop',
    },
    {
      'title': 'Wireless Mouse',
      'price': '\$79',
      'image':
          'https://images.unsplash.com/photo-1582562124811-c09040d0a901?w=300&h=200&fit=crop',
    },
  ];

  final List<Map<String, String>> hotOffers = [
    {
      'title': '50% Off Electronics',
      'subtitle': 'Limited time offer on all tech gadgets',
      'tag': '50% OFF',
      'tagColor': 'purple',
    },
    {
      'title': 'Free Shipping Weekend',
      'subtitle': 'No delivery charges on orders above \$50',
      'tag': 'FREE',
      'tagColor': 'pink',
    },
  ];

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeMode = ref.watch(themeModeProvider);
    final locale = ref.watch(localProvider);
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.all(16),
              width: double.infinity,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Theme.of(context).colorScheme.primary,
                    Theme.of(context).colorScheme.secondary,
                  ],
                ),
              ),
              child: Stack(
                children: [
                  Center(
                    child: Text(
                      AppLocalizations.of(context)!.ourProducts,
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                  ),
                  PositionedDirectional( //logout
                    start: 8,
                    top: 0,
                    bottom: 0,
                    child: IconButton(
                      onPressed: () {
                        ref.read(authProvider.notifier).state = false;
                      },
                      icon: Icon(Icons.logout_outlined),
                    ),
                  ),
                  PositionedDirectional( //theme mode
                    end: 8,
                    top: 0,
                    bottom: 0,
                    child: IconButton(
                      onPressed: () {
                        ref
                            .read(themeModeProvider.notifier)
                            .state = themeMode == ThemeMode.light
                            ? ThemeMode.dark
                            : ThemeMode.light;
                      },
                      icon: Icon(
                        themeMode == ThemeMode.light
                            ? Icons.dark_mode_outlined
                            : Icons.light_mode_outlined,
                      ),
                    ),
                  ),
                  PositionedDirectional( // language
                    end: 50,
                    top: 0,
                    bottom: 0,
                    child: Column(
                      children: [
                        IconButton(
                          onPressed: () {
                            ref
                                .read(localProvider.notifier)
                                .state = locale == const Locale('en')
                                ? const Locale('ar')
                                : const Locale('en');
                          },
                          icon: Icon(Icons.translate_outlined),
                        ),
                        Text(
                          locale == const Locale('en')
                              ? 'ar'
                              : 'en',
                          style: Theme.of(context).textTheme.bodySmall
                              ,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 24),

            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: carouselCustom(pagesList: featuredProducts),
            ),
            SizedBox(height: 32),

            Padding(
              padding: const EdgeInsets.all(20.0),
              child: GridView.builder(
                shrinkWrap: true,
                // important
                physics: NeverScrollableScrollPhysics(),
                // disable GridView scrolling
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: MediaQuery.of(context).size.width > 600
                      ? 2
                      : 1,
                  crossAxisSpacing: 20,
                  mainAxisSpacing: 30,
                  childAspectRatio: 4 / 2,
                ),
                itemCount: products.length,
                // also don't forget this
                itemBuilder: (context, index) {
                  final product = products[index];
                  return HoverCard(
                    color: Theme.of(context).colorScheme.surfaceContainer,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Expanded(
                          child: Stack(
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.vertical(
                                  top: Radius.circular(16),
                                ),
                                child: CachedNetworkImage(
                                  imageUrl: product['image']!,
                                  fit: BoxFit.cover,
                                  width: double.infinity,
                                  height: double.infinity,
                                  progressIndicatorBuilder:
                                      (context, url, downloadProgress) =>
                                          Center(
                                            child: CircularProgressIndicator(
                                              value: downloadProgress.progress,
                                            ),
                                          ),
                                  errorWidget: (context, url, error) => Icon(
                                    color: Theme.of(context).colorScheme.error,
                                    Icons.error,
                                  ),
                                ),
                              ),
                              Positioned(
                                top: 8,
                                right: 8,
                                child: CircleAvatar(
                                  backgroundColor: Theme.of(
                                    context,
                                  ).colorScheme.primary,
                                  child: IconButton.outlined(
                                    onPressed: () {},
                                    icon: Icon(
                                      Icons.shopping_cart,
                                      color: Theme.of(context).iconTheme.color,
                                      size: 20,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                product['title']!,
                                style: Theme.of(context).textTheme.bodyMedium,
                              ),
                              Text(
                                product['price']!,
                                style: Theme.of(context).textTheme.bodySmall,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),

            SizedBox(height: 32),
            Text(AppLocalizations.of(context)!.hotOffers, style: Theme.of(context).textTheme.titleLarge),

            SizedBox(height: 16),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Center(
                child: ConstrainedBox(
                  constraints: BoxConstraints(maxWidth: 700),
                  // pick any width you want
                  child: ListView.separated(
                    physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: hotOffers.length,
                    itemBuilder: (_, i) {
                      final offer = hotOffers[i];
                      return HoverCard(
                        color: Theme.of(context).colorScheme.surfaceContainer,
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Row(
                            children: [
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      offer['title']!,
                                      style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                        color: Theme.of(
                                          context,
                                        ).colorScheme.onSurface,
                                      ),
                                    ),
                                    SizedBox(height: 4),
                                    Text(
                                      offer['subtitle']!,
                                      style: TextStyle(
                                        fontSize: 14,
                                        color: Theme.of(
                                          context,
                                        ).colorScheme.onSurfaceVariant,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                padding: EdgeInsets.symmetric(
                                  horizontal: 16,
                                  vertical: 8,
                                ),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(30),
                                  gradient: LinearGradient(
                                    colors: offer['tagColor'] == 'purple'
                                        ? [
                                            Theme.of(
                                              context,
                                            ).colorScheme.primary,
                                            Colors.pink,
                                          ]
                                        : [Colors.pink, Colors.orange],
                                  ),
                                ),
                                child: Text(
                                  offer['tag']!,
                                  style: TextStyle(
                                    color: Theme.of(
                                      context,
                                    ).colorScheme.onSurface,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                    separatorBuilder: (_, __) => SizedBox(height: 12),
                  ),
                ),
              ),
            ),

            SizedBox(height: 32),
          ],
        ),
      ),
    );
  }
}
