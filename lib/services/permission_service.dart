
import 'package:permission_handler/permission_handler.dart';


class PermissionService {

   Future<bool> requestPermission()async{
    final status = await Permission.microphone.request();
    return status.isGranted;
  }

}
