import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/auth_provider.dart';
import '../../providers/saved_jobs_provider.dart';
import 'job_list_tab.dart';
import 'saved_jobs_tab.dart';
import 'profile_tab.dart';

class HomeShell extends StatefulWidget {
  const HomeShell({super.key});

  @override
  State<HomeShell> createState() => _HomeShellState();
}

class _HomeShellState extends State<HomeShell> {
  int _index = 0;

  @override
  Widget build(BuildContext context) {
  const tabs = [JobListTab(), SavedJobsTab(), ProfileTab()];
    return Scaffold(
      appBar: AppBar(
        title: const Text('Job Portal'),
        actions: [
          IconButton(
            onPressed: () async {
              await context.read<AuthProvider>().logout();
            },
            icon: const Icon(Icons.logout),
          )
        ],
      ),
      body: tabs[_index],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _index,
        onTap: (i) => setState(() => _index = i),
        items: [
          const BottomNavigationBarItem(icon: Icon(Icons.work), label: 'Jobs'),
          BottomNavigationBarItem(
              icon: Stack(children: [
                const Icon(Icons.bookmark),
                Positioned(
                  right: 0,
                  child: Consumer<SavedJobsProvider>(
                    builder: (_, saved, __) => CircleAvatar(
                      radius: 8,
                      backgroundColor: Colors.red,
                      child: Text(
                        saved.count.toString(),
                        style: const TextStyle(fontSize: 10, color: Colors.white),
                      ),
                    ),
                  ),
                )
              ]),
              label: 'Saved'),
          const BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
        ],
      ),
    );
  }
}
