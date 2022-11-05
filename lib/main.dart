import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

void main() {
  runApp(const ProviderScope(child: MyApp()));
}

extension OptionalInfixAddition<T extends num> on T? {
  T? operator +(T? other) {
    final shadow = this;
    if (shadow != null) {
      return shadow + (other ?? 0) as T;
    } else {
      return null;
    }
  }
}

//my first extension
extension OptionaNegative<T extends num> on T? {
  T? operator -(T? other) {
    final showd = this;
    if (showd != null) {
      return showd - (other ?? 0) as T;
    } else {
      return null;
    }
  }
}

void testIt() {
  final int? int1 = 1;
  final int int2 = 1;
  final result = int1 + int2;
  print(result);
}

class Counter extends StateNotifier<int?> {
  Counter() : super(null);
  void increment() => state = state == null ? 1 : state + 1;
  void decreament() => state = state == null ? 0 : state - 1;
  //int? get value => state;
}

//my own trial
// class Decounter extends StateNotifier<int?> {
//   Decounter() : super(null);
//   void decreament() => state = state == null ? 0 : state - 1;
// }
// final decountProvider = StateNotifierProvider<Decounter, int?>(
//   (ref) => Decounter(),
// );

final counterProvider = StateNotifierProvider<Counter, int?>(
  (ref) => Counter(),
);

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    // testIt();
    return MaterialApp(
      title: 'Flutter Demo',
      // theme: ThemeData(
      //   primarySwatch: Colors.blue,
      // ),
      debugShowCheckedModeBanner: false,
      darkTheme: ThemeData.dark(),
      themeMode: ThemeMode.dark,
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends ConsumerWidget {
  const MyHomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Riverpd Hooks'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Consumer(builder: (context, ref, child) {
            final count = ref.watch(
              counterProvider,
            );
            // final count2 = ref.watch(counterProvider,);
            final text = count == null ? 'Press the button' : count.toString();
            // final text2 = count == null ? 'Press the button' : count.toString();
            return Center(
              child: Text(
                text,
                style: Theme.of(context).textTheme.headline6,
              ),
            );
          }),
          TextButton(
              onPressed: () {
                ref.read(counterProvider.notifier).decreament();
              },
              child: const Text('decrease')),
          TextButton(
            onPressed: () {
              ref.read(counterProvider.notifier).increment();
            },
            child: const Text('Increament counter'),
          ),
        ],
      ),
    );
  }
}
