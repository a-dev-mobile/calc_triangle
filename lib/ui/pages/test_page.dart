// ignore_for_file: prefer_const_constructors, avoid_print

import 'package:flutter/material.dart';

const int startIndex = 0;
int selectedIndex = startIndex;
const int maxSelected = 2;

List<int> selectedIndexList = [];

final List<String> base = ['a', 'b', 'c', 'd', 'e', 'f', 'g', 'h'];
List<String> updateBase = List.from(base);
List<String> viewBase = List.from(base);

class ChangeListPage extends StatefulWidget {
  const ChangeListPage({Key? key}) : super(key: key);

  @override
  _ChangeListPageState createState() => _ChangeListPageState();
}

class _ChangeListPageState extends State<ChangeListPage> {
  void prev() {
    setState(() {
      selectedIndex--;

      if (selectedIndex < 0) selectedIndex = base.length - 1;

      replaceInList();
    });
  }

  void select() {
    setState(() {
      if (selectedIndexList.length > maxSelected - 1) {
        selectedIndexList.removeAt(0);
        updateBase = List.from(base);
        viewBase = List.from(base);

        for (var item in selectedIndexList) {
          updateBase.replaceRange(item, item + 1, ['=' + viewBase[item] + '=']);
        }
      }

      selectedIndexList.add(selectedIndex);

      viewBase = List.from(updateBase);

      viewBase.replaceRange(selectedIndex, selectedIndex + 1,
          ['=' + viewBase[selectedIndex] + '=']);

      updateBase = List.from(viewBase);
    });
    print('==============');
  }

  void next() {
    setState(() {
      selectedIndex++;
      if (selectedIndex > base.length - 1) selectedIndex = 0;

      replaceInList();
      // var index = baseIndex.indexOf(select);
      // baseIndex.replaceRange(index, index + 1, ['g']);
    });
  }

  void clear() {
    setState(() {
      updateBase = List.from(base);
      viewBase = List.from(base);
      selectedIndexList.clear();
      selectedIndex = startIndex;

      selectedIndexList.clear;

      replaceInList();
    });
  }

  void replaceInList() {
    viewBase = List.from(updateBase);
    viewBase.replaceRange(selectedIndex, selectedIndex + 1,
        ['!' + viewBase[selectedIndex] + '!']);
  }

  @override
  void initState() {
    replaceInList();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final List<Widget> listWidget =
        viewBase.map((e) => Text(e.toString())).toList();
    print('build');

    print('updateBase ${updateBase.toString()}');
    print('viewBase ${viewBase.toString()}');

    return Scaffold(
        body: Center(
      child: SafeArea(
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Column(
                children: listWidget,
              ),
              Row(
                children: [
                  ElevatedButton(
                      onPressed: () {
                        prev();
                      },
                      child: Text('prev')),
                  Spacer(),
                  ElevatedButton(
                      onPressed: () {
                        print('1selIndexsList ${selectedIndexList.toString()}');
                        print(
                            '1selIndexsList.length ${selectedIndexList.length}');
                        print('1selectedIndex $selectedIndex');

                        select();

                        print('2selIndexsList ${selectedIndexList.toString()}');
                        print(
                            '2selIndexsList.length ${selectedIndexList.length}');
                        print('2selectedIndex $selectedIndex');
                      },
                      child: Text('select')),
                  Spacer(),
                  ElevatedButton(
                      onPressed: () {
                        next();
                      },
                      child: Text('next')),
                ],
              ),
              ElevatedButton(
                  onPressed: () {
                    clear();
                  },
                  child: Text('clear')),
            ]),
      ),
    ));
  }
}
