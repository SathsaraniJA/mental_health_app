import 'package:flutter/material.dart'; 
import 'screens/daily_checkin_screen.dart';
// Import the Flutter material package, which contains prebuilt widgets and themes following Material Design.

void main() {
  runApp(const MyApp()); 
  // Entry point of the app. runApp() starts the app and inflates the given widget (MyApp) as the root.
}

class MyApp extends StatelessWidget {
  const MyApp({super.key}); 
  // StatelessWidget is used here because MyApp itself does not have mutable state.

  @override
  Widget build(BuildContext context) {
    // build method describes the UI of this widget.
    return MaterialApp(
      debugShowCheckedModeBanner: false, 
      // Removes the debug banner in the top-right corner when running in debug mode.
      title: 'Mental Health App', 
      // App title, used in Android task manager and other places.
      theme: ThemeData(
        primarySwatch: Colors.teal, 
        // Sets the primary color theme of the app to teal.
      ),
      home: const DailyCheckInScreen(), // start with this screen
       
      // Sets the home screen (first screen shown) to MainScreen widget.
    );
  }
}

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});
  // StatefulWidget is used because this screen has state that changes (the selected tab index).

  @override
  State<MainScreen> createState() => _MainScreenState(); 
  // Creates mutable state for this widget.
}

class _MainScreenState extends State<MainScreen> {
  int _currentIndex = 0; 
  // Keeps track of which BottomNavigationBar tab is selected (0 = Home initially).

  // Screens for each tab
  final List<Widget> _screens = [
    // Home Screen with logo
    Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center, 
        // Centers the children vertically.
        children: [
          Image.asset(
            'assets/mental.png', // Path to your logo in assets folder.
            width: 150, // Width of the image
            height: 150, // Height of the image
          ),
          const SizedBox(height: 20), 
          // Adds vertical spacing between logo and text
          const Text(
            "🏠 Home Screen", 
            style: TextStyle(fontSize: 24), 
            // Sets text size to 24
          ),
        ],
      ),
    ),

    // Mood Tracker Screen
    const Center(
      child: Text(
        "😊 Mood Tracker", 
        style: TextStyle(fontSize: 24),
      ),
    ),

    // Meditation Screen
    const Center(
      child: Text(
        "🧘 Meditation", 
        style: TextStyle(fontSize: 24),
      ),
    ),

    // Resources Screen
    const Center(
      child: Text(
        "📚 Resources", 
        style: TextStyle(fontSize: 24),
      ),
    ),

    // Community Screen
    const Center(
      child: Text(
        "💬 Community", 
        style: TextStyle(fontSize: 24),
      ),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    // build method describes the UI of MainScreen
    return Scaffold(
      appBar: AppBar(
        title: const Text("Mental Health App"), 
        // Top app bar title
      ),
      body: _screens[_currentIndex], 
      // Displays the screen corresponding to the selected tab index
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex, 
        // Highlights the current tab
        type: BottomNavigationBarType.fixed, 
        // Fixed type keeps all tabs visible even if there are more than 3
        selectedItemColor: Colors.teal, 
        // Color of the selected tab
        unselectedItemColor: Colors.grey, 
        // Color of unselected tabs
        onTap: (index) {
          setState(() {
            _currentIndex = index; 
            // Updates the selected tab index and rebuilds the UI
          });
        },
        items: const [
          // BottomNavigationBar items
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
          BottomNavigationBarItem(icon: Icon(Icons.mood), label: "Mood"),
          BottomNavigationBarItem(icon: Icon(Icons.self_improvement), label: "Meditation"),
          BottomNavigationBarItem(icon: Icon(Icons.menu_book), label: "Resources"),
          BottomNavigationBarItem(icon: Icon(Icons.group), label: "Community"),
        ],
      ),
    );
  }
}
