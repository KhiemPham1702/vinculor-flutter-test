import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:test_app_flutter/widget/shared_library/app_components/app_action.dart';
import 'package:test_app_flutter/widget/shared_library/app_components/app_label.dart';
import 'package:test_app_flutter/widget/shared_library/app_components/app_tile.dart';
import 'package:test_app_flutter/widget/shared_library/app_page/app_page.dart';
import 'package:test_app_flutter/widget/shared_library/app_page/app_page_section/card_section.dart';
import 'package:test_app_flutter/widget/shared_library/app_page/app_page_section/list_section.dart';
import 'package:test_app_flutter/widget/controller/app_controller.dart';
import 'package:test_app_flutter/widget/main/app_scaffold.dart';
import 'package:test_app_flutter/widget/todo_editor/todo_list_item.dart';

class TodoEditorPage extends StatefulWidget {
  const TodoEditorPage({super.key});

  @override
  State<TodoEditorPage> createState() => _TodoEditorPageState();
}

class _TodoEditorPageState extends State<TodoEditorPage> {
  late final _appController = GetIt.instance<AppController>();

  get _appPage => AppPage(
        scaffold: AppScaffold(
          titleText: 'TODO Editor',
          floatingAction: AppItemAction(
            label: AppLabel(text: 'Add Item'),
            onPressed: (context) async => _appController.addTodoItem(context),
          ),
        ),
        loadingEmitter: _appController.todoItemsEmitter,
        sections: [
          CardSection<List<TodoItem>>(
            emitter: _appController.todoItemsEmitter,
            tileBuilder: _cardTiles,
          ),
          ListSection(
            listEmitter: _appController.todoItemsEmitter,
            itemGroups: _buildItemGroups(),
          )
        ],
      );

  @override
  Widget build(BuildContext context) {
    return _appPage.build();
  }

  List<Widget> _cardTiles(List<TodoItem> items) {
    return [
      AppTile(
        iconData: Icons.numbers,
        titleText: 'Count: ${items.length}',
      ).build(),
    ];
  }

  List<ListItemGroup<TodoItem>> _buildItemGroups() {
    return [
      ListItemGroup(
        titleText: 'In Progress',
        showCount: false,
        filter: (item) => !item.isDone,
        builder: (item) => TodoListItem(item: item, appController: _appController),
      ),
      ListItemGroup(
        titleText: 'Completed',
        showCount: true,
        filter: (item) => item.isDone,
        builder: (item) => TodoListItem(item: item, appController: _appController),
      ),
    ];
  }
}