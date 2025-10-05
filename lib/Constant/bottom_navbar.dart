import 'package:flutter/material.dart';


class BottomNavController extends StatefulWidget {
  final int currentIndex;
  const BottomNavController({Key? key, this.currentIndex = 0}) : super(key: key);

  @override
  State<BottomNavController> createState() => _BottomNavControllerState();
}

class _BottomNavControllerState extends State<BottomNavController> {
  late int _selectedIndex;

  final _tabKeys = List.generate(4, (_) => GlobalKey<NavigatorState>());

  final _labels = const ['Dashboard', 'Report', 'Inventory', 'Delivery'];

  final _iconAssets = const [
    'assets/dashboard/btmnavbar1.png',
    'assets/dashboard/btmnavbar2.png',
    'assets/dashboard/btmnavbar3.png',
    'assets/dashboard/btmnavbar4.png',
  ];

  @override
  void initState() {
    super.initState();
    _selectedIndex = widget.currentIndex;
  }


  Widget _buildTabNavigator({
    required int index,
    required Widget root,
  }) {
    return Offstage(
      offstage: _selectedIndex != index,
      child: Navigator(
        key: _tabKeys[index],
        onGenerateRoute: (settings) {

          return MaterialPageRoute(
            builder: (_) => root,
            settings: const RouteSettings(name: 'root'),
          );
        },
      ),
    );
  }

  Future<bool> _onWillPop() async {

    final currentNavigator = _tabKeys[_selectedIndex].currentState!;
    if (currentNavigator.canPop()) {
      currentNavigator.pop();
      return false;
    }

    if (_selectedIndex != 0) {
      setState(() => _selectedIndex = 0);
      return false;
    }

    return true;
  }

  @override
  Widget build(BuildContext context) {
    const active = Color(0xFF22BEC8);

    return WillPopScope(
      onWillPop: _onWillPop,
      child: Scaffold(
        backgroundColor: const Color(0xFF0F172A),


        body: Stack(
          children: [
           // _buildTabNavigator(index: 0, root: DashboardPage(

          //  )),
          //  _buildTabNavigator(index: 1, root: const ReportPage()),
          //  _buildTabNavigator(index: 2, root: const InventoryPage()),
          //  _buildTabNavigator(index: 3, root: const DeliveryPage()),
          ],
        ),

        bottomNavigationBar: SafeArea(
          child: Container(
            margin: const EdgeInsets.all(12),
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
            decoration: BoxDecoration(
              color: const Color(0xFF35435B),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: List.generate(_labels.length, (i) {
                final isSelected = _selectedIndex == i;
                final inactive = Colors.white.withOpacity(0.7);
                return Expanded(
                  child: InkWell(
                    borderRadius: BorderRadius.circular(16),
                    onTap: () => setState(() => _selectedIndex = i),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 6),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          ImageIcon(
                            AssetImage(_iconAssets[i]),
                            size: 22,
                            color: isSelected ? active : inactive,
                          ),
                          const SizedBox(height: 4),
                          Text(
                            _labels[i],
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: isSelected ? FontWeight.w700 : FontWeight.w400,
                              color: isSelected ? active : inactive,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              }),
            ),
          ),
        ),
      ),
    );
  }

  void pushInTab(int tabIndex, Route route) {
    _tabKeys[tabIndex].currentState?.push(route);
  }
}
