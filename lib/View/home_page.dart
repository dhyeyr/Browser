// import 'dart:io';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_inappwebview/flutter_inappwebview.dart';
// import 'package:mirrorwall/Model/const.dart';
// import 'package:provider/provider.dart';
//
// import '../Controller/bookmark_provider.dart';
// import '../Controller/connectivity_provider.dart';
//
// class Home_page extends StatefulWidget {
//   final String url;
//
//
//   const Home_page({super.key, required this.url});
//
//   @override
//   State<Home_page> createState() => _MyWebViewState();
// }
//
// class _MyWebViewState extends State<Home_page> {
//   InAppWebViewController? webViewController;
//   PullToRefreshController? pullToRefreshController;
//   bool? isBookmark;
//   String? namelist;
//
//   @override
//   void initState() {
//     super.initState();
//
//     pullToRefreshController = PullToRefreshController(
//       onRefresh: () async {
//         if (Platform.isAndroid) {
//           webViewController?.reload();
//           pullToRefreshController?.endRefreshing();
//         } else if (Platform.isIOS) {
//           webViewController?.loadUrl(
//               urlRequest: URLRequest(url: await webViewController?.getUrl()));
//         }
//       },
//     );
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text("Web View"),
//         actions: [
//           PopupMenuButton(
//             constraints: const BoxConstraints.expand(height: 110, width: 200),
//             offset: const Offset(30, 50),
//             icon: Icon(Icons.more_vert),
//             itemBuilder: (context) {
//               return [
//                 PopupMenuItem(
//                   value: 1,
//                   child: Padding(
//                     padding: const EdgeInsets.all(10),
//                     child: Row(
//                       children: [
//                         Icon(Icons.bookmark_add_outlined),
//                         SizedBox(
//                           width: 10,
//                         ),
//                         Text("BookMark"),
//                       ],
//                     ),
//                   ),
//                 ),
//                 PopupMenuItem(
//                   value: 2,
//                   child: Padding(
//                     padding: const EdgeInsets.all(10),
//                     child: Row(
//                       children: [
//                         Icon(Icons.screen_search_desktop_outlined),
//                         SizedBox(
//                           width: 10,
//                         ),
//                         Text("Search Engine"),
//                       ],
//                     ),
//                   ),
//                 ),
//               ];
//             },
//             onSelected: (value) {
//
//               showDialog(
//                 context: context,
//                 builder: (BuildContext context) {
//                   return AlertDialog(
//                     title: Text('Select an Option'),
//                     content: Column(
//                       mainAxisSize: MainAxisSize.min,
//                       children: <Widget>[
//                         Consumer<ConnectivityProvider>(
//                           builder: (BuildContext context, uvalue, Widget? child) => RadioListTile(
//                             title: Text('Google'),
//                             value: 'https://www.google.com',
//                             groupValue: uvalue.selectedEngine,
//                             onChanged: (String? value) {
//                               uvalue.selectedEngine = value!;
//                               Navigator.of(context).pop();
//                             },
//                           ),
//                         ),
//                         Consumer<ConnectivityProvider>(
//                           builder: (BuildContext context, uvalue, Widget? child) => RadioListTile(
//                             title: Text('Yahoo'),
//                             value: 'https://www.yahoo.com',
//                             groupValue: uvalue.selectedEngine,
//                             onChanged: (String? value) {
//                               uvalue.selectedEngine = value!;
//                               Navigator.of(context).pop();
//                             },
//                           ),
//                         ),
//                         Consumer<ConnectivityProvider>(
//                           builder: (BuildContext context, uvalue, Widget? child) => RadioListTile(
//                             title: Text('Bing'),
//                             value: 'https://www.bing.com',
//                             groupValue: uvalue.selectedEngine,
//                             onChanged: (String? value) {
//                               uvalue.selectedEngine = value!;
//                               Navigator.of(context).pop();
//                             },
//                           ),
//                         ),
//                         Consumer<ConnectivityProvider>(
//                           builder: (BuildContext context, uvalue, Widget? child) => RadioListTile(
//                             title: Text('Duck Duck Go'),
//                             value: 'https://duckduckgo.com',
//                             groupValue: uvalue.selectedEngine,
//                             onChanged: ( value) {
//                               uvalue.selectedEngine = value!;
//                               Navigator.of(context).pop();
//                             },
//                           ),
//                         ),
//                       ],
//                     ),
//
//                   );
//                 },
//               );
//
//
//
//               if (value == 1) {
//                 showModalBottomSheet(
//                   isScrollControlled: true,
//                   isDismissible: false,
//                   context: context,
//                   builder: (context) {
//                     return Container(
//                       height: MediaQuery.sizeOf(context).height * 0.9,
//                       color: Colors.white,
//                       child: Column(
//                         children: [
//                           InkWell(
//                             onTap: () {
//                               Navigator.pop(context);
//                             },
//                             child: Container(
//                               height: 50,
//                               color: Colors.grey,
//                               child: Center(
//                                 child: Row(
//                                   mainAxisAlignment: MainAxisAlignment.center,
//                                   children: [
//                                     Icon(Icons.close),
//                                     SizedBox(
//                                       width: 10,
//                                     ),
//                                     Text(
//                                       "Dismiss",
//                                       style: TextStyle(fontSize: 23),
//                                     ),
//                                   ],
//                                 ),
//                               ),
//                             ),
//                           ),
//                           Expanded(
//                             child: Consumer<BookMarkProvider>(
//                                 builder: (context, bookmarkprovider, child) {
//                                   return ListView.separated(
//                                       itemBuilder: (context, index) {
//                                         return ListTile(
//                                           title: Text("Hello"),
//                                         );
//                                       },
//                                       separatorBuilder: (context, index) {
//                                         return Divider();
//                                       },
//                                       itemCount:
//                                       bookmarkprovider.sitenamelist.length);
//                                 }),
//                           )
//                         ],
//                       ),
//                     );
//                   },
//                 );
//               }
//             },
//           ),
//         ],
//       ),
//       body: Column(
//         children: [
//           Consumer<ConnectivityProvider>(
//             builder: (context, ConnectivityProvider, child) {
//               if (ConnectivityProvider.progress >= 1) {
//                 return SizedBox.shrink();
//               }
//               return LinearProgressIndicator(
//                 minHeight: 8,
//                 value: ConnectivityProvider.progress,
//                 color: Colors.yellow,
//               );
//             },
//           ),
//           Expanded(
//             child: InAppWebView(
//           // initialUrlRequest: URLRequest(url: Uri.parse(context.read<ConnectivityProvider>().selectedEngine)),
//               initialUrlRequest: URLRequest(url: WebUri(widget.url)),
//               onWebViewCreated: (controller) {
//                 webViewController = controller;
//               },
//               pullToRefreshController: pullToRefreshController,
//               onLoadStop: (controller, url) async {
//                 var canGoBack = await controller.canGoBack();
//                 var canGoForward = await controller.canGoForward();
//                 print("mounted $mounted");
//
//                 if (mounted) {
//                   Provider.of<ConnectivityProvider>(context, listen: false)
//                       .backForwardStatus(canGoBack, canGoForward);
//                 }
//
//                 print("canGoBack $canGoBack");
//               },
//               onProgressChanged: (controller, progress) {
//                 Provider.of<ConnectivityProvider>(context, listen: false)
//                     .changeProgress(progress / 100);
//                 print("progress => $progress");
//               },
//             ),
//
//           ),
//           Padding(
//             padding: const EdgeInsets.all(10),
//             child: TextFormField(
//               decoration: const InputDecoration(
//                 hintText: "Search",
//                 prefixIcon: Icon(Icons.search),
//                 contentPadding: EdgeInsets.all(10),
//                 border:
//                 OutlineInputBorder(), // enabledBorder: InputBorder.none,
//               ),
//               onFieldSubmitted: (value) {
//                 var searchtext = "https://www.google.com/search?q=$value";
//                 webViewController?.loadUrl(
//                   urlRequest: URLRequest(
//                     url: WebUri(searchtext),
//                   ),
//                 );
//               },
//             ),
//           ),
//           SizedBox(
//             height: 10,
//           ),
//           Consumer2<ConnectivityProvider, BookMarkProvider>(builder:
//               (context, connectivityprovider, bookmarkprovider, child) {
//             return Row(
//               mainAxisAlignment: MainAxisAlignment.spaceAround,
//               children: [
//                 IconButton(
//                   onPressed: () {
//                     Navigator.pushReplacement(
//                       context,
//                       PageRouteBuilder(
//                         pageBuilder: (context, animation, secondaryAnimation) =>
//                             Home_page(url: "https://www.google.com"),
//                       ),
//                     );
//                   },
//                   icon: Icon(
//                     Icons.home_filled,
//                     size: 30,
//                   ),
//                 ),
//                 IconButton(
//                   onPressed: () {
//                     namelist = webViewController.toString();
//                     bookmarkprovider.addBookmark(namelist!);
//                     print(bookmarkprovider.sitenamelist.length);
//                   },
//                   icon: bookmarkprovider.isBookmark
//                       ? Icon(
//                     Icons.bookmark,
//                     size: 30,
//                   )
//                       : Icon(
//                     Icons.bookmark_add_outlined,
//                     size: 30,
//                   ),
//                 ),
//                 IconButton(
//                   onPressed: () {
//                     webViewController?.goBack();
//                   },
//                   icon: connectivityprovider.canGoBack
//                       ? Icon(
//                     Icons.arrow_back_ios,
//                     size: 30,
//                   )
//                       : Icon(
//                     Icons.arrow_back_ios,
//                     size: 30,
//                     color: Colors.black12,
//                   ),
//                 ),
//                 IconButton(
//                   onPressed: () {
//                     webViewController?.reload();
//                   },
//                   icon: Icon(
//                     Icons.refresh_sharp,
//                     size: 30,
//                   ),
//                 ),
//                 IconButton(
//                   onPressed: () {
//                     webViewController?.goForward();
//                   },
//                   icon: connectivityprovider.canGoForward
//                       ? Icon(
//                     Icons.arrow_forward_ios,
//                     size: 30,
//                   )
//                       : Icon(
//                     Icons.arrow_forward_ios,
//                     size: 30,
//                     color: Colors.black12,
//                   ),
//                 ),
//               ],
//             );
//           }),
//         ],
//       ),
//     );
//   }
// }

// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables
import 'dart:io';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../Controller/connectivity_provider.dart';
import '../util.dart';

class Home_page extends StatefulWidget {
  final String url;

  const Home_page({super.key, required this.url});

  @override
  State<Home_page> createState() => _MyWebViewState();
}

class _MyWebViewState extends State<Home_page> {
  InAppWebViewController? webViewController;
  PullToRefreshController? pullToRefreshController;
  ConnectivityResult _connectionStatus = ConnectivityResult.none;
  late Connectivity _connectivity;
  @override
  void initState() {
    pullToRefreshController = PullToRefreshController(
      onRefresh: () async {
        if (Platform.isAndroid) {
          webViewController?.reload();
          pullToRefreshController?.endRefreshing();
        } else if (Platform.isIOS) {
          webViewController?.loadUrl(
              urlRequest: URLRequest(url: await webViewController?.getUrl()));
        }
      },
    );
    getList();
  }
  InAppWebViewController? _webViewController;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("My Browser"),
        centerTitle: true,
        leading: SizedBox.shrink(),
        actions: [
          PopupMenuButton(
            constraints: const BoxConstraints.expand(height: 110, width: 200),
            offset: const Offset(30, 50),
            icon: Icon(Icons.more_vert),
            itemBuilder: (context) {
              return [
                PopupMenuItem(
                  value: 1,
                  child: Padding(
                    padding: const EdgeInsets.all(10),
                    child: Row(
                      children: [
                        Icon(Icons.bookmark_add_outlined),
                        SizedBox(
                          width: 10,
                        ),
                        Text("BookMark"),
                      ],
                    ),
                  ),
                ),
                PopupMenuItem(
                  value: 2,
                  child: Padding(
                    padding: const EdgeInsets.all(10),
                    child: Row(
                      children: [
                        Icon(Icons.screen_search_desktop_outlined),
                        SizedBox(
                          width: 10,
                        ),
                        Text("Search Engine"),
                      ],
                    ),
                  ),
                ),
              ];
            },
            onSelected: (val) {
              if (val == 1) {
                showModalBottomSheet(
                  isDismissible: false,
                  isScrollControlled: true,
                  context: context,
                  builder: (context) {
                    return Container(
                      height: MediaQuery.sizeOf(context).height * 0.9,
                      color: Colors.white,
                      child: Column(
                        children: [
                          InkWell(
                            onTap: () {
                              Navigator.pop(context);
                            },
                            child: Container(
                              height: 50,
                              color: Colors.black26,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(Icons.close),
                                  SizedBox(width: 5),
                                  Text("Dismiss"),
                                ],
                              ),
                            ),
                          ),
                          Consumer<ConnectivityProvider>(
                            builder: (context, netProvider, child) {
                              return (localLink.length == 0)
                                  ? Center(
                                child: Text(
                                  "No any bookmarks yet...",
                                  style: TextStyle(fontSize: 20),
                                ),
                              )
                                  : Expanded(
                                child: ListView.builder(
                                  itemCount: localLink.length,
                                  itemBuilder: (context, index) {
                                    return ListTile(
                                      title: Text(
                                        localLink1[index],
                                        maxLines: 1,
                                      ),
                                      subtitle: Text(localLink[index],
                                          maxLines: 1),
                                      trailing: IconButton(
                                        onPressed: () {
                                          Provider.of<ConnectivityProvider>(
                                              context,
                                              listen: false)
                                              .removeBookmark(index);
                                        },
                                        icon: Icon(Icons.close),
                                      ),
                                    );
                                  },
                                ),
                              );
                            },
                          )
                        ],
                      ),
                    );
                  },
                );
              }
              if (val == 2) {
                AlertDialog alert = AlertDialog(
                  title: Center(child: Text('Search Engine')),
                  actions: [
                    Consumer<ConnectivityProvider>(
                      builder: (BuildContext context, Uvalue, Widget? child) {
                        return Container(
                          height: MediaQuery.sizeOf(context).height * 0.3,
                          width: MediaQuery.sizeOf(context).width * 0.6,
                          child: Column(
                            children: [
                              RadioListTile(
                                title: Text('Google'),
                                value: 1,
                                groupValue: Uvalue.selectedValue,
                                onChanged: (value) {
                                  Uvalue.radioChange(value!);
                                  Navigator.push(context, MaterialPageRoute(
                                    builder: (context) {
                                      return Home_page(
                                          url: "https://www.google.com");
                                    },
                                  ));
                                },
                              ),
                              RadioListTile(
                                title: Text('Yahoo'),
                                value: 2,
                                groupValue: Uvalue.selectedValue,
                                onChanged: (value) {
                                  Uvalue.radioChange(value!);
                                  Navigator.push(context, MaterialPageRoute(
                                    builder: (context) {
                                      return Home_page(
                                          url: "https://in.search.yahoo.com");
                                    },
                                  ));
                                },
                              ),
                              RadioListTile(
                                title: Text('Bing'),
                                value: 3,
                                groupValue: Uvalue.selectedValue,
                                onChanged: (value) {
                                  Uvalue.radioChange(value!);
                                  Navigator.push(context, MaterialPageRoute(
                                    builder: (context) {
                                      return Home_page(
                                          url: "https://www.bing.com");
                                    },
                                  ));
                                },
                              ),
                              RadioListTile(
                                title: Text('Duck Duck Go'),
                                value: 4,
                                groupValue: Uvalue.selectedValue,
                                onChanged: (value) {
                                  Uvalue.radioChange(value!);
                                  Navigator.push(context, MaterialPageRoute(
                                    builder: (context) {
                                      return Home_page(
                                          url: "https://duckduckgo.com");
                                    },
                                  ));
                                },
                              ),
                            ],
                          ),
                        );
                      },
                    )
                  ],
                );
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return alert;
                  },
                );
              }
            },



          ),
        ],
      ),
      body: Column(
        children: [
          Container(
            // padding: EdgeInsets.all(8),
             margin: EdgeInsets.only(left: 8),

            height: 40,
            width: double.infinity,
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Text(
                Provider.of<ConnectivityProvider>(context).currentUrl,
                style: TextStyle(
                    fontSize: 16,
                    color: Colors.blue,
                    fontWeight: FontWeight.w500),
              ),
            ),
          ),
          Expanded(
            child: InAppWebView(
              initialUrlRequest: URLRequest(url: WebUri(widget.url)),
              onWebViewCreated: (controller) {
                webViewController = controller;
              },
              pullToRefreshController: pullToRefreshController,
              onLoadStop: (controller, url) {
                updatePageInfo(controller);
                var d = Provider.of<ConnectivityProvider>(context, listen: false);
              },
              onProgressChanged: (controller, progress) {
                Provider.of<ConnectivityProvider>(context, listen: false)
                    .changeProgress(progress / 100);
                print("progress => $progress");
              },
            ),
          ),
          StreamBuilder<ConnectivityResult>(
              stream: Connectivity().onConnectivityChanged,
              builder: (context, snapshot) {
                if (snapshot.data == ConnectivityResult.wifi || snapshot.data == ConnectivityResult.mobile) {
                  return SizedBox.shrink();
                } else {
                  return Container(
                    color: Colors.red,
                    width: double.infinity,
                    height: 40,
                    padding: EdgeInsets.all(8),
                    child: Center(
                        child: Text(
                          "No Connection..",
                          style: TextStyle(color: Colors.white),
                        )),
                  );
                }
              }),

          Consumer<ConnectivityProvider>(
            builder: (context, netProvider, child) {
              if (netProvider.progress >= 1) {
                return SizedBox.shrink();
              }
              return LinearProgressIndicator(
                minHeight: 8,
                value: netProvider.progress,
                color: Colors.grey,
              );
            },
          ),

          Container(
            margin: EdgeInsets.all(8),
            padding: EdgeInsets.all(8),
            child: TextFormField(
              decoration: InputDecoration(
                  hintText: "Search or type web address",
                  suffixIcon: Icon(Icons.search),
                  border: OutlineInputBorder()),
              onFieldSubmitted: (value) {
                if (widget.url == "https://www.google.com") {
                  //Google
                  var searchText = "https://www.google.com/search?q=$value";
                  webViewController?.loadUrl(
                      urlRequest: URLRequest(url: WebUri(searchText)));
                  print("Entered Text $value");
                } else if (widget.url == "https://in.search.yahoo.com") {
                  //Yahoo
                  var searchText =
                      "https://in.search.yahoo.com/search?p=$value";
                  webViewController?.loadUrl(
                      urlRequest: URLRequest(url: WebUri(searchText)));
                  print("Entered Text $value");
                } else if (widget.url == "https://www.bing.com") {
                  //Bing
                  var searchText = "https://www.bing.com/?q=$value";
                  webViewController?.loadUrl(
                      urlRequest: URLRequest(url: WebUri(searchText)));
                  print("Entered Text $value");
                } else if (widget.url == "https://duckduckgo.com") {
                  //Duck Duck Go
                  var searchText = "https://duckduckgo.com/&q=$value";
                  webViewController?.loadUrl(
                      urlRequest: URLRequest(url: WebUri(searchText)));
                  print("Entered Text $value");
                }
              },
            ),
          ),
          SizedBox(height: 16),
          Consumer<ConnectivityProvider>(builder: (context, value, child) {
            return Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Container(
                    child: IconButton(
                      onPressed: () {
                        Navigator.push(context, MaterialPageRoute(
                          builder: (context) {
                            return Home_page(url: widget.url);
                          },
                        ));
                      },
                      icon: Icon(
                        Icons.home,
                        size: 30,
                      ),
                    )),
                Container(
                  child: IconButton(
                      onPressed: () async {
                        var a =
                        Provider.of<ConnectivityProvider>(context, listen: false);

                        if (localLink.contains(a.currentUrl)) {
                          showDuplicateBookmarkAdd(context);
                        } else {
                          showBookmarkAdd(context);
                          localLink1.add(a.pageTitle);
                          localLink.add(a.currentUrl);
                        }

                        SharedPreferences prefs =
                        await SharedPreferences.getInstance();
                        prefs.setStringList('link', localLink);
                        prefs.setStringList('link1', localLink1);
                      },
                      icon: Icon(Icons.bookmark_add, size: 30)),
                ),


                Container(
                  child: IconButton(
                      onPressed: value.canGoBack
                          ? () {
                        webViewController?.goBack();
                      }
                          : null,
                      icon: (value.canGoBack)
                          ? Icon(Icons.arrow_back_ios, size: 30)
                          : Icon(
                        Icons.arrow_back_ios,
                        size: 30,
                        color: Colors.black12,
                      )),
                ),
                Container(
                  child: IconButton(
                      onPressed: () {
                        webViewController?.reload();
                      },
                      icon: Icon(Icons.refresh, size: 30)),
                ),
                Container(
                  child: IconButton(
                      onPressed: value.canGoForward
                          ? () => webViewController?.goForward()
                          : null,
                      icon: (value.canGoForward)
                          ? Icon(Icons.arrow_forward_ios, size: 30)
                          : Icon(
                        Icons.arrow_forward_ios,
                        size: 30,
                        color: Colors.black12,
                      )),

                ),
              ],
            );
          }),
          SizedBox(height: 16),

        ],
      ),
    );
  }

  void getList() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String>? storedLinks = prefs.getStringList('link');
    List<String>? storedLinks1 = prefs.getStringList('link1');

    if (storedLinks1 != null && storedLinks1.isNotEmpty) {
      localLink1 = storedLinks1;
    } else {}
    if (storedLinks != null && storedLinks.isNotEmpty) {
      localLink = storedLinks;
    }
  }

  void updatePageInfo(InAppWebViewController controller) async {
    var d = Provider.of<ConnectivityProvider>(context, listen: false);
    String? title = await controller.getTitle();
    d.pageTitle = title ?? '';
    var canGoBack = await controller.canGoBack();
    var canGoForward = await controller.canGoForward();
    d.currentUrl = (await controller.getUrl())?.toString() ?? '';
    if (mounted) {
      Provider.of<ConnectivityProvider>(context, listen: false)
          .backForwardStatus(canGoBack, canGoForward);
    }
  }

  void showBookmarkAdd(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Center(child: Text('Added to Bookmark')),
        duration: Duration(seconds: 2),
      ),
    );
  }

  void showDuplicateBookmarkAdd(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Center(child: Text('Already Added to Bookmark')),
        duration: Duration(seconds: 2),
      ),
    );
  }
}
