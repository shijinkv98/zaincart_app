import 'package:flutter/material.dart';

import 'package:zaincart_app/screen/home_screen.dart';
import 'package:zaincart_app/screen/my_cart_screen.dart';
import 'package:zaincart_app/screen/wishlist_screen.dart';
import 'package:zaincart_app/utils/constants.dart';

class Home extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => HomeState();
}

class HomeState extends State<Home> {
  // this is static property so other widget throughout the app
  // can access it simply by AppState.currentTab
  static int currentTab = 0;
  GlobalKey _bottomNavigationKey = GlobalKey();

  String _title;
  int _page = 0;

  // list tabs here
  final List<TabItem> tabs = [
    TabItem(
      tabName: "Home",
      icon: Icons.home,
      page: HomeScreen(),
    ),
    TabItem(
      tabName: "Settings",
      icon: Icons.settings,
      page: WishlistScreen(),
    ),
    TabItem(
      tabName: "Settings",
      icon: Icons.settings,
      page: MyCartScreen(),
    ),
  ];

  HomeState() {
    // indexing is necessary for proper funcationality
    // of determining which tab is active
    tabs.asMap().forEach((index, details) {
      details.setIndex(index);
    });
  }

  // sets current tab index
  // and update state
  void _selectTab(int index) {
    if (index == currentTab) {
      // pop to first route
      // if the user taps on the active tab
      tabs[index].key.currentState.popUntil((route) => route.isFirst);
    } else {
      // update the state
      // in order to repaint
      setState(() {
        currentTab = index;
        switch (index) {
          case 0:
            _title = "Home";
            break;
          case 1:
            _title = "Wishlist";
            break;
          case 2:
            _title = "Cart";
            break;
          case 3:
            _title = "Requests";
            break;
          default:
            _title = "";
        }
      });
    }
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // WillPopScope handle android back btn
    return WillPopScope(
      onWillPop: () async {
        final isFirstRouteInCurrentTab =
            !await tabs[currentTab].key.currentState.maybePop();
        if (isFirstRouteInCurrentTab) {
          // if not on the 'main' tab
          if (currentTab != 0) {
            // select 'main' tab
            _selectTab(0);
            // back button handled by app
            return false;
          }
        }
        // let system handle back button if we're on the first route
        return isFirstRouteInCurrentTab;
      },
      // this is the base scaffold
      // don't put appbar in here otherwise you might end up
      // with multiple appbars on one screen
      // eventually breaking the app
      child: Scaffold(
        // indexed stack shows only one child
        key: drawerScaffoldKey,
        body: IndexedStack(
          index: currentTab,
          children: tabs.map((e) => e.page).toList(),
        ),
        // Bottom navigation
        bottomNavigationBar: BottomNavigationBar(
          // this will be set when a new tab is tapped
          onTap: _selectTab,

          currentIndex: _page,
          items: [
            BottomNavigationBarItem(
              icon: new Icon(
                Icons.home_outlined,
                color: Constants.zc_orange,
                size: 30.0,
              ),
              label: "",
            ),
            BottomNavigationBarItem(
                icon: new Icon(
                  Icons.favorite_outline,
                  color: Constants.zc_orange,
                  size: 30.0,
                ),
                label: ""),
            BottomNavigationBarItem(
                icon: Icon(
                  Icons.shopping_cart_outlined,
                  color: Constants.zc_orange,
                  size: 30.0,
                ),
                label: "")
          ],
        ),
      ),
    );
  }
}

class TabItem {
  // you can customize what kind of information is needed
  // for each tab
  final String tabName;
  final IconData icon;
  final GlobalKey<NavigatorState> key = GlobalKey<NavigatorState>();
  int _index = 0;
  Widget _page;
  TabItem({
    @required this.tabName,
    @required this.icon,
    @required Widget page,
  }) {
    _page = page;
  }

  // I was getting a weird warning when using getters and setters for _index
  // so I converted them to functions

  // used to set the index of this tab
  // which will be used in identifying if this tab is active
  void setIndex(int i) {
    _index = i;
  }

  int getIndex() => _index;

// adds a wrapper around the page widgets for visibility
// visibility widget removes unnecessary problems
// like interactivity and animations when the page is inactive
  Widget get page {
    return Visibility(
      // only paint this page when currentTab is active
      visible: _index == HomeState.currentTab,
      // important to preserve state while switching between tabs
      maintainState: true,
      child: Navigator(
        // key tracks state changes
        key: key,
        onGenerateRoute: (routeSettings) {
          return MaterialPageRoute(
            builder: (_) => _page,
          );
        },
      ),
    );
  }
}
