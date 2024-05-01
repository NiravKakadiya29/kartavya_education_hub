import '../const/consts.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home'),
        leading: Builder(
          builder: (context) => IconButton(
            icon: Icon(Icons.menu),
            onPressed: () => Scaffold.of(context).openDrawer(),
          ),
        ),
      ),
      drawer: MyDrawer(),
      backgroundColor: Vx.blue200,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(
                  top: 20.0, bottom: 8, left: 15, right: 15),
              child: Center(
                child: NeuBox(
                  borderRadius: 15.0,
                  blurRadius: 0.0,
                  bgColor: 0xff288BA8,
                  bottomRight: 0xff90CAF9,
                  topLeft: 0xffd8d7d7,
                  distance: -2.0,
                  height: 150.0,
                  width: MediaQuery.of(context).size.width,
                  child: Center(
                    child: Row(
                      children: [
                        20.widthBox,
                        'Result'.text.size(25).semiBold.make(),
                        Spacer(),
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 8.0, right: 20, top: 8, bottom: 8),
                          child: Image.asset(
                            "./lib/assets/images/Result.png",
                            width: 120,
                          ),
                        )
                      ],
                    ),
                  ),
                ).onTap(() {
                  Get.to(ResultPage());
                }),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                  top: 8.0, bottom: 8, left: 15, right: 15),
              child: Center(
                child: NeuBox(
                  borderRadius: 15.0,
                  blurRadius: 0.0,
                  bgColor: 0xff288BA8,
                  bottomRight: 0xff90CAF9,
                  topLeft: 0xffd8d7d7,
                  distance: -2.0,
                  height: 150.0,
                  width: MediaQuery.of(context).size.width,
                  child: Center(
                    child: Row(
                      children: [
                        20.widthBox,
                        'HomeWork'.text.size(25).semiBold.make(),
                        Spacer(),
                        Padding(
                          padding: const EdgeInsets.only(top: 8, bottom: 8),
                          child: Image.asset(
                            "./lib/assets/images/hw.png",
                            width: 180,
                          ),
                        )
                      ],
                    ),
                  ),
                ).onTap(() {
                  Get.to(HomeworkPage());
                }),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                  top: 8.0, bottom: 8, left: 15, right: 15),
              child: Center(
                child: NeuBox(
                  borderRadius: 15.0,
                  blurRadius: 0.0,
                  bgColor: 0xff288BA8,
                  bottomRight: 0xff90CAF9,
                  topLeft: 0xffd8d7d7,
                  distance: -2.0,
                  height: 150.0,
                  width: MediaQuery.of(context).size.width,
                  child: Center(
                    child: Row(
                      children: [
                        20.widthBox,
                        'Gallery'.text.size(25).semiBold.make(),
                        Spacer(),
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 8.0, right: 50, top: 8, bottom: 8),
                          child: Image.asset(
                            "./lib/assets/images/gallery.png",
                            width: 100,
                          ),
                        )
                      ],
                    ),
                  ),
                ).onTap(() {
                  Get.to(GalleryPage());
                }),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// class MyDrawer extends StatelessWidget {
//   const MyDrawer({
//     super.key,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return Drawer(
//       child: ListView(
//         children: [
//           DrawerHeader(
//             decoration: BoxDecoration(
//               color: Colors.blue,
//             ),
//             child: Text('Drawer Header'),
//           ),
//           ListTile(
//             title: Text('Item 1'),
//             onTap: () {
//               // Handle tap action for item 1
//             },
//           ),
//           ListTile(
//             title: Text('Item 2'),
//             onTap: () {
//               // Handle tap action for item 2
//             },
//           ),
//         ],
//       ),
//     );
//   }
// }
