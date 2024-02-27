import 'package:flutter/material.dart';

import 'package:flutter_drag_drop/providers/phone_provider.dart';
import 'package:flutter_drag_drop/ui/enum/widget_enum.dart';
import 'package:flutter_drag_drop/ui/widgets/secondary/data_widget.dart';
import 'package:flutter_drag_drop/ui/widgets/secondary/tool_widget.dart';
import 'package:flutter_draggable_list/flutter_draggable_list.dart';
import 'package:provider/provider.dart';
import 'package:flutter_svg/flutter_svg.dart';

class PhoneWidget extends StatelessWidget {
  PhoneWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
        color: const Color(0xfff4f8fc),
        child: Center(
            child: Stack(
          children: [
            SvgPicture.asset(
              "assets/images/svg/phone.svg",
              height: 627,
              width: 299.74,
            ),
            Positioned(
              top: 28,
              left: 9.80,
              child: ContainerPhone(),
            )
          ],
        )));
  }
}

class ContainerPhone extends StatefulWidget {
  ContainerPhone({
    super.key,
  });

  @override
  State<ContainerPhone> createState() => _ContainerPhoneState();
}

class _ContainerPhoneState extends State<ContainerPhone> {
  @override
  Widget build(BuildContext context) {
    final phoneProvider = Provider.of<PhoneProvider>(context, listen: true);
    return DragTarget<EnumWidget>(
      onAccept: (data) {
        phoneProvider.changeValue(KeyedSubtree(
          child: DataWidget(
            enumWidget: data,
          ),
          key: Key(uuid.v4()),
        ));
      },
      builder: (context, candidateData, rejectedData) {
        return Container(
          child: Scaffold(
            body: Consumer<PhoneProvider>(
              builder: (context, value, child) {
                return ReorderableListView(
                  buildDefaultDragHandles: true,
                  children: List.generate(
                      value.widgets.length,
                      (index) => ListTile(
                        
                            key: Key(uuid.v4()),
                            title: value.widgets[index],
                          
                          )),
                  onReorder: (oldIndex, newIndex) {
                    if (oldIndex < newIndex) {
                      newIndex -= 1;
                    }
                    Widget widget = phoneProvider.widgets.removeAt(oldIndex);
                    phoneProvider.changeValueIndex(widget, newIndex);
                  },
                );
              },
            ),
          ),
          width: 278.74,
          height: 576,
          decoration: BoxDecoration(
              color: Colors.white, borderRadius: BorderRadius.circular(30)),
        );
      },
    );
  }
}
