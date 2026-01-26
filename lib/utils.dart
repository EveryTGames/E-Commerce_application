import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';


class AnimatedTextButton extends StatefulWidget {
  final VoidCallback? onPressed;
  final Widget? child;
  final String? text;

  // Optional custom colors
  final Color? normalColor;
  final Color? hoverColor;
  final Color? pressedColor;
  final Color? disabledColor;
  final Color? backgroundColor;

  const AnimatedTextButton({
    super.key,
    required this.onPressed,
    this.child,
    this.text,
    this.normalColor,
    this.hoverColor,
    this.pressedColor,
    this.disabledColor,
    this.backgroundColor,
  });

  @override
  State<AnimatedTextButton> createState() => _AnimatedTextButtonState();
}

class _AnimatedTextButtonState extends State<AnimatedTextButton> {
  double _scale = 1.0;

  void _onTapDown(TapDownDetails details) => setState(() => _scale = 0.9);

  void _onTapUp(TapUpDetails details) => setState(() => _scale = 1.0);

  void _onTapCancel() => setState(() => _scale = 1.0);

  void _onHover(bool hovering) => setState(() => _scale = hovering ? 1.1 : 1.0);

  @override
  Widget build(BuildContext context) {
    final ButtonStyle defaultStyle = Theme
        .of(context)
        .textButtonTheme
        .style!;

    // Wrap the style so we can override colors but keep the default style
    final ButtonStyle style = defaultStyle.copyWith(
      foregroundColor: WidgetStateProperty.resolveWith<Color?>(
            (states) {
          if (states.contains(WidgetState.disabled))
            return widget.disabledColor ?? Colors.black26;
          if (states.contains(WidgetState.hovered))
            return widget.hoverColor ?? widget.normalColor;
          if (states.contains(WidgetState.pressed))
            return widget.pressedColor ?? widget.normalColor;
          return widget.normalColor;
        },
      ),
      backgroundColor: WidgetStateProperty.all(widget.backgroundColor),
    );

    return MouseRegion(
      onEnter: (_) => _onHover(true),
      onExit: (_) => _onHover(false),
      child: GestureDetector(
        onTap: widget.onPressed,
        onTapDown: _onTapDown,
        onTapUp: _onTapUp,
        onTapCancel: _onTapCancel,
        child: AnimatedScale(
          scale: _scale,
          duration: const Duration(milliseconds: 100),
          curve: Curves.easeInOut,
          child: TextButton(
            onPressed: widget.onPressed,
            style: style,
            child: widget.child ??
                AutoSizeText(
                  widget.text ?? "",
                  maxFontSize: 50,
                  minFontSize: 10,
                  maxLines: 1,
                ),
          ),
        ),
      ),
    );
  }
}


class HoverImage extends StatefulWidget {
  final String imagePath;
  final double borderRadius;

  const HoverImage({
    super.key,
    required this.imagePath,
    this.borderRadius = 12.0,
  });

  @override
  State<HoverImage> createState() => _HoverImageState();
}

class _HoverImageState extends State<HoverImage> {
  double _scale = 1.0;

  void _onHover(bool hovering) {
    setState(() {
      _scale = hovering ? 1.1 : 1.0;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => _onHover(true),
      onExit: (_) => _onHover(false),
      child: AnimatedScale(
        scale: _scale,
        duration: const Duration(milliseconds: 150),
        curve: Curves.easeInOut,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(widget.borderRadius),
          child: Image.asset(widget.imagePath),
        ),
      ),
    );
  }
}


class HoverCard extends StatefulWidget {
  final Widget child;
  final Color color;

  const HoverCard({super.key, required this.child, this.color = Colors.white});

  @override
  State<HoverCard> createState() => _HoverCardState();
}

class _HoverCardState extends State<HoverCard> {
  double _elevation = 20;
  double _offset = 0; // vertical lift

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) =>
          setState(() {
            _elevation = 40;
            _offset = -8; // move up
          }),
      onExit: (_) =>
          setState(() {
            _elevation = 20;
            _offset = 0; // reset position
          }),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 180),
        curve: Curves.easeOut,
        transform: Matrix4.translationValues(0, _offset, 0),
        child: Material(
          color: widget.color,
          elevation: _elevation,
          borderRadius: BorderRadius.circular(16),
          clipBehavior: Clip.antiAlias,
          child: widget.child,
        ),
      ),
    );
  }
}



class carouselCustom extends ConsumerStatefulWidget {
  const carouselCustom({super.key,
    required this.pagesList,
  });

  final List<Map<String, String>> pagesList;

  @override
  ConsumerState<carouselCustom> createState() => _carouselCustomState();
}

class _carouselCustomState extends ConsumerState<carouselCustom> {
  final PageController _controller = PageController();

  int _currentPage = 0;

  @override
  void initState() {
    super.initState();

    _controller.addListener(() {
      final newPage = _controller.page?.round() ?? 0;
      if (newPage != _currentPage) {
        setState(() => _currentPage = newPage);
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {


    return Container(
      height: 300,
      child: Stack(
        children: [
          PageView(
            controller: _controller,
            children: widget.pagesList.map((product) {
              return Stack(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: Image.network(
                      product['image']!,
                      fit: BoxFit.cover,
                      width: double.infinity,
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      gradient: LinearGradient(
                        colors: [Theme.of(context).colorScheme.surface, Colors.transparent],
                        begin: Alignment.bottomCenter,
                        end: Alignment.topCenter,
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: 16,
                    left: 16,
                    child: Text(
                      product['title']!,
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.onSurface,
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              );
            }).toList(),
          ),

          // LEFT BUTTON
          PositionedDirectional(
            start : 8,
            top: 0,
            bottom: 0,
            child: _currentPage == 0 ? SizedBox.shrink() : IconButton(
              icon: Icon(Icons.chevron_left, size: 40, color: Colors.white),
              onPressed: () {
                _controller.previousPage(
                  duration: Duration(milliseconds: 300),
                  curve: Curves.easeOut,
                );
              },
            ),
          ),

          // RIGHT BUTTON
          PositionedDirectional(
            end: 8,
            top: 0,
            bottom: 0,
            child:  _currentPage == widget.pagesList.length -1  ? SizedBox.shrink() : IconButton(
              icon: Icon(Icons.chevron_right, size: 40, color: Colors.white),
              onPressed: () {
                _controller.nextPage(
                  duration: Duration(milliseconds: 300),
                  curve: Curves.easeOut,
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}


class FeaturedCarousel extends StatefulWidget {
  final List<Map<String, String>> pagesList;

  const FeaturedCarousel({
    super.key,
    required this.pagesList,
  });

  @override
  _FeaturedCarouselState createState() => _FeaturedCarouselState();
}

class _FeaturedCarouselState extends State<FeaturedCarousel> {
  final PageController _controller = PageController();

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 300,
      child: Stack(
        children: [
          PageView(
            controller: _controller,
            children: widget.pagesList.map((product) {
              return Stack(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: Image.network(
                      product['image']!,
                      fit: BoxFit.cover,
                      width: double.infinity,
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      gradient: LinearGradient(
                        colors: [Colors.black54, Colors.transparent],
                        begin: Alignment.bottomCenter,
                        end: Alignment.topCenter,
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: 16,
                    left: 16,
                    child: Text(
                      product['title']!,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              );
            }).toList(),
          ),

          // LEFT BUTTON
          Positioned(
            left: 8,
            top: 0,
            bottom: 0,
            child: IconButton(
              icon: Icon(Icons.chevron_left, size: 40, color: Colors.white),
              onPressed: () {
                _controller.previousPage(
                  duration: Duration(milliseconds: 300),
                  curve: Curves.easeOut,
                );
              },
            ),
          ),

          // RIGHT BUTTON
          Positioned(
            right: 8,
            top: 0,
            bottom: 0,
            child: IconButton(
              icon: Icon(Icons.chevron_right, size: 40, color: Colors.white),
              onPressed: () {
                _controller.nextPage(
                  duration: Duration(milliseconds: 300),
                  curve: Curves.easeOut,
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
