import 'dart:async';




import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:webview_flutter_android/webview_flutter_android.dart';


import '../main.dart';


var url="https://xd.adobe.com/view/828c2c7e-f6c3-4ae3-a07f-e08ecbfac7e1-d7df/";

class WebViewScreen extends StatefulWidget {
  const WebViewScreen({Key? key}) : super(key: key);

  @override
  State<WebViewScreen> createState() => _WebViewScreenState();
}

class _WebViewScreenState extends State<WebViewScreen> {
  late final WebViewController _controller;
  late final WebViewController _controller2;

  final Completer<WebViewController> _controllerCompleter =
      Completer<WebViewController>();

  var lastUrl = "";
  var backEnabled = false;

  @override
  void initState() {
    late final PlatformWebViewControllerCreationParams params;
    params = const PlatformWebViewControllerCreationParams();

    final WebViewController controller =
        WebViewController.fromPlatformCreationParams(params);

    controller
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(const Color(0x00000000))
      ..setNavigationDelegate(
        NavigationDelegate(
          onProgress: (int progress) {
            print('WebView is loading (progress : $progress%)');
          },
          onPageStarted: (String url) {
            print('Page started loading: $url');
            // if(url==homeURL){
            //   setState(() {
            //     backButtonOpacity=1;
            //   });
            // }else  if(url==loginURL){
            //   setState(() {
            //     backButtonOpacity=.5;
            //   });
            // }
          },
          onPageFinished: (String url) async {
            // try {
            //
            // } catch (e, s) {
            //   print(s);
            // }
            //
            // lastUrl = url;
            // setBack();
            //
            // // getCookies(url);
            // // getCookies(url.replaceAll("https://", ""));
            // // print('Page finished loading: $url');
            // if (isLoading) {
            //   setState(() {
            //     isLoading = false;
            //   });
            // } else {
            //   setState(() {});
            // }
            //
            // print("urlurlurlurl $url");
            //
            // if ((url == loginURL || url == loginURL2)) {
            //   if (artistId != null) {
            //     try {
            //
            //     } catch (e, s) {
            //       print(s);
            //     }
            //   }
            //   artistId = null;
            // }
            //
            // if (artistId == null && url == homeURL) {
            //   _controller2
            //       ?.loadRequest(Uri.parse(Uri.encodeFull(getauthIdURL)));
            // }
          },
          onWebResourceError: (WebResourceError error) {
            print('''
Page resource error:
  code: ${error.errorCode}
  description: ${error.description}
  errorType: ${error.errorType}
  isForMainFrame: ${error.isForMainFrame}
          ''');
          },
          onNavigationRequest: (NavigationRequest request) {
            // if (request.url.contains(RestAPI.paymentCallBackURL)) {
            //   print('blocking navigation to ${request.url}');
            //   setState(() {
            //     isLoading = true;
            //   });
            //   RestAPI().afterPayment(request.url).then((value) {
            //     setState(() {
            //       isLoading = false;
            //     });
            //     if (value?.code == 200) {
            //       //if(value!.data!.bookingView![0].typeId=="2") {} else {}
            //       Navigator.push(
            //         context,
            //         MaterialPageRoute(
            //             builder: (context) =>
            //                 ConfirmationSuccessScreen(value!)),
            //       );
            //     } else {
            //       Navigator.push(
            //         context,
            //         MaterialPageRoute(
            //             builder: (context) => ConfirmationFailScreen()),
            //       );
            //     }
            //   });
            //   return NavigationDecision.prevent;
            // }
            // print('allowing navigation to ${request.url}');
            return NavigationDecision.navigate;
          },
        ),
      )
      ..addJavaScriptChannel(
        'Toaster',
        onMessageReceived: (JavaScriptMessage message) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(message.message)),
          );
        },
      )
      ..loadRequest(Uri.parse(Uri.encodeFull(url)));

    // fetchUrlsFromPref().then((value) {
    //   controller..loadRequest(Uri.parse(Uri.encodeFull(homeURL)));
    // });
    //
    // onRemoteConfigUpdate = () {
    //   controller..loadRequest(Uri.parse(Uri.encodeFull(homeURL)));
    // };

    // #docregion platform_features
    if (controller.platform is AndroidWebViewController) {
      AndroidWebViewController.enableDebugging(true);
      (controller.platform as AndroidWebViewController)
          .setMediaPlaybackRequiresUserGesture(false);
    }
    // #enddocregion platform_features

    _controller = controller;

    if (2 == 2) {
      late final PlatformWebViewControllerCreationParams params;
      params = const PlatformWebViewControllerCreationParams();

      final WebViewController controller =
          WebViewController.fromPlatformCreationParams(params);
      controller
        ..setJavaScriptMode(JavaScriptMode.unrestricted)
        ..setBackgroundColor(const Color(0x00000000))
        ..setNavigationDelegate(
          NavigationDelegate(
            onProgress: (int progress) {
              print('WebView is loading (progress : $progress%)');
            },
            onPageStarted: (String url) {
              print('Page started loading: $url');
              // if(url==homeURL){
              //   setState(() {
              //     backButtonOpacity=1;
              //   });
              // }else  if(url==loginURL){
              //   setState(() {
              //     backButtonOpacity=.5;
              //   });
              // }
            },
            onPageFinished: (String url) async {
              // if (url.contains("getauthId"))
              //   getSellerID();
              // else {
              //   var html = await _controller2.runJavaScriptReturningResult(
              //       "window.document.getElementsByTagName('html')[0].outerHTML;");
              //   print("CookieManager ${html}");
              // }
            },
            onWebResourceError: (WebResourceError error) {},
            onNavigationRequest: (NavigationRequest request) {
              return NavigationDecision.navigate;
            },
          ),
        );

      _controller2 = controller;
    }

    super.initState();
  }

  var isLoading = true;

  @override
  Widget build(BuildContext context) {
    print("lastUrl $lastUrl canGoBack ${_controller.canGoBack()}");

    return WillPopScope(
      onWillPop: () async {
        return Future(() {
          if (backEnabled) {
            _controller?.goBack();
            return false;
          } else
            return true;
        });
      },
      child: Scaffold(
          resizeToAvoidBottomInset: true,
          backgroundColor: Colors.white,
          appBar: null,
          body: Stack(
            fit: StackFit.expand,
            children: [
              Opacity(
                opacity: 0,
                child: Container(
                  width: 1,
                  height: 1,
                  child: WebViewWidget(
                    controller: _controller2,
                  ),
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  // Visibility(
                  //   visible: true,
                  //   child: Padding(
                  //     padding: const EdgeInsets.only(top: 50),
                  //     child: Stack(
                  //       alignment: Alignment.center,
                  //       fit: StackFit.loose,
                  //       children: [
                  //         Align(
                  //           alignment: Alignment.centerLeft,
                  //           child: InkWell(
                  //             onTap: () async {
                  //               if (backEnabled) _controller?.goBack();
                  //               //Navigator.pop(context);
                  //             },
                  //             child: Padding(
                  //               padding: const EdgeInsets.only(left: 18),
                  //               child: Container(
                  //                 height: 45,
                  //                 width: 45,
                  //                 padding: EdgeInsets.symmetric(horizontal: 12),
                  //                 child: Opacity(
                  //                   opacity: (backEnabled) ? 1.0 : .2,
                  //                   child: Image.asset(
                  //                     'assets/images/Icon ionic-ios-arrow-round-back.png',
                  //                   ),
                  //                 ),
                  //               ),
                  //             ),
                  //           ),
                  //         ),
                  //         Center(
                  //           child: InkWell(
                  //             onTap: () async {
                  //               // final fcmToken =
                  //               //     await FirebaseMessaging.instance.getToken();
                  //               // fcm = fcmToken!;
                  //               // setState(() {});
                  //               // print("CookieManager fcmToken ${fcmToken}");
                  //             },
                  //             child: Text(
                  //               "Darzi",
                  //               style: TextStyle(
                  //                   fontSize: 16,
                  //                   color: Colors.black),
                  //             ),
                  //           ),
                  //         ),
                  //         Container(),
                  //       ],
                  //     ),
                  //   ),
                  // ),
                  Expanded(
                    child: Container(
                      child: WebViewWidget(
                        controller: _controller,
                      ),
                    ),
                  ),
                ],
              ),
              // Visibility(
              //     visible: isLoading,
              //     child: Center(child: CircularProgressIndicator())),
            ],
          )),
    );
  }



}
