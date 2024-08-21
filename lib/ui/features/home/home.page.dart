import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

import 'package:tractian_mobile_challenge/core/utils/app_assets.dart';
import 'package:tractian_mobile_challenge/domain/http/companies.service.dart';
import 'package:tractian_mobile_challenge/ui/features/assets/assets.page.dart';
import 'package:tractian_mobile_challenge/ui/features/home/widgets/company_tile.dart';
import 'package:tractian_mobile_challenge/ui/features/widgets/future_retry_builder.widget.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(context) => Scaffold(
        appBar: AppBar(title: AppAssets.tractian),
        body: FutureRetryBuilder(
          future: GetIt.instance.get<CompaniesService>().getAll(),
          builder: (companies) => ListView.separated(
            itemCount: companies.length,
            separatorBuilder: (_, __) => const SizedBox(height: 40),
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
            itemBuilder: (_, index) => CompanyTile(
              company: companies.elementAt(index),
              onPressed: (company) => Navigator.pushNamed(context, AssetsPage.route, arguments: company.id),
            ),
          ),
        ),
      );
}
