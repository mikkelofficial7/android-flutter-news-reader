import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_news_reader/constant/api_constant.dart';
import 'package:flutter_news_reader/constant/color.dart';
import 'package:flutter_news_reader/pages/profile/accountpage.dart';
import 'package:flutter_news_reader/_supabase_firebase/user_auth.dart';
import 'package:flutter_news_reader/route/base/base_navigation_service.dart';
import 'package:flutter_news_reader/pages/login/loginpage.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'constant/language.dart';
import 'pages/home/homepage.dart';
import 'pages/search/search_first/search_page.dart';
import 'bloc/navigation_bottom/bloc.dart';
import 'bloc/navigation_bottom/event_state.dart';
import 'package:firebase_core/firebase_core.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(); // initiate firebase auth
  await Supabase.initialize(
    url: ApiConstant.supabaseUrl,
    anonKey: ApiConstant.supabaseKey,
  ); // initiate supabase

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorKey: NavigationService.navigatorKey,
      home: ParentApp(),
    );
  }
}

class ParentApp extends StatelessWidget {
  const ParentApp({super.key});

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

  bool isLoggedIn = UserAuth.isUserLoginByGoogle();

  final List<Widget> listTabPage = [
    HomePage(),
    SearchPage(),
    UserAuth.isUserLoginByGoogle() ? AccountPage() : LoginPage()
  ]; // check list tab last index, if login then add accountPage() if no then add loginPage()

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
