import '../const/consts.dart';
import 'addtest.dart';
import 'teacherdrawer.dart';

class TeacherHomePage extends StatefulWidget {
  const TeacherHomePage({super.key});

  @override
  State<TeacherHomePage> createState() => _TeacherHomePageState();
}

class _TeacherHomePageState extends State<TeacherHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Teacher Dashboard'),
      ),
      drawer: TeacherDrawer(),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
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
                    height: 130.0,
                    width: MediaQuery.of(context).size.width,
                    child: Center(
                      child: Row(
                        children: [
                          20.widthBox,
                          'Add Marks'.text.size(22).bodyText1(context).make(),
                          Spacer(),
                          Padding(
                            padding: const EdgeInsets.only(top: 8, bottom: 8),
                            child: Image.asset(
                              "./lib/assets/images/Result.png",
                              width: 130,
                            ),
                          )
                        ],
                      ),
                    ),
                  ).onTap(() {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => AddTest()),
                    );
                  }),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
