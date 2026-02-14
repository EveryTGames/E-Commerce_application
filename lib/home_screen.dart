import 'package:ShopCraft/l10n/app_localizations.dart';
import 'package:ShopCraft/utils.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

import 'main.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  // Simulated API Responses

  static final Map<String, dynamic> homeResponseEn = {
    "featuredProducts": [
      {
        "title": "Premium Laptop Collection",
        "image":
            "https://images.unsplash.com/photo-1526374965328-7f61d4dc18c5?w=400&h=300&fit=crop",
      },
      {
        "title": "Professional Workspace",
        "image":
            "https://images.unsplash.com/photo-1581091226825-a6a2a5aee158?w=400&h=300&fit=crop",
      },
      {
        "title": "Ambient Lighting",
        "image":
            "https://images.unsplash.com/photo-1500673922987-e212871fec22?w=400&h=300&fit=crop",
      },
    ],
    "products": [
      {
        "title": "MacBook Pro 16\"",
        "price": 2399,
        "currency": "USD",
        "image":
            "https://images.unsplash.com/photo-1488590528505-98d2b5aba04b?w=300&h=200&fit=crop",
      },
      {
        "title": "Wireless Headphones",
        "price": 299,
        "currency": "USD",
        "image":
            "https://images.unsplash.com/photo-1582562124811-c09040d0a901?w=300&h=200&fit=crop",
      },
      {
        "title": "Smart Watch",
        "price": 399,
        "currency": "USD",
        "image":
            "https://images.unsplash.com/photo-1506744038136-46273834b3fb?w=300&h=200&fit=crop",
      },
    ],
    "hotOffers": [
      {
        "title": "50% Off Electronics",
        "subtitle": "Limited time offer on all tech gadgets",
        "tag": "50% OFF",
        "tagColor": "purple",
      },
      {
        "title": "Free Shipping Weekend",
        "subtitle": "No delivery charges on orders above \$50",
        "tag": "FREE",
        "tagColor": "pink",
      },
    ],
  };

  static final Map<String, dynamic> homeResponseAr = {
    "featuredProducts": [
      {
        "title": "مجموعة لابتوبات فاخرة",
        "image":
            "https://images.unsplash.com/photo-1526374965328-7f61d4dc18c5?w=400&h=300&fit=crop",
      },
      {
        "title": "بيئة عمل احترافية",
        "image":
            "https://images.unsplash.com/photo-1581091226825-a6a2a5aee158?w=400&h=300&fit=crop",
      },
      {
        "title": "إضاءة محيطية",
        "image":
            "https://images.unsplash.com/photo-1500673922987-e212871fec22?w=400&h=300&fit=crop",
      },
    ],
    "products": [
      {
        "title": "ماك بوك برو 16 بوصة",
        "price": 2399,
        "currency": "USD",
        "image":
            "https://images.unsplash.com/photo-1488590528505-98d2b5aba04b?w=300&h=200&fit=crop",
      },
      {
        "title": "سماعات لاسلكية",
        "price": 299,
        "currency": "USD",
        "image":
            "https://images.unsplash.com/photo-1582562124811-c09040d0a901?w=300&h=200&fit=crop",
      },
      {
        "title": "ساعة ذكية",
        "price": 399,
        "currency": "USD",
        "image":
            "https://images.unsplash.com/photo-1506744038136-46273834b3fb?w=300&h=200&fit=crop",
      },
    ],
    "hotOffers": [
      {
        "title": "خصم 50٪ على الإلكترونيات",
        "subtitle": "عرض لفترة محدودة على جميع الأجهزة التقنية",
        "tag": "خصم 50٪",
        "tagColor": "purple",
      },
      {
        "title": "شحن مجاني في نهاية الأسبوع",
        "subtitle": "بدون رسوم توصيل للطلبات فوق 50 دولار",
        "tag": "مجاني",
        "tagColor": "pink",
      },
    ],
  };

  Map<String, dynamic> getHomeResponse(Locale locale) {
    return locale.languageCode == 'ar' ? homeResponseAr : homeResponseEn;
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeMode = ref.watch(themeModeProvider);
    final locale = ref.watch(localProvider);

    final response = getHomeResponse(locale);

    final featuredProducts = List<Map<String, dynamic>>.from(
      response["featuredProducts"],
    );
    final products = List<Map<String, dynamic>>.from(response["products"]);
    final hotOffers = List<Map<String, dynamic>>.from(response["hotOffers"]);

    final currencyFormatter = NumberFormat.currency(
      locale: locale.toString(),
      symbol: locale.languageCode == 'ar' ? 'د.أ ' : '\$',
    );

    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: SingleChildScrollView(
        child: Column(
          children: [
            //  HEADER
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Theme.of(context).colorScheme.primary,
                    Theme.of(context).colorScheme.secondary,
                  ],
                ),
              ),
              child:
              Column(
                children: [
                  SizedBox(height: 25,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      IconButton(
                        onPressed: () {
                          ref.read(authProvider.notifier).state = false;
                        },
                        icon: Icon(
                          size: MediaQuery.of(context).size.width * 0.01 * 6,
                          Icons.logout_outlined,
                        ),
                      ),
                      Text(
                        AppLocalizations.of(context)!.ourProducts,
                        style: Theme.of(context).textTheme.titleLarge?.copyWith(
                          fontSize: MediaQuery.of(context).size.width * 0.01 * 9,
                        ),
                      ),
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(
                            onPressed: () {
                              ref
                                  .read(themeModeProvider.notifier)
                                  .state = themeMode == ThemeMode.light
                                  ? ThemeMode.dark
                                  : ThemeMode.light;
                            },
                            icon: Icon(
                              size: MediaQuery.of(context).size.width * 0.01 * 6,
                              themeMode == ThemeMode.light
                                  ? Icons.dark_mode_outlined
                                  : Icons.light_mode_outlined,
                            ),
                          ),
                          IconButton(
                            onPressed: () {
                              ref
                                  .read(localProvider.notifier)
                                  .state = locale.languageCode == 'en'
                                  ? const Locale('ar')
                                  : const Locale('en');
                            },
                            icon: Icon(
                              size: MediaQuery.of(context).size.width * 0.01 * 6,
                              Icons.translate_outlined,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),

            const SizedBox(height: 24),

            //  FEATURED
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: carouselCustom(pagesList: featuredProducts),
            ),

            const SizedBox(height: 32),

            //PRODUCTS
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: MediaQuery.of(context).size.width > 600
                      ? 2
                      : 1,
                  crossAxisSpacing: 20,
                  mainAxisSpacing: 30,
                  childAspectRatio: 4 / 2,
                ),
                itemCount: products.length,
                itemBuilder: (context, index) {
                  final product = products[index];

                  return HoverCard(
                    color: Theme.of(context).colorScheme.surfaceContainer,
                    child: Column(
                      children: [
                        Expanded(
                          child: CachedNetworkImage(
                            imageUrl: product["image"],
                            fit: BoxFit.cover,
                            width: double.infinity,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(10),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(product["title"]),
                              Text(currencyFormatter.format(product["price"])),
                            ],
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),

            const SizedBox(height: 32),

            Text(
              AppLocalizations.of(context)!.hotOffers,
              style: Theme.of(context).textTheme.titleLarge,
            ),

            const SizedBox(height: 16),

            // HOT OFFERS
            ListView.separated(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: hotOffers.length,
              separatorBuilder: (_, __) => const SizedBox(height: 12),
              itemBuilder: (_, i) {
                final offer = hotOffers[i];

                return HoverCard(
                  color: Theme.of(context).colorScheme.surfaceContainer,
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Row(
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                offer["title"],
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(offer["subtitle"]),
                            ],
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 8,
                          ),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(30),
                            color: offer["tagColor"] == "purple"
                                ? Colors.purple
                                : Colors.pink,
                          ),
                          child: Text(
                            offer["tag"],
                            style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),

            const SizedBox(height: 32),
          ],
        ),
      ),
    );
  }
}
