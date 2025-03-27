import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';

class CustomBrowser extends StatefulWidget {
  final url;
  const CustomBrowser({super.key, 
    required this.url,
  });
  @override
  _CustomInAppBrowserState createState() => _CustomInAppBrowserState();
}

class _CustomInAppBrowserState extends State<CustomBrowser> {
  late InAppWebViewController _webViewController;
  final List<String> _targetUrls = [
    'gtdelivery://payment-success',
    // 'example.com/checkout-complete',
    // 'payment-success'
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Payment Gateway'),
        actions: [
          IconButton(
            icon: const Icon(Icons.close),
            onPressed: () => Navigator.pop(context),
          ),
        ],
      ),
      body: InAppWebView(
        initialUrlRequest: URLRequest(url: WebUri(widget.url)), // Fixed line
        onWebViewCreated: (controller) {
          _webViewController = controller;
        },
        onLoadStart: (controller, url) {
          if (url != null) {
            print('Visited URL: ${url.toString()}');
            if (_isTargetUrl(url.toString())) {
              Navigator.pop(context, url.toString());
            }
          }
        },
      ),
    );
  }

  bool _isTargetUrl(String url) {
    return _targetUrls.any((target) => url.contains(target));
  }
}