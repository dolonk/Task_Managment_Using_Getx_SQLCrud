
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:task_mnagment/ui/add_task_page/add_task_page.dart';

import '../../theme.dart';
import '../../widget/button.dart';

class AppTaskBar extends StatelessWidget {
  const AppTaskBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(left: 15,right: 15,top: 15),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(DateFormat.yMMMMd().format(DateTime.now()),
                    style: subHeadingStyle),
                Text("Today",style: headingStyle,)
              ],
            ),
          ),
          MyButton(label: "+ Add Task", onTap: ()=> Get.to(AddTaskPage()))
        ],
      ),
    );
  }
}