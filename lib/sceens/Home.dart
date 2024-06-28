import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:machine_test/widgets/App%20Text.dart';
import 'package:machine_test/widgets/App%20container.dart';
import '../constant/colors.dart';
import '../sceens/Register page.dart';

class PatientListPage extends StatefulWidget {
  final String token;

  PatientListPage({required this.token});

  @override
  _PatientListPageState createState() => _PatientListPageState();
}

class _PatientListPageState extends State<PatientListPage> {
  List<dynamic> _patients = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _fetchPatients();
  }

  Future<void> _fetchPatients() async {
    final response = await http.get(
      Uri.parse('https://flutter-amr.noviindus.in/api/PatientList'),
      headers: {
        'Authorization': 'Bearer ${widget.token}',
      },
    );

    if (response.statusCode == 200) {
      final List<dynamic> patients = json.decode(response.body);
      setState(() {
        _patients = patients;
        _isLoading = false;
      });
    } else {
      // Handle error
      setState(() {
        _isLoading = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to load patients')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: white,
      // appBar: AppBar(
      //   title: Text('Patient List'),
      //   actions: [
      //     IconButton(
      //       icon: Icon(Icons.add),
      //       onPressed: () {
      //         Navigator.push(
      //           context,
      //           MaterialPageRoute(
      //             builder: (context) =>
      //                 RegisterPatientPage(token: widget.token),
      //           ),
      //         );
      //       },
      //     ),
      //   ],
      // ),
      body: Column(
        children: [
          Padding(
            padding:
                const EdgeInsets.only(left: 20, right: 20, top: 50, bottom: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: Icon(
                      Icons.arrow_back,
                      size: 25,
                    )),
                Image.asset('assets/notification.png'),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              children: [
                Expanded(
                  child: SizedBox(
                    height: 40,
                    child: TextFormField(
                      decoration: InputDecoration(
                          prefixIcon: Icon(
                            Icons.search,
                            color: Colors.grey,
                          ),
                          hintText: 'Search for treatments',
                          hintStyle: GoogleFonts.inter(
                              fontWeight: FontWeight.w300,
                              fontSize: 14,
                              color: Colors.grey),
                          contentPadding: EdgeInsets.symmetric(
                              vertical: 10, horizontal: 15),
                          focusedBorder: OutlineInputBorder(
                            borderSide: const BorderSide(color: Colors.grey),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide: const BorderSide(color: Colors.grey),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          border: const OutlineInputBorder()),
                    ),
                  ),
                ),
                SizedBox(
                  width: 15,
                ),
                Container(
                  height: 40,
                  width: 90,
                  decoration: BoxDecoration(
                      color: green, borderRadius: BorderRadius.circular(9)),
                  child: Center(
                      child: AppText(
                    text: 'Search',
                    size: 12,
                    textcolor: white,
                    weight: FontWeight.w500,
                  )),
                )
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                AppText(
                    text: 'Sort by :',
                    size: 16,
                    weight: FontWeight.w500,
                    textcolor: grayblack),
                Container(
                  width: 169,
                  height: 39,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(90),
                      border: Border.all(color: Colors.grey)),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        AppText(
                            text: 'Date',
                            size: 15,
                            weight: FontWeight.w400,
                            textcolor: grayblack),
                        Icon(
                          Icons.keyboard_arrow_down,
                          color: grayblack,
                        )
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
          Divider(
            height: 2,
            color: Colors.grey[300],
          ),
          Expanded(
            child: ListView.builder(
              itemBuilder: (context, index) {
                return Padding(
                  padding:
                      const EdgeInsets.only(left: 20, right: 20, bottom: 20),
                  child: Container(
                    height: 166,
                    decoration: BoxDecoration(
                        color: Color(0xffF1F1F1),
                        borderRadius: BorderRadius.circular(10)),
                    child: Padding(
                      padding: const EdgeInsets.only(
                        top: 20,
                      ),
                      child: Column(
                        children: [
                          Expanded(
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 20),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  AppText(
                                      text: '1.',
                                      size: 18,
                                      weight: FontWeight.w500,
                                      textcolor: black),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Expanded(
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        AppText(
                                            text: 'Vikram Singh',
                                            size: 18,
                                            weight: FontWeight.w500,
                                            textcolor: Colors.black),
                                        AppText(
                                            text:
                                                'Couple Combo Package (Rejuven)',
                                            size: 16,
                                            weight: FontWeight.w300,
                                            textcolor: green),
                                        Row(
                                          children: [
                                            Icon(
                                              Icons.calendar_month_outlined,
                                              color: Colors.red,
                                              size: 15,
                                            ),
                                            AppText(
                                                text: ' 31/01/2024',
                                                size: 15,
                                                weight: FontWeight.w400,
                                                textcolor: Colors.grey),
                                            SizedBox(
                                              width: 20,
                                            ),
                                            Icon(
                                              Icons.group_outlined,
                                              color: Colors.red,
                                              size: 15,
                                            ),
                                            AppText(
                                                text: ' Jithesh',
                                                size: 15,
                                                weight: FontWeight.w400,
                                                textcolor: Colors.grey),
                                          ],
                                        )
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Divider(
                            height: 2,
                            color: Colors.grey[300],
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                                top: 10, bottom: 10, left: 40, right: 20),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                AppText(
                                    text: 'View Booking details',
                                    size: 16,
                                    weight: FontWeight.w300,
                                    textcolor: black),
                                Icon(
                                  Icons.arrow_forward_ios,
                                  size: 15,
                                  color: green,
                                )
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                );
              },
              itemCount: 15,
            ),
          )
        ],
      ),
      bottomNavigationBar: BottomAppBar(
        color: white,
        child: GestureDetector(
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) =>
                      RegisterPatientPage(token: widget.token),
                ));
          },
          child: MyContainer(
            text: Text(
              'Register Now',
              style: GoogleFonts.poppins(
                  fontWeight: FontWeight.w600, fontSize: 17, color: white),
            ),
          ),
        ),
      ),
    );
  }
}
