import 'package:flutter/material.dart';
import 'package:flutter_login/my_app.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';


Future main() async  {
   await dotenv.load(fileName: ".env");
    runApp( MyApp());
}

