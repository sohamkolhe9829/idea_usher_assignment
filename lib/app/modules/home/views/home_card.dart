import 'package:flutter/material.dart';

// ignore: must_be_immutable
class HomeCard extends StatelessWidget {
  String title;
  int value;
  int currentSteps;
  int goalSteps;
  String lightAsset;
  String darkAsset;
  HomeCard({
    super.key,
    required this.title,
    required this.value,
    required this.goalSteps,
    required this.currentSteps,
    required this.lightAsset,
    required this.darkAsset,
  });

  @override
  Widget build(BuildContext context) {
    double progress = (currentSteps / goalSteps).clamp(0.0, 1.0);

    bool isDark = Theme.of(context).scaffoldBackgroundColor == Colors.black;

    return AspectRatio(
      aspectRatio: 16 / 7,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 30),
        decoration: BoxDecoration(
          color: Theme.of(context).cardColor,
          borderRadius: BorderRadius.circular(30),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: "$title: ",
                          style: TextStyle(
                            fontSize: 20,
                            color: Theme.of(
                              context,
                            ).textTheme.labelMedium!.color,
                          ),
                        ),
                        TextSpan(
                          text: value.toString(),
                          style: TextStyle(
                            fontSize: 20,
                            color: Theme.of(
                              context,
                            ).textTheme.labelMedium!.color,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 20),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          height: 22,
                          width: double.infinity,
                          decoration: BoxDecoration(
                            color: Theme.of(context).splashColor,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Stack(
                            children: [
                              // Progress fill
                              FractionallySizedBox(
                                widthFactor: progress,
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: Theme.of(
                                      context,
                                    ).textTheme.labelMedium!.color,
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 8),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "$currentSteps",
                              style: TextStyle(
                                color: Theme.of(
                                  context,
                                ).textTheme.labelMedium!.color,
                              ),
                            ),
                            Text(
                              "Goal: ${goalSteps.toString().replaceAllMapped(RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (match) => '${match[1]},')}",
                              style: TextStyle(
                                color: Theme.of(
                                  context,
                                ).textTheme.labelMedium!.color,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            SizedBox(width: 10),
            SizedBox(
              width: 70,
              height: 70,
              child: Image.asset(
                isDark ? darkAsset : lightAsset,
                fit: BoxFit.cover,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
