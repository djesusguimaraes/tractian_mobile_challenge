import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class AppAssets {
  static Widget get component => Image.asset(AssetsPath.component, fit: BoxFit.contain);
  static Widget get asset => SvgPicture.asset(AssetsPath.asset);
  static Widget get company => SvgPicture.asset(AssetsPath.company);
  static Widget get location => SvgPicture.asset(AssetsPath.location);
  static Widget get tractian => SvgPicture.asset(AssetsPath.tractian);
}

class AssetsPath {
  static const _png = 'assets/png';
  static const _svg = 'assets/svg';

  static const component = '$_png/component.png';
  static const asset = '$_svg/asset.svg';
  static const company = '$_svg/company.svg';
  static const location = '$_svg/location.svg';
  static const tractian = '$_svg/tractian.svg';
}
