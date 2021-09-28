import 'package:flutter/material.dart';

String deviceDetector(Size size) {
  if (360 < size.width && size.width < 390)
    return 'mobiles390-';
  else if (390 < size.width && size.width <= 450)
    return 'mobiles450-';
  else if (450 < size.width && size.width <= 768)
    return 'tablets768-';
  else if (768 < size.width && size.width <= 1024)
    return 'tablets1024-';
  else if (1024 < size.width && size.width <= 1536)
    return 'laptops1536-';
  else if (1536 < size.width && size.width <= 1920)
    return 'laptops1920-';
  else
    return "Device Type Not Supported";
}
