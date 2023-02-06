
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:salla/shared/networks/local/cache_helper.dart';
import 'file:///C:/Users/reham/IdeaProjects/salla/lib/moduls/LoginShop.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
class models {

  String img ;
  String txt1 ;
  String txt2 ;

  models(this.img,this.txt1,this.txt2);


}

class onboardingscreen extends StatefulWidget {
  @override
  _onboardingscreenState createState() => _onboardingscreenState();
}

class _onboardingscreenState extends State<onboardingscreen> {
  bool last=false;

  @override
  Widget build(BuildContext context) {
    var page = PageController();
    List<models> boardings = [

      models('assets/images/shop1.png', 'Salla', 'New whole world'),
      models('assets/images/shop2.png', 'Products', 'You can see all products inside your home'),
      models('assets/images/shop3.png', 'Save Favourites', 'Now you can save your most favourite products')




    ];
    return Scaffold(
      appBar: AppBar(

        actions: [

          TextButton(
              onPressed: (){
                cache.SaveData(key: 'OnBoarding', value: true).then((value) {

                  if(value){
                    Navigator.pushAndRemoveUntil(

                        context,
                        MaterialPageRoute(
                          builder: (context) => loginscreen(),

                        ),
                            (Route <dynamic> route) => false
                    );
                  }


                }
                );


              },
              child: Text('SKIP',style: TextStyle(color: Colors.deepOrange),)
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(30.0),
        child: Column(
          children: [
            Expanded(
              child: PageView.builder(
                onPageChanged: (int index) {
                  if(index == (boardings.length)-1)
                    {

                      setState(() {
                        last=true;
                      });

                      print('last');
                    }
                  else
                    {
                      print('not last');
                      setState(() {
                        last=false;
                      });
                    }

                },
                controller: page,
                physics: BouncingScrollPhysics(),
                  itemBuilder: (context,index) => item(boardings[index]),
                  itemCount: 3,

              ),
            ),

            SizedBox(height: 40,),
            Row(
              children: [
                SmoothPageIndicator(
                    controller: page,
                    count: boardings.length,
                  effect: ExpandingDotsEffect(
                    dotColor: Colors.grey,
                    activeDotColor: Colors.deepOrange,
                    dotHeight: 10,
                    dotWidth: 10,
                    spacing: 5.0,
                    expansionFactor:4
                  ),
                ),
                Spacer(),
                FloatingActionButton(
                  onPressed: (){


                    if(last==true)
                      {

                        cache.SaveData(key: 'OnBoarding', value: true).then((value) {
                          if(value){
                            Navigator.pushAndRemoveUntil(

                                context,
                                MaterialPageRoute(
                                  builder: (context) => loginscreen(),

                                ),
                                    (Route <dynamic> route) => false

                            );

                          }

                        }

                        );

                      }
                    else
                      {
                        page.nextPage(
                            duration: Duration(milliseconds: 750),
                            curve: Curves.fastLinearToSlowEaseIn
                        );
                      }



                  },
                  child: Icon(Icons.arrow_forward_ios),

                )
              ],
            )
          ],
        ),
      ),




    );
  }

  Widget item(models model) => Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [

      Expanded(child: Padding(
        padding: const EdgeInsets.only(top: 30),
        child: Image(image: AssetImage('${model.img}')),
      )),
      Text('${model.txt1}',style: TextStyle(
        fontWeight: FontWeight.bold,
        fontFamily: 'Cfont',
        fontSize: 20.0,
      ),),
      SizedBox(height: 30,),
      Text('${model.txt2}',style: TextStyle(
        fontWeight: FontWeight.w600,
        fontFamily: 'Cfont',
        fontSize: 18.0,
      ),),
      SizedBox(height: 20,),



    ],

  );
}
