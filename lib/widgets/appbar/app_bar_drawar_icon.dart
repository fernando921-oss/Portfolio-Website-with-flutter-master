import 'package:flutter/material.dart';

class AppBarDrawarIcon extends StatefulWidget {
  final ValueNotifier<bool> drawerNotifier; // 👈 shared notifier

  const AppBarDrawarIcon({super.key, required this.drawerNotifier});

  @override
  State<AppBarDrawarIcon> createState() => _AppBarDrawarIconState();
}

class _AppBarDrawarIconState extends State<AppBarDrawarIcon>
    with SingleTickerProviderStateMixin {
  late AnimationController controller;
  late Animation<double> animation;

  @override
  void initState() {
    super.initState();
    controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 250),
    );
    animation = Tween<double>(begin: 0.0, end: 1.0).animate(controller);

    // 👇 Listen for drawer open/close changes from Scaffold
    widget.drawerNotifier.addListener(() {
      if (widget.drawerNotifier.value) {
        controller.forward();
      } else {
        controller.reverse();
      }
    });
  }

  void toggleDrawer(BuildContext context) {
    final scaffold = Scaffold.of(context);

    if (widget.drawerNotifier.value) {
      Navigator.of(context).maybePop(); // close
      widget.drawerNotifier.value = false;
    } else {
      scaffold.openDrawer(); // open
      widget.drawerNotifier.value = true;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (context) {
        return IconButton(
          icon: AnimatedIcon(
            icon: AnimatedIcons.menu_close,
            progress: animation,
          ),
          onPressed: () => toggleDrawer(context),
        );
      },
    );
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }
}
