import 'package:device_info_plus/device_info_plus.dart';
import 'package:learn_flutter/utils/platform_utils.dart';

class DeviceService {

  DeviceService._();

  static final DeviceInfoPlugin _plugin = DeviceInfoPlugin();

  /// fetch device information based on the current platform
  static Future<Map<String, dynamic>> getDeviceInfo() async {
    try {
      if (PlatformUtils.isAndroid) {
        return await _getAndroidInfo();
      }
      if (PlatformUtils.isIOS) {
        return await _getIosInfo();
      }
      if (PlatformUtils.isWeb) {
        return await _getWebInfo();
      }
      return {'platform': 'unknown'};
    } catch (e) {
      var msg = e.toString();
      return {'platform': 'error', 'error': msg};
    }
  }

  static Future< Map<String, dynamic> > _getWebInfo() async {
    final info = await _plugin.webBrowserInfo;
    final map = {
      'platform': 'web',
      'vendor': info.vendor,
      'userAgent': info.userAgent,
    };
    return map;
  }

  static Future< Map<String, dynamic> > _getIosInfo() async {
    final info = await _plugin.iosInfo;
    final map = {
      'platform': 'ios',
      'model': info.model,
      'machine': info.utsname.machine,
      'systemVersion': info.systemVersion,
      'isPhysicalDevice': info.isPhysicalDevice,
    };
    return map;
  }

  static Future< Map<String, dynamic> > _getAndroidInfo() async {
    final info = await _plugin.androidInfo;
    final map = {
      'platform': 'android',
      'brand': info.brand,
      'model': info.model,
      'sdkInt': info.version.sdkInt,
      'release': info.version.release,
      'isPhysicalDevice': info.isPhysicalDevice,
    };
    return map;
  }

}