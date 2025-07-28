import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_flutter/app/core/models/group.model.dart';
import 'package:todo_flutter/app/core/models/todo.model.dart';
import 'package:todo_flutter/app/core/theme/app.colors.dart';
import 'package:todo_flutter/app/l10n/app_localizations.dart';
import 'package:todo_flutter/app/shared/widgets/add_todo_dialog.widget.dart';
import 'package:todo_flutter/app/shared/widgets/export.widgets.dart';
import 'package:todo_flutter/app/shared/widgets/todo_list_tile.dart';
import 'home.controller.dart';
import 'home.state.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).textTheme;
    final l10n = AppLocalizations.of(context);

    return Scaffold(
      drawer: const UserDrawer(),
      appBar: AppBar(title: Text(l10n.todo)),
      backgroundColor: AppColors.background,
      body: Padding(
        padding: const EdgeInsets.only(
          left: 16,
          right: 16,
          top: 8.0,
          bottom: 16,
        ),
        child: BlocBuilder<HomeController, HomeState>(
          builder: (context, state) {
            if (state is HomeTodoLoaded) {
              final todos = state.todos;
              return todos.isEmpty
                  ? Center(child: Text(l10n.noTasksFound))
                  : BlocBuilder<HomeController, HomeState>(
                      builder: (context, state) {
                        List<GroupModel> grupos = [];
                        if (state is HomeGroupsLoaded) grupos = state.groups;
                        return RefreshIndicator(
                          onRefresh: () async {
                            await context.read<HomeController>().getTodos();
                          },
                          child: ListView.separated(
                            separatorBuilder: (context, index) =>
                                const Divider(),
                            itemCount: todos.length,
                            itemBuilder: (context, index) {
                              final todo = todos[index];
                              return TodoListTile(
                                todo: todo,
                                grupos: grupos,
                                onDelete: () => context
                                    .read<HomeController>()
                                    .deleteTodo(todo.id.toString()),
                                onEdit: (updated) => context
                                    .read<HomeController>()
                                    .updateTodo(updated),
                                onToggleComplete: (checked) =>
                                    context.read<HomeController>().updateTodo(
                                      silent: true,
                                      todo.copyWith(
                                        completedAt: checked == true
                                            ? DateTime.now()
                                            : null,
                                      ),
                                    ),
                              );
                            },
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
      floatingActionButton: BlocBuilder<HomeController, HomeState>(
        builder: (context, state) {
          List<GroupModel> userGroups = [];
          if (state is HomeGroupsLoaded) userGroups = state.groups;
          return FloatingActionButton.extended(
            icon: const Icon(Icons.add),
            label: Text(l10n.newTask),
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
          );
        },
      ),
    );
  }

  Widget _buildErrorMessage(String message, TextTheme theme) {
    return Text(message, style: theme.bodyLarge?.copyWith(color: Colors.red));
  }
}
