import 'dart:async';

import 'package:geolocator/geolocator.dart';

class LocationService {

  static Future<Position> getLocation() async {
    bool isEnabled;
    LocationPermission permission;

    // 检查位置服务是否已启用
    isEnabled = await Geolocator.isLocationServiceEnabled();
    if ( ! isEnabled) {
      // 如果服务未启用, 抛出错误
      return Future.error('Location services are disabled.');
    }

    // 检查权限状态
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      // 如果权限被拒绝, 请求权限
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }

    // 如果权限被永久拒绝, 抛出错误
    if (permission == LocationPermission.deniedForever) {
      return Future.error('Location permissions are permanently denied, cannot request.');
    }

    // 获取当前位置信息
    Position position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
    var latitude = position.latitude;
    var longitude = position.longitude;
    var string = position.toString();
    print('Latitude: $latitude, Longitude: $longitude, Position: $string');
    return position;
  }

  static StreamSubscription<Position> getPositionStream() {
    onData(Position position) {
      var latitude = position.latitude;
      var longitude = position.longitude;
      print('Latitude: $latitude, Longitude: $longitude');
    }
    // 仅当移动 10 米时更新
    var settings = const LocationSettings(accuracy: LocationAccuracy.high, distanceFilter: 10);
    return Geolocator.getPositionStream(locationSettings: settings).listen(onData);
  }

}