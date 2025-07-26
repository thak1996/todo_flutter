import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:todo_flutter/app/core/models/group.model.dart';
import 'package:todo_flutter/app/core/models/todo.model.dart';
import 'package:todo_flutter/app/core/models/user.model.dart';
import 'package:todo_flutter/app/shared/widgets/add_todo_dialog.widget.dart';
import 'home.controller.dart';
import 'home.state.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).textTheme;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Home"),
        actions: [
          IconButton(
            icon: Icon(Icons.logout),
            onPressed: () {
              context.read<HomeController>().logout();
              context.go('/login');
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.only(
          left: 16,
          right: 16,
          top: 8.0,
          bottom: 8.0,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            BlocSelector<HomeController, HomeState, UserModel?>(
              selector: (state) => context.read<HomeController>().currentUser,
              builder: (context, user) {
                if (user == null) return const SizedBox.shrink();
                return _buildUserContent(user, theme);
              },
            ),
            const SizedBox(height: 24),
            Expanded(
              child: BlocBuilder<HomeController, HomeState>(
                builder: (context, state) {
                  if (state is HomeTodoLoaded) {
                    final todos = state.todos;
                    return todos.isEmpty
                        ? Center(child: Text('Nenhuma tarefa encontrada.'))
                        : ListView.builder(
                            itemCount: todos.length,
                            itemBuilder: (context, index) {
                              final todo = todos[index];
                              return Card(
                                child: ListTile(
                                  title: Text(todo.title),
                                  subtitle: todo.description != null
                                      ? Text(todo.description!)
                                      : null,
                                  trailing: IconButton(
                                    icon: const Icon(Icons.delete),
                                    onPressed: () {
                                      // context.read<HomeController>().deleteTodo(todo.id);
                                    },
                                  ),
                                ),
                              );
                            },
                          );
                  } else if (state is HomeError) {
                    return _buildErrorMessage(state.message.toString(), theme);
                  }
                  return const Center(child: CircularProgressIndicator());
                },
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: BlocBuilder<HomeController, HomeState>(
        builder: (context, state) {
          List<GroupModel> userGroups = [];
          if (state is HomeGroupsLoaded) userGroups = state.groups;
          return FloatingActionButton(
            onPressed: () {
              final grupos = userGroups
                  .map((g) => {'id': g.id, 'name': g.name})
                  .toList();
              showDialog(
                context: context,
                builder: (context) => AddTodoDialog(
                  grupos: grupos,
                  onAdd:
                      ({
                        required String title,
                        String? description,
                        required int priority,
                        DateTime? completedAt,
                        DateTime? createAt,
                        DateTime? deletedAt,
                        String? groupId,
                      }) {
                        context.read<HomeController>().addTodo(
                          TodoModel(
                            userId:
                                context
                                    .read<HomeController>()
                                    .authService
                                    .currentUser
                                    ?.uid ??
                                '',
                            title: title,
                            description: description,
                            priority: TodoPriority.values[priority],
                            completedAt: completedAt,
                            createAt: createAt,
                            deletedAt: deletedAt,
                            groupId: groupId,
                          ),
                        );
                      },
                ),
              );
            },
            child: const Icon(Icons.add),
          );
        },
      ),
    );
  }

  Widget _buildUserContent(UserModel user, TextTheme theme) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text('Bem-vindo, ${user.name ?? "Usuário"}!', style: theme.bodyLarge),
      ],
    );
  }

  Widget _buildErrorMessage(String message, TextTheme theme) {
    return Text(message, style: theme.bodyLarge?.copyWith(color: Colors.red));
  }
}
