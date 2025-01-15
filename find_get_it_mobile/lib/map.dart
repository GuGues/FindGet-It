// lib/login_page.dart
import 'package:flutter/material.dart';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_naver_map/flutter_naver_map.dart';
import 'package:location/location.dart';
import 'package:http/http.dart' as http;

import 'appConfig.dart';
import 'global.dart';

class MapPage extends StatefulWidget {
  const MapPage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _MapPageState();
}
class _MapPageState extends State<MapPage> {

  double lat = 0;
  double lng = 0;
  Location location = new Location();


  _getLocationOther(String args) async {
    var uri = Uri.parse(appConfig.url + '/app/chatting/get-location');
    final response = await http.post(uri,
          headers: <String, String>{'Content-Type': 'application/json'},
          body: jsonEncode(<String, String>{
            'chatting_no':args.toString(),
            'email':GlobalState.loginEmail,
          }));
    if (response.statusCode == 200) {
      // 서버에서 받은 JSON 데이터를 파싱해서 List<ChattingRoom>로 변환
      Map<String, dynamic> data = json.decode(utf8.decode(response.bodyBytes));
      setState(() {
        lat = data['lat'];
        lng = data['lng'];
      });
    } else {
      throw Exception('Failed to load fetchRoom');
    }
  }



  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final args = ModalRoute
          .of(context)
          ?.settings
          .arguments;
      if (args is String)
          _getLocationOther(args);
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: NaverMap(
          options: const NaverMapViewOptions(
              locationButtonEnable: true,
          ),
          onMapReady: (controller) {
            final other = NMarker(
                id: 'test',
                position: NLatLng(lat, lng));
            controller.addOverlayAll({other});
            controller.setLocationTrackingMode(NLocationTrackingMode.follow);
            final onMarkerInfoWindow =
            NInfoWindow.onMarker(id: other.info.id, text: "멋쟁이 사자처럼");
            other.openInfoWindow(onMarkerInfoWindow);
          },
        ),
      ),
    );
  }
}