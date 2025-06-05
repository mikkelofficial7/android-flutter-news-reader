import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_news_reader/constant/color.dart';
import 'constant/language.dart';
import 'pages/accountpage.dart';
import 'pages/home/homepage.dart';
import 'pages/search/searchpage.dart';
import 'bloc/navigation_bottom/bloc.dart';
import 'bloc/navigation_bottom/event_state.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: appName,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: lightGray),
        useMaterial3: true,
      ),
      home: NavigationPage(),
    );
  }
}

class NavigationPage extends StatelessWidget {
  const NavigationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return NavigationBottom();
  }
}

class NavigationBottom extends StatefulWidget {
  const NavigationBottom({super.key});

  @override
  _NavigationBottomState createState() => _NavigationBottomState();
}

class _NavigationBottomState extends State<NavigationBottom> {
  int selectedIndex = 0;
  final NavigationBottomBloc _navigationBottomBloc = NavigationBottomBloc();

  final List<Widget> listTabPage = [
    HomePage(),
    SearchPage(),
    AccountPage(),
  ];

  void onClickTab(int index) {
    setState(() {
      _navigationBottomBloc.add(NavigationBottomEvent(index: index));
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => _navigationBottomBloc,
      child: BlocConsumer<NavigationBottomBloc, NavigationBottomState>(
          builder: (context, state) {
            selectedIndex = state.index;

            return Scaffold(
              body: listTabPage[selectedIndex],
              bottomNavigationBar: BottomNavigationBar(
                currentIndex: selectedIndex,
                selectedItemColor: primaryColor,
                unselectedItemColor: black,
                onTap: (index) {
                  onClickTab(index);
                },
                items: const [
                  BottomNavigationBarItem(
                    icon: Icon(Icons.home),
                    label: homeScreen,
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(Icons.search),
                    label: searchScreen,
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(Icons.person),
                    label: accountScreen,
                  ),
                ],
              ),
            );
          },
          listener: (context, state) {}),
    );
  }
}
