import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'E-Waste Management',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MainPage(),
    );
  }
}

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int _selectedCategoryIndex = 0;
  int _selectedBottomNavIndex = 0;

  final List<Widget> _pages = [
    const EventsPage(),
    const FAQPage(),
    const EducatePage(),
  ];

  void _onCategorySelected(int index) {
    setState(() {
      _selectedCategoryIndex = index;
    });
  }

  void _onBottomNavSelected(int index) {
    setState(() {
      _selectedBottomNavIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Get to Know',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.black,
      ),
      body: Column(
        children: [
          // "Get to Know" Bar with Category Buttons (Independent of Bottom Nav)
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CategoryButton(
                  label: 'Events',
                  isSelected: _selectedCategoryIndex == 0,
                  onPressed: () => _onCategorySelected(0),
                ),
                CategoryButton(
                  label: 'FAQ',
                  isSelected: _selectedCategoryIndex == 1,
                  onPressed: () => _onCategorySelected(1),
                ),
                CategoryButton(
                  label: 'Educate',
                  isSelected: _selectedCategoryIndex == 2,
                  onPressed: () => _onCategorySelected(2),
                ),
              ],
            ),
          ),
          // Display the selected page content (Independent of Bottom Nav)
          Expanded(
            child: _pages[_selectedCategoryIndex],
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedBottomNavIndex, // Independent of the top navigation
        selectedItemColor: Colors.deepPurple,
        unselectedItemColor: Colors.grey,
        backgroundColor: Colors.black,
        onTap: _onBottomNavSelected, // Updates bottom navigation index
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.explore),
            label: 'Explore',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.bookmark),
            label: 'Saved',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}

// Reusable Category Button Widget
class CategoryButton extends StatelessWidget {
  final String label;
  final bool isSelected;
  final VoidCallback onPressed;

  const CategoryButton({
    required this.label,
    required this.isSelected,
    required this.onPressed,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: isSelected ? Colors.deepPurple : Colors.black,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.0),
        ),
      ),
      onPressed: onPressed,
      child: Text(
        label,
        style: const TextStyle(color: Colors.white),
      ),
    );
  }
}

// Events Page
class EventsPage extends StatelessWidget {
  const EventsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        'Welcome to the Events page!',
        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.grey[700]),
      ),
    );
  }
}

// FAQ Page
class FAQPage extends StatelessWidget {
  const FAQPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: const [
        InfoTile(
          title: 'What is waste?',
          content: 'Lorem ipsum dolor sit amet, consectetur adipiscing elit.',
        ),
        InfoTile(
          title: 'Waste Management',
          content: 'Lorem ipsum dolor sit amet, consectetur adipiscing elit.',
        ),
        InfoTile(
          title: 'Importance of waste management',
          content: 'Lorem ipsum dolor sit amet, consectetur adipiscing elit.',
        ),
        InfoTile(
          title: 'Types of waste',
          content: 'Lorem ipsum dolor sit amet, consectetur adipiscing elit.',
        ),
      ],
    );
  }
}

// Educate Page
class EducatePage extends StatelessWidget {
  const EducatePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        'Educate content will be displayed here.',
        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.grey[700]),
      ),
    );
  }
}

// Info Tile for FAQ Page
class InfoTile extends StatefulWidget {
  final String title;
  final String content;

  const InfoTile({required this.title, required this.content, super.key});

  @override
  State<InfoTile> createState() => _InfoTileState();
}

class _InfoTileState extends State<InfoTile> {
  bool _isExpanded = false;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.grey[200],
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      child: ExpansionTile(
        title: Text(widget.title),
        trailing: Icon(
          _isExpanded ? Icons.keyboard_arrow_up : Icons.keyboard_arrow_down,
        ),
        onExpansionChanged: (expanded) {
          setState(() {
            _isExpanded = expanded;
          });
        },
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              widget.content,
              style: const TextStyle(fontSize: 14),
            ),
          ),
        ],
      ),
    );
  }
}
