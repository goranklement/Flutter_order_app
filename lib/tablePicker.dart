import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:qr/colors.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:multi_select_flutter/multi_select_flutter.dart';
import 'package:qr/order.dart';
import 'package:qr/waiter.dart';

class TablePicker extends StatefulWidget {
  const TablePicker({super.key});

  @override
  State<TablePicker> createState() => _TablePickerState();
}

class _TablePickerState extends State<TablePicker> {
  final inputController= TextEditingController();
  static List<int> _possibleNumbers= [];
  List<int> _helpNumbers=[];
  List<int> _selectedNumbers = [];

  List<MultiSelectItem<int>> _items = _possibleNumbers.map((number) => MultiSelectItem<int>(number, number.toString())).toList();

double _currentSliderValue = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(

        body: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Container(
      
              color: getColor(0xff54e39e),
              child: Column(
                children: [
                Text("Select number of tables", 
                style: GoogleFonts.lobster(
    fontSize: 25,
  ),
                ),
                SizedBox(
                  
                  width: 90,
                  child: TextField(
                    controller: inputController,
                    onChanged: (value) {
                      double broj=double.parse(value);
                      if(broj<0 || broj>100){
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar
     (
      duration: Duration(seconds: 5),
      backgroundColor: getColor(0xff18544b),
      content: Text("Number should be in range (0-100)")));
                      }
                      else {
                setState(() {
                                      
                                      _currentSliderValue = broj;
                                      addNumbers(broj.toStringAsFixed(0));
                                    });

                      }
                    

                    },
                     

                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                    ),
                    keyboardType: TextInputType.number,
                     decoration: InputDecoration(
                      hintText: "0",
                  border: OutlineInputBorder(),
                filled: true,
                fillColor: getColor(0xff76f5b7)
              ),
                  ),
                ),
            SizedBox(height: 40,),
                  Slider(
        value: _currentSliderValue,
        max: 100,
        divisions: 100,
        label: _currentSliderValue.round().toString(),
        onChanged: (double value) {
          setState(() {
                  _currentSliderValue = value;
                  inputController.value= TextEditingValue(text: _currentSliderValue.toStringAsFixed(0));
                  addNumbers(_currentSliderValue.toStringAsFixed(0));
          });
        },
      ),
                ],
              ),
            ),
             MultiSelectDialogField(
              searchable: true,
                items: _items,
                selectedColor: Colors.blue,
                decoration: BoxDecoration(
                  color: Colors.blue.withOpacity(0.1),
                  borderRadius: BorderRadius.all(Radius.circular(40)),
                  border: Border.all(
                    color: Colors.blue,
                    width: 2,
                  ),
                ),
                buttonIcon: Icon(
                  Icons.checklist_rounded,
                  color: Colors.blue,
                  size: 40,
                ),
                buttonText: Text(
                  "Pick table nubers You serve",
                  style: TextStyle(
                    color: Colors.blue[800],
                    fontSize: 16,
                  ),
                ),
                onConfirm: (results) {
                  _selectedNumbers = results;
                },),
                ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      shadowColor: getColor(0xff278a3c),
                        elevation: 15,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(25),
                        ),
                        foregroundColor: getColor(0xff82ff9d),
                        backgroundColor: getColor(0xff345e3a)),
                    onPressed: () {
                        Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => OrderView( numbers: _selectedNumbers,
                                
                                )),
                      );

                    },
                    child: Text("Continue")),
                    ],
                
        ),
    );
  }
  
  void addNumbers(String max) {
    _helpNumbers.clear();
    _possibleNumbers.clear();
      int maxic=int.parse(max);     
         int i=1;
         for(i;i<=maxic;i++){
          _helpNumbers.add(i);
      }
      setState(() {
        _possibleNumbers=_helpNumbers;
        
      _items = _possibleNumbers.map((number) => MultiSelectItem<int>(number, number.toString())).toList();
      });
      
      
     


  }
 

}