import 'package:ahio/home/paiement/mode_paiement.dart';
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

  final _formkey = GlobalKey<FormState>();

  final _snackBar = const SnackBar(
    content:
        Text('Les dates début séjour et fin séjour doivent être sélectionner'),
    backgroundColor: Colors.red,
  );

  var dateDebut = TextEditingController();
  var dateFin = TextEditingController();
  late DateTime minDate;

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
  void initState() {
    super.initState();
    minDate = DateTime.now();
  }

  void onSelectionChanged(DateRangePickerSelectionChangedArgs args) {
    setState(() {
      minDate = DateTime.now();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formkey,
      child: Scaffold(
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
                    padding: EdgeInsets.only(
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
                              children: [
                                Text(
                                  "Appartement",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 23,
                                  ),
                                ),
                                SizedBox(
                                  width: 200,
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
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18,
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
                const Gap(20),
                Padding(
                  padding: EdgeInsets.all(8.0),
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
                  padding: const EdgeInsets.all(25.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      /*Container(
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
                      ),*/
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
                          minDate: minDate,
                        ),
                      ),
                      const Gap(10),
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
                                padding: EdgeInsets.all(5.0),
                                child: SizedBox(
                                  width: 100,
                                  child: Row(
                                    children: [
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
                            validator: (value) {
                              if (value!.isEmpty) {
                                return "Veuillez sélectionner la date de début séjour";
                              } else {
                                return null;
                              }
                            },
                          ),
                          const Gap(10),
                          TextFormField(
                            controller: dateFin,
                            textInputAction: TextInputAction.done,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20),
                              ),
                              hintText: "Fin",
                              prefixIcon: Padding(
                                padding: EdgeInsets.all(5.0),
                                child: SizedBox(
                                  width: 90,
                                  child: Row(
                                    children: [
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
                            validator: (value) {
                              if (value!.isEmpty) {
                                return "Veuillez sélectionner la date de fin séjour";
                              } else {
                                return null;
                              }
                            },
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
              onPressed: () async {
                if (_formkey.currentState!.validate()) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const ModePaiementScreen(),
                    ),
                  );
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(_snackBar);
                }
              },
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
      ),
    );
  }
}
