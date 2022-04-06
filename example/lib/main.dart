import 'package:flutter/material.dart';

import 'package:dotted_slider/dotted_slider.dart';

void main() {
  runApp(MaterialApp(
    home: ExampleApp(),
  ));
}

class ExampleApp extends StatelessWidget {
  final controller = SliderController(
    selected: 0,
    dots: 3,

    infinite: true
  );

  ExampleApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Example dotted slider"),
      ),

      body: Column(
        children: [
          const SizedBox(height: 16),
          DottedSlider(controller: controller),
          const SizedBox(height: 16),

          Row(
            children: [
              ElevatedButton(
                onPressed: () => controller.previuos(),
                child: const Text("Previous")
              ),

              const SizedBox(width: 16),
              ElevatedButton(
                onPressed: () => controller.next(),
                child: const Text("Next")
              ),
              
              const SizedBox(width: 16),
              ElevatedButton(
                onPressed: () => controller.addDot(),
                child: const Text("Add dot")
              ),

              const SizedBox(width: 16),
              ElevatedButton(
                onPressed: () => controller.popDot(),
                child: const Text("Pop dot")
              )
            ],

            mainAxisAlignment: MainAxisAlignment.center,
          )
        ],
      ),
    );
  }
}
