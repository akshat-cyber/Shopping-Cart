import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:shared_preferences/shared_preferences.dart';
void main() {
  runApp(MaterialApp(
    home: ShopData(),
  ));
}
List<Icon> icons = [Icon(Icons.airport_shuttle),Icon(Icons.train), Icon(Icons.adb), Icon(Icons.cake)];
// ignore: non_constant_identifier_names
List<Text> NameOfProduct = [Text("Car"),Text("Train"),Text("Toy"),Text("Cake")];
// ignore: non_constant_identifier_names
List<Text> CostOfProduct = [ Text("Cost ₹3000"), Text("Cost ₹4000"), Text("Cost ₹5000"),  Text("Cost ₹300")];
List dta;
class ShopData extends StatefulWidget {
  @override
  _ShopDataState createState() => _ShopDataState();
}
class _ShopDataState extends State<ShopData> {
  // ignore: non_constant_identifier_names
  Trigger(int index) async {// saves the cart data
    SharedPreferences _shp = await SharedPreferences.getInstance();
    setState(() {
      _shp.setString("$index", NameOfProduct[index].toString());
      dta.add("$index");
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Shop now"),
        backgroundColor: Colors.black,
      ),
      body: Container(
        color: Colors.deepOrangeAccent,
        child: ListView.builder(
          itemCount: icons.length,
          itemBuilder: (BuildContext context, int index){
            return ListTile(

              leading: CircleAvatar(
                child: icons[index],
                maxRadius: 20,
              ),
              title: NameOfProduct[index],
              subtitle: CostOfProduct[index],
              trailing: FlatButton(onPressed: Trigger(index), child: Container(
                child: Icon(Icons.add_shopping_cart),
              )),
            );

          },
        ),
      ),
      floatingActionButton: FloatingActionButton
        (
        onPressed: (){
          Navigator.push(context, MaterialPageRoute(builder: (context)=>CartData()));
        },
        child: Icon(Icons.shopping_cart),
      ),
    );
  }
}
// shows the cart data
class CartData extends StatefulWidget {
  @override
  _CartDataState createState() => _CartDataState();
}

class _CartDataState extends State<CartData> {
// ignore: non_constant_identifier_names
  List Dta;
  // ignore: non_constant_identifier_names
  void DisplayCart() async {

    SharedPreferences _shp = await SharedPreferences.getInstance();
    setState(() {
      for(var i in dta) {
        Dta.add(_shp.getString("$i"));
      }
    });
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    DisplayCart();
  }
  @override
  Widget build(BuildContext context)  {
    return Scaffold(
      appBar: AppBar(
        title: Text("Your Cart"),
        leading: IconButton(
            icon: Icon(Icons.arrow_back_ios), onPressed: (){
          Navigator.pop(context);
        }),
      ),
      body: Container(
        child:  Text("$Dta"),
      ),
    );
  }
}