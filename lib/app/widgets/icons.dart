import 'package:flutter/material.dart';

import '../core/values/colors.dart';
import '../core/values/icons.dart';

List<Icon> getIcons(){
  return const [
    Icon(IconData(personIcon, fontFamily: 'MaterialIcons'),color: purple),
    Icon(IconData(worklcon, fontFamily: 'MaterialIcons'),color: pink,),
    Icon(IconData(movieIcon, fontFamily: 'MaterialIcons'),color: green,),
    Icon(IconData(sporticon, fontFamily: 'MaterialIcons'),color: yellow,),
    Icon(IconData(travelIcon, fontFamily: 'MaterialIcons'),color: deepPink,),
    Icon(IconData(shoplcon, fontFamily: 'MaterialIcons'),color: lightBlue,),
  ];
}