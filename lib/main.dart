import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int quantity = 0;
  var endTween = 30.0;
  void _handleScroll() {
    if (quantity > 0) {
      setState(() {
        endTween = 100;
      });
    } else if (quantity == 0) {
      setState(() {
        endTween = 30;
      });
    }
  }

  @override
  void setState(VoidCallback fn) {
    if (mounted) super.setState(fn);
  }

  @override
  void initState() {
    super.initState();
    if (quantity == 0) {
      setState(() {
        endTween = 30;
      });
    }
    _handleScroll();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Ürünler')),
      body: GridView.builder(
        itemCount: 30,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          crossAxisSpacing: 15.0,
          mainAxisSpacing: 15.0,
        ),
        itemBuilder: (context, ide) {
          return const ProductCard();
        },
      ),
    );
  }
}

class ProductCard extends StatefulWidget {
  const ProductCard({super.key});

  @override
  State<ProductCard> createState() => _ProductCardState();
}

class _ProductCardState extends State<ProductCard> {
  int quantity = 0;
  var endTween = 30.0;
  void _handleScroll() {
    if (quantity > 0) {
      setState(() {
        endTween = 120;
      });
    } else if (quantity == 0) {
      setState(() {
        endTween = 30;
      });
    }
  }

  @override
  void setState(VoidCallback fn) {
    if (mounted) super.setState(fn);
  }

  @override
  void initState() {
    super.initState();
    if (quantity == 0) {
      setState(() {
        endTween = 30;
      });
    }
    _handleScroll();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Stack(
        children: [
          Container(
            height: 200,
            width: 200,
            decoration: BoxDecoration(
              border: Border.all(width: 0.5, color: Colors.grey),
              borderRadius: const BorderRadius.all(Radius.circular(30)),
            ),
            child: const Center(
                child: Icon(
              Icons.production_quantity_limits,
              size: 100,
            )),
          ),
          Positioned(
            right: 10,
            top: 10,
            child: Container(
              decoration: const BoxDecoration(
                  shape: BoxShape.rectangle,
                  borderRadius: BorderRadius.all(Radius.circular(30)),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.deepPurple,
                      offset: Offset(0, 4),
                      spreadRadius: 0,
                      blurRadius: 12,
                    ),
                    BoxShadow(
                      color: Colors.white,
                      offset: Offset(0, 4),
                      spreadRadius: 0,
                      blurRadius: 12,
                    ),
                  ]),
              child: TweenAnimationBuilder(
                tween: Tween<double>(begin: 30, end: endTween),
                duration: const Duration(milliseconds: 200),
                builder: (context, double size, child) {
                  double heightPercent = (50).abs() / 100;
                  bool isFull = endTween == 120;
                  double radius = 10.0;
                  return Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(radius)),
                      color:
                          quantity == 0 ? Colors.white : Colors.deepPurple[400],
                    ),
                    height: (quantity > 0 ? 32 : 20) + heightPercent * size,
                    width: 32,
                    child: Column(
                        mainAxisAlignment: isFull
                            ? MainAxisAlignment.spaceEvenly
                            : MainAxisAlignment.center,
                        children: [
                          Expanded(
                            child: GestureDetector(
                              onTap: () {
                                setState(() {
                                  quantity++;
                                  _handleScroll();
                                });
                              },
                              child: const AbsorbPointer(
                                child: Center(
                                  child: Icon(
                                    Icons.add,
                                    size: 20,
                                    color: Colors.black,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          ...(quantity > 0
                              ? [
                                  Expanded(
                                    child: AnimatedOpacity(
                                        opacity: size > 30 ? 1 : 0,
                                        duration:
                                            const Duration(milliseconds: 200),
                                        child: Container(
                                            color: Colors.white,
                                            child: Center(
                                              child: Text(quantity.toString()),
                                            ))),
                                  ),
                                  quantity == 1
                                      ? Expanded(
                                          child: Center(
                                            child: GestureDetector(
                                              onTap: () {
                                                setState(() {
                                                  quantity--;
                                                  _handleScroll();
                                                });
                                              },
                                              child: const Center(
                                                  child: Icon(
                                                Icons.delete_outline,
                                                size: 20,
                                                color: Colors.black,
                                              )),
                                            ),
                                          ),
                                        )
                                      : Expanded(
                                          child: Center(
                                            child: GestureDetector(
                                              onTap: () {
                                                setState(() {
                                                  quantity--;
                                                  _handleScroll();
                                                });
                                              },
                                              child: const Center(
                                                  child: Icon(
                                                Icons.remove,
                                                size: 20,
                                                color: Colors.black,
                                              )),
                                            ),
                                          ),
                                        )
                                ]
                              : []),
                        ]),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
