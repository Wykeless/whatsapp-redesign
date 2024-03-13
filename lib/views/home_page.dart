import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:whatsapp_redesign/data/data.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {
  late TabController? tabController = TabController(length: 2, vsync: this);

  int pageIndex = 0;

  List<Container> containers = [
    Container(
      color: const Color(0xff1a1a1a),
      child: ListView.builder(
        itemCount: users.length,
        scrollDirection: Axis.vertical,
        itemBuilder: ((context, index) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                CircleAvatar(
                  radius: 30,
                  backgroundImage:
                      NetworkImage(users[index].profilePictureUrl!),
                ),
                Expanded(
                  child: ListTile(
                    title: Text(
                      users[index].username!,
                      style: const TextStyle(color: Colors.white),
                    ),
                    subtitle: Text(
                      users[index].textMessages!.last,
                      style: const TextStyle(color: Colors.white),
                    ),
                  ),
                ),
                Container(
                  width: 20,
                  height: 20,
                  decoration: BoxDecoration(
                    color: const Color(0xffe45d66),
                    borderRadius: BorderRadius.circular(50),
                  ),
                  child: Center(
                      child:
                          Text(users[index].textMessages!.length.toString())),
                )
              ],
            ),
          );
        }),
      ),
    ),
    Container(
      color: const Color(0xff1a1a1a),
      child: ListView.builder(
        itemCount: groups.length,
        scrollDirection: Axis.vertical,
        itemBuilder: ((context, index) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                CircleAvatar(
                  radius: 30,
                  backgroundImage:
                      NetworkImage(groups[index].profilePictureUrl!),
                ),
                Expanded(
                  child: ListTile(
                    title: Text(
                      groups[index].username!,
                      style: const TextStyle(color: Colors.white),
                    ),
                    subtitle: Text(
                      groups[index].textMessages!.last,
                      style: const TextStyle(color: Colors.white),
                    ),
                  ),
                ),
                Container(
                  width: 20,
                  height: 20,
                  decoration: BoxDecoration(
                    color: const Color(0xffe45d66),
                    borderRadius: BorderRadius.circular(50),
                  ),
                  child: Center(
                      child:
                          Text(users[index].textMessages!.length.toString())),
                )
              ],
            ),
          );
        }),
      ),
    ),
  ];

  Widget _custonIconButton({
    required IconData activeIcon,
    required IconData inactiveIcon,
    required int index,
  }) {
    const double iconSize = 30;
    const Color inactiveIconColor = Color(0xff868686);
    const Color activeIconColor = Color(0xff00c564);

    return IconButton(
      enableFeedback: false,
      onPressed: () {
        setState(() {
          pageIndex = index;
        });
      },
      icon: Icon(
        pageIndex == index ? activeIcon : inactiveIcon,
        color: pageIndex == index ? activeIconColor : inactiveIconColor,
        size: iconSize,
      ),
    );
  }

  Container _bottomNavBar() {
    return Container(
      height: 90,
      decoration: const BoxDecoration(
        color: Color(0xff1a1a1a),
        boxShadow: [
          BoxShadow(
            color: Colors.white,
            blurRadius: 0.1,
            spreadRadius: 0.1,
          ),
        ],
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(30),
          topRight: Radius.circular(30),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _custonIconButton(
            activeIcon: Icons.home_sharp,
            inactiveIcon: Icons.home_outlined,
            index: 0,
          ),
          _custonIconButton(
            activeIcon: Icons.phone,
            inactiveIcon: Icons.phone_outlined,
            index: 1,
          ),
          GestureDetector(
            onTap: (() => print('Yes')),
            child: Container(
              width: 60,
              height: 60,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: const Alignment(0.8, 1.0),
                  stops: const [0.1, 0.3, 0.6],
                  colors: [
                    Colors.blue,
                    Colors.blue.shade300,
                    Colors.green,
                  ],
                ),
              ),
              child: const Icon(
                Icons.add_rounded,
                size: 30,
                color: Colors.white,
              ),
            ),
          ),
          _custonIconButton(
            activeIcon: Icons.camera_alt_rounded,
            inactiveIcon: Icons.camera_alt_outlined,
            index: 2,
          ),
          _custonIconButton(
            activeIcon: Icons.person,
            inactiveIcon: Icons.person_outline,
            index: 3,
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    //Custom "scaffold" background
    return Container(
      decoration: const BoxDecoration(
        gradient: RadialGradient(
          center: Alignment(0.2, -1.01), // near the top right
          radius: 0.5,
          colors: <Color>[
            Color(0xFF1f4138), // green
            Color.fromARGB(255, 36, 36, 35), // black
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
              //Custom appbar
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
              //Status row
              Positioned(
                top: 0,
                left: 0,
                right: 0,
                bottom: 500,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: users.length,
                    itemBuilder: ((context, index) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: CircleAvatar(
                          radius: 32,
                          backgroundColor: Colors.transparent,
                          child: CustomPaint(
                            painter: CirclePainter(),
                            child: CircleAvatar(
                              radius: 22,
                              backgroundImage:
                                  NetworkImage(users[index].statusUrl!),
                            ),
                          ),
                        ),
                      );
                    }),
                  ),
                ),
              ),
              //Chat screen body
              Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  height: 560,
                  width: double.infinity,
                  decoration: const BoxDecoration(
                    color: Color(0xff1a1a1a),
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(30),
                      topRight: Radius.circular(30),
                    ),
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
                            padding: const EdgeInsets.symmetric(horizontal: 18),
                            child: Container(
                              height: 40,
                              width: double.infinity,
                              decoration: BoxDecoration(
                                color: const Color(0xff222222),
                                borderRadius: BorderRadius.circular(30),
                              ),
                            ),
                          ),
                          TabBar(
                            dividerColor: Colors.transparent,
                            indicatorWeight: 0,
                            indicatorSize: TabBarIndicatorSize.tab,
                            labelColor: const Color(0xffffffff),
                            padding: const EdgeInsets.only(
                                left: 30, right: 30, top: 9),
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
                              indicatorHeight: 35,
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
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: containers[tabController!.index],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              //Bottom Navigation bar
              Align(
                alignment: Alignment.bottomCenter,
                child: _bottomNavBar(),
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
  BubblePainter createBoxPainter([VoidCallback? onChanged]) {
    return BubblePainter(this, onChanged);
  }
}

class BubblePainter extends BoxPainter {
  BubblePainter(this.decoration, VoidCallback? onChanged) : super(onChanged);

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

class CirclePainter extends CustomPainter {
  var wavePaint = Paint()
    ..color = const Color.fromARGB(255, 41, 41, 41)
    ..style = PaintingStyle.stroke
    ..strokeWidth = 3.0
    ..isAntiAlias = true
    ..shader = const RadialGradient(
      colors: [
        Color(0xff2e6dea),
        Color(0xff00b759),
      ],
    ).createShader(Rect.fromCircle(
      center: const Offset(25, 50),
      radius: 65,
    ));
  @override
  void paint(Canvas canvas, Size size) {
    double centerX = size.width / 2.0;
    double centerY = size.height / 2.0;
    canvas.drawCircle(Offset(centerX, centerY), 27.0, wavePaint);
  }

  @override
  bool shouldRepaint(CirclePainter oldDelegate) {
    return false;
  }
}
