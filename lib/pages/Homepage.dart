
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:newtotolist/Homepages/Homepage_Diario.dart';
import 'package:newtotolist/Homepages/Homepage_Nota.dart';
import 'package:newtotolist/widgets/drawer.dart';
import 'package:flutter/material.dart';
import 'AddNote.dart';
import 'CheckList.dart';

class Homepage extends StatefulWidget {
  const Homepage({Key? key}) : super(key: key);

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
final PageController _pageController = PageController(initialPage: 0);
int currentIndex = 0;

int currentTab = 0;
  setBottomBarIndex(index) {
    setState(() {
      currentIndex = index;
    });
  }

  final List<Widget> screens = [
    HomePage_Diario(),
    HomePageNota()
  ];

  @override
  final style1 = TextStyle(fontSize: 18, color: Colors.black);
  // final PageStorageBucket bucket = PageStorageBucket();

  @override
  Widget build(BuildContext context) {
  late Widget currentscreen = const HomePage_Diario();

  final Size size = MediaQuery.of(context).size;
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
    return Scaffold(
      key: _scaffoldKey,
    // resizeToAvoidBottomInset: false,
        endDrawer: Drawer( child: MainDrawer()),
          appBar: AppBar(
                backgroundColor: Color.fromARGB(255, 243, 182, 15),
                elevation: 0,             
                title: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: Text(
                    "Awake",
                    style: TextStyle(fontSize: 30),
                  ),
                ),
                actions: [
                  IconButton(
                    icon: Icon(
                      Icons.short_text,
                      color: Colors.white,
                      size: 30,
                    ),
                    onPressed: () => _scaffoldKey.currentState?.openEndDrawer(),
                  )
                ],
              ),
        body: screens[currentIndex],
        bottomNavigationBar: 
     Stack(
        children: [
          Positioned(
            child: Container(
              width: size.width,
              height: 80,
              child: Stack(
                clipBehavior: Clip.none, children: [
                  CustomPaint(
                    size: Size(size.width, 80),
                    painter: BNBCustomPainter(),
                  ),
                  Center(
                    heightFactor: 0.6,
                    child: SpeedDial(
                      overlayColor: Colors.black38,
                      overlayOpacity: 0.4,
                      animatedIcon: AnimatedIcons.add_event,
                      children: [
                        SpeedDialChild(
                          backgroundColor: Colors.orangeAccent,
                          child: Icon(Icons.note_add),
                          onTap: (){
                              Navigator.push(context, 
                              MaterialPageRoute(builder: 
                              (_)=> HomeNota()));
                          }
                        ), 
                        SpeedDialChild(
                          backgroundColor: Colors.orangeAccent,
                          child: Icon(Icons.check),
                          onTap: (){
                              Navigator.push(context, 
                              MaterialPageRoute(builder: 
                              (_)=> checkList()));
                          }
                        ),
                      ],
                    ),
                  ),
                  Container(
                    width: size.width,
                    height: 80,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        IconButton(
                          icon: Icon(
                            Icons.access_alarms_sharp,
                            size: 35,
                            color: currentIndex == 0 ? Colors.orange : Colors.grey.shade400,
                          ),
                          onPressed: () {
                            setBottomBarIndex(0);
                            setState(() {
                               currentscreen = HomePage_Diario();
                              currentIndex = 0;
                            });
                            print(currentIndex);
                            print(currentscreen);
                          },
                          splashColor: Colors.white,
                        ),
                        Container(
                          width: size.width * 0.20,
                        ),
                        Builder(
                          builder: (context) {
                            return IconButton(
                                icon: Icon(
                                Icons.check_circle,
                                size: 35,
                                  color: currentIndex == 1 ? Colors.orange : Colors.grey.shade400,
                                ),
                                onPressed: () {
                                  setState(() {
                                        
                                    currentscreen= HomePageNota();
                                    currentIndex = 1;
                                  });
                                  setBottomBarIndex(1);
                                   print(currentIndex);
                                   print(currentscreen);
                                  
                                });
                          }
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          )
        ],
      )
    );

    
  }
}


class BNBCustomPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = new Paint()
      ..color = Color(0xff292e4e)
      ..style = PaintingStyle.fill;

    Path path = Path();
    path.moveTo(0, 20); // Start
    path.quadraticBezierTo(size.width * 0.20, 0, size.width * 0.35, 0);
    path.quadraticBezierTo(size.width * 0.40, 0, size.width * 0.40, 20);
    path.arcToPoint(Offset(size.width * 0.60, 20), radius: Radius.circular(20.0), clockwise: false);
    path.quadraticBezierTo(size.width * 0.60, 0, size.width * 0.65, 0);
    path.quadraticBezierTo(size.width * 0.80, 0, size.width, 20);
    path.lineTo(size.width, size.height);
    path.lineTo(0, size.height);
    path.lineTo(0, 20);
    canvas.drawShadow(path, Colors.black, 5, true);
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}