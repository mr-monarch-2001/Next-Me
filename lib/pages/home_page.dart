import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'pin_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final TextEditingController taskController = TextEditingController();
  List<String> tasks = [];

  @override
  void initState() {
    super.initState();
    _loadTasks();
  }

  Future<void> _loadTasks() async {
    final prefs = await SharedPreferences.getInstance();
    final saved = prefs.getStringList('tasks');
    if (saved != null) {
      setState(() {
        tasks = saved;
      });
    }
  }

  Future<void> _saveTasks() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setStringList('tasks', tasks);
  }

  void _addTask() {
    final task = taskController.text.trim();
    if (task.isNotEmpty) {
      setState(() {
        tasks.add(task);
        taskController.clear();
      });
      _saveTasks();
    }
  }

  void _removeTask(int index) {
    setState(() {
      tasks.removeAt(index);
    });
    _saveTasks();
  }

  void _logout() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const PinPage()),
    );
  }

  void _clearAllTasks() {
    setState(() {
      tasks.clear();
    });
    _saveTasks();
  }

  @override
  void dispose() {
    taskController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        _logout(); // Go back to PIN screen on back press
        return false;
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text('NextMe To-Do List'),
          backgroundColor: Colors.deepPurple,
          actions: [
            IconButton(
              icon: const Icon(Icons.delete_forever),
              onPressed: _clearAllTasks,
              tooltip: "Clear All Tasks",
            ),
            IconButton(
              icon: const Icon(Icons.logout),
              onPressed: _logout,
              tooltip: "Logout",
            ),
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              TextField(
                controller: taskController,
                decoration: InputDecoration(
                  labelText: 'Enter task',
                  border: OutlineInputBorder(),
                  suffixIcon: IconButton(
                    icon: const Icon(Icons.add),
                    onPressed: _addTask,
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Expanded(
                child: tasks.isEmpty
                    ? const Center(child: Text("No tasks yet."))
                    : ListView.builder(
                        itemCount: tasks.length,
                        itemBuilder: (context, index) => Card(
                          child: ListTile(
                            title: Text(tasks[index]),
                            trailing: IconButton(
                              icon: const Icon(Icons.delete, color: Colors.red),
                              onPressed: () => _removeTask(index),
                            ),
                          ),
                        ),
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
