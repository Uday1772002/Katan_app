import 'package:flutter/material.dart';
import 'package:katanapp/BotNaviteam/BotNaviteam.dart';
import 'package:katanapp/components/mangacard.dart';
import 'package:katanapp/constants/constants.dart';
import 'package:web_scraper/web_scraper.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int selectedNavindex = 0;
  bool mangaLoaded = false;
  late List<Map<String, dynamic>> mangaList;

  void navBarTap(int index) {
    setState(() {
      selectedNavindex = index;
    });
  }

  void fetchManga() async {
    //doubt
    final webscraper = WebScraper(Constants.baseUrl);
    if (await webscraper.loadWebPage('/read')) {
      mangaList = webscraper.getElement(
          'div#content>div.wrapper>div.postbody>div.bixbox>div.listupd>div.bs>div.bsx>div.limit > img',
          ['src', 'alt']);
      print(mangaList);
      setState(() {
        mangaLoaded = true;
      });
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchManga();
  }

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text("katan"),
        backgroundColor: Constants.darkgrey,
      ),
      body: mangaLoaded
          ? Container(
              height: screenSize.height,
              width: double.infinity,
              color: Constants.balck,
              child: SingleChildScrollView(
                physics: BouncingScrollPhysics(),
                child: Wrap(
                  children: [
                    Container(
                      width: double.infinity,
                      height: 30,
                      padding: EdgeInsets.only(left: 20),
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "${mangaList.length}mangas",
                        style: TextStyle(
                          fontSize: 23,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    MangaCard(
                      mangaImg:
                          "https://avt.mkklcdnv6.com/35/s/22-1604808354.jpg",
                      mangaTitle: "A Boy That Can't swim",
                    )
                  ],
                ),
              ),
            )
          : Center(child: CircularProgressIndicator()),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        backgroundColor: Constants.darkgrey,
        selectedItemColor: Constants.lightblue,
        unselectedItemColor: Colors.white,
        currentIndex: selectedNavindex,
        onTap: navBarTap,
        items: [
          botNavIteam(Icons.explore_outlined, "EXPLORE"),
          botNavIteam(Icons.favorite, "FAVORITE"),
          botNavIteam(Icons.watch_later, "RECENT"),
          botNavIteam(Icons.more_horiz, "MORE"),
        ],
      ),
    );
  }
}
