import 'package:datepicker_dropdown/datepicker_dropdown.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';
import 'package:intl/intl.dart';

class RempliPayerScreen extends StatefulWidget {
  const RempliPayerScreen({super.key});

  @override
  State<RempliPayerScreen> createState() => _RempliPayerScreenState();
}

class _RempliPayerScreenState extends State<RempliPayerScreen> {
  String _selectedDate = '';
  String _dateCount = '';
  String _range = '';
  String _rangeCount = '';

  var dateDebut = TextEditingController();
  var dateFin = TextEditingController();

  void _onSelectionChanged(DateRangePickerSelectionChangedArgs args) {
    setState(() {
      if (args.value is PickerDateRange) {
        _range =
            '${DateFormat('dd/MM/yyyy').format(args.value.startDate)} - ${DateFormat('dd/MM/yyyy').format(args.value.endDate ?? args.value.startDate)}';
        dateDebut = TextEditingController(
            text: "${DateFormat('dd/MM/yyyy').format(args.value.startDate)}");
        dateFin = TextEditingController(
            text:
                "${DateFormat('dd/MM/yyyy').format(args.value.endDate ?? args.value.startDate)}");
      }
      /*else if (args.value is DateTime) {
        _selectedDate = args.value.toString();
      } else if (args.value is List<DateTime>) {
        _dateCount = args.value.length.toString();
      } else {
        _rangeCount = args.value.length.toString();
      }*/
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(225, 239, 216, 1.0),
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          "Remplir et Payer",
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.normal,
          ),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const CircleAvatar(
            backgroundColor: Colors.white,
            child: Icon(
              Icons.arrow_back,
              color: Colors.black,
            ),
          ),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                width: 400,
                height: 200,
                decoration: const BoxDecoration(
                  color: Colors.transparent,
                  image: DecorationImage(
                    image: AssetImage("images/sal2.png"),
                    fit: BoxFit.cover,
                  ),
                  borderRadius: BorderRadius.all(
                    Radius.circular(40),
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.only(
                    left: 30.0,
                    bottom: 15,
                  ),
                  child: Column(
                    children: [
                      Spacer(),
                      Row(
                        children: [
                          Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: const [
                              Text(
                                "Appartement",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 23,
                                ),
                              ),
                              SizedBox(
                                width: 240,
                                child: AutoSizeText(
                                  "Abidjan / Cocody cité des arts rue L109",
                                  maxLines: 2,
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.normal,
                                    fontSize: 14,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Text(
                                "25.000 F",
                                style: TextStyle(
                                  color: Colors.green,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                ),
                              ),
                              Text(
                                " / nuit",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.normal,
                                  fontSize: 14,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              Gap(20),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.info_outlined,
                      color: Colors.red,
                    ),
                    Gap(10),
                    Text(
                      "Informations obligatoires",
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.normal,
                        color: Colors.red,
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      decoration: const BoxDecoration(
                        color: Color.fromRGBO(0, 0, 0, .16),
                        borderRadius: BorderRadius.all(Radius.circular(15)),
                      ),
                      child: DropdownDatePicker(
                        locale: 'fr_FR',
                        isDropdownHideUnderline: true,
                        isFormValidator: true,
                        startYear: 1900,
                        endYear: 3000,
                        width: 10,
                        selectedMonth: 01,
                        selectedYear: 2023,
                        onChangedMonth: (value) =>
                            print('onChangedMonth: $value'),
                        onChangedYear: (value) =>
                            print('onChangedYear: $value'),
                        //boxDecoration: BoxDecoration(
                        // border: Border.all(color: Colors.grey, width: 1.0)), // optional
                        showDay: false,
                        // dayFlex: 2,// optional
                        // locale: "zh_CN",// optional
                        // hintDay: 'Day', // optional
                        // hintMonth: 'Month', // optional
                        // hintYear: 'Year', // optional
                        // hintTextStyle: TextStyle(color: Colors.grey), // optional
                      ),
                    ),
                    Gap(10),
                    Container(
                      decoration: const BoxDecoration(
                        color: Color.fromRGBO(0, 0, 0, .16),
                        borderRadius: BorderRadius.all(Radius.circular(15)),
                      ),
                      child: SfDateRangePicker(
                        onSelectionChanged: _onSelectionChanged,
                        view: DateRangePickerView.month,
                        selectionMode: DateRangePickerSelectionMode.range,
                        startRangeSelectionColor: Colors.green,
                        endRangeSelectionColor: Colors.green,
                        rangeSelectionColor: Colors.lightGreen,
                        initialSelectedRange: PickerDateRange(
                          DateTime.now().subtract(
                            const Duration(days: 4),
                          ),
                          DateTime.now().add(
                            const Duration(days: 3),
                          ),
                        ),
                      ),
                    ),
                    Gap(10),
                    Column(
                      children: [
                        TextFormField(
                          controller: dateDebut,
                          textInputAction: TextInputAction.done,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                            hintText: "Début",
                            prefixIcon: Padding(
                              padding: const EdgeInsets.all(5.0),
                              child: SizedBox(
                                width: 90,
                                child: Row(
                                  children: const [
                                    Icon(Icons.date_range_outlined),
                                    Text(
                                      "Début séjour :",
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        fontSize: 10,
                                        fontWeight: FontWeight.normal,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          keyboardType: TextInputType.text,
                        ),
                        Gap(10),
                        TextFormField(
                          controller: dateFin,
                          textInputAction: TextInputAction.done,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                            hintText: "Fin",
                            prefixIcon: Padding(
                              padding: const EdgeInsets.all(5.0),
                              child: SizedBox(
                                width: 90,
                                child: Row(
                                  children: const [
                                    Icon(Icons.date_range_outlined),
                                    Text(
                                      "Fin séjour :",
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        fontSize: 10,
                                        fontWeight: FontWeight.normal,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          keyboardType: TextInputType.text,
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Container(
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(15),
            topRight: Radius.circular(15),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.only(
            left: 90.0,
            right: 90.0,
            top: 10,
            bottom: 10,
          ),
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color.fromRGBO(147, 226, 55, 1),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
            ),
            onPressed: () {},
            child: const Text(
              "Mode de paiement",
              style: TextStyle(
                fontSize: 15,
                color: Colors.black,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
