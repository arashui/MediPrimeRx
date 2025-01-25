import 'package:flutter/material.dart';
import 'package:medi_prime_rx/utils/constant/dimension.dart';
import '../Screen/account.dart';
import '../Screen/customer.dart';
import '../Screen/dashboard.dart';
import '../Screen/invoice.dart';
import '../Screen/medicine.dart';
import '../Screen/report.dart';
import '../Screen/settings.dart';
import '../Screen/support.dart';
import '../Screen/user_activity.dart';
import 'package:bottom_navy_bar/bottom_navy_bar.dart';
import '../screen/order.dart';
import '../utils/constant/app_big_text.dart';
import '../utils/constant/app_small_text.dart';
import '../utils/constant/colors.dart';

// Basic responsive utility to detect desktop screens
class Responsive {
  static bool isDesktop(BuildContext context) =>
      MediaQuery.of(context).size.width >= 1024;

  static bool isMobile(BuildContext context) =>
      MediaQuery.of(context).size.width < 1024;
}

class SideMenu extends StatefulWidget {
  const SideMenu({super.key});

  @override
  SideMenuState createState() => SideMenuState();
}

class SideMenuState extends State<SideMenu> {
  int _currentIndex = 0;

  // List of pages corresponding to each menu item
  final List<Widget> _pages = [
    const Dashboard(),
    const Medicine(),
    const Invoice(),
    const Customer(),
    const Order(),
    const Account(),
    const Report(),
    const UserActivity(),
    const Settings(),
    const SupportAndHelp(),
  ];

  void _onSelectPage(int index) {
    setState(() {
      _currentIndex = index;
    });
    if (!Responsive.isDesktop(context)) {
      Navigator.pop(context); // Close the drawer on mobile
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          // Sidebar for desktop screens
          if (Responsive.isDesktop(context)) _buildSidebar(),
          // Main content area
          Expanded(child: _pages[_currentIndex]),
        ],
      ),
      // Drawer for mobile screens
      drawer: Responsive.isMobile(context) ? Drawer(child: _buildSidebarContent()) : null,
      bottomNavigationBar: Responsive.isMobile(context)
          ? _buildBottomNavigationBar()
          : null,
    );
  }

  // Sidebar builder for desktop screens
  Widget _buildSidebar() {
    return SizedBox(
      width: 230,
      child: Drawer(
        elevation: Dimensions.fontSize20,
        backgroundColor: Colors.white,
        child: _buildSidebarContent(),
      ),
    );
  }

  // Shared content for sidebar and drawer
  Widget _buildSidebarContent() {
    return ListView(
      padding: EdgeInsets.zero,
      children: [
        Container(
          alignment: Alignment.center,
          padding: EdgeInsets.all(Dimensions.height10),
          height: 120,
          child: const Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              AppBigText(
                text: 'MediPrimeRx',
                color: Colors.black,
                fontWeight: FontWeight.bold,
              )
            ],
          ),
        ),
        _buildMenuItem(Icons.dashboard_customize_outlined, 'Dashboard', 0),
        _buildMenuItem(Icons.medical_information, 'Medicine', 1),
        _buildMenuItem(Icons.note_add_outlined, 'Invoice', 2),
        _buildMenuItem(Icons.people_alt_outlined, 'Customer', 3),
        _buildMenuItem(Icons.sailing, 'Order', 4),
        _buildMenuItem(Icons.person_outline, 'Account', 5),
        _buildMenuItem(Icons.report_gmailerrorred, 'Report', 6),
        _buildMenuItem(Icons.add_reaction_outlined, 'User Activity', 7),
        _buildMenuItem(Icons.support_agent, 'Support and Help', 8),
      ],
    );
  }

  // Bottom navigation bar for mobile screens
  Widget _buildBottomNavigationBar() {
    return BottomNavyBar(
      backgroundColor: secondaryColor,
      containerHeight: 60,
      selectedIndex: _currentIndex,
      showElevation: true,
      itemCornerRadius: 24,
      curve: Curves.elasticInOut,
      onItemSelected: (index) => setState(() => _currentIndex = index),
      items: <BottomNavyBarItem>[
        BottomNavyBarItem(
          icon: Image.asset("assets/home.png", width: 30),
          title: Text('HOME', style: Theme.of(context).textTheme.bodyMedium),
          activeColor: primaryColor,
          inactiveColor: secondaryColor,
        ),
        BottomNavyBarItem(
          icon: Image.asset("assets/digital-services.png", width: 30),
          title: Text('Items/Services',
              style: Theme.of(context).textTheme.bodyLarge),
          activeColor: primaryColor,
          inactiveColor: secondary2Color,
        ),
        BottomNavyBarItem(
          icon: Image.asset("assets/sale.png", width: 30),
          title: Text('Sale', style: Theme.of(context).textTheme.bodyLarge),
          activeColor: primaryColor,
          inactiveColor: secondaryColor,
        ),
        BottomNavyBarItem(
          icon: Image.asset("assets/accounting.png", width: 30),
          title: Text('Report', style: Theme.of(context).textTheme.bodyLarge),
          activeColor: primaryColor,
          inactiveColor: secondary2Color,
        ),
        BottomNavyBarItem(
          icon: Image.asset("assets/settings.png", width: 30),
          title: Text('Settings', style: Theme.of(context).textTheme.bodyLarge),
          activeColor: primaryColor,
          inactiveColor: secondary2Color,
        ),
      ],
    );
  }

  // Reusable method to build menu items
  Widget _buildMenuItem(IconData icon, String title, int index) {
    return InkWell(
      onTap: () => _onSelectPage(index),
      child: Container(
        color: _currentIndex == index ? primaryColor : Colors.white,
        child: ListTile(
          leading: Icon(
            icon,
            color: _currentIndex == index ? Colors.white : Colors.grey,
          ),
          title: AppSmallText(
            text: title,
            style: TextStyle(
              color: _currentIndex == index ? Colors.white : Colors.black,
              fontWeight:
              _currentIndex == index ? FontWeight.bold : FontWeight.normal,
            ),
          ),
        ),
      ),
    );
  }
}
