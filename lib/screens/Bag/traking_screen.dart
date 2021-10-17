import 'package:dar_sllah/widgets/traking/empty_tracking_widget.dart';
import 'package:dar_sllah/widgets/traking/traking_widget.dart';
import 'package:flutter/material.dart';

class TrakingScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(body: //EmptyTrackingWidget(),
      TrakingWidget(),
    );
  }
}