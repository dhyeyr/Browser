import 'dart:io';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';

class ConnectivityProvider extends ChangeNotifier {
  bool isNet = false;
  double progress = 0;
  ConnectivityResult result = ConnectivityResult.none;

  String? webAdd;
  String searchengine = "Google";
  bool isBook = false;
  List<URLRequest> bookMarList = [];

  String? url;
  String? bookUrl;
  List<String> bookName=[];
  List<String> bookLink=[];

  TextEditingController addressController = TextEditingController();
  InAppWebViewController? inAppWebViewController;
  PullToRefreshController? pullToRefreshController;

  bool canGoBack = false;
  bool canGoForward = false;
  int selectedValue = 1;
  ConnectivityResult connectivityResult = ConnectivityResult.none;
  void radioChange(int v) {
    selectedValue = v;
    notifyListeners();
  }

  NetProvider() {
    addNetListener();
  }

  void changeNetConnection(bool isNet) {
    this.isNet = isNet;
    notifyListeners();
  }

  void changeProgress(double progress) {
    this.progress = progress;
    notifyListeners();
  }

  void backForwardStatus(bool canGoBack,bool canGoForward) {
    this.canGoBack = canGoBack;
    this.canGoForward = canGoForward;
    notifyListeners();
  }

  void addNetListener() {
    Connectivity().onConnectivityChanged.listen((event) {
      result = event;
      notifyListeners();
    });
  }
  // void addNetListener() {
  //   var listen = Connectivity().onConnectivityChanged.listen((event) {
  //     connectivityResult = event;
  //     notifyListeners();
  //   });
  // }


  void addBook(URLRequest url) {
    isBook = !isBook;
    bookName.add(inAppWebViewController!.getTitle().toString());
    bookLink.add(bookUrl!);
    bookMarList.add(URLRequest());
    notifyListeners();
  }

  refresh() {
    pullToRefreshController = PullToRefreshController(
      onRefresh: () async{

        if (Platform.isAndroid) {
          await  inAppWebViewController?.reload();
          Future.delayed(
            const Duration(seconds: 2),
          );
          pullToRefreshController?.endRefreshing();
        } else if (Platform.isIOS) {
          inAppWebViewController
              ?.loadUrl(
            urlRequest: URLRequest(
              url: await inAppWebViewController
                  ?.getUrl(),
            ),
          );
        }
      },
    );
  }

  loadUrl(int index) {
    inAppWebViewController?.loadUrl(
        urlRequest: URLRequest(url: WebUri(bookLink![index])));
  }

  void remove(int index) {
    bookMarList.removeAt(index);
    notifyListeners();
  }

  void changeNet(bool isNet) {
    this.isNet = isNet;
    notifyListeners();
  }



  void radio(String value) {
    searchengine = value;
    notifyListeners();
  }

  getUrl(String value) async {
    if (searchengine == "Google") {
      webAdd = WebUri("https://www.google.com/search?&q=$value").path;
    } else if (searchengine == "Duck Duck Go") {
      webAdd = WebUri("https://duckduckgo.com/&q=$value").path;
    } else if (searchengine == "Yahoo") {
      webAdd = WebUri("https://in.search.yahoo.com/search?p=$value").path;
    } else {
      webAdd = WebUri("https://www.bing.com/search?q=$value").path;
    }
  }
}

