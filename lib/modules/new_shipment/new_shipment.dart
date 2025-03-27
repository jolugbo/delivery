import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:gt_delivery/constant/app_color.dart';
import 'package:gt_delivery/constant/app_images.dart';
import 'package:gt_delivery/modules/new_shipment/payment.dart';
import 'package:gt_delivery/provider/config_provider.dart';
import 'package:gt_delivery/provider/delivery_provider.dart';
import 'package:gt_delivery/provider/user_provider.dart';
import 'package:gt_delivery/utils/helper.dart';
import 'package:gt_delivery/utils/textstyles/text_styles.dart';
import 'package:gt_delivery/utils/widget/add_item_widget.dart';
import 'package:gt_delivery/utils/widget/app_button.dart';
import 'package:gt_delivery/utils/widget/app_text_fields.dart';
import 'package:gt_delivery/utils/widget/back_button.dart';
import 'package:gt_delivery/utils/widget/indicator.dart';
import 'package:gt_delivery/utils/widget/item_button.dart';
import 'package:gt_delivery/utils/widget/item_image.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class NewShipment extends StatefulWidget {
  final token;
  const NewShipment({required this.token, super.key});

  @override
  State<NewShipment> createState() => _NewShipmentState();
}

class _NewShipmentState extends State<NewShipment> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController receiverNameController = TextEditingController();
  final TextEditingController numberController = TextEditingController();
  final TextEditingController receiverNumberController =
      TextEditingController();
  final TextEditingController addressController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController receiverEmailController = TextEditingController();
  final TextEditingController postCodeController = TextEditingController();
  final TextEditingController receiverPostCodeController =
      TextEditingController();
  final TextEditingController cityController = TextEditingController();
  final TextEditingController receiverCityController = TextEditingController();
  final TextEditingController receiverAddressController =
      TextEditingController();
  final TextEditingController receiverHouseNoController =
      TextEditingController();
  final TextEditingController itemNameController = TextEditingController();
  final TextEditingController valueController = TextEditingController();
  final TextEditingController colorController = TextEditingController();
  final TextEditingController textController = TextEditingController();
  final TextEditingController weightController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  final String googleApiKey = "AIzaSyBZr_teD3IuoXYHppZv9M6fkvA4UZZjY-0";
  List<dynamic> _placesList = [];
  final List<String> items = [
    "Scheduling Window: You can schedule a delivery starting from 30 minutes ahead, up to 30 days in advance.",
    "Responsibility: Please ensure all delivery details are accurate. We are not responsible for delays due to incorrect information.",
    "Delivery Timeframe: While we aim to deliver on time, delays may occur. We’ll notify you if there are any issues.",
  ];
  bool sameLocation = false;
  bool itemCreated = false;
  String shippingType = '';
  String shippingTypeName = 'New Shipment';
  int newShipmentStep = 0;
  int qty = 0;
  String progressText = "Shipment type";
  bool isLoading = false;
  bool isCourierSet = false;
  bool isDeliveryPartnerSet = false;
  bool showSuccessOverlay = false;
  String modalHeader = "Personal Information Completed";
  String shortenedFileName = "";
  double fileSize = 0;
  String modalBody = "Please Proceed to upload KYC Documents";
  bool _isButtonEnabled = false;
  late ScrollController _scrollController;
  late ScrollController _scrollController1;
  bool? isGeneral;
  File? _itemImage;
  Widget? item;
  bool checkedValue = false;
  bool destinationValue = false;
  String? selectedCountry;
  String? selectedShipmentType;
  String? selectedItemCategory;
  String? selectedSubCategory;
  DateTime? _selectedDate;
  TimeOfDay? _selectedTime;
  List<dynamic> categories = [];
  List<dynamic> couriers = [];
  List<dynamic> countries = [];
  List<dynamic> states = [];
  List<dynamic> shipmentTypes = [];
  List<dynamic> itemCategories = [];
  List<dynamic> itemSubCategories = [];
  dynamic userProfile = {};
  dynamic orderRequest = {};
  dynamic estimateRequest = {};
  Map<String, dynamic> estimateResponse = {};
  dynamic locationCoordinates = {};
  String fetchedCity = "";
  String courierShippingType = "";

  bool _validateInputs() {
    if (receiverNameController.text.trim().isEmpty) {
      _showError('Receiver name is required');
      return false;
    }
    if (receiverNumberController.text.trim().isEmpty ||
        receiverNumberController.text.length < 10) {
      _showError('Enter a valid phone number');
      return false;
    }
    if (receiverEmailController.text.trim().isEmpty ||
        !_isValidEmail(receiverEmailController.text)) {
      _showError('Enter a valid email');
      return false;
    }
    if (receiverPostCodeController.text.trim().isEmpty) {
      _showError('Post code is required');
      return false;
    }
    if (receiverCityController.text.trim().isEmpty) {
      _showError('Please select a city');
      return false;
    }
    // if (receiverHouseNoController.text.trim().isEmpty) {
    //   _showError('Apartment/House No. is required');
    //   return false;
    // }
    if (receiverAddressController.text.trim().isEmpty) {
      _showError('Address details are required');
      return false;
    }

    return true; // If all validations pass
  }

  bool _validateInputs2() {
    if (receiverNameController.text.trim().isEmpty) {
      _showError('Receiver name is required');
      return false;
    }
    if (receiverNumberController.text.trim().isEmpty ||
        receiverNumberController.text.length < 10) {
      _showError('Enter a valid phone number');
      return false;
    }
    if (receiverEmailController.text.trim().isEmpty ||
        !_isValidEmail(receiverEmailController.text)) {
      _showError('Enter a valid email');
      return false;
    }
    if (receiverPostCodeController.text.trim().isEmpty) {
      _showError('Post code is required');
      return false;
    }
    if (receiverCityController.text.trim().isEmpty) {
      _showError('Please select a city');
      return false;
    }
    // if (receiverHouseNoController.text.trim().isEmpty) {
    //   _showError('Apartment/House No. is required');
    //   return false;
    // }
    if (receiverAddressController.text.trim().isEmpty) {
      _showError('Address details are required');
      return false;
    }

    return true; // If all validations pass
  }

  bool _isValidEmail(String email) {
    final emailRegex =
        RegExp(r"^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$");
    return emailRegex.hasMatch(email);
  }

  void _showError(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message), backgroundColor: Colors.red),
    );
  }

  Future<void> fetchPlaces(String input) async {
    String url =
        "https://maps.googleapis.com/maps/api/place/autocomplete/json?input=$input&key=$googleApiKey&components=country:ng";

    final response = await http.get(Uri.parse(url));
    print(json.decode(response.body)["predictions"]);
    if (response.statusCode == 200) {
      setState(() {
        _placesList = json.decode(response.body)["predictions"];
      });
    }
  }

  Future<void> getPlaceDetails(String placeId, String inboundOutbound) async {
    String detailsUrl =
        "https://maps.googleapis.com/maps/api/place/details/json?place_id=$placeId&key=$googleApiKey";

    final response = await http.get(Uri.parse(detailsUrl));

    if (response.statusCode == 200) {
      final location =
          json.decode(response.body)["result"]["geometry"]["location"];
      //print("Latitude: ${location["lat"]}, Longitude: ${location["lng"]}");

      final data = json.decode(response.body);
      final result = data["result"];

      // Extract address details
      String formattedAddress = result["formatted_address"] ?? "";
      String postalCode = "";
      String city = "";

      for (var component in result["address_components"]) {
        if (component["types"].contains("postal_code")) {
          postalCode = component["long_name"];
        }
        if (component["types"].contains("locality")) {
          city = component["long_name"];
        }
      }

      //print("Latitude: ${location["lat"]}, Longitude: ${location["lng"]}");

      setState(() {
        locationCoordinates[inboundOutbound] = {
          "longitude": location["lng"],
          "latitude": location["lat"]
        };
        fetchedCity = city;
        if (inboundOutbound == "Recipient") {
          // Update UI fields
          receiverAddressController.text = formattedAddress;
          receiverPostCodeController.text = postalCode;
          receiverAddressController.text =
              json.decode(response.body)["result"]["formatted_address"];
        } else {
          addressController.text =
              json.decode(response.body)["result"]["formatted_address"];
        }
        _placesList = [];
      });
    }
  }

  Future<void> fetchSubCategories(
      String input, StateSetter setModalState) async {
    if (input.isEmpty) return;
    setModalState(() {
      isLoading = true;
    });
    final deliveryProvider =
        Provider.of<DeliveryProvider>(context, listen: false);
    try {
      final subCategories = await deliveryProvider.fetchItemSubCategory(
          token: widget.token, code: input);
      setModalState(() {
        isLoading = false;
        itemSubCategories = subCategories["data"];
      });
    } catch (error) {
      print('Error fetching data: $error');
    }
  }

  Widget scheduleSuccess(BuildContext context) {
    return Container(
      width: 350,
      height: 450,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(mainAxisSize: MainAxisSize.min, children: [
        const SizedBox(height: 20), // Space for the close button
        Image(
          image: AssetImage(AppImages.boxx),
          width: 100,
        ),
        const SizedBox(height: 50),
        Text(
          'Schedule successful!',
          style: AppTextStyle.body(size: 18, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 10),
        Text(
          'Your package has been scheduled for delivery on 15th September 2024.',
          textAlign: TextAlign.center,
          style: AppTextStyle.body(
              size: 16, fontWeight: FontWeight.w400, color: AppColor.lightdark),
        ),
        const SizedBox(height: 40),
        AppButton(
            title: 'Proceed',
            color: AppColor.primaryColor,
            onTap: () => {
                  for (int i = 0; i < 2; i++)
                    {
                      if (Navigator.of(context).canPop())
                        {Navigator.of(context).pop()}
                    }
                }),
      ]),
    );
  }

  Future<void> _pickTime(BuildContext context) async {
    TimeOfDay? pickedTime = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (pickedTime != null) {
      setState(() {
        _selectedTime = pickedTime;
      });
    }
  }

  String _formatTime(TimeOfDay time) {
    final now = DateTime.now();
    final dt = DateTime(now.year, now.month, now.day, time.hour, time.minute);
    return "${dt.hour % 12 == 0 ? 12 : dt.hour % 12}:${dt.minute.toString().padLeft(2, '0')} ${dt.hour >= 12 ? "PM" : "AM"}";
  }

  Future<void> _pickDate(BuildContext context) async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2100),
    );
    if (pickedDate != null) {
      setState(() {
        _selectedDate = pickedDate;
      });
    }
  }

  void _loadData() async {
    setState(() {
      isLoading = true;
    });
    final deliveryProvider =
        Provider.of<DeliveryProvider>(context, listen: false);
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    final configProvider = Provider.of<ConfigProvider>(context, listen: false);
    try {
      final shipmentCategories =
          await deliveryProvider.fetchShipmentCat(token: widget.token);
      setState(() {
        isLoading = false;
        categories = shipmentCategories["data"];
      });
      print(categories);
      final results = await Future.wait([
        configProvider.fetchCountries(token: widget.token),
        deliveryProvider.fetchShipmentType(token: widget.token),
        userProvider.fetchUserProfile(token: widget.token),
        configProvider.fetchCountry(token: widget.token),
        deliveryProvider.fetchItemCategory(token: widget.token),
      ]);
      final countryList = results[0];
      final shipmentTypeList = results[1];
      final userProfileResp = results[2];
      final stateList = results[3];
      final itemCategoryList = results[4];
      print("item Category list $itemCategoryList");

      setState(() {
        states = (stateList["data"]["states"] as List<dynamic>)
            .where((state) => state['setting']['supportOutbound'] == true)
            .toList();
        countries = (countryList['data'] as List<dynamic>)
            .where((country) => country['setting']['supportOutbound'] == true)
            .toList();
        shipmentTypes = (shipmentTypeList['data'] as List<dynamic>)
            .where((country) => country['status'] == "Active")
            .toList();
        itemCategories = (itemCategoryList['data'] as List<dynamic>).toList();
        userProfile = userProfileResp;
        nameController.text = userProfile["data"]["fullName"] ?? "";
        numberController.text = userProfile["data"]["phoneNumber"] ?? "";
        emailController.text = userProfile["data"]["email"] ?? "";
        numberController.text = userProfile["data"]["phoneNumber"] ?? "";
        addressController.text =
            userProfile["data"]["address"]?["addressLine1"] ?? "";
        postCodeController.text =
            userProfile["data"]["address"]?["zipcode"] ?? "";
      });
    } catch (error) {
      // Handle errors here
      print('Error fetching data: $error');
    }
  }

  Future<void> _saveSenderInfo() async {
    setState(() {
      isLoading = true;
      if (sameLocation) {
        var matchingState = states
            .where((state) =>
                state['name'] == userProfile["data"]["address"]?["state"])
            .toList();
        String? stateCode;
        if (matchingState.isNotEmpty) {
          stateCode = matchingState.first["code"];
        }
        orderRequest["pickupLocationCode"] = stateCode;
        orderRequest["routeCode"] = stateCode;
        orderRequest["sender"] = {
          "firstName": nameController.text,
          "lastName": "",
          "phoneNumber": numberController.text
        };
        orderRequest["pickupLocation"] = {
          "addressLine": userProfile["data"]["address"]?["addressLine1"],
          "city": userProfile["data"]["address"]?["city"],
          "state": userProfile["data"]["address"]?["state"],
          "country": "Nigeria",
          "postCode": userProfile["data"]["address"]?["zipcode"],
          "coordinates": {
            "longitude": userProfile["data"]["address"]?["longitude"],
            "latitude": userProfile["data"]["address"]?["latitude"]
          }
        };
      } else {
        if (cityController.text.isEmpty ||
            addressController.text.isEmpty ||
            postCodeController.text.isEmpty) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
                content:
                    Text('Please fill in all the fields before proceeding')),
          );
          return;
        } else {
          orderRequest["routeCode"] = cityController.text;
          orderRequest["pickupLocation"] = {
            "addressLine": addressController.text,
            "city": fetchedCity,
            "state": cityController.text,
            "country": "Nigeria",
            "postCode": postCodeController.text,
            "coordinates": locationCoordinates["Sender"]
          };
        }
      }
      print(orderRequest);
      newShipmentStep = 2;
      progressText = "Recipient Details";
    });
    _scrollToTop();
    setState(() {
      isLoading = false;
    });
  }

  Future<void> _saveRecipientInfo() async {
    setState(() {
      isLoading = true;
    });

    setState(() {
      orderRequest["destinationLocationCode"] = receiverCityController.text;
      orderRequest["destinationLocation"] = {
        "addressLine": receiverAddressController.text,
        "city": fetchedCity,
        "state": receiverCityController.text,
        "country": "Nigeria",
        "postCode": postCodeController.text,
        "coordinates": locationCoordinates["Recipient"]
      };
      orderRequest["receiver"] = {
        "firstName": receiverNameController.text,
        "lastName": "",
        "phoneNumber": receiverNumberController.text,
        "email": receiverEmailController.text
      };
      print(orderRequest);
      newShipmentStep = 3;
      progressText = "Package Details";
      isLoading = false;
    });
    _scrollToTop();
    print("orderRequest - $orderRequest \n");
  }

  Future<void> _saveItemInfo() async {
    setState(() {
      isLoading = true;
      //orderRequest["shipmentType"] = selectedShipmentType;
      orderRequest["details"] ??= [];
      orderRequest["details"]!.add(
        {
          "itemName": itemNameController.text,
          "category": selectedItemCategory,
          "image": _itemImage,
          "subCategory": selectedSubCategory,
          "weight": weightController.text,
          "quantity": qty,
          "itemValue": valueController.text,
          "state": "Good"
        },
      );
      itemCreated = true;
    });

    setState(() {
      isLoading = false;
    });
    Navigator.of(context).pop();
    print("orderRequest - $orderRequest \n");
    //print("estimateRequest - $estimateRequest");
  }

  Future<void> getCourier() async {
    setState(() {
      isLoading = true;
    });
    double totalWeight =
        (orderRequest["details"] as List<dynamic>?)?.fold(0.0, (sum, detail) {
              double weight = double.tryParse(detail["weight"].toString()) ?? 0;
              return sum! + weight;
            }) ??
            0.0;
    print("Total Weight: $totalWeight");
    orderRequest["shipmentWeight"] = totalWeight;
    var courierRequest = {
      "shipmentWeightInKg": totalWeight,
      "pickupLocation": orderRequest["pickupLocation"],
      "destinationLocation": orderRequest["destinationLocation"],
      "shipmentType": courierShippingType
    };
    print(courierRequest);
    final deliveryProvider =
        Provider.of<DeliveryProvider>(context, listen: false);
    try {
      // Perform the API calls concurrently
      final couriersResp = await deliveryProvider.getCourier(
          token: widget.token, couriersRequest: courierRequest);
      setState(() {
        couriers = couriersResp["data"]["resultData"];
        isLoading = false;
        newShipmentStep = 4;
        progressText = "Courier";
      });
    } catch (error) {
      setState(() {
        isLoading = false;
      });
      // Handle errors here
      print('Error fetching data: $error');
    }
  }

  Future<void> getEstimate() async {
    setState(() {
      isLoading = true;
    });
    estimateRequest = {
      "shipmentCategory": shippingTypeName,
      "shipmentCategoryCode": shippingType,
      "shipmentWeight": weightController.text,
      "pickupLocation": orderRequest["pickupLocation"],
      "destination": orderRequest["destinationLocation"],
      "sourceCode": orderRequest["routeCode"],
      "destinationCode": orderRequest["destinationLocationCode"]
    };

    final deliveryProvider =
        Provider.of<DeliveryProvider>(context, listen: false);
    final response = await deliveryProvider.getEstimates(
        token: widget.token, estimateRequest: estimateRequest);

    setState(() {
      isLoading = false;
    });
    if (response["success"]) {
      setState(() {
        estimateResponse = response["data"];
        newShipmentStep = 5;
        progressText = "Price Estimate";
      });
    }
    // estimateResponse = {"fees": [
    //   {"routeCode": null,
    //   "displayName": "GTD Inter State Latest Pricing",
    //   "duration": 24,
    //   "amount": 86400,
    //   "deliveryPartnerCode": "GTD"}],
    //   "insuranceFee": 0, "destinationDutyFee": 0}
  }

  Future<void> createOrder() async {
    setState(() {
      isLoading = true;
    });
    (orderRequest["details"] as List<dynamic>?)?.forEach((detail) {
      detail["image"] = null;
    });

    print(orderRequest);

    final deliveryProvider =
        Provider.of<DeliveryProvider>(context, listen: false);
    final response = await deliveryProvider.createOrder(
        token: widget.token, orderRequest: orderRequest);

    setState(() {
      isLoading = false;
      //orderRequest[""] = 
    });
    if (response["success"]) {
      response["data"]["email"] = emailController.text;
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => Payment(
                  token: widget.token, 
                  paymentDetails: response["data"],
                  orderRequest: orderRequest
                  )));
    }
  }

  void _onScroll() {
    // Check if the user has scrolled to the bottom
    if (_scrollController.position.atEdge) {
      bool isAtBottom = _scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent;
      if (isAtBottom && !_isButtonEnabled) {
        setState(() {
          _isButtonEnabled = true;
        });
      }
    }
  }

  void _scrollToTop() {
    _scrollController1.animateTo(
      -10, // Position 0 is the top
      duration: const Duration(seconds: 1), // Animation duration
      curve: Curves.easeInOut, // Animation curve
    );
  }

  Future<dynamic> addItemDetails(BuildContext context) {
    _itemImage = null;
    var size = MediaQuery.of(context).size;
    return showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (BuildContext context, StateSetter setModalState) {
            return Container(
              height: size.height * 0.8,
              width: double.infinity,
              decoration: const BoxDecoration(
                  color: AppColor.white,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(15),
                      topRight: Radius.circular(15))),
              child: Center(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      const SizedBox(height: 10),
                      AnimatedContainer(
                        duration: const Duration(milliseconds: 250),
                        width: size.width * 0.3,
                        height: 6.w,
                        padding: const EdgeInsets.only(left: 0),
                        margin: EdgeInsets.only(right: 12.w),
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: AppColor.lightdark,
                          borderRadius: BorderRadius.circular(1000.r),
                        ),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        'Add Item',
                        style: AppTextStyle.body(
                            fontWeight: FontWeight.bold, size: 20),
                      ),
                      const SizedBox(height: 5),
                      Text(
                        'Add Item to be shipped.',
                        style: AppTextStyle.body(size: 14),
                      ),
                      const SizedBox(height: 15),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Form(
                            key: _formKey,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                item_image(
                                  onTap: () async {
                                    var img = await HelperClass()
                                        .showImageSourceSelector(context);
                                    if (img != null) {
                                      setModalState(() {
                                        _itemImage = img;
                                      });
                                      File file = File(_itemImage!
                                          .path); // Convert _itemImage to File
                                      String fileName = file.uri.pathSegments
                                          .last; // Extract the full file name
                                      shortenedFileName = fileName.length > 10
                                          ? fileName
                                              .substring(fileName.length - 10)
                                          : fileName; // Extract the file name
                                      int fileSizeInByt = file
                                          .lengthSync(); // Get the file size in bytes
                                      fileSize = fileSizeInByt /
                                          1024; // Convert to KB for readability
                                    }
                                  },
                                  item: _itemImage != null
                                      ? Container(
                                          padding: const EdgeInsets.all(5),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceAround,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.center,
                                                  children: [
                                                    Image(
                                                        image: FileImage(File(
                                                            _itemImage!.path)),
                                                        height: 80),
                                                    SizedBox(
                                                        width:
                                                            size.width * 0.05),
                                                    Column(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        Text(
                                                          shortenedFileName,
                                                          style:
                                                              AppTextStyle.body(
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w600,
                                                                  color:
                                                                      AppColor
                                                                          .dark,
                                                                  size: 14),
                                                        ),
                                                        Text(
                                                          "${fileSize.toStringAsFixed(2)} KB",
                                                          style:
                                                              AppTextStyle.body(
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w500,
                                                                  color: AppColor
                                                                      .lightdark,
                                                                  size: 12),
                                                        ),
                                                      ],
                                                    ),
                                                  ]),
                                              GestureDetector(
                                                  onTap: () {
                                                    setModalState(() {
                                                      _itemImage = null;
                                                    });
                                                  },
                                                  child: Container(
                                                    height: 35,
                                                    width: 35,
                                                    decoration: BoxDecoration(
                                                        shape: BoxShape.circle,
                                                        color: AppColor.white,
                                                        border: Border.all(
                                                            color: AppColor
                                                                .white)),
                                                    child: const Icon(
                                                        Icons.cancel,
                                                        size: 25,
                                                        color: AppColor
                                                            .primaryColor),
                                                  )),
                                              // IconButton(
                                              //   icon: const Icon(Icons.cancel,
                                              //       color: AppColor.grey),
                                              //   onPressed:
                                              // ),
                                            ],
                                          ),
                                        )
                                      : null,
                                  width: size.width,
                                ),
                                if (_itemImage == null)
                                  const Text("Please Upload item image",
                                      style: TextStyle(
                                          color: Colors.red, fontSize: 12)),
                                const SizedBox(height: 10),
                                Visibility(
                                  visible: shippingType == "International",
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      const SizedBox(height: 15),
                                      Text(
                                        'Country or Origin',
                                        style: AppTextStyle.body(size: 14),
                                      ),
                                      const SizedBox(height: 5),
                                      DropdownButtonFormField<String>(
                                        hint: Text(
                                          'Choose Country',
                                          style: AppTextStyle.body(size: 14),
                                        ),
                                        decoration: const InputDecoration(
                                            enabledBorder: OutlineInputBorder(
                                                borderSide:
                                                    BorderSide(width: 0.3)),
                                            focusedBorder: OutlineInputBorder(
                                                borderSide: BorderSide(
                                                    color:
                                                        AppColor.primaryColor)),
                                            border: OutlineInputBorder(
                                                borderRadius: BorderRadius.all(
                                              Radius.circular(10.0),
                                            ))),
                                        items: countries
                                            .map<DropdownMenuItem<String>>(
                                                (country) {
                                          return DropdownMenuItem<String>(
                                            value: country["isoCode"],
                                            child: Text(
                                              country["name"],
                                              style:
                                                  AppTextStyle.body(size: 14),
                                            ),
                                          );
                                        }).toList(),
                                        onChanged: (value) {
                                          setState(() {
                                            selectedCountry = value;
                                          });
                                          print("Selected Vehicle ID: $value");
                                        },
                                      ),
                                    ],
                                  ),
                                ),
                                const SizedBox(height: 10),
                                Text(
                                  'Shipment Type',
                                  style: AppTextStyle.body(size: 14),
                                ),
                                const SizedBox(height: 5),
                                DropdownButtonFormField<String>(
                                  hint: Text(
                                    'Choose Shipment Type',
                                    style: AppTextStyle.body(size: 14),
                                  ),
                                  decoration: const InputDecoration(
                                      enabledBorder: OutlineInputBorder(
                                          borderSide: BorderSide(width: 0.3)),
                                      focusedBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                              color: AppColor.primaryColor)),
                                      border: OutlineInputBorder(
                                          borderRadius: BorderRadius.all(
                                        Radius.circular(10.0),
                                      ))),
                                  items: shipmentTypes
                                      .map<DropdownMenuItem<String>>(
                                          (shipmentType) {
                                    return DropdownMenuItem<String>(
                                      value: shipmentType["code"],
                                      child: Text(
                                        shipmentType["name"],
                                        style: AppTextStyle.body(size: 14),
                                      ),
                                    );
                                  }).toList(),
                                  validator: (value) => value == null
                                      ? 'Please select a shipment type'
                                      : null,
                                  onChanged: (value) {
                                    setState(() {
                                      selectedShipmentType = value;
                                    });
                                  },
                                ),
                                const SizedBox(height: 10),
                                Text(
                                  'Item Name',
                                  style: AppTextStyle.body(size: 14),
                                ),
                                const SizedBox(height: 5),
                                AppTextFields(
                                    controller: itemNameController,
                                    validator: (value) => value!.isEmpty
                                        ? 'Item name is required'
                                        : null,
                                    hint: 'Enter Name'),
                                const SizedBox(height: 10),
                                Text(
                                  'Item Value',
                                  style: AppTextStyle.body(size: 14),
                                ),
                                const SizedBox(height: 5),
                                TextFormField(
                                  controller: valueController,
                                  keyboardType: TextInputType.number,
                                  style: AppTextStyle.body(
                                      fontWeight: FontWeight.normal, size: 12),
                                  inputFormatters: [
                                    FilteringTextInputFormatter
                                        .digitsOnly, // Allows only numbers
                                  ],
                                  validator: (value) => value!.isEmpty
                                      ? 'Enter item value'
                                      : null,
                                  decoration: InputDecoration(
                                    hintText: 'Enter Value', // Placeholder text
                                    suffixText: 'NGN', // Permanent suffix
                                    focusedBorder: const OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: AppColor.primaryColor),
                                    ),
                                    hintStyle: AppTextStyle.body(
                                        size: 12.5,
                                        fontWeight: FontWeight.normal),

                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(8),
                                      borderSide: const BorderSide(width: 0.1),
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 10),
                                Text(
                                  'Item Category',
                                  style: AppTextStyle.body(size: 14),
                                ),
                                const SizedBox(height: 5),
                                DropdownButtonFormField<String>(
                                  hint: Text(
                                    'Select Category',
                                    style: AppTextStyle.body(size: 14),
                                  ),
                                  decoration: const InputDecoration(
                                      enabledBorder: OutlineInputBorder(
                                          borderSide: BorderSide(width: 0.3)),
                                      focusedBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                              color: AppColor.primaryColor)),
                                      border: OutlineInputBorder(
                                          borderRadius: BorderRadius.all(
                                        Radius.circular(10.0),
                                      ))),
                                  items: itemCategories
                                      .map<DropdownMenuItem<String>>(
                                          (itemCategory) {
                                    return DropdownMenuItem<String>(
                                      value: itemCategory["name"],
                                      child: Text(
                                        itemCategory["name"],
                                        style: AppTextStyle.body(size: 14),
                                      ),
                                    );
                                  }).toList(),
                                  validator: (value) => value == null
                                      ? 'Please select a category'
                                      : null,
                                  onChanged: (value) {
                                    setState(() {
                                      selectedItemCategory = value;
                                    });
                                    fetchSubCategories(value!, setModalState);
                                    print("Selected Category: $value");
                                  },
                                ),
                                const SizedBox(height: 10),
                                Text(
                                  'Sub Category',
                                  style: AppTextStyle.body(size: 14),
                                ),
                                const SizedBox(height: 5),
                                DropdownButtonFormField<String>(
                                  hint: Text(
                                    'Select Sub Category',
                                    style: AppTextStyle.body(size: 14),
                                  ),
                                  decoration: const InputDecoration(
                                      enabledBorder: OutlineInputBorder(
                                          borderSide: BorderSide(width: 0.3)),
                                      focusedBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                              color: AppColor.primaryColor)),
                                      border: OutlineInputBorder(
                                          borderRadius: BorderRadius.all(
                                        Radius.circular(10.0),
                                      ))),
                                  items: itemSubCategories
                                      .map<DropdownMenuItem<String>>(
                                          (subCategory) {
                                    return DropdownMenuItem<String>(
                                      value: subCategory["name"],
                                      child: Text(
                                        subCategory["name"],
                                        style: AppTextStyle.body(size: 14),
                                      ),
                                    );
                                  }).toList(),
                                  validator: (value) => value == null
                                      ? 'Please select a subcategory'
                                      : null,
                                  onChanged: (value) {
                                    setState(() {
                                      selectedSubCategory = value;
                                    });
                                    print("Selected Sub Category: $value");
                                  },
                                ),
                                Visibility(
                                    visible: shippingType == "INTL",
                                    child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          const SizedBox(height: 10),
                                          Text(
                                            'Color',
                                            style: AppTextStyle.body(size: 14),
                                          ),
                                          const SizedBox(height: 5),
                                          AppTextFields(
                                              controller: colorController,
                                              hint: 'e.g black, green'),
                                          const SizedBox(height: 10),
                                          Text(
                                            'What is it made of?',
                                            style: AppTextStyle.body(size: 14),
                                          ),
                                          const SizedBox(height: 5),
                                          AppTextFields(
                                              controller: textController,
                                              hint: 'e.g plastic, wood, metal'),
                                          const SizedBox(height: 10),
                                          Text(
                                            'What is it used for?',
                                            style: AppTextStyle.body(size: 14),
                                          ),
                                          const SizedBox(height: 5),
                                          AppTextFields(
                                              controller: textController,
                                              hint: 'e.g driving, sweeping'),
                                          const SizedBox(height: 10),
                                        ])),
                                Text(
                                  'Weight',
                                  style: AppTextStyle.body(size: 14),
                                ),
                                const SizedBox(height: 5),
                                TextFormField(
                                  controller: weightController,
                                  keyboardType: TextInputType.number,
                                  style: AppTextStyle.body(
                                      fontWeight: FontWeight.normal, size: 12),
                                  inputFormatters: [
                                    FilteringTextInputFormatter
                                        .digitsOnly, // Allows only numbers
                                  ],
                                  decoration: InputDecoration(
                                    hintText:
                                        'Enter Weight', // Placeholder text
                                    suffixText: 'KG', // Permanent suffix
                                    focusedBorder: const OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: AppColor.primaryColor),
                                    ),
                                    hintStyle: AppTextStyle.body(
                                        size: 12.5,
                                        fontWeight: FontWeight.normal),

                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(8),
                                      borderSide: const BorderSide(width: 0.1),
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 10),
                                Text(
                                  'Qty',
                                  style: AppTextStyle.body(size: 14),
                                ),
                                const SizedBox(height: 5),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    ElevatedButton(
                                      onPressed: () {
                                        if (qty > 0) {
                                          setModalState(() {
                                            --qty;
                                          });
                                        }
                                      },
                                      style: ElevatedButton.styleFrom(
                                        padding: const EdgeInsets.all(12),
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(20),
                                        ),
                                        backgroundColor: AppColor.white,
                                      ),
                                      child: const Icon(
                                        Icons.remove,
                                        color: AppColor.dark,
                                        size: 24,
                                      ),
                                    ),
                                    Text(
                                      "$qty",
                                      style: AppTextStyle.body(
                                          fontWeight: FontWeight.bold,
                                          size: 22),
                                    ),
                                    ElevatedButton(
                                      onPressed: () {
                                        setModalState(() {
                                          ++qty;
                                        });
                                      },
                                      style: ElevatedButton.styleFrom(
                                        padding: const EdgeInsets.all(12),
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(20),
                                        ),
                                        backgroundColor: AppColor.dark,
                                      ),
                                      child: const Icon(
                                        Icons.add, // Plus icon
                                        color: AppColor.white, // Icon color
                                        size: 24, // Icon size
                                      ),
                                    ),
                                  ],
                                ),
                                if (qty == 0) // ✅ Show error if qty is 0
                                  const Text("Quantity must be at least 1",
                                      style: TextStyle(
                                          color: Colors.red, fontSize: 12)),
                                const SizedBox(height: 50),
                                AppButton(
                                    title: 'Add Item',
                                    onTap: () async {
                                      if (_formKey.currentState!.validate()) {
                                        if (_itemImage == null) return;
                                        await _saveItemInfo();
                                      }
                                    }),
                                const SizedBox(height: 30),
                              ],
                            )),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }

  @override
  void initState() {
    super.initState();
    _loadData();
    _scrollController = ScrollController();
    _scrollController1 = ScrollController();
    _scrollController.addListener(_onScroll);
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: AppColor.primaryColor, // Header color
        elevation: 0,
        leading: const Padding(
            padding: EdgeInsets.symmetric(horizontal: 10),
            child: GoBackButtton(
              iconColor: AppColor.white,
            )),
        title: Text(
          shippingTypeName,
          style: const TextStyle(color: Colors.white),
        ),
        centerTitle: true,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          // Progress Indicator
          Container(
              decoration: const BoxDecoration(
                color: AppColor.primaryColor,
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(16), // Rounded bottom-left corner
                  bottomRight:
                      Radius.circular(16), // Rounded bottom-right corner
                ),
              ),
              height: 70.h,
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 15.h),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          progressText,
                          style: const TextStyle(color: Colors.white),
                        ),
                        Text(
                          '${newShipmentStep + 1} / 6 Step',
                          style: const TextStyle(color: Colors.white),
                        ),
                      ],
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 0, vertical: 10),
                      child: KYCSlideIndicator(
                          currentIndex: newShipmentStep, total: 6),
                    ),
                  ])),

          Expanded(
            child: Stack(
              children: [
                SingleChildScrollView(
                  physics: const ClampingScrollPhysics(),
                  controller: _scrollController1,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: getWidgetForCase(newShipmentStep),
                  ),
                ),
                if (isLoading)
                  Container(
                    color: Colors.black.withOpacity(0.5),
                    child: const Center(
                      child: CircularProgressIndicator(
                        color: AppColor.primaryColor,
                      ),
                    ),
                  ),
                if (showSuccessOverlay)
                  Positioned.fill(
                    child: GestureDetector(
                      onTap: () {
                        setState(() {
                          showSuccessOverlay = false;
                        });
                      },
                      child: Container(
                        color: Colors.black.withOpacity(0.5),
                        child: Center(
                          child: Stack(
                            children: [
                              Container(
                                width: 350,
                                height: 450,
                                padding: const EdgeInsets.all(20),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    const SizedBox(height: 50),
                                    Image(
                                      image: AssetImage(AppImages.mark),
                                      height: 100,
                                    ),
                                    const SizedBox(height: 50),
                                    Text(
                                      modalHeader,
                                      textAlign: TextAlign.center,
                                      style: AppTextStyle.body(
                                        size: 18,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    const SizedBox(height: 10),
                                    Text(
                                      modalBody,
                                      textAlign: TextAlign.center,
                                      style: AppTextStyle.body(
                                        size: 16,
                                        fontWeight: FontWeight.w400,
                                        color: AppColor.lightdark,
                                      ),
                                    ),
                                    const SizedBox(height: 40),
                                    AppButton(
                                      title: 'Proceed',
                                      color: AppColor.primaryColor,
                                      onTap: () {
                                        setState(() {
                                          showSuccessOverlay = false;
                                        });
                                      },
                                    ),
                                  ],
                                ),
                              ),
                              Positioned(
                                top: 10,
                                right: 10,
                                child: GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      showSuccessOverlay = false;
                                    });
                                  },
                                  child: Container(
                                    height: 35,
                                    width: 35,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: Colors.white,
                                      border: Border.all(
                                        color: Colors.grey.shade300,
                                        width: 1.5,
                                      ),
                                    ),
                                    child: const Center(
                                      child: Icon(
                                        Icons.close,
                                        color: AppColor.dark,
                                        size: 18,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget getWidgetForCase(int index) {
    var size = MediaQuery.of(context).size;
    //final authProvider = Provider.of<AuthProvider>(context, listen: false);
    switch (index) {
      case 0:
        //region shipment Type selection
        return SizedBox(
          height: size.height * 0.8,
          width: size.width,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const SizedBox(height: 30),
              Center(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Column(
                    children: categories.map((item) {
                      return Column(
                        children: [
                          ItemButton(
                            isActive: shippingType == item["code"],
                            imagePath: AppImages.world,
                            title: item["name"],
                            subtitle: item["description"],
                            onTap: () {
                              setState(() {
                                //orderRequest["shipmentCategory"] = item["name"];
                                orderRequest["shipmentType"] =
                                    item["shipmentType"];
                                shippingType = item["code"];
                                shippingTypeName = item["name"];
                                courierShippingType = item["shipmentType"];
                              });
                              print(shippingTypeName);
                            },
                          ),
                          const SizedBox(height: 10), // Add space between items
                        ],
                      );
                    }).toList(),
                  ),
                ),
              ),
              const Spacer(),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: AppButton(
                    color: shippingType == ''
                        ? AppColor.grey
                        : AppColor.primaryColor,
                    title: 'Next',
                    onTap: () {
                      if (shippingType == '') return;
                      setState(() {
                        newShipmentStep = 1;
                        progressText = "Pickup Information";
                      });
                    }),
              ),
              const SizedBox(height: 50)
            ],
          ),
        );
      case 1:
        //region Pickup Information
        return SizedBox(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 20),
                Text(
                  'Pickup Information',
                  style: AppTextStyle.body(
                      fontWeight: FontWeight.bold, color: AppColor.dark),
                ),
                const SizedBox(height: 15),
                Text(
                  'Sender Name',
                  style: AppTextStyle.body(size: 14),
                ),
                const SizedBox(height: 5),
                AppTextFields(
                  controller: nameController,
                  hint: 'Input Sender Name',
                  isReadOnly: true,
                ),
                const SizedBox(height: 15),
                Text(
                  'Phone Number',
                  style: AppTextStyle.body(size: 14),
                ),
                const SizedBox(height: 5),
                AppTextFields(
                  controller: numberController,
                  hint: 'Input Sender Phone Number',
                  isReadOnly: true,
                ),
                const SizedBox(height: 15),
                Text(
                  'Email',
                  style: AppTextStyle.body(size: 14),
                ),
                const SizedBox(height: 5),
                AppTextFields(
                  controller: emailController,
                  hint: 'Input Sender Email',
                  isReadOnly: true,
                ),
                const SizedBox(height: 15),
                Row(
                  children: [
                    SizedBox(
                      width: 280,
                      child: Text(
                        'Pickup location is same as my current location',
                        style: AppTextStyle.body(size: 14),
                      ),
                    ),
                    const Spacer(),
                    FlutterSwitch(
                      activeColor: Colors.green,
                      width: 55,
                      height: 35,
                      valueFontSize: 25,
                      toggleSize: 25,
                      value: sameLocation,
                      borderRadius: 30,
                      padding: 8.0,
                      onToggle: (val) {
                        setState(() {
                          sameLocation = val;
                        });
                      },
                    ),
                  ],
                ),
                const SizedBox(height: 15),
                Visibility(
                  visible: !sameLocation,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'City/Province',
                        style: AppTextStyle.body(size: 14),
                      ),
                      const SizedBox(height: 5),
                      DropdownButtonFormField<String>(
                        value: cityController.text.isNotEmpty
                            ? cityController.text
                            : null,
                        hint: Text(
                          'Choose City/Province',
                          style: AppTextStyle.body(size: 14),
                        ),
                        decoration: const InputDecoration(
                            enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(width: 0.3)),
                            focusedBorder: OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: AppColor.primaryColor)),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.all(
                              Radius.circular(10.0),
                            ))),
                        items: states.map<DropdownMenuItem<String>>((state) {
                          return DropdownMenuItem<String>(
                            value: state["code"],
                            child: Text(
                              state["name"],
                              style: AppTextStyle.body(size: 14),
                            ),
                          );
                        }).toList(),
                        onChanged: (value) {
                          cityController.text = value ?? "";
                          print("Selected state code: $value");
                        },
                      ),
                      Text(
                        'Post Code',
                        style: AppTextStyle.body(size: 14),
                      ),
                      const SizedBox(height: 5),
                      AppTextFields(
                          controller: postCodeController,
                          hint: 'Input Post Code'),
                      const SizedBox(height: 15),
                      Text(
                        'Address Details',
                        style: AppTextStyle.body(size: 14),
                      ),
                      const SizedBox(height: 5),
                      SizedBox(
                        height: size.height * 0.18,
                        child: Column(
                          children: [
                            TextFormField(
                              controller: addressController,
                              style: AppTextStyle.body(
                                  fontWeight: FontWeight.normal,
                                  size: 12,
                                  color: AppColor.lightdark),
                              decoration: const InputDecoration(
                                hintText: "Enter Address",
                                suffixIcon: Icon(Icons.location_on),
                                border: OutlineInputBorder(),
                              ),
                              onChanged: (value) {
                                if (value.isNotEmpty) fetchPlaces(value);
                              },
                            ),
                            SizedBox(
                              height: size.height * 0.1,
                              child: ListView.builder(
                                itemCount: _placesList.length,
                                itemBuilder: (context, index) {
                                  return ListTile(
                                    title: Text(
                                      _placesList[index]["description"],
                                      style: AppTextStyle.body(
                                          fontWeight: FontWeight.normal,
                                          size: 12,
                                          color: AppColor.lightdark),
                                    ),
                                    onTap: () {
                                      getPlaceDetails(
                                          _placesList[index]["place_id"],
                                          "Sender");
                                    },
                                  );
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 10),
                AppButton(
                    title: 'Next',
                    onTap: () {
                      _saveSenderInfo();
                    }),
                const SizedBox(height: 30),
              ],
            ),
          ),
        );

      case 2:
        //region Pickup Information
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Visibility(
                visible: shippingType == "INTL",
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 15),
                    Text(
                      'Destination Country',
                      style: AppTextStyle.body(size: 14),
                    ),
                    const SizedBox(height: 5),
                    DropdownButtonFormField<String>(
                      hint: Text(
                        'Choose Country',
                        style: AppTextStyle.body(size: 14),
                      ),
                      decoration: const InputDecoration(
                          enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(width: 0.3)),
                          focusedBorder: OutlineInputBorder(
                              borderSide:
                                  BorderSide(color: AppColor.primaryColor)),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.all(
                            Radius.circular(10.0),
                          ))),
                      items: countries.map<DropdownMenuItem<String>>((country) {
                        return DropdownMenuItem<String>(
                          value: country["isoCode"],
                          child: Text(
                            country["name"],
                            style: AppTextStyle.body(size: 14),
                          ),
                        );
                      }).toList(),
                      onChanged: (value) {
                        setState(() {
                          selectedCountry = value;
                        });
                        print("Selected Vehicle ID: $value");
                      },
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 15),
              Text(
                'Receiver Information',
                style: AppTextStyle.body(
                    fontWeight: FontWeight.w700,
                    size: 15,
                    color: AppColor.lightdark),
              ),
              const SizedBox(height: 15),
              Text(
                'Receiver Name',
                style: AppTextStyle.body(size: 14),
              ),
              const SizedBox(height: 5),
              AppTextFields(
                  controller: receiverNameController, hint: 'Input Name'),
              const SizedBox(height: 10),
              Text(
                'Phone Number',
                style: AppTextStyle.body(size: 14),
              ),
              const SizedBox(height: 5),
              AppTextFields(
                  controller: receiverNumberController,
                  hint: 'Input Phone Number'),
              const SizedBox(height: 10),
              Text(
                'Email',
                style: AppTextStyle.body(size: 14),
              ),
              const SizedBox(height: 5),
              AppTextFields(
                  controller: receiverEmailController,
                  hint: 'Input Recipient email'),
              const SizedBox(height: 10),
              Text('Address Details', style: AppTextStyle.body(size: 14)),
              const SizedBox(height: 5),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextFormField(
                    controller: receiverAddressController,
                    style: AppTextStyle.body(
                      fontWeight: FontWeight.normal,
                      size: 12,
                      color: AppColor.lightdark,
                    ),
                    decoration: const InputDecoration(
                      hintText: "Enter Address",
                      suffixIcon:
                          Icon(Icons.location_on, color: AppColor.primaryColor),
                      border: OutlineInputBorder(),
                      contentPadding:
                          EdgeInsets.symmetric(horizontal: 10, vertical: 12),
                    ),
                    onChanged: (value) {
                      if (value.isNotEmpty) fetchPlaces(value);
                    },
                  ),

                  // Suggestions List (Only shows when there are results)
                  AnimatedContainer(
                    duration: const Duration(milliseconds: 300),
                    height: _placesList.isNotEmpty
                        ? size.height * 0.12
                        : 0, // Dynamic height
                    child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: _placesList.length,
                      itemBuilder: (context, index) {
                        return ListTile(
                          dense: true, // Reduces ListTile height
                          contentPadding:
                              const EdgeInsets.symmetric(horizontal: 10),
                          title: Text(
                            _placesList[index]["description"],
                            style: AppTextStyle.body(
                              fontWeight: FontWeight.normal,
                              size: 12,
                              color: AppColor.lightdark,
                            ),
                          ),
                          onTap: () {
                            getPlaceDetails(
                                _placesList[index]["place_id"], "Recipient");
                          },
                        );
                      },
                    ),
                  ),

                  // Post Code (Auto-filled)
                  if (_placesList.isEmpty)
                    const SizedBox(
                        height: 10), // Add space only if no suggestions
                  Text('Post Code', style: AppTextStyle.body(size: 14)),
                  const SizedBox(height: 5),
                  AppTextFields(
                    controller: receiverPostCodeController,
                    hint: 'Input Post Code',
                    isReadOnly:
                        true, // Prevent user edits since it's auto-filled
                  ),

                  // City/Province Dropdown
                  const SizedBox(height: 10),
                  Text('City/Province', style: AppTextStyle.body(size: 14)),
                  const SizedBox(height: 5),
                  DropdownButtonFormField<String>(
                    value: receiverCityController.text.isNotEmpty
                        ? receiverCityController.text
                        : null,
                    hint: Text('Choose City/Province',
                        style: AppTextStyle.body(size: 14)),
                    decoration: const InputDecoration(
                      enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(width: 0.3)),
                      focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: AppColor.primaryColor)),
                      border: OutlineInputBorder(
                          borderRadius:
                              BorderRadius.all(Radius.circular(10.0))),
                    ),
                    items: states.map<DropdownMenuItem<String>>((state) {
                      return DropdownMenuItem<String>(
                        value: state["code"],
                        child: Text(state["name"],
                            style: AppTextStyle.body(size: 14)),
                      );
                    }).toList(),
                    onChanged: (String? newValue) {
                      if (newValue != null) {
                        receiverCityController.text = newValue;
                      }
                    },
                  ),
                ],
              ),
              const SizedBox(height: 50),
              AppButton(
                  title: 'Next',
                  onTap: () {
                    if (_validateInputs()) {
                      _saveRecipientInfo(); // Proceed if all inputs are valid
                    }
                  }),
              const SizedBox(height: 30),
            ],
          ),
        );
      case 3:
        //region package details
        return SizedBox(
            height: size.height * 0.8,
            width: size.width,
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  SizedBox(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(height: 15),
                          Text(
                            'Package Details',
                            style: AppTextStyle.body(
                                fontWeight: FontWeight.w700,
                                size: 18,
                                color: AppColor.lightdark),
                          ),
                          const SizedBox(height: 5),
                          SizedBox(
                            height: size.height * 0.65,
                            child: Column(
                              children: [
                                Visibility(
                                  visible: itemCreated,
                                  child: Flexible(
                                    child: ConstrainedBox(
                                      constraints: BoxConstraints(
                                        maxHeight: size.height * 0.5,
                                      ),
                                      child: Scrollbar(
                                        controller: _scrollController,
                                        thumbVisibility: true,
                                        child: ListView.builder(
                                          controller: _scrollController,
                                          physics:
                                              const BouncingScrollPhysics(),
                                          shrinkWrap: true,
                                          itemCount:
                                              orderRequest["details"]?.length,
                                          itemBuilder: (context, index) {
                                            return selected_image(
                                              onTap: () async {},
                                              item: Container(
                                                padding:
                                                    const EdgeInsets.all(5),
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceAround,
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .center,
                                                      children: [
                                                        Image(
                                                          image: FileImage(
                                                            orderRequest["details"]
                                                                            [
                                                                            index]
                                                                        [
                                                                        "image"]
                                                                    is File
                                                                ? orderRequest[
                                                                            "details"]
                                                                        [index]
                                                                    ["image"]
                                                                : File(orderRequest[
                                                                                "details"]
                                                                            [
                                                                            index]
                                                                        [
                                                                        "image"]
                                                                    .toString()),
                                                          ),
                                                          height: 80,
                                                        ),
                                                        SizedBox(
                                                            width: size.width *
                                                                0.05),
                                                        Column(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .center,
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          children: [
                                                            Text(
                                                              shortenedFileName,
                                                              style:
                                                                  AppTextStyle
                                                                      .body(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w600,
                                                                color: AppColor
                                                                    .dark,
                                                                size: 14,
                                                              ),
                                                            ),
                                                            Text(
                                                              "${fileSize.toStringAsFixed(2)} KB",
                                                              style:
                                                                  AppTextStyle
                                                                      .body(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w500,
                                                                color: AppColor
                                                                    .lightdark,
                                                                size: 12,
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ],
                                                    ),
                                                    Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceAround,
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .center,
                                                      children: [
                                                        Text(
                                                          "${orderRequest["details"][index]['quantity']}X",
                                                          style:
                                                              AppTextStyle.body(
                                                            fontWeight:
                                                                FontWeight.w600,
                                                            color:
                                                                AppColor.dark,
                                                            size: 14,
                                                          ),
                                                        ),
                                                        SizedBox(
                                                            width: size.width *
                                                                0.01),
                                                        GestureDetector(
                                                          onTap: () {
                                                            setState(() {
                                                              orderRequest[
                                                                      "details"]
                                                                  .removeAt(
                                                                      index);
                                                            });
                                                          },
                                                          child: Container(
                                                            height: 35,
                                                            width: 35,
                                                            decoration:
                                                                BoxDecoration(
                                                              shape: BoxShape
                                                                  .circle,
                                                              color: AppColor
                                                                  .white,
                                                              border: Border.all(
                                                                  color: AppColor
                                                                      .white),
                                                            ),
                                                            child: const Icon(
                                                              Icons
                                                                  .delete_sharp,
                                                              size: 25,
                                                              color: AppColor
                                                                  .primaryColor,
                                                            ),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              width: size.width,
                                            );
                                          },
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 15),
                                GestureDetector(
                                  onTap: () {
                                    addItemDetails(context);
                                  },
                                  child: const AddItemWidget(
                                    title: 'Add Item',
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Visibility(
                    visible: itemCreated,
                    child: Container(
                      // margin: EdgeInsets.only(top: size.height * 0.7),
                      alignment: Alignment.center,
                      child: AppButton(
                          title: 'Next',
                          onTap: () {
                            getCourier();
                          }),
                    ),
                  ),
                ]));

      case 4:
        return SizedBox(
          height: size.height * 0.8,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  children: couriers.map((item) {
                    return Column(
                      children: [
                        const SizedBox(height: 10),
                        ItemButton(
                          isActive: orderRequest["vehicleType"] ==
                              item["vehicleType"],
                          imagePath: AppImages.bike,
                          title: item["vehicleType"],
                          subtitle: "${item["amount"]}",
                          onTap: () {
                            setState(() {
                              orderRequest["vehicleType"] = item["vehicleType"];
                              isCourierSet = true;
                            });
                          },
                        ),
                        const SizedBox(height: 10), // Add space between items
                      ],
                    );
                  }).toList(),
                ),
              ),
              const Spacer(),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: AppButton(
                    title: 'Next',
                    color: isCourierSet ? AppColor.primaryColor : AppColor.grey,
                    onTap: () {
                      if (isCourierSet) {
                        getEstimate();
                      }
                    }),
              ),
              const SizedBox(height: 40),
            ],
          ),
        );

      case 5:
        return SizedBox(
            height: size.height,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          SizedBox(
                            width: 150,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  orderRequest["pickupLocation"]["addressLine"],
                                  style: AppTextStyle.body(
                                      fontWeight: FontWeight.w500, size: 14),
                                ),
                                const SizedBox(height: 10),
                                Text(
                                  'Pickup Location',
                                  style: AppTextStyle.body(size: 12),
                                ),
                              ],
                            ),
                          ),
                          Image(image: AssetImage(AppImages.arrow)),
                          SizedBox(
                            width: 150,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Text(
                                  textAlign: TextAlign.end,
                                  orderRequest["destinationLocation"]
                                      ["addressLine"],
                                  style: AppTextStyle.body(
                                      fontWeight: FontWeight.w500, size: 14),
                                ),
                                const SizedBox(height: 10),
                                Text(
                                  'Package Destination',
                                  style: AppTextStyle.body(size: 12),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),
                      const Divider(),
                      const SizedBox(height: 10),
                      Text(
                        "${orderRequest["shipmentWeight"]}kg",
                        style: AppTextStyle.body(
                            size: 14, fontWeight: FontWeight.w500),
                      ),
                      const SizedBox(height: 3),
                      Text(
                        'Package Size',
                        style: AppTextStyle.body(size: 12),
                      ),
                      const SizedBox(height: 10),
                      Column(
                        children: (estimateResponse["fees"] as List<dynamic>)
                            .map<Widget>((item) {
                          return Column(
                            children: [
                              ItemButton(
                                isActive: orderRequest["deliveryPartnerCode"] ==
                                    item["deliveryPartnerCode"],
                                imagePath: AppImages.world,
                                title: item["displayName"].length > 15
                                    ? '${item["displayName"].substring(0, 15)}...'
                                    : item["displayName"],
                                subtitle: "${item["duration"]} days",
                                trailing: "${item["amount"]}",
                                onTap: () {
                                  setState(() {
                                    isDeliveryPartnerSet = true;
                                    orderRequest["deliveryPartnerCode"] =
                                        item["deliveryPartnerCode"];
                                  });
                                  print(orderRequest);
                                },
                              ),
                              const SizedBox(height: 10),
                            ],
                          );
                        }).toList(),
                      ),
                      const SizedBox(height: 10),
                      Row(
                        children: [
                          Expanded(
                            child: CheckboxListTile(
                              activeColor: AppColor.primaryColor,
                              title: Text(
                                "Insurance",
                                style: AppTextStyle.body(
                                    fontWeight: FontWeight.w500, size: 16),
                              ),
                              value: checkedValue,
                              onChanged: (newValue) {
                                setState(() {
                                  checkedValue = newValue!;
                                });
                              },
                              controlAffinity: ListTileControlAffinity.leading,
                            ),
                          ),
                          Text(
                            "${estimateResponse['insuranceFee']}",
                            style: AppTextStyle.body(
                                size: 14,
                                color: AppColor.primaryColor,
                                fontWeight: FontWeight.w500),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: CheckboxListTile(
                              activeColor: AppColor.primaryColor,
                              title: Text(
                                "Destination Duty Fee",
                                style: AppTextStyle.body(
                                    fontWeight: FontWeight.w500, size: 16),
                              ),
                              value: destinationValue,
                              onChanged: (newValue) {
                                setState(() {
                                  destinationValue = newValue!;
                                });
                              },
                              controlAffinity: ListTileControlAffinity.leading,
                            ),
                          ),
                          Text(
                            "${estimateResponse['destinationDutyFee']}",
                            style: AppTextStyle.body(
                                size: 14,
                                color: AppColor.primaryColor,
                                fontWeight: FontWeight.w500),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Center(
                  child: SizedBox(
                    width: 300,
                    child: Text(
                      textAlign: TextAlign.center,
                      'Final price will be determined upon inspection of the package',
                      style: AppTextStyle.body(size: 14),
                    ),
                  ),
                ),
                const SizedBox(height: 30),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    AppButton(
                      borderColor: AppColor.lightgrey,
                      color: AppColor.white,
                      textColor: AppColor.black,
                      title: 'Schedule',
                      onTap: () {
                        showModalBottomSheet(
                          isScrollControlled: true,
                          context: context,
                          builder: (BuildContext context) {
                            return StatefulBuilder(
                              builder: (BuildContext context,
                                  StateSetter setModalState) {
                                return Container(
                                  height: size.height * 0.8,
                                  width: double.infinity,
                                  decoration: const BoxDecoration(
                                    color: AppColor.white,
                                    borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(15),
                                      topRight: Radius.circular(15),
                                    ),
                                  ),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    mainAxisSize: MainAxisSize.max,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      const SizedBox(height: 10),
                                      Container(
                                        width: size.width,
                                        alignment: Alignment.center,
                                        child: AnimatedContainer(
                                          duration:
                                              const Duration(milliseconds: 250),
                                          width: size.width * 0.3,
                                          height: 6.w,
                                          padding:
                                              const EdgeInsets.only(left: 0),
                                          margin: EdgeInsets.only(right: 12.w),
                                          alignment: Alignment.center,
                                          decoration: BoxDecoration(
                                            color: AppColor.lightdark,
                                            borderRadius:
                                                BorderRadius.circular(1000.r),
                                          ),
                                        ),
                                      ),
                                      const SizedBox(height: 10),
                                      Padding(
                                          padding: const EdgeInsets.all(10),
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            mainAxisSize: MainAxisSize.max,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                'Schedule Delivery',
                                                textAlign: TextAlign.left,
                                                style: AppTextStyle.body(
                                                  fontWeight: FontWeight.bold,
                                                  size: 20,
                                                ),
                                              ),
                                              const SizedBox(height: 10),
                                              Text(
                                                'From 30 minutes, up to 30 days in advance',
                                                style: AppTextStyle.body(
                                                    size: 14,
                                                    color: AppColor.lightdark),
                                              ),
                                              const SizedBox(height: 15),
                                              const Divider(
                                                color: AppColor.lightgrey,
                                                thickness: 1.0,
                                                height: 20.0,
                                              ),
                                              const SizedBox(height: 15),
                                              Container(
                                                width: size.width,
                                                alignment: Alignment.centerLeft,
                                                padding:
                                                    const EdgeInsets.all(0),
                                                child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .center,
                                                    mainAxisSize:
                                                        MainAxisSize.max,
                                                    children: [
                                                      Text(
                                                        'Date',
                                                        style:
                                                            AppTextStyle.body(
                                                                size: 14,
                                                                color: AppColor
                                                                    .lightdark),
                                                      ),
                                                      ElevatedButton(
                                                        onPressed: () =>
                                                            _pickDate(context),
                                                        style: ElevatedButton
                                                            .styleFrom(
                                                          backgroundColor:
                                                              AppColor
                                                                  .lightgrey,
                                                        ),
                                                        child: Text(
                                                          (_selectedDate !=
                                                                  null)
                                                              ? DateFormat(
                                                                      'dd MMM yyyy')
                                                                  .format(
                                                                      _selectedDate!)
                                                              : 'Select Date',
                                                          style: const TextStyle(
                                                              color: AppColor
                                                                  .dark), // White text for contrast
                                                        ),
                                                      ),
                                                    ]),
                                              ),
                                              SizedBox(
                                                width: size.width * 0.8,
                                                child: const Divider(
                                                  color: AppColor.lightgrey,
                                                  thickness: 1.0,
                                                  height: 20.0,
                                                ),
                                              ),
                                              const SizedBox(height: 15),
                                              Container(
                                                width: size.width,
                                                alignment: Alignment.centerLeft,
                                                padding:
                                                    const EdgeInsets.all(0),
                                                child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .center,
                                                    mainAxisSize:
                                                        MainAxisSize.max,
                                                    children: [
                                                      Text(
                                                        'Pickup Time',
                                                        style:
                                                            AppTextStyle.body(
                                                                size: 14,
                                                                color: AppColor
                                                                    .lightdark),
                                                      ),
                                                      ElevatedButton(
                                                        onPressed: () =>
                                                            _pickTime(context),
                                                        style: ElevatedButton
                                                            .styleFrom(
                                                          backgroundColor:
                                                              AppColor
                                                                  .lightgrey,
                                                        ),
                                                        child: Text(
                                                          (_selectedTime !=
                                                                  null)
                                                              ? _formatTime(
                                                                  _selectedTime!)
                                                              : 'Select Time',
                                                          style: const TextStyle(
                                                              color: AppColor
                                                                  .dark), // White text for contrast
                                                        ),
                                                      ),
                                                    ]),
                                              ),
                                              const SizedBox(height: 15),
                                              GestureDetector(
                                                child: Text(
                                                  'Terms of Schedules Rides',
                                                  style: AppTextStyle.body(
                                                      size: 14,
                                                      color: AppColor
                                                          .primaryColor),
                                                ),
                                                onTap: () {
                                                  showModalBottomSheet(
                                                    isScrollControlled: true,
                                                    context: context,
                                                    builder:
                                                        (BuildContext context) {
                                                      return StatefulBuilder(
                                                        builder:
                                                            (BuildContextcontext,
                                                                StateSetter
                                                                    setModalState) {
                                                          return Container(
                                                            height:
                                                                size.height *
                                                                    0.8,
                                                            padding:
                                                                const EdgeInsets
                                                                    .all(10),
                                                            width:
                                                                double.infinity,
                                                            decoration:
                                                                const BoxDecoration(
                                                              color: AppColor
                                                                  .white,
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .only(
                                                                topLeft: Radius
                                                                    .circular(
                                                                        15),
                                                                topRight: Radius
                                                                    .circular(
                                                                        15),
                                                              ),
                                                            ),
                                                            child: Column(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .start,
                                                              mainAxisSize:
                                                                  MainAxisSize
                                                                      .max,
                                                              crossAxisAlignment:
                                                                  CrossAxisAlignment
                                                                      .start,
                                                              children: [
                                                                const SizedBox(
                                                                    height: 10),
                                                                Container(
                                                                  width: size
                                                                      .width,
                                                                  alignment:
                                                                      Alignment
                                                                          .center,
                                                                  child:
                                                                      AnimatedContainer(
                                                                    duration: const Duration(
                                                                        milliseconds:
                                                                            250),
                                                                    width:
                                                                        size.width *
                                                                            0.3,
                                                                    height: 6.w,
                                                                    padding: const EdgeInsets
                                                                        .only(
                                                                        left:
                                                                            0),
                                                                    margin: EdgeInsets.only(
                                                                        right: 12
                                                                            .w),
                                                                    alignment:
                                                                        Alignment
                                                                            .center,
                                                                    decoration:
                                                                        BoxDecoration(
                                                                      color: AppColor
                                                                          .lightdark,
                                                                      borderRadius:
                                                                          BorderRadius.circular(
                                                                              1000.r),
                                                                    ),
                                                                  ),
                                                                ),
                                                                const SizedBox(
                                                                    height: 30),
                                                                const Text(
                                                                  "Terms of service",
                                                                  style: TextStyle(
                                                                      fontSize:
                                                                          18,
                                                                      color: AppColor
                                                                          .dark,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w700),
                                                                ),
                                                                const SizedBox(
                                                                    height: 20),
                                                                Column(
                                                                    crossAxisAlignment:
                                                                        CrossAxisAlignment
                                                                            .start,
                                                                    children: List
                                                                        .generate(
                                                                      items
                                                                          .length,
                                                                      (index) =>
                                                                          Row(
                                                                        crossAxisAlignment:
                                                                            CrossAxisAlignment.start,
                                                                        children: [
                                                                          Text(
                                                                            '${index + 1}. ',
                                                                            style: const TextStyle(
                                                                                fontWeight: FontWeight.bold,
                                                                                fontSize: 14,
                                                                                color: AppColor.dark),
                                                                          ),
                                                                          const SizedBox(
                                                                              width: 15),
                                                                          Expanded(
                                                                            child:
                                                                                Text(
                                                                              items[index],
                                                                              style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w700, color: AppColor.lightdark),
                                                                            ),
                                                                          ),
                                                                        ],
                                                                      ),
                                                                    )),
                                                                const SizedBox(
                                                                    height: 10),
                                                                const Text(
                                                                  "By scheduling a delivery, you agree to these terms.",
                                                                  style: TextStyle(
                                                                      fontSize:
                                                                          14,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w700,
                                                                      color: AppColor
                                                                          .lightdark),
                                                                ),
                                                                SizedBox(
                                                                    height: size
                                                                            .height *
                                                                        0.3),
                                                                Padding(
                                                                  padding: const EdgeInsets
                                                                      .symmetric(
                                                                      horizontal:
                                                                          20),
                                                                  child:
                                                                      AppButton(
                                                                    color: isGeneral !=
                                                                            null
                                                                        ? AppColor
                                                                            .primaryColor
                                                                        : AppColor
                                                                            .grey,
                                                                    title:
                                                                        'Okay',
                                                                    onTap: () {
                                                                      Navigator.of(
                                                                              context)
                                                                          .pop();
                                                                    },
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                          );
                                                        },
                                                      );
                                                    },
                                                  );
                                                },
                                              ),
                                            ],
                                          )),
                                      SizedBox(height: size.height * 0.3),
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 20),
                                        child: AppButton(
                                          color: isGeneral != null
                                              ? AppColor.primaryColor
                                              : AppColor.grey,
                                          title: 'Continue',
                                          onTap: () {
                                            HelperClass().modalTemplate(
                                                context,
                                                size.height * 0.6,
                                                scheduleSuccess(context));
                                          },
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              },
                            );
                          },
                        );
                      },
                      width: MediaQuery.sizeOf(context).width * 0.35,
                    ),
                    AppButton(
                      title: 'Next',
                      color: isDeliveryPartnerSet
                          ? AppColor.primaryColor
                          : AppColor.grey,
                      onTap: () {
                        if (isDeliveryPartnerSet) {
                          createOrder();
                        }
                      },
                      width: size.width * 0.35,
                    ),
                  ],
                ),
                const SizedBox(height: 30),
              ],
            ));
      default:
        return Container();
    }
  }
}
