import 'package:flutter/material.dart';

class SidebarNavigation extends StatelessWidget {
  const SidebarNavigation({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          DrawerHeader(
            child: Text('Hermes-Termux', style: TextStyle(color: Colors.white, fontSize: 24)),
          ),
          ListTile(leading: Icon(Icons.terminal), title: Text('Terminal'), onTap: () {}),
          ListTile(leading: Icon(Icons.chat), title: Text('Chat'), onTap: () {}),
          ListTile(leading: Icon(Icons.school), title: Text('Skills'), onTap: () {}),
          ListTile(leading: Icon(Icons.memory), title: Text('Memory'), onTap: () {}),
          ListTile(leading: Icon(Icons.bug_report), title: Text('Logs'), onTap: () {}),
          ListTile(leading: Icon(Icons.settings), title: Text('Settings'), onTap: () {}),
        ],
      ),
    );
  }
}
