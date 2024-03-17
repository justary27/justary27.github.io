String deviceDetector(double width) {
  if (360 < width && width <= 390)
    return 'mobiles390-';
  else if (390 < width && width <= 450)
    return 'mobiles450-';
  else if (450 < width && width <= 768)
    return 'tablets768-';
  else if (768 < width && width <= 1024)
    return 'tablets1024-';
  else if (1024 < width && width <= 1536)
    return 'laptops1536-';
  else if (1536 < width && width <= 1920)
    return 'laptops1920-';
  else
    return "Device Type Not Supported";
}
