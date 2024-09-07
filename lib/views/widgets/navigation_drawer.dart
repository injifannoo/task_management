import 'package:flutter/material.dart';

class Navigation_drawer extends StatelessWidget {
  const Navigation_drawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          const DrawerHeader(
            decoration: BoxDecoration(color: Colors.blue),
            child: Text('Menu', style: TextStyle(color: Colors.white, fontSize: 24)),
          ),
          ListTile(
            leading: const Icon(Icons.home),
            title: const Text('Home'),
            onTap: () => Navigator.pushNamed(context, '/home'),
          ),
          ListTile(
            leading:const Icon(Icons.check),
            title: const Text('Completed Tasks'),
            onTap: () => Navigator.pushNamed(context, '/completed'),
          ),
          ListTile(
            leading: const Icon(Icons.settings),
            title:const Text('Settings'),
            onTap: () => Navigator.pushNamed(context, '/settings'),
          ),
        ],
      ),
    );
  }
}
