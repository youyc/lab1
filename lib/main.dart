import 'package:flutter/material.dart';
 
void main() => runApp(MyApp());
 
class MyApp extends StatefulWidget {
  _BMRCalulator createState() => _BMRCalulator();  
}

class _BMRCalulator extends State<MyApp>{
  List<String> _bmrEquationList = ["Mifflin - St Jeor", "Harris-Benedict"];
  String _selectedBmrEquation = "Mifflin - St Jeor";
  List<String> _genderList = ['Male', 'Female'];
  String _selectedGender = 'Male';
  double _age = 0;
  double _cm = 0;
  double _kg = 0;
  double _bmrResult = 0;
  String _error = "";
  final TextEditingController _ageController = TextEditingController();
  final TextEditingController _cmController = TextEditingController();
  final TextEditingController _kgController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Material App',
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        resizeToAvoidBottomPadding: false,

        appBar: AppBar(
          centerTitle: true,
          title: Text('BMR Calculator', style: TextStyle(fontSize: 30, color: Colors.lightBlue[50]))
        ),
        body: Container(
          color: Colors.grey[50],
          child: Column(
          children: <Widget>[
            Align(
              alignment: Alignment.topLeft,
              child: Text(_error, style: TextStyle(color: Colors.red, fontSize: 25, fontWeight: FontWeight.bold))
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(15, 20, 15, 0), 
              child: SizedBox(
                width: 300,
                height: 100,
                child: Center(
                  child: Container(
                    child: Text(_bmrResult.toStringAsFixed(0), style: TextStyle(fontSize: 80)),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.black, width: 1),
                    )
                  )
                )
              )
            ),

            Align(
              alignment: Alignment.center, 
              child: Text("Your BMR", style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold))
            ),

            Padding(
              padding: EdgeInsets.fromLTRB(26, 23, 15, 0), 
              child: Row(
                children: <Widget>[
                  Align(
                    alignment: Alignment.topLeft, 
                    child: Text("BMR Equation", style: TextStyle(color: Colors.blue, fontSize: 22, fontWeight: FontWeight.w500))
                  ),
                  SizedBox(width: 25),
                  Align(
                    alignment: Alignment.topLeft, 
                    child: DropdownButton(
                      value: _selectedBmrEquation,
                      style: TextStyle(color: Colors.black, fontSize: 20),  
                      items: _bmrEquationList.map((String bmrEquationItems){
                        return DropdownMenuItem<String>(
                          value: bmrEquationItems,
                          child: Text(bmrEquationItems)
                        );
                      }).toList(),
                      onChanged: _bmrEquationOnChanged
                    ),
                  ),
                ]
              ),
            ),
            
            Padding(
              padding: EdgeInsets.fromLTRB(26, 0, 15, 0), 
              child: Row(
                children: <Widget>[
                  Align(
                    alignment: Alignment.topLeft,
                    child: Text("Gender", style: TextStyle(color: Colors.blue, fontSize: 22, fontWeight: FontWeight.w500))
                  ),
                  SizedBox(width: 94),
                  Align(
                    alignment: Alignment.topLeft,
                    child: DropdownButton(
                      value: _selectedGender,
                      style: TextStyle(color: Colors.black, fontSize: 20), 
                      items: _genderList.map((String genderItems){
                        return DropdownMenuItem<String>(
                          value: genderItems,
                          child: Text(genderItems)
                        );
                      }).toList(),
                      onChanged: _genderOnChanged
                    )
                  ),
                ]
              ),
            ),

            Padding(
              padding: EdgeInsets.fromLTRB(15, 5, 15, 5), 
              child: TextFormField(
                keyboardType: TextInputType.number,
                controller: _ageController,      
                decoration: InputDecoration(
                  labelText: 'Enter Age', 
                  labelStyle: TextStyle(color: Colors.blue, fontSize: 22, fontWeight: FontWeight.w500),
                  border: OutlineInputBorder(   
                    borderSide: BorderSide()
                  )
                )
              ),
            ),

            Padding(
              padding: EdgeInsets.fromLTRB(15, 5, 15, 5), 
              child: TextFormField(
                keyboardType: TextInputType.number,
                controller: _cmController,      
                decoration: InputDecoration(
                  labelText: 'Enter Height', 
                  labelStyle: TextStyle(color: Colors.blue, fontSize: 22, fontWeight: FontWeight.w500),
                  suffixText: "cm",
                  suffixStyle: TextStyle(fontSize: 20, color: Colors.grey),
                  border: OutlineInputBorder(   
                    borderSide: BorderSide()
                  )
                )
              ),
            ),

            Padding(
              padding: EdgeInsets.fromLTRB(15, 5, 15, 5), 
              child: TextFormField(
                keyboardType: TextInputType.number,
                controller: _kgController,      
                decoration: InputDecoration(
                  labelText: 'Enter Weight', 
                  labelStyle: TextStyle(color: Colors.blue, fontSize: 22, fontWeight: FontWeight.w500),
                  suffixText: "kg",
                  suffixStyle: TextStyle(fontSize: 20, color: Colors.grey),
                  border: OutlineInputBorder(   
                    borderSide: BorderSide()
                  )
                )
              ),
            ),

            Padding(
              padding: EdgeInsets.fromLTRB(15, 20, 15, 0), 
              child: Align(
                alignment: Alignment.topRight,
                child: SizedBox(
                  width: 178,
                  height: 45,
                  child: RaisedButton(
                    child: Text("Calculate BMR", style: TextStyle(fontSize: 22)),
                    textColor: Colors.lightBlue[50],          
                    color: Colors.blue,          
                    splashColor: Colors.deepPurple,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                    onPressed: _onPress,
                  )
                )
              )
            ),

          ]
        )
      )
      )
    );
  }

  void _bmrEquationOnChanged(String value){
    setState(() {
      this._selectedBmrEquation = value;
    });
  }

  void _genderOnChanged(String value){
    setState(() {
      this._selectedGender = value;
    });
  }

  void _onPress(){
    setState(() {
      
      if (_ageController.text != ""  && _cmController.text != "" && _kgController.text != ""){
      this._age = double.parse(_ageController.text);
      this._cm = double.parse(_cmController.text);
      this._kg = double.parse(_kgController.text);

      if (_selectedBmrEquation == "Mifflin - St Jeor" && _selectedGender == "Male")
        this._bmrResult = (10 * _kg) + (6.25 * _cm) - (5 * _age) + 5;
      else if (_selectedBmrEquation == "Harris-Benedict" && _selectedGender == "Male")
        this._bmrResult = 66.47 + (13.75 * _kg) + (5.003 * _cm) - (6.755 * _age);
      else if (_selectedBmrEquation == "Mifflin - St Jeor" && _selectedGender == "Female")
        this._bmrResult = (10 * _kg) + (6.25 * _cm) - (5 * _age) - 161;
      else if (_selectedBmrEquation == "Harris-Benedict" && _selectedGender == "Female")
        this._bmrResult = 655.1 + (9.563 * _kg) + (1.85 * _cm) - ( 4.676 * _age);

      this._error =  "";
      }
      else{
        this._error =  "Please fill in all the information" ;
        this._bmrResult = 0;
      }
    });
  }

}
