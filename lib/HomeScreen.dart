import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  TextEditingController controller=TextEditingController();
  getcountries()async{

    var url =Uri.parse("https://restcountries.eu/rest/v2/");
    var response=await http.get(url);
    var responsebody=jsonDecode(response.body);
    setState(() {
      _totalresult.clear();
      for(Map i in responsebody)
        {
          _totalresult.add(countryname.fromJson(i));
        }
    });


  }
// method to get the names of the countries from the Api
  @override
  Widget build(BuildContext context) {
    this.getcountries();
    return  Scaffold(
      appBar: AppBar(
        shadowColor: Colors.black87,
        backgroundColor: Colors.transparent,
        elevation: 30.0,
        foregroundColor: Colors.black87,
        toolbarHeight: 80,
        centerTitle: true,
        title: Text("Countries",style: TextStyle(
          color: Colors.black87,fontWeight: FontWeight.w700, fontSize: 30,
        ),),
        leading: IconButton (onPressed: (){
             print(" ");
        },icon:Icon(
          Icons.arrow_back_ios,
          color: Colors.black87,
           size: 30,
        )

        ),
        flexibleSpace: Image(
        image: AssetImage('images/contries2.jpg'),
        fit: BoxFit.cover,
          height: 250,
      ),
        // to have a background image on the Appbar

      ),
      body:Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Container(
              child: Card(
                elevation: 15.0,
                shadowColor: Colors.black87,
                child:ListTile(
                  leading:  Icon(Icons.search_off_sharp, size: 30,),
                  trailing: IconButton(
                    onPressed: (){
                       controller.clear();
                       //to clear what was written on the textfield
                       onchangedtext(" ");
                       // assign the empty string to the method to get the totalsearch result
                    },
                    icon: Icon(Icons.cancel),
                  ),
                  title: TextField(
                    onChanged: onchangedtext,
                     //calling the function
                     style:  TextStyle(
                       color: Colors.black87,fontWeight: FontWeight.w400, fontSize: 25,
                     ),
                    controller:controller,
                    decoration: InputDecoration(
                      hintText:"Search",
                      border: InputBorder.none,
                    ),
                  ),
                ),
              ),
            ),
          ),
          Expanded(child: _searchresult.length!=0||controller.text.isNotEmpty?
               ListView.builder(
                 // to get back the list as listview
                 itemCount:_searchresult.length,
                   itemBuilder:(BuildContext context,int  Index)
                       {
                         return Padding(
                           padding: const EdgeInsets.all(8.0),
                           child: Card(
                             elevation: 15.0,
                             shadowColor: Colors.amberAccent,
                             color: Colors.white,
                             child: ListTile(
                               title: Text(_searchresult[Index].name,textAlign: TextAlign.center,style: TextStyle(
                                   fontSize: 30, fontWeight: FontWeight.w500,color: Colors.black87
                               ),),
                             ),
                           ),
                         );
                       },
               ):
               ListView.builder(
            itemCount:_totalresult.length,
            itemBuilder:(BuildContext context,int  Index)
            {
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: Card(
                  elevation: 15.0,
                  shadowColor: Colors.amberAccent,
                  color: Colors.white,
                  child: ListTile(
                    title: Text(_totalresult[Index].name,textAlign: TextAlign.center,style: TextStyle(
                        fontSize: 30, fontWeight: FontWeight.w500,color: Colors.black87
                    ),),
                  ),
                ),
              );
            },
          )
          )
        ],
      ),
    );
  }
  onchangedtext(String text)
  {
    _searchresult.clear();
    //clear all data on the search result to refill it again with the wanted data
    if(text.isEmpty)
      {
        setState(() {
          return;
        });
      }
    _totalresult.forEach((element) {
      //search by each letter on the text to get all the possiblities
      if(element.name.contains(text)|| element.name.toLowerCase().contains(text.toLowerCase())||element.name.toUpperCase().contains(text.toUpperCase()))
        {
            _searchresult.add(element);
            // adding the element to the search list to display the list later on the listview builder
        }
       setState(() {
       });
//refreshing
    });
  }
}
List<countryname>_searchresult=[];
// list for the saerch text
List<countryname>_totalresult=[];
// list for the total list for the countries
class countryname{
   var name ;
  countryname({this.name});
  factory countryname.fromJson(Map<dynamic,dynamic>json)
  {
    return countryname(
      name: json["name"],
      //using this method is because tha data wanted only one variable in  the list which is the name of the country
    );
  }
 }
