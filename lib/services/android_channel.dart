import 'package:flutter/services.dart';

/// Channel used to talk to the native Android side for automatic backups
/// (picking a SAF folder to back up into).
const androidChannel = MethodChannel('com.fernmoney.fern_money/android');
