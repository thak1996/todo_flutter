import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:todo_flutter/app/core/models/todo.model.dart';
import 'package:todo_flutter/app/core/models/user.model.dart';
import 'package:todo_flutter/app/core/service/auth.service.dart';
import 'package:todo_flutter/app/core/service/todo.service.dart';
import 'package:todo_flutter/app/shared/widgets/add_todo_dialog.widget.dart';
import 'home.controller.dart';
import 'home.state.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).textTheme;

    return BlocProvider(
      create: (context) {
        return HomeController(AuthService(), TodoService())
          ..loadUser()
          ..getTodos();
      },
      child: Scaffold(
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
        body: BlocBuilder<HomeController, HomeState>(
          builder: (context, state) {
            if (state is HomeTodosLoaded || state is HomeLoaded) {
              final todos = state is HomeTodosLoaded ? state.todos : [];
              final user = state is HomeLoaded ? state.user : UserModel();
              return Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    _buildUserContent(user, theme),
                    const SizedBox(height: 24),
                    Expanded(
                      child: todos.isEmpty
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
                            ),
                    ),
                  ],
                ),
              );
            } else if (state is HomeError) {
              return _buildErrorMessage(state.message.toString(), theme);
            }
            return const Center(child: CircularProgressIndicator());
          },
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            showDialog(
              context: context,
              builder: (context) => AddTodoDialog(
                onAdd: (title, description, priority) {
                  context.read<HomeController>().addTodo(
                    TodoModel(
                      userId:
                          context.read<AuthService>().currentUser?.uid ?? '',
                      title: title,
                      description: description,
                      priority: TodoPriority.values[priority],
                    ),
                  );
                },
              ),
            );
          },
          child: const Icon(Icons.add),
        ),
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
