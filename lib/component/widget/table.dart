import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:the_smart_workshop/component/const/colors.dart';
import 'package:the_smart_workshop/component/const/padding.dart';
import 'package:the_smart_workshop/component/const/texts.dart';
import 'package:the_smart_workshop/screens/deducts/a-component/cubit/cubit.dart';
import 'package:the_smart_workshop/screens/deducts/a-component/cubit/state.dart';

class WindowsListSize extends StatelessWidget {
  final String w, h, l;
  final int i;
  final Function() onDeletePressed;
  final Function() onEditPressed;

  WindowsListSize({
    required this.w,
    required this.h,
    required this.l,
    required this.i,
    required this.onDeletePressed,
    required this.onEditPressed,
  });

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ComponentCubit, ComponentState>(
        listener: (context, state) {},
        builder: (context, state) {
          return Container(
            color: i.isOdd ? Colors.grey.shade200 : Colors.white,
            child: Container(
              height: 20,
              width: 50,
              child: SPadding(
                h: .01,
                v: .02,
                child:
                    Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                  Expanded(flex: 2, child: Center(child: BTextB5(w))),
                  Expanded(flex: 1, child: Center(child: BText4('X'))),
                  Expanded(flex: 2, child: Center(child: BTextB5(h))),
                  Expanded(flex: 1, child: Center(child: BText4(l))),
                  Expanded(
                      flex: 1,
                      child: Center(
                          child: IconButton(
                        icon: Icon(
                          Icons.edit,
                          color: Colors.black,
                        ),
                        onPressed: onEditPressed,
                      ))),
                  Expanded(
                      flex: 1,
                      child: Center(
                          child: IconButton(
                        icon: Icon(
                          Icons.delete,
                          color: cLogoColorW,
                        ),
                        onPressed: onDeletePressed,
                      ))),
                ]),
              ),
            ),
          );
        });
  }
}

class Table1RowHeader extends StatelessWidget {
  final child;
  final String title;

  Table1RowHeader({required this.child, required this.title});
  final List<String> skTableColumn = [
    'المقاس',
    'العدد',
  ];

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return PaginatedDataTable(
        columnSpacing: size.width * .3,
        header: Card(
            color: Colors.black54,
            child: DPadding(
                child: title.length >= 18
                    ? WTextB6('${title}')
                    : WTextB8('${title}'))),
        columns: List.generate(
            2, (i) => DataColumn(label: BTextB4(skTableColumn[i]))),
        source: child);
  }
}

class Table1RowBody extends DataTableSource {
  final List list;

  Table1RowBody(this.list);

  @override
  DataRow? getRow(int i) {
    return DataRow.byIndex(index: i, cells: [
      DataCell(SPadding(
        v: .02,
        h: 0,
        child: Center(
          child: BTextB5(
              '${list[i].size.runtimeType == double ? list[i].size.toStringAsFixed(1) : list[i].size}'),
        ),
      )),
      DataCell(Center(
        child: BTextB4('${list[i].length}'),
      ))
    ]);
  }

  @override
  bool get isRowCountApproximate => false;

  @override
  int get rowCount => list.length;

  @override
  int get selectedRowCount => 0;
}

class Table2RowHeader extends StatelessWidget {
  final child;
  final String title;

  Table2RowHeader({required this.child, required this.title});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return PaginatedDataTable(
        columnSpacing: size.width * .11,
        header: Card(
            color: Colors.black54,
            child: DPadding(
                child: title.length >= 18
                    ? WTextB6('${title}')
                    : WTextB8('${title}'))),
        columns: [
          DataColumn(label: const Text('  ')),
          DataColumn(label: const BTextB4('المقاس')),
          DataColumn(label: const Text('  ')),
          DataColumn(label: const BTextB4('العدد')),
        ],
        source: child);
  }
}

class Table2RowBody extends DataTableSource {
  final List list;

  Table2RowBody(this.list);

  @override
  DataRow? getRow(int i) {
    return DataRow.byIndex(index: i, cells: [
      DataCell(SPadding(
        v: .02,
        h: .01,
        child: Center(
          child: BTextB5('${list[i].size1.toStringAsFixed(1)}'),
        ),
      )),
      DataCell(Center(
        child: BTextB4('x'),
      )),
      DataCell(SPadding(
        v: .02,
        h: .01,
        child: Center(
          child: BTextB5(
              '${list[i].size2.runtimeType == String ? list[i].size2 : list[i].size2.toStringAsFixed(1)}'),
        ),
      )),
      DataCell(Center(
        child: BTextB4('${list[i].length}'),
      ))
    ]);
  }

  @override
  bool get isRowCountApproximate => false;

  @override
  int get rowCount => list.length;

  @override
  int get selectedRowCount => 0;
}

class Table3RowHeader extends StatelessWidget {
  final child;
  final String title;
  final int i;

  Table3RowHeader({required this.child, required this.title, required this.i});

  final List<String> skTableColumn = [
    'المقاس',
    'مفرد',
    'متقارب',
    'متباعد',
  ];

  final List<String> shutterTableColumn = [
    'المقاس',
    'لون أساسي',
    'لون ثانوي',
    'زجاج',
  ];

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return PaginatedDataTable(
        columnSpacing: size.width * .09,
        header: Card(
            color: Colors.black54,
            child: DPadding(
                child: title.length >= 18
                    ? WTextB6('${title}')
                    : WTextB8('${title}'))),
        columns: List.generate(4, (j) {
          List list = [skTableColumn, shutterTableColumn];

          return DataColumn(label: BTextB4(list[i][j]));
        }),
        source: child);
  }
}

class Table3RowBody extends DataTableSource {
  final List list;

  Table3RowBody(this.list);
  @override
  DataRow? getRow(int j) {
    return DataRow.byIndex(
        index: j,
        cells: List.generate(
            4,
            (i) => i == 0
                ? DataCell(Container(
                    color: Colors.grey.shade200,
                    child: SPadding(
                      v: .02,
                      h: 0,
                      child: Center(
                        child: BTextB5('${list[j].size.toStringAsFixed(1)}'),
                      ),
                    ),
                  ))
                : DataCell(Center(
                    child: BTextB4(
                        '${list[j].length[i - 1] == 0 ? '-' : list[j].length[i - 1]}'),
                  ))));
  }

  @override
  bool get isRowCountApproximate => false;

  @override
  int get rowCount => list.length;

  @override
  int get selectedRowCount => 0;
}
