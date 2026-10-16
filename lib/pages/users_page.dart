import 'package:flutter/material.dart';
import '../models/app_user.dart';
import '../services/storage_service.dart';

class UsersPage extends StatefulWidget {
  const UsersPage({super.key});

  @override
  State<UsersPage> createState() => _UsersPageState();
}

class _UsersPageState extends State<UsersPage> {
  late Future<List<AppUser>> _future = StorageService.getUsers();

  void _reload() => setState(() => _future = StorageService.getUsers());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Сохранённые пользователи'),
        actions: [
          IconButton(
            icon: const Icon(Icons.delete_outline),
            tooltip: 'Очистить',
            onPressed: () async {
              await StorageService.clear();
              _reload();
            },
          ),
        ],
      ),
      body: FutureBuilder<List<AppUser>>(
        future: _future,
        builder: (context, snap) {
          if (!snap.hasData) {
            return const Center(child: CircularProgressIndicator());
          }
          final users = snap.data!;
          if (users.isEmpty) {
            return const Center(child: Text('Пока никого нет'));
          }
          return ListView.separated(
            itemCount: users.length,
            separatorBuilder: (_, __) => const Divider(height: 1),
            itemBuilder: (_, i) {
              final u = users[i];
              return ListTile(
                leading: CircleAvatar(child: Text(u.name[0].toUpperCase())),
                title: Text(u.name),
                subtitle: Text('${u.email}\n${u.phone}'),
                isThreeLine: true,
              );
            },
          );
        },
      ),
    );
  }
}
