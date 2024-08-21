import 'package:flutter/material.dart';
import 'package:tractian_mobile_challenge/core/domain/company.entity.dart';
import 'package:tractian_mobile_challenge/core/utils/app_assets.dart';

class CompanyTile extends StatelessWidget {
  final Company company;
  final ValueChanged<Company>? onPressed;

  const CompanyTile({super.key, required this.company, this.onPressed});

  @override
  Widget build(BuildContext context) => ListTile(
        horizontalTitleGap: 4,
        textColor: Colors.white,
        title: Text(company.name),
        tileColor: const Color(0xff2188FF),
        onTap: () => onPressed?.call(company),
        leading: SizedBox.square(dimension: 24, child: AppAssets.company),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
      );
}
