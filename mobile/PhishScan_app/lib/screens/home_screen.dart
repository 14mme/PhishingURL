import 'package:flutter/material.dart';

import '../services/api_service.dart';

import '../widgets/custom_button.dart';
import '../widgets/result_card.dart';
import '../widgets/url_input.dart';

class HomeScreen extends StatefulWidget {

  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() =>
      _HomeScreenState();
}

class _HomeScreenState
    extends State<HomeScreen> {

  final TextEditingController
      urlController =
      TextEditingController();

  String prediction = '';
  String confidence = '';

  bool isLoading = false;

  Future<void> detectURL() async {

    if (urlController.text.isEmpty) {

      ScaffoldMessenger.of(context)
          .showSnackBar(

        const SnackBar(
          content: Text(
            'URL tidak boleh kosong',
          ),
        ),
      );

      return;
    }

    setState(() {
      isLoading = true;
    });

    try {

      final response =
          await ApiService.predictURL(
        urlController.text,
      );

      setState(() {

        prediction =
            response['prediction'];

        confidence =
            response['confidence']
                .toString();
      });

    } catch (e) {

      ScaffoldMessenger.of(context)
          .showSnackBar(

        const SnackBar(
          content: Text(
            'Terjadi kesalahan',
          ),
        ),
      );
    }

    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      appBar: AppBar(
        title: const Text(
          'PhishScan Detection',
        ),
      ),

      body: Padding(

        padding: const EdgeInsets.all(20),

        child: Column(

          crossAxisAlignment:
              CrossAxisAlignment.stretch,

          children: [

            URLInput(
              controller: urlController,
            ),

            const SizedBox(height: 20),

            CustomButton(
              onPressed: detectURL,
              text: 'Detect URL',
            ),

            const SizedBox(height: 30),

            if (isLoading)
              const Center(
                child:
                    CircularProgressIndicator(),
              ),

            if (prediction.isNotEmpty)

              ResultCard(
                prediction: prediction,
                confidence: confidence,
              ),
          ],
        ),
      ),
    );
  }
}