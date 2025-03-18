import 'package:demoweb/borderpainter.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget{
  const HomePage({super.key});

  @override
  State<StatefulWidget> createState() => _HomePageState();

}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin{
  late AnimationController _controller;

  List<dynamic> keyExpertsDataList = [];
  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 3),
      vsync: this,
    )..repeat();
    getProfiles();
  }


  Future<void> getProfiles() async {
    final dio = Dio();
    Response response;
    response = await dio.post('https://us-central1-entym-c09bf.cloudfunctions.net/callExternalApi',
        options: Options(
          headers: {
            "Authorization":"Bearer eyJhbGciOiJSUzI1NiIsImtpZCI6ImEwODA2N2Q4M2YwY2Y5YzcxNjQyNjUwYzUyMWQ0ZWZhNWI2YTNlMDkiLCJ0eXAiOiJKV1QifQ.eyJwcm92aWRlcl9pZCI6ImFub255bW91cyIsImlzcyI6Imh0dHBzOi8vc2VjdXJldG9rZW4uZ29vZ2xlLmNvbS9lbnR5bS1jMDliZiIsImF1ZCI6ImVudHltLWMwOWJmIiwiYXV0aF90aW1lIjoxNzQyMjk4ODQ4LCJ1c2VyX2lkIjoieUFLNFFlN2Q0ck1RSkY1ajI5bTR6RlFhSXRVMiIsInN1YiI6InlBSzRRZTdkNHJNUUpGNWoyOW00ekZRYUl0VTIiLCJpYXQiOjE3NDIyOTg4NDgsImV4cCI6MTc0MjMwMjQ0OCwiZmlyZWJhc2UiOnsiaWRlbnRpdGllcyI6e30sInNpZ25faW5fcHJvdmlkZXIiOiJhbm9ueW1vdXMifX0.DNJcGiaqV8aOt4_S65g2Hxrtb0K8-tiFtjO8YfCuHMNYxoUCwQLCAvei2TjVcvO4kzHwSNp5hKxoThC6RwiZNUO7zrtTSIuXE3DeQ7HsIyUx-xmnA1z9eYC2XU-12IhLfUuIlVWHxGRgXNZBVX8LOqEykdEfbA_U8kC9jkdWNSicmguYHjriZqPgLWIHEYffwWZeHT3oofTUkapLrm2t8Haf3ghMIJ3yXqvnY5YDx1FCHOJHckS5v9lCjuhlm6GnDbNPcNKwBPELlKj37UNF2uPWs9LufyBCY9ZbYEdxrSnMeEufuhp2X4G6ZtvdRX-g_A8F7zWinWsFspayjHg-lg"
          }
        ),
        data: {
          "data":{
            "body":{},
            "endpoint":"/user-profiles",
            "headers":{
              "userapi-key":"KPaT0btDLApReHXDYApkmwNidjp8Fo"
            },
            "method":"GET"
          }
        });
    print("User Profile api response:- ");
    // print(response.statusCode);
    // print(response.data);
    if(response.data['result']!=null){
      print("result.data['data'] is not null @@@");
      if(response.data['result']['data']['profiles']!=null){
        print("result.data['data']['profiles'] is not null @@@");
        List<dynamic> profilesList = response.data['result']['data']['profiles'];
        print("profilesList size-> ${profilesList.length}");
        keyExpertsDataList = profilesList;
        print(keyExpertsDataList);
        setState(() {});
      }
    }
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home Page'),
        centerTitle: true,
      ),
      body:SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Title
            Text(
              'Dashboard',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16),
            SizedBox(
              height: 118,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: keyExpertsDataList.length,
                itemBuilder: (context, index) =>
                    _buildProfileItem(keyExpertsDataList[index]),
              ),
            ),
            SizedBox(height: 30),
            // 2x6 Grid View
            GridView.builder(
              shrinkWrap: true, // Allows GridView to fit inside Column
              physics: NeverScrollableScrollPhysics(), // Prevents inner scrolling
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 6,
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
                childAspectRatio: 1.5,
              ),
              itemCount: 24,
              itemBuilder: (context, index) {
                return Container(
                  decoration: BoxDecoration(
                    color: Colors.blueAccent,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Center(
                    child: Text(
                      'Item ${index + 1}',
                      style: TextStyle(color: Colors.white, fontSize: 18),
                    ),
                  ),
                );
              },
            ),

            SizedBox(height: 16),

            // Horizontal List
            Text(
              'Quick Actions',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            SizedBox(
              height: 100,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: 6,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: Column(
                      children: [
                        CircleAvatar(
                          radius: 30,
                          backgroundColor: Colors.blueAccent,
                          child: Icon(Icons.star, color: Colors.white),
                        ),
                        SizedBox(height: 8),
                        Text('Action ${index + 1}'),
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
  Widget _buildProfileItem(dynamic profileData) {
    return InkWell(
      onTap: () {

      },
      child: Container(
        // padding: const EdgeInsets.fromLTRB(12, 10, 0, 6),
        height: 118,
        width: 76,
        margin: const EdgeInsets.only(right: 12),
        child: Column(
          children: [
            const SizedBox(height: 10),
            _buildProfileImage(profileData['profileImage']??""),
            const SizedBox(height: 3),
            Text(
              profileData['name'] ?? "",
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 10,
                color: Colors.black,
              ),
              textAlign: TextAlign.center,
              overflow: TextOverflow.ellipsis,
              softWrap: false,
              maxLines: 1,
            ),
            const SizedBox(height: 3),
            if(profileData['isAvailable']??false) _AvailableBadge()
          ],
        ),
      ),
    );
  }

  Widget _buildProfileImage(String profileImage) {
    return SizedBox(
      height: 70,
      width: 65,
      child: Stack(
        children: [
          AnimatedBuilder(
            animation: _controller,
            builder: (_, child) => CustomPaint(
              painter: BorderPainter(_controller.value),
              child: child,
            ),
            child: Container(
              height: 60,
              width: 60,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                image: DecorationImage(
                  image: profileImage.isNotEmpty
                      ? NetworkImage(profileImage)
                      : const AssetImage('assets/default_image.png')
                  as ImageProvider,
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          const Align(
            alignment: Alignment.bottomCenter,
            child: _LiveBadge(),
          ),
        ],
      ),
    );
  }
}


class _LiveBadge extends StatelessWidget {
  const _LiveBadge();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 3, vertical: 2),
      decoration: BoxDecoration(
        color: Colors.pink,
        border: Border.all(color: Colors.white, width: 0.6),
        borderRadius: const BorderRadius.all(Radius.circular(3)),
      ),
      child: const Text(
        "Live",
        style: TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.normal,
          fontSize: 6.5,
        ),
      ),
    );
  }
}

class _AvailableBadge extends StatelessWidget {
  const _AvailableBadge();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 3, vertical: 2),
      decoration: BoxDecoration(
        color: Colors.yellow,
        border: Border.all(color: Colors.white, width: 0.6),
        borderRadius: const BorderRadius.all(Radius.circular(3)),
      ),
      child: const Text(
        "Available",
        style: TextStyle(
          color: Colors.black,
          fontWeight: FontWeight.normal,
          fontSize: 6.5,
        ),
      ),
    );
  }
}