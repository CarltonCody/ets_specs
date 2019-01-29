import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:etsspecsapp/Product.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:cached_network_image/cached_network_image.dart';

List<SamsungProduct> _productList;

void main() {
  runApp(MaterialApp(
    theme: ThemeData(
      primaryColor: Color(0xFF0F60CA),
    ),
    home: HomePage(),
  ));
}

class HomePage extends StatefulWidget {
  @override
  HomePageState createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
  int currentTab = 0;

  CEPage cePage;
  HAPage haPage;

  List<Widget> pages;

  Widget currentPage;

  @override
  void initState() {
    // TODO: implement initState

    cePage = CEPage();
    haPage = HAPage();

    pages = [cePage, haPage];

    currentPage = cePage;

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("ETS Specs"),
      ),
      body: currentPage,
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentTab,
        onTap: (int index) {
          setState(() {
            currentTab = index;
            currentPage = pages[index];
          });
        },
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.devices_other),
            title: Text('CE'),
          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.kitchen), title: Text('Appliances'))
        ],
      ),
    );
  }

}

class ListItem extends StatelessWidget {
  final int index;

  ListItem(this.index);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Card(
        child: InkWell(
            onTap: () {
              _listItemSelected(index);
            },
            child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Container(
                      padding: EdgeInsets.all(8.0),
                      child: FittedBox(
                        fit: BoxFit.contain,
                        child: CachedNetworkImage(
                        imageUrl: _productList[index].imageUrl,
                        alignment: Alignment.center,
                        placeholder: Container(
                          padding: EdgeInsets.all(8.0),
                          child: Center(
                            widthFactor: 2.4,
                            heightFactor: 2.4,
                            child: CircularProgressIndicator(),
                          ),
                        ),
                        errorWidget: Container(
                          padding: EdgeInsets.all(8.0),
                          child: Container(
                            child: Column(
                              children: <Widget>[
                                Icon(Icons.sentiment_dissatisfied),
                                Container(
                                  padding: EdgeInsets.all(4.0),
                                  child: Text(
                                    "No internet connection",
                                    style: TextStyle(fontSize: 8.0),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                        fit: BoxFit.cover,
                        height: 100.0,
                        width: 135.0,
                      ),
                      )),
                  Expanded(
                    child: Container(
                      padding: EdgeInsets.all(8.0),
                      child: Text(
                      _productList[index].productCat,
                      textAlign: TextAlign.start,
                      overflow: TextOverflow.ellipsis,
                      softWrap: true,
                      style: TextStyle( 
                        fontSize: 14.0,
                        fontWeight: FontWeight.bold),
                    ),
                    ),
                  
                  )
                ])));
  }
}

class CEPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    _fetchCESpecSheets();

    return Container(
      child: ListView.builder(
        itemCount: _productList.length,
        itemBuilder: (BuildContext context, int index) {
          return ListItem(index);
        },
      ),
    );
  }
}

class HAPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    _fetchHASpecSheets();

    return Container(
      child: ListView.builder(
        itemCount: _productList.length,
        itemBuilder: (BuildContext context, int index) {
          return ListItem(index);
        },
      ),
    );
  }
}

void _listItemSelected(int index) async {
  String url = _productList[index].specSheetUrl;
  if (await canLaunch(url)) {
    await launch(url);
  } else {
    throw 'Could not launch $url';
  }
}

void _fetchCESpecSheets() {
  _productList = new List();
  _productList.add(new SamsungProduct(
      "https://s7d2.scene7.com/is/image/SamsungUS/01_QN75Q9FNAFXZA?\$product-details-jpg\$",
      "https://drive.google.com/file/d/1XpqVOJjHfr2ye-Qz5eoPEEcY00Wqx9ld/view",
      "2018 QLED TVs"));
  _productList.add(new SamsungProduct(
      "https://s7d2.scene7.com/is/image/SamsungUS/UN65NU8500FXZA_001_Front_Black-1600x1200?\$product-details-jpg\$",
      "https://drive.google.com/file/d/1zljf_5MaeycXiEAQfGOoeE0uh5gpRyHD/view",
      "2018 UHD TVs"));
  _productList.add(new SamsungProduct(
      "https://s7d2.scene7.com/is/image/SamsungUS/qn65q9famfxza-gallery1-0313?\$product-details-jpg\$",
      "https://drive.google.com/file/d/18haIqvqUbVoMRzYZA1HxaayvM0n6FpW4/view",
      "2017 QLED TVS"));
  _productList.add(new SamsungProduct(
      "https://s7d2.scene7.com/is/image/SamsungUS/MU9000_1?\$product-details-jpg\$",
      "https://drive.google.com/file/d/1XvIOnJh_GdFeBcCmV74LIscNb5Kb0Tsl/view",
      "2017 UHD TVs"));
  _productList.add(new SamsungProduct(
      "https://s7d2.scene7.com/is/image/SamsungUS/1_UN50M5300AFXZA_070317?\$product-details-jpg\$",
      "https://drive.google.com/file/d/1cJN9BsK7uxxMjRSREc2sGzHhUrlIxKwh/view",
      "2013-2017 FHD/HD TVs"));
  _productList.add(new SamsungProduct(
      "https://s7d2.scene7.com/is/image/SamsungUS/m9500-gallery2-0403?\$product-details-jpg\$",
      "https://drive.google.com/file/d/1FZ1JXTcreBnXfgPlJe_PHUN_SMl_3_ks/view",
      "2017 BLU-RAY Players"));
  _productList.add(new SamsungProduct(
      "https://s7d2.scene7.com/is/image/SamsungUS/Pdpgallery-ubd-k8500-za-600x600-C2-052016?\$product-details-jpg\$",
      "https://drive.google.com/file/d/0ByIO8SC7-fhSdUhlQ3Y0VHYzaDg/view",
      "2015-2017 BLU-RAY Players"));
  _productList.add(new SamsungProduct(
      "https://s7d2.scene7.com/is/image/SamsungUS/Pdpdefault-ht-j5500w-za-600x600-C1-052016?\$product-details-jpg\$",
      "https://drive.google.com/file/d/0ByIO8SC7-fhSS3o2YzhFX3hVYkU/view",
      "Home theater systems"));
  _productList.add(new SamsungProduct(
      "https://s7d2.scene7.com/is/image/SamsungUS/hwm550za-gallery1-0329?\$product-details-jpg\$",
      "https://drive.google.com/file/d/0ByIO8SC7-fhSenRXcDhidkN6QVU/view",
      "2017 M series soundbars"));
  _productList.add(new SamsungProduct(
      "https://s7d2.scene7.com/is/image/SamsungUS/HW-MS6500_1?\$product-details-jpg\$",
      "https://drive.google.com/file/d/0ByIO8SC7-fhSQkI4V2FmRkRFamM/view",
      "2017 MS series soundbars"));
  _productList.add(new SamsungProduct(
      "https://s7d2.scene7.com/is/image/SamsungUS/SWA-W700_1_20170714?\$product-details-jpg\$",
      "https://drive.google.com/file/d/0ByIO8SC7-fhSOFBORkVOUWNSTVU/view",
      "Sound+ Soundbar Subwoofer"));
  _productList.add(new SamsungProduct(
      "https://s7d2.scene7.com/is/image/SamsungUS/smt813nzkexar-hero-0812?\$product-details-jpg\$",
      "https://drive.google.com/file/d/0ByIO8SC7-fhSclZTRy1iczhnY0U/view",
      "Tab S2"));
  _productList.add(new SamsungProduct(
      "https://s7d2.scene7.com/is/image/SamsungUS/SM-T580NZKAXAR-hero-71016?\$product-details-jpg\$",
      "https://drive.google.com/file/d/1hX03wva2HK-mfTLCvMmj0r7q4otPWuhU/view",
      "Tab A"));
  _productList.add(new SamsungProduct(
      "https://s7d2.scene7.com/is/image/SamsungUS/Pdpdefault-sm-t113nykaxar-600x600-C1-052016?\$product-details-jpg\$",
      "https://drive.google.com/file/d/0ByIO8SC7-fhSUVZLaWx1TGVPZXM/view",
      "Tab E Lite"));
  _productList.add(new SamsungProduct(
      "https://s7d2.scene7.com/is/image/SamsungUS/Pdpdefault-lu28e590ds-za-600x600-C1-052016?\$product-details-jpg\$",
      "https://drive.google.com/file/d/0ByIO8SC7-fhSYlNkcVBGZVczczg/view",
      "Computer monitors"));
  _productList.add(new SamsungProduct(
      "https://s7d2.scene7.com/is/image/SamsungUS/MB-MC64GA_1?\$product-details-jpg\$",
      "https://drive.google.com/file/d/0ByIO8SC7-fhSSTh0aU00ZkdPSjg/view",
      "Memory cards"));
  _productList.add(new SamsungProduct(
      "https://s7d2.scene7.com/is/image/SamsungUS/Asmr760ndaaxar-gallery3-20171120?\$product-details-jpg\$",
      "https://drive.google.com/file/d/1T2upnPpdYxQ9fmxvNICtCDBz8K9Cj63G/view",
      "Gear watches"));
  _productList.add(new SamsungProduct(
      "https://s7d2.scene7.com/is/image/SamsungUS/2-st-hmk-transparent-20171113?\$product-details-jpg\$",
      "https://drive.google.com/file/d/0ByIO8SC7-fhSNmRGVWRtazNXdUE/view",
      "SmartThings"));
}

void _fetchHASpecSheets() {
  _productList = new List();
  _productList.add(new SamsungProduct(
      "https://s7d2.scene7.com/is/image/SamsungUS/01_Washer_TopLoader_WA40J3000AW_Front_Closed_White012218?\$product-details-jpg\$",
      "https://drive.google.com/file/d/13vaNN9GKb8AuT2Wc8YhwvfSsOMWsM54l/view",
      "WA40J3000AW"));

  _productList.add(new SamsungProduct(
      "https://s7d2.scene7.com/is/image/SamsungUS/01_Dryer_Electric_DV40J3000EW_Front_White?\$product-details-jpg\$",
      "https://drive.google.com/file/d/1tSx3wYml1M1om3mhgWAuMglju7JlsSuI/view",
      "DV40J3000EW"));

  _productList.add(new SamsungProduct(
      "https://images.samsung.com/is/image/samsung/ca-top-loader-wa45h7000aw-wa45h7000aw-a2-001-front-white?\$PD_GALLERY_L_JPG\$",
      "https://drive.google.com/file/d/1BlWwkKMSnIN30s_mL6_igOG1aFgBNxFt/view",
      "WA45H7000AW"));

  _productList.add(new SamsungProduct(
      "https://s7d2.scene7.com/is/image/SamsungUS/DV45H7000EW_1?\$product-details-jpg\$",
      "https://drive.google.com/file/d/1l3qnm33u-yN65ncv65L23MjmPRX9_hu9/view",
      "DV45H7000EW"));

  _productList.add(new SamsungProduct(
      "https://images.samsung.com/is/image/samsung/ca-dryer-dv45k7600ew-dv45k7600ew-ac-001-front-white?\$PD_GALLERY_L_JPG\$",
      "https://drive.google.com/file/d/14rUV0Ntr0OXWhkl1E6OU0WAn1krOpj-F/view", 
      "WA45K7600AW"));

  _productList.add(new SamsungProduct(
      "https://s7d2.scene7.com/is/image/SamsungUS/Pdpdefault-dv45k7600ew-a3-600x600-C1-052016?\$support-product-hero-jpg\$",
      "https://drive.google.com/file/d/1G5RMiPlJmKbWsN149ua2R5eaFK4aQexC/view", 
      "DV45K7600EW"));

  _productList.add(new SamsungProduct(
      "https://s7d2.scene7.com/is/image/SamsungUS/01_Washer-TopLoader_WA50M7450AW_Front_Closed-White?\$product-details-jpg\$",
      "https://drive.google.com/file/d/1tcq1EMifkEWnsAzk3woC8xp2JK1J2PrK/view", 
      "WA50M7450AW"));

  _productList.add(new SamsungProduct(
      "https://s7d2.scene7.com/is/image/SamsungUS/01_Dryer_Electric_DVE50M7450W_Front_Closed_White?\$product-details-jpg\$",
      "https://drive.google.com/file/d/1j70rP1IQoyPkHa3o27-X0QGfPiQm6Hmd/view", 
      "DVE50M7450W"));

  _productList.add(new SamsungProduct(
      "https://s7d2.scene7.com/is/image/SamsungUS/01_Washer_TopLoader_WA52M7750AW_Front_Closed_White?\$product-details-jpg\$",
      "https://drive.google.com/file/d/1BhCeUhlPJZ0SYclqukVEtU0QafUIZ2ws/view", 
      "WA52M7750AW"));

  _productList.add(new SamsungProduct(
      "https://s7d2.scene7.com/is/image/SamsungUS/01_Dryer_Electric_DVE52M7750V_Front_Closed_Black?\$product-details-jpg\$",
      "https://drive.google.com/file/d/11RtLB6aLdVeW6eaLnT6p_XWa8uzdq1V0/view", 
      "DVE52M7750W"));

  _productList.add(new SamsungProduct(
      "https://s7d2.scene7.com/is/image/SamsungUS/Pdpdefault-wa52j8700aw-a2-600x600-C1-052016?\$support-product-hero-jpg\$",
      "https://drive.google.com/file/d/17PPeFGRZz-KHL3-4FNEFxwrWj2DjJxiY/view", 
      "WA52J8700AP"));

  _productList.add(new SamsungProduct(
      "https://s7d2.scene7.com/is/image/SamsungUS/Pdpdefault-dv52j8700ew-a2-600x600-C1-052016?\$support-product-hero-jpg\$",
      "https://drive.google.com/file/d/1iEic_Q6Imn1OeuojX6nGy5-91rdpqjbG/view", 
      "DV52J8700EP"));

  _productList.add(new SamsungProduct(
      "https://s7d2.scene7.com/is/image/SamsungUS/01_Washer_TopLoader_WA54M8750AV_Front_Closed_Black?\$product-details-jpg\$",
      "https://drive.google.com/file/d/1F7FXD2SbEVQ1wyKo9VDX0wa9_RtDdWFt/view", 
      "WA54M8750AV"));

  _productList.add(new SamsungProduct(
      "https://s7d2.scene7.com/is/image/SamsungUS/01_Dryer_Electric_DVE54M8750V_Front_Closed_Black?\$product-details-jpg\$",
      "https://drive.google.com/file/d/1CVzqNq1tPEimk_7JRgiN9UcYIIbs8-WG/view", 
      "DVE54M8750V"));

  _productList.add(new SamsungProduct(
      "https://s7d2.scene7.com/is/image/SamsungUS/01_Washer_FrontLoader_WF42H5000AW_Front_Closed_White?\$product-details-jpg\$",
      "https://drive.google.com/file/d/1ixlS47UDLY9oQzSX1xVibvQ5G3smRSKJ/view", 
      "WF42H5000AW"));

  _productList.add(new SamsungProduct(
      "https://s7d2.scene7.com/is/image/SamsungUS/01_Dryer_Electric_DV42H5000EW_Front_Closed_White?\$product-details-jpg\$",
      "https://drive.google.com/file/d/1mBUdRjTlDkxuK28pC49eQUQ5UZmFEJdB/view", 
      "DV42H5000EW"));

  _productList.add(new SamsungProduct(
      "https://s7d2.scene7.com/is/image/SamsungUS/01_Washer_FrontLoader_WF42H5200AP_Front_Closed_Silver_20171101?\$product-details-jpg\$",
      "https://drive.google.com/file/d/1BzG8Z-BFVawDGjzQBXK2ecBoxx5O4BuX/view", 
      "WF42H5200AP"));

  _productList.add(new SamsungProduct(
      "https://s7d2.scene7.com/is/image/SamsungUS/01_Dryer_Electric_DV42H5200EP_Front_Closed_Platinum?\$product-details-jpg\$",
      "https://drive.google.com/file/d/1X7vtVvD6LaG2WAu0v6PdH0NkOOgJj8sf/view", 
      "DV42H5200EP"));

  _productList.add(new SamsungProduct(
      "https://s7d2.scene7.com/is/image/SamsungUS/WF45M5500AP-A5_001_Front_Silver_020317?\$product-details-jpg\$",
      "https://drive.google.com/file/d/1Xo15vu-8XzDfsWHknEKybVuTh7vVIfut/view", 
      "WF45M5500AP"));

  _productList.add(new SamsungProduct(
      "https://s7d2.scene7.com/is/image/SamsungUS/01_Dryer_Electric_DVE45M5500P_Front_Closed_Silver?\$product-details-jpg\$",
      "https://drive.google.com/file/d/1aJJQO9AAzTS51BLk9geQ3r1t5Nfoj3vI/view", 
      "DVE45M5500P"));

  _productList.add(new SamsungProduct(
      "https://images.samsung.com/is/image/samsung/ca-washer-wf45k6200aw-wf45k6200aw-a2-001-front-white?\$PD_GALLERY_L_JPG\$",
      "https://drive.google.com/file/d/1oTvr4QY6MQ1yYc9CYm4pCcEkSk3aVRen/view", 
      "WF45K6200AW"));

  _productList.add(new SamsungProduct(
      "https://s7d2.scene7.com/is/image/SamsungUS/01_Dryer_Electric_DV45K6500EW_Front_Black_Stainless?\$product-details-jpg\$",
      "https://drive.google.com/file/d/11L0f3JSdjPFtuxsNIHi1pOi-K911_Tt0/view", 
      "DV45K6200EW"));

  _productList.add(new SamsungProduct(
      "https://s7d2.scene7.com/is/image/SamsungUS/01_Washer_FrontLoader_WF45K6500AV_Front_Closed_Pedestal_Black111617?\$product-details-jpg\$",
      "https://drive.google.com/file/d/1Wrw2VFB7ZGMl-cEkWTfyW_hiqVPhX54o/view", 
      "WF45K6500AV"));

  _productList.add(new SamsungProduct(
      "https://s7d2.scene7.com/is/image/SamsungUS/01_Dryer_Electric_DV45K6500EV_Front_Closed_Black?\$product-details-jpg\$",
      "https://drive.google.com/file/d/1oxxB8LwPwlt6aMbyk6OkpWJNotyUryDU/view", 
      "DV45K6500EV"));

  _productList.add(new SamsungProduct(
      "https://s7d2.scene7.com/is/image/SamsungUS/Pdpdefault-wf56h9100aw-a2-600x600-C1-052016?\$support-product-hero-jpg\$",
      "https://drive.google.com/file/d/1x3fbSwWzFXqnPAYXkMtZQYjr8kSs8HJB/view", 
      "WF56H9100AW"));

  _productList.add(new SamsungProduct(
      "https://s7d2.scene7.com/is/image/SamsungUS/Pdpdefault-dv56h9100gw-a2-600x600-C1-052016?\$support-product-hero-jpg\$",
      "https://drive.google.com/file/d/1O1_J0nnXJygGRmUuH163g0pMbEn56dR0/view", 
      "DV56H9100GW"));

  _productList.add(new SamsungProduct(
      "https://s7d2.scene7.com/is/image/SamsungUS/01_Washer-FlexWash_WV55M9600AV_Front_Closed_Black?\$product-details-jpg\$",
      "https://drive.google.com/file/d/1wDVMvdhK53xO7r07SK--JHDTVlI3wXDj/view", 
      "WV55M9600AV"));

  _productList.add(new SamsungProduct(
      "https://s7d2.scene7.com/is/image/SamsungUS/01_FlexDryer_Electric_DVE55M9600AV_Front_Black?\$product-details-jpg\$",
      "https://drive.google.com/file/d/1U6btoXnMRlxUJsd8P3h0_RvGFDMYyaxB/view", 
      "DVE55M9600V"));

  _productList.add(new SamsungProduct(
      "https://s7d2.scene7.com/is/image/SamsungUS/Pdpdefault-rf22k9581sr-aa-600x600-C1-052016?\$support-product-hero-jpg\$",
      "https://drive.google.com/file/d/19G-BjkzrR8-lCcRnM6vWEGE2WeQgpwXh/view", 
      "RF22K9581SG"));

  _productList.add(new SamsungProduct(
      "https://s7d2.scene7.com/is/image/SamsungUS/RF28K9070SR_01_Refrigerator_French-Door_RF28K9070SR_Front_Closed_Silver_20171024?\$product-details-jpg\$",
      "https://drive.google.com/file/d/1PDzad4nTvfgeYPD4NWs30l-_IxAvHalX/view", 
      "RF28K9070SR"));

  _productList.add(new SamsungProduct(
      "https://s7d2.scene7.com/is/image/SamsungUS/RF28M9580SG-AA_001_Front_Black?\$product-details-jpg\$",
      "https://drive.google.com/file/d/14u7VFdgJJRWkBdt658brxiKuX5usRBP6/view", 
      "RF28M9580SG"));

   _productList.add(new SamsungProduct(
      "https://s7d2.scene7.com/is/image/SamsungUS/RF28K9580_4D_with_FH?\$support-product-hero-jpg\$",
      "https://drive.google.com/file/d/1JbZ3fRH5VRyssxXAVWbV2urphIxMK_Xo/view", 
      "RF28K9580SG"));

  _productList.add(new SamsungProduct(
      "https://s7d2.scene7.com/is/image/SamsungUS/Pdpdefault-rf18hfenbsr-aa-600x600-C1-052016?\$product-details-jpg\$",
      "https://drive.google.com/file/d/1RBhCPdrrEgNtu1ZWNUdd6_cnC4WZ_gSr/view", 
      "RF18HFENBSR"));

  _productList.add(new SamsungProduct(
      "https://s7d2.scene7.com/is/image/SamsungUS/01_Refrigerator_French-Door_RF263BEAESR_Front_Closed_Silver_102417?\$product-details-jpg\$",
      "https://drive.google.com/file/d/1bqCVDnXJZtvNSBvM0QmPUZ_j7SDTc3e_/view", 
      "RF263BEAESR"));

  _productList.add(new SamsungProduct(
      "https://s7d2.scene7.com/is/image/SamsungUS/RF265BEAESR_004_Front-with-Screen_Silver?\$product-details-jpg\$",
      "https://drive.google.com/file/d/1RWQz9mtBty_V0E79i-Gc1fLC3AFc--0Y/view", 
      "RF265BEAESR"));

  _productList.add(new SamsungProduct(
      "https://s7d2.scene7.com/is/image/SamsungUS/01_Refrigerator_French-Door_RF28HFEDBSG_Front_Closed_Black?\$product-details-jpg\$",
      "https://drive.google.com/file/d/1mg2Wefs-4sA2ClenIaLy8gz-761PKeUe/view", 
      "RF28HFEDBSG"));

  _productList.add(new SamsungProduct(
      "https://s7d2.scene7.com/is/image/SamsungUS/01_Refrigerator_French-Door_RF28HMEDBSR_Front_Closed_Silver?\$product-details-jpg\$",
      "https://drive.google.com/file/d/1t93PuJtv-tlp_PUOuqPU6qa5IHiD2HAB/view", 
      "RF28HMEDBSR"));

  _productList.add(new SamsungProduct(
      "https://s7d2.scene7.com/is/image/SamsungUS/01_Refrigerator_French-Door_RF28JBEDBSG_Front_Closed_Blackjpg?\$product-details-jpg\$",
      "https://drive.google.com/file/d/19SZqsBwuE8Dwco86GPyqkAWQPQx1q-zF/view", 
      "RF28JBEDBSR"));

  _productList.add(new SamsungProduct(
      "https://s7d2.scene7.com/is/image/SamsungUS/01_Refrigerator_French-Door_RF30KMEDBSG_Front_Closed_Black?\$product-details-jpg\$",
      "https://drive.google.com/file/d/12XMDXu9KMdnhdHkzeGmqehKHPR2lGoTw/view", 
      "RF30KMEDBSG"));

  _productList.add(new SamsungProduct(
      "https://s7d2.scene7.com/is/image/SamsungUS/01_RF26HFENDWW-AA_001_Front_White?\$product-details-jpg\$",
      "https://drive.google.com/file/d/1zjqfEJ1m62BM8rGxzqoynWKC9Qf5UMEA/view", 
      "RF26HFENDSR"));

  _productList.add(new SamsungProduct(
      "https://s7d2.scene7.com/is/image/SamsungUS/01_Refrigerator_SideXSide_RS25H5111SR_Front_Closed_Silver?\$product-details-jpg\$",
      "https://drive.google.com/file/d/11YJL3VLLvLzzLGRvsZCqrK04oQN6ARzv/view", 
      "RS25H5111SR"));

  _productList.add(new SamsungProduct(
      "https://s7d2.scene7.com/is/image/SamsungUS/01_Refrigerator_SideXSide_RS25J500DSR_Front_Closed_Silver?\$product-details-jpg\$",
      "https://drive.google.com/file/d/1TkklG70yS4CAw4Tz0oOinr7pnlxIjRnN/view", 
      "RS25J500DSR"));

  _productList.add(new SamsungProduct(
      "https://s7d2.scene7.com/is/image/SamsungUS/01_Refrigerator_SideXSide_RH25H5611SR_Front_Closed_Silver?\$product-details-jpg\$",
      "https://drive.google.com/file/d/1zZBOJgyg7gtTQVA2bXxG42oU_OjXV8WW/view", 
      "RH25H5611SR"));

  _productList.add(new SamsungProduct(
      "https://s7d2.scene7.com/is/image/SamsungUS/01_Refrigerator_Top_Freezer_RT18M6215SR_Front_Closed_Silver20171026?\$product-details-jpg\$",
      "https://drive.google.com/file/d/1dbCsKjvqIEEI38R6HQX6nFwnOPvBrBoi/view", 
      "RT18M6215WW"));

  _productList.add(new SamsungProduct(
      "https://s7d2.scene7.com/is/image/SamsungUS/01_Refrigerator_Top_Freezer_RT21M6215SG_Front_Closed_Black-20171025?\$product-details-jpg\$",
      "https://drive.google.com/file/d/192juVCV1z8vgB7uFSsaVkBBZdlkOU3o8/view", 
      "RT21M6215SR"));

  _productList.add(new SamsungProduct(
      "https://s7d2.scene7.com/is/image/SamsungUS/01_Dishwasher_DW80J3020US_Front_Silver?\$product-details-jpg\$",
      "https://drive.google.com/file/d/1TWz8onnAzSMJRwZKpgAp1L0G2gB5wAFZ/view", 
      "DW80J3020US"));

  _productList.add(new SamsungProduct(
      "https://s7d2.scene7.com/is/image/SamsungUS/01_Dishwasher_DW80K5050US_Front_Silver?\$product-details-jpg\$",
      "https://drive.google.com/file/d/1nVY_bQt2cvUhrc963I38g04j4fCN42Ce/view", 
      "DW80K5050US"));

  _productList.add(new SamsungProduct(
      "https://s7d2.scene7.com/is/image/SamsungUS/01_Dishwasher_DW80M9550UG_Front_Black?\$product-details-jpg\$",
      "https://drive.google.com/file/d/1Eq9-HgLJ0S5bdc1zRnuAsxBXrw4zKbWm/view", 
      "DW80M9550UG"));

  _productList.add(new SamsungProduct(
      "https://s7d2.scene7.com/is/image/SamsungUS/Pdpdefault-dw80j7550ug-aa-600x600-C1-052016?\$product-details-jpg\$",
      "https://drive.google.com/file/d/1G6TF8pQd-8Qenvx8vZALoPknE_JV29_2/view", 
      "DW80J7550UG"));

  _productList.add(new SamsungProduct(
      "https://s7d2.scene7.com/is/image/SamsungUS/Pdpdefault-dw80f600uts-aa-600x600-C1-052016?\$product-details-jpg\$",
      "https://drive.google.com/file/d/18bi5kswnklVVv8uo5bxzDNNc63BQ9bIO/view", 
      "DW80F600UTS"));

   _productList.add(new SamsungProduct(
      "https://s7d2.scene7.com/is/image/SamsungUS/01_Microwave_OTR_ME16H702SES_Front_Closed_Silver?\$product-details-jpg\$",
      "https://drive.google.com/file/d/114Tw2j5Ez1SqaIACio_J8m98m1T0Syz1/view", 
      "ME16H702SES"));

  _productList.add(new SamsungProduct(
      "https://s7d2.scene7.com/is/image/SamsungUS/01_Microwave_OTR_ME18H704SFS_Front_Silver?\$product-details-jpg\$",
      "https://drive.google.com/file/d/1PQ2UnSbp95JDghMvAV7bJ6TyN9M07szq/view", 
      "ME18H704SFS"));

  _productList.add(new SamsungProduct(
      "https://s7d2.scene7.com/is/image/SamsungUS/01_Microwave_OTR_ME21H706MQG_Front_Black_Steel?\$product-details-jpg\$",
      "https://drive.google.com/file/d/1PgM8kU5T-9hIgw8BY9-b8ata-TbWJe4J/view", 
      "ME21H706MQS"));

  _productList.add(new SamsungProduct(
      "https://s7d2.scene7.com/is/image/SamsungUS/01_NX58K3310SS_001_Front_Silver?\$product-details-jpg\$",
      "https://drive.google.com/file/d/1CIuEIep6T-WM6NBY0yy9j-_jmP2Y08wC/view", 
      "NX58K3310SS"));

  _productList.add(new SamsungProduct(
      "https://s7d2.scene7.com/is/image/SamsungUS/01_Range_Gas_NX58H5600WSS_Front_Closed-Silver?\$product-details-jpg\$",
      "https://drive.google.com/file/d/1zzAsNtexnOP9TxARIFNvXQ-36dquJzw9/view", 
      "NX58H5600SS"));

  _productList.add(new SamsungProduct(
      "https://s7d2.scene7.com/is/image/SamsungUS/01_Range_Gas_NX58H5650WS_Front_Silver?\$product-details-jpg\$",
      "https://drive.google.com/file/d/1T4cG7q-qfmXCgzl6eVk7AP-kRv-hGwez/view", 
      "NX58H5650WS"));

  _productList.add(new SamsungProduct(
      "https://s7d2.scene7.com/is/image/SamsungUS/01_Range_Gas_Dual_Door_NX58K9850SS_Front_Closed_Silver?\$product-details-jpg\$",
      "https://drive.google.com/file/d/1lfmJR6NM3CIcnqpTcrRaLBAor7lkKXRV/view", 
      "NX58K9850SG"));

  _productList.add(new SamsungProduct(
      "https://images.samsung.com/is/image/samsung/ca-electric-range-ne58k9850ws-ne58k9850ws-ac-001-front-silver?\$PD_GALLERY_L_JPG\$",
      "https://drive.google.com/file/d/1CtrOoS-hpbtBoG0f2JTgFfw9cVgKjitD/view", 
      "NE58K9850WG"));

  _productList.add(new SamsungProduct(
      "https://images.samsung.com/is/image/samsung/ca-electric-range-ne59k3310ss-ne59k3310ss-ac-001-front-silver?\$PD_GALLERY_L_JPG\$",
      "https://drive.google.com/file/d/1Q2EY9WO3wETRcRXdO0TIMzC0SpemxxVq/view", 
      "NE59K3310SS"));

  _productList.add(new SamsungProduct(
      "https://s7d2.scene7.com/is/image/SamsungUS/01_Range_Electric_NE59M4310SS_Front_Closed_Silver?\$product-details-jpg\$",
      "https://drive.google.com/file/d/1UfueIEOYH18rxAfOKuMJz0BmxmNoWtWb/view", 
      "NE59M4310SS"));

  _productList.add(new SamsungProduct(
      "https://s7d2.scene7.com/is/image/SamsungUS/01_Range_Electric_NE59M4320SS_Front_Closed_Silver?\$product-details-jpg\$",
      "https://drive.google.com/file/d/1IbQt3bR1NrCxJ57aT7Wwjk74oVAAEZRn/view", 
      "NE59M4320SS"));
  
  _productList.add(new SamsungProduct(
      "https://s7d2.scene7.com/is/image/SamsungUS/01_Range_Electric_Dual_Door_NE59M6850SS_Front_Closed_Silver?\$product-details-jpg\$",
      "https://drive.google.com/file/d/11tpdKlM9wcB-kx2bWb0XYEXC-rVDM9uK/view", 
      "NE59M6850SS"));

  _productList.add(new SamsungProduct(
      "https://s7d2.scene7.com/is/image/SamsungUS/01_Range_Electric_Dual-Door_NE59J7850WS_Front_Closed_Silver?\$product-details-jpg\$",
      "https://drive.google.com/file/d/12B0iGb4lY55iD8E8Y-_MM6QhlzbrTd4j/view", 
      "NE59J7850WG"));

  _productList.add(new SamsungProduct(
      "https://s7d2.scene7.com/is/image/SamsungUS/Pdpdefault-ne59j3420ss-aa-600x600-C1-052016?\$product-details-jpg\$",
      "https://drive.google.com/file/d/1IG0UhfO-PLH1Pf7izmEGnzIc1xAakXWr/view", 
      "NE59J3420SS"));

  _productList.add(new SamsungProduct(
      "https://images.samsung.com/is/image/samsung/ca-electric-range-ne59j7750ws-ne59j7750ws-ac-001-front-silver?\$PD_GALLERY_L_JPG\$",
      "https://drive.google.com/file/d/1h25J3bQaDskt6c6MPXr3TuMOr3HELwAi/view", 
      "NE59J7750WS"));

  _productList.add(new SamsungProduct(
      "https://images.samsung.com/is/image/samsung/uk-robot-sr20h9050u-vr20h9050uw-eu-001-front-white?\$PD_GALLERY_L_JPG\$",
      "https://drive.google.com/file/d/1P6CENXmKu0ISuZnVRXNw8h_lZzLBPTB2/view", 
      "VR20H9050UW"));

  

  
}
