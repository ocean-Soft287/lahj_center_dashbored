import 'package:flutter/material.dart';
import '../../utils/font/fonts.dart';

class CustomNavigationRail extends StatefulWidget {
  final int selectedIndex;
  final ValueChanged<int> onDestinationSelected;

  const CustomNavigationRail({
    super.key,
    required this.selectedIndex,
    required this.onDestinationSelected,
  });

  @override
  State<CustomNavigationRail> createState() => _CustomNavigationRailState();
}

class _CustomNavigationRailState extends State<CustomNavigationRail> {
  @override
  Widget build(BuildContext context) {
    return NavigationRail(
      selectedIndex: widget.selectedIndex,
      onDestinationSelected: widget.onDestinationSelected,
      labelType: NavigationRailLabelType.all,
      leading: Column(
        children: [
          const SizedBox(height: 20),
          CircleAvatar(
            radius: 30,
            backgroundColor: Colors.blueGrey.shade200,
            child: const Icon(Icons.person, size: 40, color: Colors.white),
          ),
          const SizedBox(height: 10),
          Text(
            "محمد خالد محمود",
            style: TextStyle(
              fontFamily: Fonts.cairo,
              fontWeight: FontWeight.bold,
              fontSize: 18,
            ),
          ),
          Text(
            "user@email.com",
            style: TextStyle(
              fontFamily: Fonts.cairo,
              fontSize: 14,
              color: Colors.grey,
            ),
          ),
          const SizedBox(height: 20),
        ],
      ),
      destinations: const [
        NavigationRailDestination(
          icon: Icon(Icons.home),
          label: Text("الرئيسيه"),
        ),
        NavigationRailDestination(
          icon: Icon(Icons.shopping_bag_rounded),
          label: Text("المنتجات"),
        ),
        NavigationRailDestination(
          icon: Icon(Icons.people),
          label: Text("العملاء"),
        ),
        NavigationRailDestination(
          icon: Icon(Icons.supervised_user_circle),
          label: Text("المستخدمين"),
        ),
        NavigationRailDestination(
          icon: Icon(Icons.logout),
          label: Text("تسجيل الخروج"),
        ),
      ],
    );
  }
}
