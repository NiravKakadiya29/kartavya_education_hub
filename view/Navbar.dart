// import 'package:flutter/cupertino.dart';
// import 'package:google_nav_bar/google_nav_bar.dart';
// import '/view/intro_screens/intro_page_1.dart';
// import '/view/intro_screens/intro_page_2.dart';
//
// import '../const/consts.dart';
//
// class Navbar extends StatefulWidget {
//   const Navbar({Key? key}) : super(key: key);
//
//   @override
//   State<Navbar> createState() => _NavbarState();
// }
//
// class _NavbarState extends State<Navbar> {
//   int _selectedIndex = 0;
//   static const List<Widget> _widgetOptions = <Widget>[
//     IntroPage2(),
//     IntroPage1()
//   ];
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Center(
//         child: _widgetOptions.elementAt(_selectedIndex),
//       ),
//       bottomNavigationBar: Container(
//         decoration: BoxDecoration(
//           color: Colors.black54,
//         ),
//         child: Padding(
//           padding: const EdgeInsets.symmetric(horizontal: 30.0, vertical: 8),
//           child: GNav(
//             color: Colors.white,
//             tabBackgroundColor: Colors.grey,
//             activeColor: Colors.white,
//             hoverColor: Colors.black45,
//             rippleColor: Colors.white,
//             gap: 8,
//             padding: EdgeInsets.all(16),
//             tabs: [
//               GButton(
//                 icon: Icons.home,
//                 text: 'Home',
//               ),
//               GButton(
//                 icon: CupertinoIcons.profile_circled,
//                 text: 'Profile',
//               )
//             ],
//             selectedIndex: _selectedIndex,
//             onTabChange: (index) {
//               setState(() {
//                 _selectedIndex = index;
//               });
//             },
//           ),
//         ),
//       ),
//     );
//   }
// }
