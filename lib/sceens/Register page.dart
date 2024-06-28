import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:machine_test/widgets/Text%20FormField.dart';
import '../constant/colors.dart';
import '../widgets/App Text.dart';
import '../widgets/App container.dart';

class RegisterPatientPage extends StatefulWidget {
  final String token;

  RegisterPatientPage({required this.token});

  @override
  _RegisterPatientPageState createState() => _RegisterPatientPageState();
}

class _RegisterPatientPageState extends State<RegisterPatientPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _executiveController = TextEditingController();
  final TextEditingController _paymentController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _totalAmountController = TextEditingController();
  final TextEditingController _discountAmountController =
      TextEditingController();
  final TextEditingController _advanceAmountController =
      TextEditingController();
  final TextEditingController _balanceAmountController =
      TextEditingController();
  String? _selectedBranch;
  String? _selectedLocation;
  List<String> _selectedMaleTreatments = [];
  List<String> _selectedFemaleTreatments = [];
  List<String> _selectedTreatments = [];
  bool _isLoading = false;
  TextEditingController dobController = TextEditingController();

  final List<String> _locations = [
    'Kozhikode',
    'Alappuzha',
    'Malappuram',
    'Ernakulam',
    'Kannur',
  ];
  final List<String> _branches = ['Branch 1', 'Branch 2', 'Branch 3'];
  // final List<String> _treatments = ['Treatment 1', 'Treatment 2', 'Treatment 3'];

  Future<void> _registerPatient() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _isLoading = true;
      });

      try {
        final response = await http.post(
          Uri.parse('https://flutter-amr.noviindus.in/api/PatientUpdate'),
          headers: {
            'Authorization': 'Bearer ${widget.token}',
            'Content-Type': 'application/json',
          },
          body: json.encode({
            'name': _nameController.text,
            'executive': _executiveController.text,
            'payment': _paymentController.text,
            'phone': _phoneController.text,
            'address': _addressController.text,
            'total_amount': double.parse(_totalAmountController.text),
            'discount_amount': double.parse(_discountAmountController.text),
            'advance_amount': double.parse(_advanceAmountController.text),
            'balance_amount': double.parse(_balanceAmountController.text),
            'date_nd_time': DateTime.now().toIso8601String(),
            'id': '',
            'male': _selectedMaleTreatments.join(','),
            'female': _selectedFemaleTreatments.join(','),
            'branch': _selectedBranch,
            'treatments': _selectedTreatments.join(','),
          }),
        );

        setState(() {
          _isLoading = false;
        });

        if (response.statusCode == 200) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Patient registered successfully')),
          );
          // Navigate to PDF generation page or handle accordingly
        } else {
          final errorData = json.decode(response.body);
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
                content: Text(
                    'Failed to register patient: ${errorData['message']}')),
          );
        }
      } catch (error) {
        setState(() {
          _isLoading = false;
        });
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('An error occurred: $error')),
        );
      }
    }
  }

  int _selectedValue = 0;

  void _handleRadioValueChange(int? value) {
    setState(() {
      _selectedValue = value!;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
          surfaceTintColor: white,
          backgroundColor: white,
          title: AppText(
              text: 'Register',
              size: 24,
              weight: FontWeight.w600,
              textcolor: grayblack)),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                AppText(
                    text: 'Name',
                    size: 16,
                    weight: FontWeight.w400,
                    textcolor: grayblack),
                SizedBox(
                  height: 5,
                ),
                AppTextForm(
                    hintText: 'Enter your full name',
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter a name';
                      }
                      return null;
                    },
                    controller: _nameController),
                SizedBox(
                  height: 20,
                ),
                AppText(
                    text: 'Whatsapp Number',
                    size: 16,
                    weight: FontWeight.w400,
                    textcolor: grayblack),
                SizedBox(
                  height: 5,
                ),
                AppTextForm(
                    hintText: 'Enter your Whatsapp number',
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter phone number';
                      }
                      return null;
                    },
                    controller: _phoneController),
                SizedBox(
                  height: 20,
                ),
                AppText(
                    text: 'Address',
                    size: 16,
                    weight: FontWeight.w400,
                    textcolor: grayblack),
                SizedBox(
                  height: 5,
                ),
                AppTextForm(
                    hintText: 'Enter your full address',
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter address';
                      }
                      return null;
                    },
                    controller: _addressController),
                SizedBox(
                  height: 20,
                ),
                AppText(
                    text: 'Location',
                    size: 16,
                    weight: FontWeight.w400,
                    textcolor: grayblack),
                SizedBox(
                  height: 5,
                ),
                DropdownButtonFormField2<String>(
                  value: _selectedLocation,
                  items: _locations.map((location) {
                    return DropdownMenuItem(
                      value: location,
                      child: Text(location),
                    );
                  }).toList(),
                  onChanged: (newValue) {
                    setState(() {
                      _selectedLocation = newValue;
                    });
                  },
                  validator: (value) {
                    if (value == null) {
                      return 'Please select a location';
                    }
                    return null;
                  },
                  isExpanded: true,
                  decoration: InputDecoration(
                      fillColor: Color(0xffF1F1F1),
                      filled: true,
                      hintText: 'Enter your full address',
                      hintStyle: GoogleFonts.inter(
                          fontWeight: FontWeight.w300,
                          fontSize: 14,
                          color: Colors.grey),
                      contentPadding: EdgeInsets.symmetric(vertical: 10),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey.shade300),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey.shade300),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      border: const OutlineInputBorder()),
                  hint: const Text(
                    'Choose your location',
                    style: TextStyle(
                        fontWeight: FontWeight.w300,
                        fontSize: 14,
                        color: Colors.grey),
                  ),
                  buttonStyleData: const ButtonStyleData(
                    padding: EdgeInsets.only(right: 8),
                  ),
                  iconStyleData: const IconStyleData(
                    icon: Icon(
                      Icons.keyboard_arrow_down_sharp,
                      color: green,
                    ),
                    iconSize: 24,
                  ),
                  dropdownStyleData: DropdownStyleData(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                    ),
                  ),
                  menuItemStyleData: const MenuItemStyleData(
                    padding: EdgeInsets.symmetric(horizontal: 16),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                AppText(
                    text: 'Branch',
                    size: 16,
                    weight: FontWeight.w400,
                    textcolor: grayblack),
                SizedBox(
                  height: 5,
                ),
                DropdownButtonFormField2<String>(
                  value: _selectedBranch,
                  items: _branches.map((branch) {
                    return DropdownMenuItem(
                      value: branch,
                      child: Text(branch),
                    );
                  }).toList(),
                  onChanged: (newValue) {
                    setState(() {
                      _selectedBranch = newValue;
                    });
                  },
                  validator: (value) {
                    if (value == null) {
                      return 'Please select a branch';
                    }
                    return null;
                  },
                  isExpanded: true,
                  decoration: InputDecoration(
                      fillColor: Color(0xffF1F1F1),
                      filled: true,
                      hintText: 'Select the branch',
                      hintStyle: GoogleFonts.inter(
                          fontWeight: FontWeight.w300,
                          fontSize: 14,
                          color: Colors.grey),
                      contentPadding: EdgeInsets.symmetric(vertical: 10),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey.shade300),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey.shade300),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      border: const OutlineInputBorder()),
                  hint: const Text(
                    'Select the branch',
                    style: TextStyle(
                        fontWeight: FontWeight.w300,
                        fontSize: 14,
                        color: Colors.grey),
                  ),
                  buttonStyleData: const ButtonStyleData(
                    padding: EdgeInsets.only(right: 8),
                  ),
                  iconStyleData: const IconStyleData(
                    icon: Icon(
                      Icons.keyboard_arrow_down_sharp,
                      color: green,
                    ),
                    iconSize: 24,
                  ),
                  dropdownStyleData: DropdownStyleData(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                    ),
                  ),
                  menuItemStyleData: const MenuItemStyleData(
                    padding: EdgeInsets.symmetric(horizontal: 16),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                AppText(
                    text: 'Treatments',
                    size: 16,
                    weight: FontWeight.w400,
                    textcolor: grayblack),
                SizedBox(
                  height: 5,
                ),
                Container(
                  height: 84,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(9),
                      color: Color(0xffF0F0F0)),
                  child: Column(
                    children: [
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 20, vertical: 10),
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
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    AppText(
                                        text: 'Couple Combo Package',
                                        size: 18,
                                        weight: FontWeight.w500,
                                        textcolor: Colors.black),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Row(
                                          children: [
                                            AppText(
                                                text: 'Male  ',
                                                size: 16,
                                                weight: FontWeight.w400,
                                                textcolor: green),
                                            Container(
                                              height: 26,
                                              width: 44,
                                              decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(5),
                                                  border: Border.all(
                                                      color: Colors
                                                          .grey.shade300)),
                                              child: Center(
                                                child: AppText(
                                                  text: "$_mCount",
                                                  size: 16,
                                                  weight: FontWeight.w400,
                                                  textcolor: green,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                        Row(
                                          children: [
                                            AppText(
                                                text: 'Female  ',
                                                size: 16,
                                                weight: FontWeight.w400,
                                                textcolor: green),
                                            Container(
                                              height: 26,
                                              width: 44,
                                              decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(5),
                                                  border: Border.all(
                                                      color: Colors
                                                          .grey.shade300)),
                                              child: Center(
                                                child: AppText(
                                                  text: "$_fCount",
                                                  size: 16,
                                                  weight: FontWeight.w400,
                                                  textcolor: green,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    )
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                GestureDetector(
                  onTap: () {
                    _showQuantityDialog();
                  },
                  child: Container(
                      width: double.infinity,
                      height: 50,
                      decoration: BoxDecoration(
                          color: Color(0x4D389A48),
                          borderRadius: BorderRadius.circular(9)),
                      child: Center(
                        child: Text(
                          '+ Add Treatments',
                          style: GoogleFonts.inter(
                              fontSize: 15, fontWeight: FontWeight.w500),
                        ),
                      )),
                ),
                SizedBox(
                  height: 20,
                ),
                AppText(
                    text: 'Total Amount',
                    size: 16,
                    weight: FontWeight.w400,
                    textcolor: grayblack),
                SizedBox(
                  height: 5,
                ),
                AppTextForm(
                    hintText: '',
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter total amount';
                      }
                      return null;
                    },
                    controller: _totalAmountController),
                SizedBox(
                  height: 20,
                ),
                AppText(
                    text: 'Discount Amount',
                    size: 16,
                    weight: FontWeight.w400,
                    textcolor: grayblack),
                SizedBox(
                  height: 5,
                ),
                AppTextForm(
                    hintText: '',
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter discount amount';
                      }
                      return null;
                    },
                    controller: _discountAmountController),
                SizedBox(
                  height: 20,
                ),
                AppText(
                    text: 'Payment Option',
                    size: 16,
                    weight: FontWeight.w400,
                    textcolor: grayblack),
                SizedBox(
                  height: 5,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Row(
                      children: [
                        Radio<int>(
                          value: 1,
                          groupValue: _selectedValue,
                          onChanged: _handleRadioValueChange,
                        ),
                        AppText(
                            text: 'Cash',
                            size: 16,
                            weight: FontWeight.w400,
                            textcolor: black),
                      ],
                    ),
                    Row(
                      children: [
                        Radio<int>(
                          value: 2,
                          groupValue: _selectedValue,
                          onChanged: _handleRadioValueChange,
                        ),
                        AppText(
                            text: 'Card',
                            size: 16,
                            weight: FontWeight.w400,
                            textcolor: black),
                      ],
                    ),
                    Row(
                      children: [
                        Radio<int>(
                          value: 3,
                          groupValue: _selectedValue,
                          onChanged: _handleRadioValueChange,
                        ),
                        AppText(
                            text: 'UPI',
                            size: 16,
                            weight: FontWeight.w400,
                            textcolor: black),
                      ],
                    ),
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                AppText(
                    text: 'Advance Amount',
                    size: 16,
                    weight: FontWeight.w400,
                    textcolor: grayblack),
                SizedBox(
                  height: 5,
                ),
                AppTextForm(
                    hintText: '',
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter advance amount';
                      }
                      return null;
                    },
                    controller: _advanceAmountController),
                SizedBox(
                  height: 20,
                ),
                AppText(
                    text: 'Balance Amount',
                    size: 16,
                    weight: FontWeight.w400,
                    textcolor: grayblack),
                SizedBox(
                  height: 5,
                ),
                AppTextForm(
                    hintText: '',
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter balance amount';
                      }
                      return null;
                    },
                    controller: _balanceAmountController),
                SizedBox(
                  height: 20,
                ),
                AppText(
                    text: 'Treatment Date',
                    size: 16,
                    weight: FontWeight.w400,
                    textcolor: grayblack),
                SizedBox(
                  height: 5,
                ),
                TextFormField(
                  controller: dobController,
                  readOnly: true,
                  keyboardType: TextInputType.datetime,
                  decoration: InputDecoration(
                      fillColor: Color(0xffF1F1F1),
                      filled: true,
                      contentPadding:
                          EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10.0)),
                        borderSide:
                            BorderSide(color: Colors.grey.shade300, width: 1),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10.0)),
                        borderSide: BorderSide(color: Colors.grey.shade300),
                      ),
                      suffixIcon: Icon(Icons.calendar_month)
                      // icon: Icon(Icons.calendar_month)
                      ),
                  onTap: () async {
                    DateTime? pickedDate = await showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime(1900),
                      lastDate: DateTime(2101),
                    );

                    if (pickedDate != null) {
                      dobController.text =
                          "${pickedDate.day}/${pickedDate.month}/${pickedDate.year}";
                    }
                  },
                  style: TextStyle(
                      color: black, fontSize: 12, fontWeight: FontWeight.w400),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter Date';
                    }
                    return null;
                  },
                ),
                SizedBox(
                  height: 20,
                ),
                SizedBox(height: 20),
                _isLoading
                    ? Center(child: CircularProgressIndicator())
                    : GestureDetector(
                        onTap: _registerPatient,
                        child: MyContainer(
                            text: Text(
                          'Save',
                          style: GoogleFonts.poppins(
                              fontSize: 17,
                              fontWeight: FontWeight.w600,
                              color: white),
                        )),
                      )
              ],
            ),
          ),
        ),
      ),
    );
  }

  int _mCount = 0;
  int _fCount = 0;

  void _showQuantityDialog() {
    showDialog<int>(
      context: context,
      builder: (BuildContext context) {
        int maleCount = _mCount;
        int femaleCount = _fCount;
        return StatefulBuilder(
          builder: (BuildContext context, StateSetter setState) {
            return AlertDialog(
              title: AppText(
                  text: 'Choose Treatment',
                  size: 16,
                  weight: FontWeight.w400,
                  textcolor: grayblack),
              content: Container(
                height: 428,
                width: 222,
                child: Column(
                  children: [
                    DropdownButtonFormField2<String>(
                      isExpanded: true,
                      decoration: InputDecoration(
                          fillColor: Colors.grey[300],
                          filled: true,
                          hintText: 'Choose prefered treatment',
                          hintStyle: GoogleFonts.inter(
                              fontWeight: FontWeight.w300,
                              fontSize: 14,
                              color: Colors.grey),
                          contentPadding: EdgeInsets.symmetric(vertical: 10),
                          focusedBorder: OutlineInputBorder(
                            borderSide: const BorderSide(color: Colors.grey),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide:
                                const BorderSide(color: Color(0xff00000040)),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          border: const OutlineInputBorder()),
                      hint: Text(
                        'Choose prefered treatment',
                        style: TextStyle(
                            fontWeight: FontWeight.w300,
                            fontSize: 14,
                            color: Colors.grey),
                      ),
                      items: treatmentList
                          .map((item) => DropdownMenuItem<String>(
                                value: item,
                                child: Text(
                                  item,
                                  style: const TextStyle(
                                    fontSize: 14,
                                  ),
                                ),
                              ))
                          .toList(),
                      onChanged: (value) {},
                      onSaved: (value) {
                        selectedValue = value.toString();
                      },
                      buttonStyleData: const ButtonStyleData(
                        padding: EdgeInsets.only(right: 8),
                      ),
                      iconStyleData: const IconStyleData(
                        icon: Icon(
                          Icons.keyboard_arrow_down_sharp,
                          color: green,
                        ),
                        iconSize: 24,
                      ),
                      dropdownStyleData: DropdownStyleData(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                        ),
                      ),
                      menuItemStyleData: const MenuItemStyleData(
                        padding: EdgeInsets.symmetric(horizontal: 16),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Container(
                          height: 50,
                          width: 124,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(9),
                              border: Border.all(color: Colors.grey.shade400),
                              color: Colors.grey[300]),
                          child: Row(
                            children: [
                              SizedBox(
                                width: 15,
                              ),
                              AppText(
                                  text: 'Male',
                                  size: 14,
                                  weight: FontWeight.w300,
                                  textcolor: grayblack),
                            ],
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              if (maleCount > 0) maleCount--;
                            });
                          },
                          child: CircleAvatar(
                            backgroundColor: green,
                            radius: 15,
                            child: Center(
                              child: Icon(
                                Icons.remove,
                                color: white,
                                size: 15,
                              ),
                            ),
                          ),
                        ),
                        Text('$maleCount'),
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              maleCount++;
                            });
                          },
                          child: CircleAvatar(
                            backgroundColor: green,
                            radius: 15,
                            child: Center(
                              child: Icon(
                                Icons.add,
                                color: white,
                                size: 15,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Container(
                          height: 50,
                          width: 124,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(9),
                              border: Border.all(color: Colors.grey.shade400),
                              color: Colors.grey[300]),
                          child: Row(
                            children: [
                              SizedBox(
                                width: 15,
                              ),
                              AppText(
                                  text: 'Female',
                                  size: 14,
                                  weight: FontWeight.w300,
                                  textcolor: grayblack),
                            ],
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              if (femaleCount > 0) femaleCount--;
                            });
                          },
                          child: CircleAvatar(
                            backgroundColor: green,
                            radius: 15,
                            child: Center(
                              child: Icon(
                                Icons.remove,
                                color: white,
                                size: 15,
                              ),
                            ),
                          ),
                        ),
                        Text('$femaleCount'),
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              femaleCount++;
                            });
                          },
                          child: CircleAvatar(
                            backgroundColor: green,
                            radius: 15,
                            child: Center(
                              child: Icon(
                                Icons.add,
                                color: white,
                                size: 15,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              actions: <Widget>[
                GestureDetector(
                  onTap: () {
                    setState(() {
                      _mCount = maleCount;
                    });
                    setState(() {
                      _fCount = femaleCount;
                    });
                    Navigator.of(context).pop();
                  },
                  child: MyContainer(
                      text: Text(
                    'Save',
                    style: GoogleFonts.poppins(
                        fontWeight: FontWeight.w600,
                        fontSize: 17,
                        color: white),
                  )),
                ),
              ],
            );
          },
        );
      },
    ).then((value) {
      setState(() {});
    });
  }

  String? selectedValue;
  final List<String> treatmentList = [
    'Relaxation Retreat Package',
    'Detox Delight Pakage',
    'Ultimate Pamper Package',
    'Stress Relief Package',
    'Mother-to-Be Package',
  ];
}
