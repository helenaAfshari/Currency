import 'package:arz_digital/Model/Currency.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;
import 'dart:developer' as developer;
import 'package:intl/intl.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale('fa', ''), // English, no country code
      ],
      theme: ThemeData(
          fontFamily: 'verdana',
          textTheme: const TextTheme(
              headline1: TextStyle(
                fontFamily: 'verdana',
                fontSize: 16,
                fontWeight: FontWeight.w700,
              ),
              bodyText1: TextStyle(
                fontFamily: 'verdana',
                fontSize: 13,
                fontWeight: FontWeight.w300,
              ),
              headline2: TextStyle(
                fontFamily: 'verdana',
                color: Colors.white,
                fontSize: 14,
                fontWeight: FontWeight.w300,
              ),
              
               headline3: TextStyle(
                fontFamily: 'verdana',
                color: Colors.red,
                fontSize: 14,
                fontWeight: FontWeight.w700),

                 headline4: TextStyle(
                fontFamily: 'verdana',
                color: Colors.green,
                fontSize: 14,
                fontWeight: FontWeight.w700),
              )),
      debugShowCheckedModeBanner: false,
      home: Home(),
    );
  }
}

//این متد برای scafoldهست
//ووbodyهست
class Home extends StatefulWidget {
  Home({
    Key? key,
  }) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<Currency> currency = [];

//یک uilرا گرفته از سرور و داخل uiریخته
//itemهارا مقداردهی کردیم
 Future getResponse(BuildContext cntx) async {
    var url = "http://sasansafari.com/flutter/api.php?access_key=flutter123456";
   
    developer.log("getResponse", name: "wlifeCycle");

   var value = await http.get(Uri.parse(url));

      

      if (currency.isEmpty) {
        if (value.statusCode == 200) {
            _showSnackBar(context,"به روزرسانی اطلاعات با موفقیت انجام شد");
          List jsonList = convert.jsonDecode(value.body);
          
          //برای این که لیست ببینیم خالی هست یانه که خالی نباشد لیست
          if (jsonList.length > 0) {
            //باید لیست پیمایش بشه
            for (int i = 0; i < jsonList.length; i++) {
              setState(() {
                //اینجا مدلی که از currencyساختیم و میخواهیم پرش کنیم
                currency.add(Currency(
                  id: jsonList[i]["id"],
                  title: jsonList[i]["title"],
                  price: jsonList[i]["price"],
                  changes: jsonList[i]["changes"],
                  status: jsonList[i]["status"],
                ));
              });
            }
          }
        }
      }

      return value;
    
  }

     @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getResponse(context);
      developer.log("initState",name: "wlifeCycle");
  }
      
      @override
  void didUpdateWidget(covariant Home oldWidget) {
    // TODO: implement didUpdateWidget
    super.didUpdateWidget(oldWidget);
     developer.log("didUpdateWidget",name: "wlifeCycle");
  }

    @override
  void deactivate() {
    // TODO: implement deactivate
    super.deactivate();
      developer.log("deactivate",name: "wlifeCycle");
  }

    @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
    developer.log("didChangeDependencies",name: "wlifeCycle");
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
     developer.log("dispose",name: "wlifeCycle");
  }


  @override
  Widget build(BuildContext context) {
    
  
    developer.log("build", name: "wlifeCycle");

    var rtl;
    return Scaffold(
        backgroundColor: Color.fromARGB(255, 125, 138, 138),
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.grey,
          actions: [
            Align(
                alignment: Alignment.centerRight,
                child: Text(
                  "قیمت به روز سکه و ارز",
                  style: Theme.of(context).textTheme.headline1,
                )),
            Image.asset("assets/images/icon.png"),
            const SizedBox(
              width: 8,
            ),
            Expanded(
                child: Align(
              alignment: Alignment.centerLeft,
              child: Image.asset("assets/images/menu.png"),
            )),
          ],
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Image.asset("assets/images/qq.png"),
                    const SizedBox(
                      width: 8,
                    ),
                    Text(
                      "نرخ ارز ازاد چیست",
                      style: Theme.of(context).textTheme.bodyText1,
                    ),
                  ],
                ),

                const SizedBox(
                  height: 12,
                ),
                Text(
                  "نرخ ارزها درمعاملات نقدی و رایج روزانه است  معاملات نقدی معاملاتی هستند که خریدار و فروشنده به محض انجام معامله  ارز و ریال را باهم تبادل مینمایند.",
                  style: Theme.of(context).textTheme.bodyText1,
                  
                ),

                Padding(
                  padding: const EdgeInsets.fromLTRB(6, 7, 7, 7),
                  child: Container(
                    height: 35,
                    width: double.infinity,
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.all((Radius.circular(50))),
                      color: const Color.fromARGB(255, 130, 130, 130),
                    ),
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Text(
                            "نام ازاد ارز",
                            style: Theme.of(context).textTheme.headline2,
                          ),
                          Text(
                            "قیمت",
                            style: Theme.of(context).textTheme.headline2,
                          ),
                          Text(
                            "تغییر",
                            style: Theme.of(context).textTheme.headline2,
                          ),
                        ]),
                  ),
                ),
                //list
                SizedBox(
                    width: double.infinity,
                    height: MediaQuery.of(context).size.height/2,
                    child: listFutureBuilder(context)),

                //update Button Box
                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 12, 0, 0),
                  child: Container(
                    width: double.infinity,
                    height: MediaQuery.of(context).size.height/16,
                    decoration: BoxDecoration(
                        color: Color.fromARGB(255, 200, 197, 221),
                        borderRadius: BorderRadius.circular(1000)),
                    //اینجا  onpresedرا به صورت آنانیموس تعریف کردیم یعنی ناشناخته
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        //update btn
                        SizedBox(
                          height: MediaQuery.of(context).size.height/16,
                          child: TextButton.icon(
                              style: ButtonStyle(
                                  backgroundColor: MaterialStateProperty.all(
                                      Color.fromARGB(255, 89, 84, 117)),
                                  shape: MaterialStateProperty.all<
                                          RoundedRectangleBorder>(
                                      RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(1000)))),
                              onPressed: () {
                              
                              //اینجا لیست را پاک میکنه و دوباره میتونه اجرا کند
                              currency.clear();

                              listFutureBuilder(context);

                              },
                              
                              
                            
                              icon: const Icon(
                                CupertinoIcons.refresh,
                                color: Colors.deepOrange,
                              ),
                              label: Padding(
                                padding: const EdgeInsets.fromLTRB(
                                  8,
                                  0,
                                  0,
                                  0,
                                ),
                                child: Text(
                                  "به روزرسانی",
                                  style: Theme.of(context).textTheme.headline2,
                                ),
                              )),
                        ),
                        Text("اخرین به روزرسانی ${_getTime()}"),
                        const SizedBox(
                          width: 8,
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ));
  }

  FutureBuilder<dynamic> listFutureBuilder(BuildContext context) {
    return FutureBuilder(
                    builder: (context, snapshot) {
                      return snapshot.hasData?
                       ListView.separated(
                      itemCount: currency.length,
                      itemBuilder: (BuildContext context, int position) {
                        return Padding(
                          padding: const EdgeInsets.fromLTRB(0, 8, 0, 0),
                          child: MyItem(position, currency),
                        );
                      },
                      separatorBuilder: (BuildContext context, int index) {
                        //اینجا میگیم که باقی مانده 9 باشه یعنی 9تا9تا تبلیغ بزاره تو لیست
                        if (index % 9 == 0) {
                          return const Padding(
                            padding: EdgeInsets.fromLTRB(0, 8, 0, 0),
                            child: add(),
                          );
                        } else {
                          return SizedBox.shrink();
                        }
                      },
                    ):const Center(child: CircularProgressIndicator(),);

                    },
                    future: getResponse(context),
                  );
  }

   String _getTime() {

   DateTime now = DateTime.now();
    
    return DateFormat('kk:mm:ss').format(now);
 
}
     
}


//snackBar
void _showSnackBar(BuildContext context, String msg) {
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    content: Text(
      msg,
      style: Theme.of(context).textTheme.headline1,
    ),
    backgroundColor: Color.fromARGB(255, 124, 79, 175),
  ));
}

//در اینجا میگیم میخواهیم تبلیغ بندازیم بین لیست
class add extends StatelessWidget {
  const add({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 50,
      decoration: BoxDecoration(boxShadow: const <BoxShadow>[
        BoxShadow(blurRadius: 1.0, color: Colors.grey)
      ], color: Colors.red, 
      borderRadius: BorderRadius.circular(1000)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Text(
            "تبلیغات",
            style: Theme.of(context).textTheme.bodyText1,
          ),
        ],
      ),
    );
  }
}

//ایتم هایی که در لیست هست
class MyItem extends StatelessWidget {
  int position;
  List<Currency> currency;

  MyItem(this.position, this.currency);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 50,
      decoration: BoxDecoration(boxShadow: const <BoxShadow>[
        BoxShadow(blurRadius: 1.0, color: Colors.grey)
      ], color: Colors.white, borderRadius: BorderRadius.circular(1000)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Flexible(
            fit: FlexFit.tight,
            flex: 1,
            
            child:
          Text(
            currency[position].title.toString(),
            style: Theme.of(context).textTheme.bodyText1,
            textAlign: TextAlign.center,
          ),
          ),
          Flexible(
            fit: FlexFit.tight,
            flex: 1,
            child: 
          Text(
            getFarsiNumber(currency[position].price.toString()),
            style: Theme.of(context).textTheme.bodyText1,
             textAlign: TextAlign.center,
          ),
          ),
          Flexible(
             fit: FlexFit.tight,
            flex: 1,
            child: 
          Text(
            getFarsiNumber(currency[position].changes.toString()),
            
            //:یعنی در غیر اینصورت
            style:currency[position].status=="n"
            ? Theme.of(context).textTheme.headline3 
            :Theme.of(context).textTheme.headline4,
             textAlign: TextAlign.center,
          ),
          ),
        ],
      ),
    );
  }
}

//این تابع عدد را بگیریم و تبدیل کنیم به فارسی  و returnکنم
String getFarsiNumber(String number){ 
  
  
 const en = ['0', '1', '2', '3', '4', '5', '6', '7' , '8','9'];
 const fa = ['۰', '۱', '۲', '۳', '۴', '۵', '۶', '۷' , '۸','۹'];
  
   en.forEach((element) { 

     number = number.replaceAll(element, fa[en.indexOf(element)]);
      
   });

  return number;


}