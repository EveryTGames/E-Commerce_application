import 'package:ShopCraft/utils.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(ShopCraftApp());
}

class ShopCraftApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ShopCraft',
      theme: ThemeData(primarySwatch: Colors.purple, fontFamily: 'Suwannaphum'),
      home: ShopHomePage(),
    );
  }
}

class ShopHomePage extends StatelessWidget {
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
      'image':
          'https://images.unsplash.com/photo-1581091226825-a6a2a5aee158?w=300&h=200&fit=crop',
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

   ShopHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Header
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Colors.purple, Colors.deepPurple],
                ),
              ),
              child: Center(
                child: Text(
                  'Our Products',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),

            SizedBox(height: 24),

            // Featured Products
            Text(
              'Featured Products',
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: Colors.grey[800],
              ),
            ),
            SizedBox(height: 16),
            FeaturedCarousel(pagesList: featuredProducts),
            SizedBox(height: 32),

            // Product Grid
            Text(
              'Shop Our Collection',
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: Colors.grey[800],
              ),
            ),
            SizedBox(height: 16),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: GridView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: products.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: MediaQuery.of(context).size.width > 600
                      ? 2
                      : 1,
                  childAspectRatio: 4 / 2,
                  crossAxisSpacing: 16,
                  mainAxisSpacing: 25,
                ),
                itemBuilder: (context, index) {
                  final product = products[index];
                  return HoverCard(
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
                                 imageUrl:  product['image']!,
                                  fit: BoxFit.cover,
                                  progressIndicatorBuilder: (context, url, downloadProgress) =>
                                      CircularProgressIndicator(value: downloadProgress.progress),
                                  errorWidget: (context, url, error) => Icon(Icons.error),
                                  width: double.infinity,
                                  height: double.infinity,
                                ),
                              ),
                              Positioned(
                                top: 8,
                                right: 8,
                                child: CircleAvatar(
                                  backgroundColor: Colors.purple,
                                  child: IconButton(
                                    icon: Icon(
                                      Icons.shopping_cart,
                                      color: Colors.white,
                                      size: 20,
                                    ),
                                    onPressed: () {},
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                product['title']!,
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              SizedBox(height: 8),
                              Text(
                                product['price']!,
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.purple,
                                ),
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

            // Hot Offers
            Text(
              'Hot Offers 🔥',
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: Colors.grey[800],
              ),
            ),
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
                                      ),
                                    ),
                                    SizedBox(height: 4),
                                    Text(
                                      offer['subtitle']!,
                                      style: TextStyle(
                                        fontSize: 14,
                                        color: Colors.grey[600],
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
                                        ? [Colors.purple, Colors.pink]
                                        : [Colors.pink, Colors.orange],
                                  ),
                                ),
                                child: Text(
                                  offer['tag']!,
                                  style: TextStyle(
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
