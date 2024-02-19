import 'package:flutter/material.dart';
import 'package:vibration/vibration.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:zikirmatik/kible.dart';

void main() {
  runApp(ZikirmatikApp());
}

const List<String> list = <String>[
  '500',
  '1000',
  '2000',
  '3000',
  '4000',
  '5000',
  '6000',
  '7000',
  '8000',
  '9000',
  '10000'
];

class ZikirmatikApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Zikirmatik',
      home: ZikirmatikScreen(),
    );
  }
}

class ZikirmatikScreen extends StatefulWidget {
  @override
  _ZikirmatikScreenState createState() => _ZikirmatikScreenState();
}

class _ZikirmatikScreenState extends State<ZikirmatikScreen> {
  final List<String> mp3List = [
    'mp3/Kuran-Kuran-1-Cuz.mp3',
    'mp3/Kuran-Kuran-2-Cuz.mp3',
    'mp3/Kuran-Kuran-3-Cuz.mp3',
    'mp3/Kuran-Kuran-4-Cuz.mp3',
    'mp3/Kuran-Kuran-5-Cuz.mp3',
    'mp3/Kuran-Kuran-6-Cuz.mp3',
    'mp3/Kuran-Kuran-7-Cuz.mp3',
    'mp3/Kuran-Kuran-8-Cuz.mp3',
    'mp3/Kuran-Kuran-9-Cuz.mp3',
    'mp3/Kuran-Kuran-10-Cuz.mp3',
    'mp3/Kuran-Kuran-11-Cuz.mp3',
    'mp3/Kuran-Kuran-12-Cuz.mp3',
    'mp3/Kuran-Kuran-13-Cuz.mp3',
    'mp3/Kuran-Kuran-14-Cuz.mp3',
    'mp3/Kuran-Kuran-15-Cuz.mp3',
    'mp3/Kuran-Kuran-16-Cuz.mp3',
    'mp3/Kuran-Kuran-17-Cuz.mp3',
    'mp3/Kuran-Kuran-18-Cuz.mp3',
    'mp3/Kuran-Kuran-19-Cuz.mp3',
    'mp3/Kuran-Kuran-20-Cuz.mp3',
    'mp3/Kuran-Kuran-21-Cuz.mp3',
    'mp3/Kuran-Kuran-22-Cuz.mp3',
    'mp3/Kuran-Kuran-23-Cuz.mp3',
    'mp3/Kuran-Kuran-24-Cuz.mp3',
    'mp3/Kuran-Kuran-25-Cuz.mp3',
    'mp3/Kuran-Kuran-26-Cuz.mp3',
    'mp3/Kuran-Kuran-27-Cuz.mp3',
    'mp3/Kuran-Kuran-28-Cuz.mp3',
    'mp3/Kuran-Kuran-29-Cuz.mp3',
    'mp3/Kuran-Kuran-30-Cuz.mp3',
  ];
  List<bool> isPlayingList = [];
  @override
  void initState() {
    super.initState();
    // Burada isPlayingList'i mp3List boyutunda false'larla başlatın
    isPlayingList = List.generate(mp3List.length, (index) => false);
  }

  Future<void> playCustomAudio(int index) async {
    await advancedPlayer.play(AssetSource(mp3List[index]));
  }

  int zikirCount = 0;
  int selectedDropdownValue = 0;
  String dropdownValue = list.first;
  AudioCache audioCache = AudioCache();
  AudioPlayer advancedPlayer = AudioPlayer();

  void incrementZikirCount() {
    setState(() {
      zikirCount++;
    });
    checkJob();
  }

  void resetZikirCount() {
    setState(() {
      zikirCount = 0;
    });
  }

  void stopAudio() {
    advancedPlayer.stop();
  }

  void checkJob() {
    if (dropdownValue == '$zikirCount') {
      Vibration.vibrate(duration: 1000);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'Dersini tamamladın!',
            style: TextStyle(
              fontFamily: 'Roboto',
              fontWeight: FontWeight.w400,
              fontSize: 30,
              color: Colors.white,
            ),
          ),
        ),
      );
    }
  }

  bool isDropdownVisible = false;
  bool isPlaying = false;
  @override
  Widget build(BuildContext context) {
    final double screenHeight = MediaQuery.of(context).size.height;
    final double screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/images/playstore.png',
              scale: 12,
            ),
            SizedBox(
              width: screenWidth * 0.004,
            ),
            const Text(
              'Zikirmatik',
              style: TextStyle(color: Colors.black),
            ),
          ],
        ),
        backgroundColor: Colors.deepPurpleAccent, //<-- SEE HERE
      ),
      drawer: Drawer(
        backgroundColor: Colors.deepPurpleAccent,
        // Add a ListView to the drawer. This ensures the user can scroll
        // through the options in the drawer if there isn't enough vertical
        // space to fit everything.
        child: ListView(
          // Important: Remove any padding from the ListView.
          padding: EdgeInsets.zero,
          children: [
            const SizedBox(
              height: 64.0,
              child: DrawerHeader(
                decoration: BoxDecoration(
                  color: Colors.deepPurpleAccent,
                  image: DecorationImage(
                    image: AssetImage('assets/images/playstore.png'),
                    // Resminizin yolunu ekleyin
                    fit: BoxFit.fitHeight,
                  ),
                ),
                child: const Text(
                  '',
                  style: TextStyle(color: Colors.black),
                ),
                margin: EdgeInsets.all(0.0),
                padding: EdgeInsets.all(0.0),
              ),
            ),
            ListTile(
              leading: Icon(
                Icons.search, // "find" ikonu
                color: Colors.black,
              ),
              title: const Text(
                'Kible Bul',
                style: TextStyle(
                  fontFamily: 'Roboto',
                  fontWeight: FontWeight.w800,
                  fontSize: 20,
                  color: Colors.black,
                ),
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => CompassApp()),
                );
              },
            ),
          ],
        ),
      ),
      backgroundColor: Color.fromARGB(255, 147, 130, 192),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Stack(
              alignment: Alignment.center,
              children: [
                Image.asset(
                  'assets/images/zikir.png',
                  height: screenHeight * 0.51,
                ),
                Positioned(
                  bottom: screenWidth * 0.35,
                  right: screenWidth * 0.4,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(width: screenWidth * 0.18),
                      Opacity(
                        opacity: 0.0,
                        child: ElevatedButton(
                          onPressed: resetZikirCount,
                          child: Text('Sıfırla'),
                          style: ElevatedButton.styleFrom(
                            shadowColor: Colors.transparent,
                            primary: Theme.of(context).primaryColor,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Positioned(
                  bottom: screenHeight * 0.1,
                  right: screenWidth * 0.2,
                  height: screenHeight * 0.1,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(width: screenWidth * 0.18),
                      Opacity(
                        opacity: 0.0,
                        child: ElevatedButton(
                          onPressed: incrementZikirCount,
                          child: Text('Say'),
                          style: ElevatedButton.styleFrom(
                            minimumSize: Size(100, 290),
                            shadowColor: Colors.transparent,
                            primary: Theme.of(context).primaryColor,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Positioned(
                  width: screenHeight * 0.25,
                  height: screenHeight * 0.096,
                  bottom: screenHeight * 0.307,
                  child: Container(
                    color: Colors.white,
                    alignment: Alignment.bottomRight,
                    padding: EdgeInsets.all(8.0),
                    child: Text(
                      '$zikirCount',
                      style: TextStyle(
                        fontFamily: 'Roboto',
                        fontWeight: FontWeight.w800,
                        fontSize: 40,
                        color: Colors.black,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        color: Color.fromARGB(255, 147, 130, 192),
        notchMargin: 1.0,
        child: Container(
          width: MediaQuery.of(context).size.width * 0.4,
          color: Colors.transparent,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedButton(
                onPressed: () {
                  showModalBottomSheet(
                    context: context,
                    builder: (BuildContext context) {
                      return Container(
                        padding: EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: Theme.of(context).scaffoldBackgroundColor,
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(116),
                            topRight: Radius.circular(16),
                          ),
                        ),
                        child: SizedBox(
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              DropdownButton<String>(
                                value: dropdownValue,
                                icon: const Icon(Icons.arrow_downward),
                                iconSize: 24,
                                elevation: 116,
                                style: TextStyle(
                                    color: Color.fromARGB(255, 12, 12, 12),
                                    fontSize: 20),
                                underline: Container(
                                  height: 2,
                                  color: Color.fromARGB(255, 16, 16, 16),
                                ),
                                onChanged: (String? value) {
                                  setState(() {
                                    dropdownValue = value!;

                                    showDialog(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return AlertDialog(
                                          title: Text('Değer Seçildi'),
                                          content: Text(
                                              'Seçilen Değer: $dropdownValue'),
                                          actions: [
                                            ElevatedButton(
                                              onPressed: () {
                                                Navigator.of(context).pop();
                                              },
                                              style: ElevatedButton.styleFrom(
                                                shape: CircleBorder(),
                                                primary:
                                                    Colors.deepPurpleAccent,
                                              ),
                                              child: Icon(
                                                Icons.cancel,
                                                size: 25,
                                              ),
                                            ),
                                          ],
                                        );
                                      },
                                    );
                                  });
                                },
                                items: list.map<DropdownMenuItem<String>>(
                                  (String value) {
                                    return DropdownMenuItem<String>(
                                      value: value,
                                      child: Text(value),
                                    );
                                  },
                                ).toList(),
                              ),
                              SizedBox(
                                width: MediaQuery.of(context).size.width *
                                    0.05, // Örneğin, genişliği ekran genişliğinin %10'u olarak ayarlıyoruz
                              ),
                              Text("Eklenecek ders sayısını seçin"),
                              SizedBox(
                                width: MediaQuery.of(context).size.width *
                                    0.05, // Örneğin, genişliği ekran genişliğinin %10'u olarak ayarlıyoruz
                              ),
                              ElevatedButton(
                                onPressed: () {
                                  setState(() {
                                    isDropdownVisible = false;
                                  });
                                  Navigator.of(context).pop();
                                },
                                style: ElevatedButton.styleFrom(
                                  primary: Colors.deepPurpleAccent,
                                  shape: CircleBorder(),
                                ),
                                child: Icon(
                                  Icons.cancel,
                                  size: 25,
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  );
                },
                child: Row(
                  children: [
                    Icon(Icons.school),
                    SizedBox(
                      width: screenWidth * 0.05,
                    ),
                    Text('Ders Seç'),
                  ],
                ),
                style: ElevatedButton.styleFrom(
                  primary: Colors.deepPurpleAccent,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: Text(
                          'Cüz Listesi',
                          style: TextStyle(
                              color: Color.fromARGB(255, 12, 12, 12),
                              fontSize: 20),
                        ),
                        content: SizedBox(
                          height: 300,
                          width: 200,
                          child: SingleChildScrollView(
                            child: Column(
                              children: List.generate(
                                mp3List.length,
                                (index) => StatefulBuilder(
                                  builder: (BuildContext context,
                                      StateSetter setState) {
                                    return ListTile(
                                      title: Text('Cüz ${index + 1}'),
                                      trailing: Row(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          ElevatedButton(
                                            onPressed: () {
                                              setState(() {
                                                if (isPlayingList[index]) {
                                                  isPlayingList[index] = false;
                                                  stopAudio();
                                                } else {
                                                  isPlayingList[index] = true;
                                                  playCustomAudio(index);
                                                }
                                              });
                                            },
                                            style: ElevatedButton.styleFrom(
                                              shape: CircleBorder(),
                                              primary: Colors.deepPurpleAccent,
                                            ),
                                            child: Icon(
                                              isPlayingList[index]
                                                  ? Icons.stop
                                                  : Icons.play_arrow,
                                              size: 25,
                                            ),
                                          ),
                                        ],
                                      ),
                                      onTap: () {
                                        setState(() {
                                          if (isPlayingList[index]) {
                                            isPlayingList[index] = false;
                                            stopAudio();
                                          } else {
                                            isPlayingList[index] = true;
                                            playCustomAudio(index);
                                          }
                                        });
                                      },
                                    );
                                  },
                                ),
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  );
                },
                child: Row(
                  children: [
                    Icon(Icons.star),
                    SizedBox(
                      width: screenWidth * 0.05,
                    ),
                    Text('Dualar', style: TextStyle(color: Colors.white)),
                  ],
                ),
                style: ElevatedButton.styleFrom(
                  primary: Colors.deepPurpleAccent,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
