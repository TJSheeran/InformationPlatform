import 'package:demo711/config/app_colors.dart';
import 'package:flutter/material.dart';

class LifeservicePage extends StatefulWidget {
  LifeservicePage({Key? key}) : super(key: key);

  @override
  State<LifeservicePage> createState() => _LifeservicePageState();
}

class _LifeservicePageState extends State<LifeservicePage> {
  int selectedIndex = 0;
  PageController _pageController = PageController();
  int pagesCount = 5;
  List<String> tabTitle = ['快 递', '空 调', '电 费', '医 保', '寝 室'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Row(
          children: [
            SizedBox(
              width: 100,
              child: ListView.separated(
                  itemBuilder: (BuildContext context, int index) {
                    return GestureDetector(
                      onTap: () {
                        setState(() {
                          selectedIndex = index;
                          _pageController.jumpToPage(index);
                        });
                      },
                      child: Container(
                        child: Row(
                          children: [
                            AnimatedContainer(
                              duration: Duration(milliseconds: 200),
                              height: (selectedIndex == index) ? 50 : 0,
                              width: 5,
                              color: AppColor.bluegreen,
                            ),
                            Expanded(
                              child: AnimatedContainer(
                                alignment: Alignment.center,
                                duration: Duration(milliseconds: 200),
                                height: 50,
                                color: (selectedIndex == index)
                                    ? AppColor.bluegreen.withOpacity(0.2)
                                    : Colors.transparent,
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 0, horizontal: 5),
                                  child: Text(
                                    tabTitle[index],
                                    style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w200,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                  separatorBuilder: ((BuildContext context, int index) {
                    return SizedBox(height: 5);
                  }),
                  itemCount: pagesCount),
            ),
            Expanded(
                child: Container(
              child: PageView(
                controller: _pageController,
                children: [
                  for (var i = 0; i < pagesCount; i++)
                    Container(
                      color: AppColor.bluegreen,
                      child: Center(child: Text('$tabTitle[index]')),
                    ),
                ],
              ),
            ))
          ],
        ),
      ),
    );
  }
}
