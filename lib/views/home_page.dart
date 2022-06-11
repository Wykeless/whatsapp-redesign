import 'dart:ui';

import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {
  late TabController? tabController = TabController(length: 2, vsync: this);
  int pageIndex = 0;
  List<Container> containers = [
    Container(
      color: Colors.white,
      child: const Text('Page 1'),
    ),
    Container(
      color: Colors.white,
      child: const Text('Page 2'),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: RadialGradient(
          center: Alignment(0.2, -1.01), // near the top right
          radius: 0.5,
          colors: <Color>[
            Color(0xFF1f4138), // green
            Color(0xFF1e1d1e), // black
          ],
          stops: <double>[0.15, 1.0],
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: SafeArea(
          child: Stack(
            children: [
              ImageFiltered(
                imageFilter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                child: Container(
                  decoration: const BoxDecoration(
                    gradient: RadialGradient(
                      center: Alignment(-1.0, -0.5), // near the top right
                      radius: 0.4,
                      colors: <Color>[
                        Color(0xFF1f4138), // green
                        Colors.transparent, // black
                      ],
                      stops: <double>[0.25, 1.0],
                    ),
                  ),
                ),
              ),
              Align(
                alignment: Alignment.topCenter,
                child: Row(
                  children: [
                    const SizedBox(
                      width: 15,
                    ),
                    Image.asset(
                      'assets/whatsapp_logo.png',
                      width: 30,
                      height: 30,
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    const Text(
                      "Whatsapp",
                      style: TextStyle(fontSize: 20, color: Colors.white),
                    ),
                    const Spacer(),
                    IconButton(
                      onPressed: () {},
                      icon: const Icon(
                        Icons.search,
                        color: Colors.white,
                      ),
                    )
                  ],
                ),
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  height: 550,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.black87,
                    borderRadius: BorderRadius.circular(25),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      const SizedBox(
                        height: 30,
                      ),
                      Stack(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(
                              left: 25,
                              right: 25,
                              top: 0,
                            ),
                            child: Container(
                              height: 30,
                              width: double.infinity,
                              decoration: BoxDecoration(
                                color: const Color(0xff222222),
                                borderRadius: BorderRadius.circular(30),
                              ),
                            ),
                          ),
                          TabBar(
                            padding: const EdgeInsets.only(
                                left: 30, right: 30, top: 5),
                            controller: tabController,
                            tabs: [
                              Text(
                                'Chats',
                                style: TextStyle(
                                  color: tabController!.index == 1
                                      ? const Color(0xff535353)
                                      : null,
                                ),
                              ),
                              Text(
                                'Groups',
                                style: TextStyle(
                                  color: tabController!.index == 0
                                      ? const Color(0xff535353)
                                      : null,
                                ),
                              ),
                            ],
                            indicator: const BubbleTabIndicator(
                              indicatorHeight: 30,
                              insets: EdgeInsets.all(0),
                              indicatorColor: Color(0xff323232),
                            ),
                            onTap: (index) {
                              setState(() {});
                            },
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      Expanded(
                        child: containers[tabController!.index],
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class BubbleTabIndicator extends Decoration {
  final double indicatorHeight;
  final Color indicatorColor;
  final double indicatorRadius;
  @override
  final EdgeInsetsGeometry padding;
  final EdgeInsetsGeometry insets;
  final TabBarIndicatorSize tabBarIndicatorSize;

  const BubbleTabIndicator({
    this.indicatorHeight = 30.0,
    this.indicatorColor = Colors.greenAccent,
    this.indicatorRadius = 100.0,
    this.tabBarIndicatorSize = TabBarIndicatorSize.label,
    this.padding = const EdgeInsets.symmetric(vertical: 1.0, horizontal: 8.0),
    this.insets = const EdgeInsets.symmetric(horizontal: 5.0),
  });

  @override
  Decoration? lerpFrom(Decoration? a, double t) {
    if (a is BubbleTabIndicator) {
      return BubbleTabIndicator(
        padding: EdgeInsetsGeometry.lerp(a.padding, padding, t)!,
        insets: EdgeInsetsGeometry.lerp(a.insets, insets, t)!,
      );
    }
    return super.lerpFrom(a, t);
  }

  @override
  Decoration? lerpTo(Decoration? b, double t) {
    if (b is BubbleTabIndicator) {
      return BubbleTabIndicator(
        padding: EdgeInsetsGeometry.lerp(padding, b.padding, t)!,
        insets: EdgeInsetsGeometry.lerp(insets, b.insets, t)!,
      );
    }
    return super.lerpTo(b, t);
  }

  @override
  _BubblePainter createBoxPainter([VoidCallback? onChanged]) {
    return _BubblePainter(this, onChanged);
  }
}

class _BubblePainter extends BoxPainter {
  _BubblePainter(this.decoration, VoidCallback? onChanged) : super(onChanged);

  final BubbleTabIndicator decoration;

  double get indicatorHeight => decoration.indicatorHeight;
  Color get indicatorColor => decoration.indicatorColor;
  double get indicatorRadius => decoration.indicatorRadius;
  EdgeInsetsGeometry get padding => decoration.padding;
  EdgeInsetsGeometry get insets => decoration.insets;
  TabBarIndicatorSize get tabBarIndicatorSize => decoration.tabBarIndicatorSize;

  Rect _indicatorRectFor(Rect rect, TextDirection textDirection) {
    Rect indicator = padding.resolve(textDirection).inflateRect(rect);

    if (tabBarIndicatorSize == TabBarIndicatorSize.tab) {
      indicator = insets.resolve(textDirection).deflateRect(rect);
    }

    return Rect.fromLTWH(
      indicator.left,
      indicator.top,
      indicator.width,
      indicator.height,
    );
  }

  @override
  void paint(Canvas canvas, Offset offset, ImageConfiguration configuration) {
    assert(configuration.size != null);
    final Rect rect = Offset(
            offset.dx, (configuration.size!.height / 2) - indicatorHeight / 2) &
        Size(configuration.size!.width, indicatorHeight);
    final TextDirection textDirection = configuration.textDirection!;
    final Rect indicator = _indicatorRectFor(rect, textDirection);
    final Paint paint = Paint();
    paint.color = indicatorColor;
    paint.style = PaintingStyle.fill;
    canvas.drawRRect(
      RRect.fromRectAndRadius(
        indicator,
        Radius.circular(indicatorRadius),
      ),
      paint,
    );
  }
}
