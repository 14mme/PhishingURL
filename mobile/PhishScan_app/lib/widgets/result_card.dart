import 'package:flutter/material.dart';

class ResultCard extends StatelessWidget {

  final String prediction;
  final String confidence;

  const ResultCard({
    super.key,
    required this.prediction,
    required this.confidence,
  });

  @override
  Widget build(BuildContext context) {

    final bool isPhishing =
        prediction == 'Phishing';

    return Card(

      elevation: 5,

      child: Padding(

        padding: const EdgeInsets.all(20),

        child: Column(

          children: [

            Text(
              prediction,

              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,

                color: isPhishing
                    ? Colors.red
                    : Colors.green,
              ),
            ),

            const SizedBox(height: 10),

            Text(
              'Confidence: $confidence',

              style: const TextStyle(
                fontSize: 18,
              ),
            ),
          ],
        ),
      ),
    );
  }
}