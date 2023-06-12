import 'package:ecom/screens/home/home-screen.dart';
import 'package:ecom/screens/inprogress_screen/inprogress-screen.dart';
import 'package:ecom/screens/main_screen/widgets/current-city.dart';
import 'package:ecom/screens/profile/profile.screen.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  var _selectedPageIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.surface,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 8.0),
            child: FloatingActionButton.small(
              onPressed: () {},
              backgroundColor: Theme.of(context).colorScheme.surface,
              child: const Icon(Icons.notifications_none),
            ),
          )
        ],
        title: const CurrentCity(),
        titleTextStyle: Theme.of(context).textTheme.titleMedium,
      ),
      body: Stack(
        children: [
          _buildPage(),
          _appBarShadow(context),
          _bottomNavigationBar(context),
        ],
      ),
    );
  }

  // Show the page according to the selected page
  Widget _buildPage() {
    switch (_selectedPageIndex) {
      case 0:
        return const HomeScreen();
      case 4:
        return const ProfileScreen();
      default:
        return const InProgressScreen();
    }
  }

  // Build bottom navigation buttons
  Widget _bottomNavigationButton(String label, IconData icon, int pageIndex) {
    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedPageIndex = pageIndex;
        });
      },
      child: SizedBox(
        width: 20.w,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              size: 18.sp,
              color: _selectedPageIndex == pageIndex ? Theme.of(context).colorScheme.primary : null,
            ),
            Text(
              label,
              style: TextStyle(
                fontSize: 7.sp,
                color: _selectedPageIndex == pageIndex ? Theme.of(context).colorScheme.primary : null,
                ),
            )
          ],
        ),
      ),
    );
  }

  // Custom shadow fot the appbar; Due to issues with the default shadow
  Widget _appBarShadow(BuildContext context) {
    return Positioned(
      top: 0,
      child: Container(
        height: 5,
        width: 100.w,
        decoration: BoxDecoration(
          gradient: LinearGradient(colors: [
            Theme.of(context).colorScheme.shadow.withOpacity(0.2),
            Colors.transparent
          ], begin: Alignment.topCenter, end: Alignment.bottomCenter),
        ),
      ),
    );
  }

  //Bottom navigation bar
  Widget _bottomNavigationBar(BuildContext context) {
    return Positioned(
        bottom: 0,
        child: SizedBox(
          width: 100.w,
          height: 80,
          child: Stack(
            children: [
              CustomPaint(
                size: Size(100.w, 80),
                painter: BottomNavigationPainter(context),
              ),
              Center(
                heightFactor: 0.6,
                child: SizedBox(
                  width: 15.w,
                  height: 15.w,
                  child: GestureDetector(
                    onTap: () {
                          setState(() {
                            _selectedPageIndex = 0;
                          });
                        },
                    child: Container(
                      width: double.infinity,
                      height: double.infinity,
                      decoration: BoxDecoration(
                          gradient: LinearGradient(
                              colors: [
                                Theme.of(context).colorScheme.primary,
                                Theme.of(context).colorScheme.inversePrimary
                              ],
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter),
                          borderRadius: BorderRadius.circular(20)),
                      child: Center(
                          child: Icon(
                        Icons.home_outlined,
                        size: 40,
                        color: Theme.of(context).colorScheme.onPrimary,
                      )),
                    ),
                  ),
                ),
              ),
              SizedBox(
                  width: 100.w,
                  height: 80,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      _bottomNavigationButton(
                          "Services", Icons.list_alt_outlined, 1),
                      _bottomNavigationButton("Messages", Icons.email_outlined, 2),
                      SizedBox(
                        width: 20.w,
                      ),
                      _bottomNavigationButton(
                          "Cart", Icons.shopping_cart_outlined, 3),
                      _bottomNavigationButton(
                          "Profile", Icons.person_outline_rounded, 4),
                    ],
                  ))
            ],
          ),
        ));
  }
}

// Creating the custom background for the bottom navigation bar
class BottomNavigationPainter extends CustomPainter {
  BuildContext context;
  BottomNavigationPainter(this.context);

  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..color = Theme.of(context).colorScheme.surface
      ..style = PaintingStyle.fill;
    Path path = Path()..moveTo(0, 0);
    path.lineTo(35.w, 0);
    path.quadraticBezierTo(40.w, 0, 40.w, 20);
    path.lineTo(40.w, 40);
    path.quadraticBezierTo(40.w, 60, 45.w, 60);
    path.lineTo(55.w, 60);
    path.quadraticBezierTo(60.w, 60, 60.w, 40);
    path.lineTo(60.w, 20);
    path.quadraticBezierTo(60.w, 0, 65.w, 0);
    path.lineTo(100.w, 0);
    path.lineTo(size.width, size.height);
    path.lineTo(0, size.height);
    path.close();
    canvas.drawShadow(path, Colors.black, 10, true);
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}
