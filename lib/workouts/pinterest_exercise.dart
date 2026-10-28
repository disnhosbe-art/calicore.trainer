import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class PinterestExercise extends StatefulWidget {
  final String pinId;

  const PinterestExercise({
    super.key,
    required this.pinId,
  });

  @override
  State<PinterestExercise> createState() =>
      _PinterestExerciseState();
}

class _PinterestExerciseState extends State<PinterestExercise> {
  late final WebViewController _controller;
  bool _loading = true;
  bool _error = false;

  @override
  void initState() {
    super.initState();

    _controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(const Color(0xFF101010))
      ..setNavigationDelegate(
        NavigationDelegate(
          onPageFinished: (_) {
            if (mounted) {
              setState(() => _loading = false);
            }
          },
          onWebResourceError: (error) {
            if (error.isForMainFrame == true && mounted) {
              setState(() {
                _loading = false;
                _error = true;
              });
            }
          },
        ),
      )
      ..loadRequest(
        Uri.parse(
          'https://assets.pinterest.com/ext/embed.html?id=${widget.pinId}',
        ),
      );
  }

  @override
  void didUpdateWidget(covariant PinterestExercise oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (oldWidget.pinId != widget.pinId) {
      setState(() {
        _loading = true;
        _error = false;
      });

      _controller.loadRequest(
        Uri.parse(
          'https://assets.pinterest.com/ext/embed.html?id=${widget.pinId}',
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(18),
      child: Stack(
        children: [
          Positioned.fill(
            child: WebViewWidget(controller: _controller),
          ),
          if (_loading)
            const Center(
              child: CircularProgressIndicator(
                color: Color(0xFFB5FF39),
              ),
            ),
          if (_error)
            Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(
                    Icons.wifi_off,
                    color: Colors.white70,
                    size: 35,
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    'Unable to load animation',
                    style: TextStyle(color: Colors.white),
                  ),
                  TextButton(
                    onPressed: () {
                      setState(() {
                        _loading = true;
                        _error = false;
                      });
                      _controller.reload();
                    },
                    child: const Text('Retry'),
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }
}
