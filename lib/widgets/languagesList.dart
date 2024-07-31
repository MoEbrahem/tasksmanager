import 'package:flutter/material.dart';
import 'package:tasksmanager/AppColor.dart';

class ItemList extends StatelessWidget {
  String textBox;
  String title;
  Function()? ontap;
  ItemList({super.key,required this.textBox,required this.title,required this.ontap});

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;

    return Container(
      margin: EdgeInsets.only(top: height*0.02),
      child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: Theme.of(context).textTheme.headlineSmall,
              ),
              InkWell(
                onTap: ontap,
                child: Container(
                  margin: const EdgeInsets.only(top: 20,left: 20),
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  height: height * 0.07,
                  decoration: BoxDecoration(
                      color: AppColor.whiteColor,
                      border: Border.all(
                        color: AppColor.primaryLightColor,
                      ),),
                  child: Row(
                    children: [
                      Text(
                        textBox,
                        style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                              color: AppColor.primaryLightColor,
                            ),
                      ),
                      const Spacer(),
                      const Icon(
                        Icons.arrow_drop_down,
                        color: AppColor.primaryLightColor,
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
    );
  }
}