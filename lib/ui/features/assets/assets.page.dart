import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:tractian_mobile_challenge/domain/http/assets.service.dart';
import 'package:tractian_mobile_challenge/domain/http/locations.service.dart';
import 'package:tractian_mobile_challenge/ui/features/widgets/future_retry_builder.widget.dart';

import 'widgets/assets_filter.widget.dart';

final getIt = GetIt.instance;

class AssetsPage extends StatelessWidget {
  static const route = '/assets';

  const AssetsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final companyId = ModalRoute.of(context)!.settings.arguments as String;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(title: const Text('Assets')),
      body: FutureRetryBuilder(
        future: Future.wait({
          getIt<LocationsService>(param1: companyId).getAll(),
          getIt<AssetsService>(param1: companyId).getAll(),
        }),
        builder: (data) => AssetsFilter(
          items: [...data.first, ...data.last],
          builder: (items) => const SizedBox.expand(),
        ),
      ),
    );
  }
}
