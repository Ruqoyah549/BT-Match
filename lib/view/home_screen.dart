import 'package:bt_match/controller/home_controller.dart';
import 'package:bt_match/model/team_response.dart';
import 'package:bt_match/widgets/date_widget.dart';
import 'package:bt_match/widgets/subtitle_widget.dart';
import 'package:bt_match/widgets/team_item.dart';
import 'package:bt_match/widgets/title_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({Key? key}) : super(key: key);

  final homeController = Get.put(HomeController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: OrientationBuilder(
            builder: (context, orientation) =>
                orientation == Orientation.portrait
                    ? buildPortrait(context)
                    : buildLandscape(context),
          ),
        ),
      ),
    );
  }

  Widget buildPortrait(BuildContext context) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TitleWidget(),
          SizedBox(height: 30),
          SubtitleWidget(),
          SizedBox(height: 10),
          DateWidget(homeController: homeController),
          SizedBox(height: 30),
          Obx(
            () => Expanded(
              child: homeController.isLoading.value
                  ? Center(
                      child: CircularProgressIndicator(),
                    )
                  : ListView.builder(
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                        Team team = homeController.teams[index];
                        return TeamItem(team: team);
                      },
                      itemCount: homeController.teams.length,
                    ),
            ),
          ),
        ],
      );

  Widget buildLandscape(BuildContext context) => SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TitleWidget(),
            SizedBox(height: 30),
            SubtitleWidget(),
            SizedBox(height: 10),
            DateWidget(homeController: homeController),
            SizedBox(height: 30),
            Obx(
              () => homeController.isLoading.value
                  ? Center(
                      child: CircularProgressIndicator(),
                    )
                  : GridView.builder(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      padding:
                          EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        mainAxisSpacing: 5,
                        crossAxisSpacing: 15,
                        mainAxisExtent: 100,
                      ),
                      itemBuilder: (context, index) {
                        Team team = homeController.teams[index];
                        return TeamItem(team: team);
                      },
                      itemCount: homeController.teams.length,
                    ),
            ),
          ],
        ),
      );
}
