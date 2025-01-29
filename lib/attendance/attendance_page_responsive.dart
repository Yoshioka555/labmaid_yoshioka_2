import 'package:flutter/material.dart';
import '../widget/responsive_widget.dart';
import 'attendance_home_page.dart';
import 'attendance_page_web.dart';

//変更点
//新規作成
//出席管理ページのレスポンシブ

class AttendancePageTop extends StatelessWidget {
  const AttendancePageTop({super.key});
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return Theme(
      data: ThemeData(
        useMaterial3: true, // Material 3 を有効化
        colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.pink),//イベントページのテーマカラーを設定（purple）
      ),
      child: const ResponsiveWidget(
        //従来通りのUI
        mobileWidget: AttendanceHomePage(),
        //Web用のUI
        webWidget: AttendancePageWeb(),
      ),
    );
  }
}