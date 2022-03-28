import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:fluttertest/src/helper/myTheme.dart';
import 'package:fluttertest/src/provider/dataProvider.dart';
import 'package:fluttertest/src/widgets/addButtonCustom.dart';
import 'package:fluttertest/src/widgets/backButtonCustom.dart';
import 'package:fluttertest/src/widgets/categoryWidget.dart';
import 'package:fluttertest/src/widgets/dayWidget.dart';
import 'package:fluttertest/src/widgets/productWidget.dart';
import 'package:fluttertest/src/widgets/specialTextField.dart';
import 'package:provider/provider.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future.delayed(Duration.zero, () {
      Provider.of<DataProvider>(context, listen: false).getData();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        body: Stack(
          children: [
            Container(
              width: MediaQuery.of(context).size.width,
              height: 120,
              color: MyTheme.black,
              child: Align(
                alignment: Alignment.bottomCenter,
                child: Padding(
                  padding:
                      const EdgeInsets.only(bottom: 50, left: 20, right: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: const [
                      BackButtonCustom(),
                      Text(
                        "الوجبات",
                        style: MyTheme.styleWhite2,
                      ),
                      AddButtonCustom()
                    ],
                  ),
                ),
              ),
            ),
            Consumer<DataProvider>(
              builder: (context, provider, child) {
                return Container(
                  margin: const EdgeInsetsDirectional.only(top: 80),
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height,
                  decoration: const BoxDecoration(
                      // color: MyTheme.backGround,
                      gradient: LinearGradient(
                        begin: Alignment.topRight,
                        end: Alignment.bottomLeft,
                        colors: [
                          Colors.white,
                          Color(0xfff9fafc),
                        ],
                      ),
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(30.0),
                          topRight: Radius.circular(30.0))),
                  child: RefreshIndicator(
                    onRefresh: () {
                      return provider.getData();
                    },
                    color: MyTheme.black,
                    child: Padding(
                      padding: const EdgeInsets.only(top: 15),
                      child: ListView(
                        children: [
                          Row(
                            children: [
                              const SizedBox(width: 20),
                              Material(
                                elevation: 3,
                                borderRadius:
                                const BorderRadius.all(Radius.circular(8.0)),
                                child: Container(
                                  height: 47,
                                  width: 52,
                                  child: const Icon(Icons.home),
                                  decoration: const BoxDecoration(
                                      color: Colors.white,
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(8.0))),
                                ),
                              ),
                              const SizedBox(width: 15),
                              Flexible(
                                  child: SpecialTextFieldSearch(
                                onChange: (v) {},
                              )),
                              const SizedBox(width: 20),
                            ],
                          ),
                          const SizedBox(height: 20),
                          provider.categories == null
                              ? const LinearProgressIndicator(
                                  color: MyTheme.black,
                                  minHeight: 32.0,
                                )
                              : SizedBox(
                                  height: 32,
                                  child: ListView.builder(
                                      itemCount: provider.categories!.length,
                                      scrollDirection: Axis.horizontal,
                                      itemBuilder: (context, i) {
                                        return CategoryWidget(
                                          provider: provider,
                                          index: i,
                                        );
                                      }),
                                ),
                          const SizedBox(height: 20),
                          provider.days == null
                              ? const LinearProgressIndicator(
                                  color: MyTheme.black,
                                  minHeight: 32.0,
                                )
                              : SizedBox(
                                  height: 32,
                                  child: ListView.builder(
                                      itemCount: provider.days!.length,
                                      scrollDirection: Axis.horizontal,
                                      itemBuilder: (context, i) {
                                        return DayWidget(
                                          provider: provider,
                                          index: i,
                                        );
                                      }),
                                ),
                          const SizedBox(height: 20),
                          provider.products == null
                              ? SizedBox(
                                  height:
                                      MediaQuery.of(context).size.height * .4,
                                  child: const Center(
                                    child: CircularProgressIndicator(
                                      color: MyTheme.black,
                                    ),
                                  ),
                                )
                              : ListView.builder(
                                  itemCount: provider.products!.length,
                                  physics: const NeverScrollableScrollPhysics(),
                                  shrinkWrap: true,
                                  scrollDirection: Axis.vertical,
                                  itemBuilder: (context, i) {
                                    return ProductWidget(
                                      provider: provider,
                                      index: i,
                                    );
                                  })
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ],
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.startFloat,
        floatingActionButton: FloatingActionButton(
          onPressed: () {},
          backgroundColor: const Color(0xffe51e4e),
          tooltip: 'Filter',
          child: const Icon(Icons.add),
        ), // This trailing comma makes auto-formatting nicer for build methods.
      ),
    );
  }
}
