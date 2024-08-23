import 'package:flutter/material.dart';

class FutureRetryBuilder<T> extends StatefulWidget {
  final Future<T>? future;
  final Widget Function(T)? builder;

  const FutureRetryBuilder({super.key, this.future, this.builder});

  @override
  State<FutureRetryBuilder<T>> createState() => _FutureRetryBuilderState<T>();
}

class _FutureRetryBuilderState<T> extends State<FutureRetryBuilder<T>> {
  Key _retryKey = UniqueKey();

  @override
  Widget build(BuildContext context) => FutureBuilder<T>(
      key: _retryKey,
      future: widget.future,
      builder: (context, snapshot) {
        if (snapshot.connectionState != ConnectionState.done) return const Center(child: CircularProgressIndicator());
        if (snapshot.hasData && widget.builder != null) return widget.builder!.call(snapshot.data as T);
        return Center(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(snapshot.error?.toString() ?? 'Ocorreu um erro ao buscar as informações'),
              ),
              TextButton.icon(
                onPressed: () => setState(() => _retryKey = UniqueKey()),
                icon: const Icon(Icons.loop_outlined),
                label: const Text('Tentar Novamente'),
              )
            ]),
          ),
        );
      });
}
