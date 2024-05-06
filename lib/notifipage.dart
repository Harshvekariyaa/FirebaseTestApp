import 'dart:math';
import 'package:firebase_messaging/firebase_messaging.dart';
Future<void>BackgroundHandler(RemoteMessage rm) async{
  print("${rm.notification!.title}");
}

class notifipage{

  static Future<String?>getToken() async{
    FirebaseMessaging fm = FirebaseMessaging.instance;

    String? token = await FirebaseMessaging.instance.getToken();
    return token!;
  }
  static Future<void> intialize() async{
    NotificationSettings nf = await FirebaseMessaging.instance.requestPermission();
    if(nf.authorizationStatus == AuthorizationStatus.authorized){
      FirebaseMessaging.onBackgroundMessage((message) {
        return BackgroundHandler(message);
      },);
      FirebaseMessaging.onMessage.listen((msg) {
        print("msg ----> ${msg.notification!.title}");
      });
      print("Msg authorized!!!!!!!");
    }
  }

}