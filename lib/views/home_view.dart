import 'package:flutter/material.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:to_do/views/home/home_view_mobile.dart';
import 'package:to_do/views/home/home_view_web.dart';

import 'home/home_view_tablet.dart';


class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenTypeLayout.builder(
      //Desktop - 1100 | Tab - 700 | Mobile - 250
      breakpoints:
          const ScreenBreakpoints(desktop: 1100, tablet: 700, watch: 250),
      desktop: (BuildContext context)=>const HomeViewWeb(),
      tablet: (BuildContext context)=>const HomeViewTablet(),
      mobile: (BuildContext context)=> HomeViewMobile(),
    );
  }
}