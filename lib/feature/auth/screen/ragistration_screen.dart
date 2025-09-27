import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:serialman_app/core/constansts/app_colors.dart';
import 'package:serialman_app/core/g_widgets/custom_dropdown/custom_dropdown.dart';
import 'package:serialman_app/core/g_widgets/custom_flushbar.dart';
import 'package:serialman_app/core/g_widgets/custom_labeltext.dart';
import 'package:serialman_app/core/g_widgets/custom_sanckbar.dart';
import 'package:serialman_app/core/g_widgets/custom_tab_selector/custom_tab_selector.dart';
import 'package:serialman_app/core/g_widgets/custom_text_field.dart';
import 'package:serialman_app/data/model/business_type_model/business_type_model.dart';
import 'package:serialman_app/data/model/user_model.dart';
import 'package:serialman_app/feature/auth/data/model/serviceTaker_register.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../bloc/auth_bloc.dart';
import '../bloc/auth_event.dart';
import '../bloc/auth_state.dart';
import '../data/model/registraotion_reqeust.dart';
import 'login_screen.dart';

class RegistrationScreen extends StatefulWidget {
  RegistrationScreen({super.key});

  @override
  State<RegistrationScreen> createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  UserType? _SelectUserType = UserType.ServiceCenter;
  final _formKey = GlobalKey<FormState>();
  AutovalidateMode _autovalidateMode = AutovalidateMode.disabled;

  bool obscureIndex = true;
  bool obscureIndex1 = true;
  final List<String> genderList = ["Male", "Female", "Other"];
  List<String> _saveItems = [];
  static const String _storageKey = "organization_names";
  final TextEditingController name = TextEditingController();
  final TextEditingController addressLine1 = TextEditingController();
  final TextEditingController addressLine2 = TextEditingController();
  final TextEditingController contactName = TextEditingController();
  final TextEditingController email = TextEditingController();
  final TextEditingController phone = TextEditingController();
  final TextEditingController organization = TextEditingController();
  final TextEditingController loginName = TextEditingController();
  final TextEditingController password = TextEditingController();
  final TextEditingController confirmPassword = TextEditingController();
  String? _selectedGender;
  BusinessType? _selectedBusinessType;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<AuthBloc>().add(LoadBusinessTypesEvent());
    });
    _loadSaveItems();
  }

  // serviceCenter registration handler
  void _handleServiceCenterRegistration() async {
    if (!_formKey.currentState!.validate()) {
      setState(() => _autovalidateMode = AutovalidateMode.always);
      return;
    }

    final request = RegistrationRequest(
      name: name.text.trim(),
      addressLine1: addressLine1.text.trim(),
      addressLine2: addressLine2.text.trim(),
      contactName: contactName.text.trim(),
      email: email.text.trim(),
      phone: phone.text.trim(),
      organizationName: organization.text.trim(),
      businessTypeId: _selectedBusinessType?.id,
      loginName: loginName.text.trim(),
      password: password.text,
    );
    context.read<AuthBloc>().add(RegistrationServiceCenterEvent(request));
  }

  // serviceTaker registration handler
  void _handleServiceTakerRegistration() async {
    // final authProvider = Provider.of<AuthProvider>(context, listen: false);
    if (!_formKey.currentState!.validate()) {
      setState(() => _autovalidateMode = AutovalidateMode.always);
      return;
    }

    final request = ServiceTakerRequest(
      name: name.text.trim(),
      email: email.text.trim(),
      phone: phone.text.trim(),
      loginName: loginName.text.trim(),
      password: password.text,
      gender: _selectedGender,
    );
    context.read<AuthBloc>().add(RegisterServiceTakerEvent(request));
  }

  //load  organization data
  Future<void> _loadSaveItems() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _saveItems = prefs.getStringList(_storageKey) ?? [];
    });
  }

  //save organization data
  Future<void> _saveNewItem(String newData) async {
    if (newData.trim().isEmpty || _saveItems.contains(newData.trim())) {
      return;
    }
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _saveItems.add(newData.trim());
    });
    await prefs.setStringList(_storageKey, _saveItems);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: BlocConsumer<AuthBloc, AuthState>(
        listener: (context, state) async {
          if (state is AuthSuccess) {
            await CustomFlushbar.showSuccess(
              context: context,
              title: "Success",
              message: "Registration Successful",
            );
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (context) => const LoginScreenBloc()),
              (route) => false,
            );
          } else if (state is AuthFailure) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: CustomSnackBarWidget(
                  title: "Error",
                  message: state.message,
                ),
                elevation: 0,
                backgroundColor: Colors.transparent,
                behavior: SnackBarBehavior.floating,
              ),
            );
          }
        },
        builder: (context, state) {
          if (state is AuthLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Form(
              key: _formKey,
              autovalidateMode: _autovalidateMode,
              child: Scaffold(
                backgroundColor: Colors.white,
                body: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 15,
                    vertical: 50,
                  ),
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            IconButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              icon: Icon(
                                Icons.arrow_back,
                                color: AppColor.primaryColor,
                              ),
                            ),
                            Text(
                              "Registration",
                              style: TextStyle(
                                color: AppColor.primaryColor,
                                fontSize: 25,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 20),
                        // Custom Tab Selector
                        CustomTabSelector<UserType>(
                          selectedValue: _SelectUserType,
                          items: const [
                            UserType.ServiceCenter,
                            UserType.ServiceTaker,
                          ],
                          onChanged: (UserType newValue) {
                            setState(() {
                              _SelectUserType = newValue;
                            });
                          },
                          itemTitleBuilder: (value) {
                            switch (value) {
                              case UserType.ServiceCenter:
                                return 'As Service Center';
                              case UserType.ServiceTaker:
                                return 'As Service Taker';
                            }
                          },
                          selectedIcon: Icons
                              .check, // Add a check icon to the selected tab
                        ),
                        //Service Center
                        Visibility(
                          visible: _SelectUserType == UserType.ServiceCenter,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 12,
                              vertical: 20,
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                CustomLabeltext("Name"),
                                SizedBox(height: 10),
                                CustomTextField(
                                  hintText: "Name",
                                  isPassword: false,
                                  controller: name,
                                ),
                                SizedBox(height: 10),
                                CustomLabeltext("Address Line 1"),
                                SizedBox(height: 10),
                                CustomTextField(
                                  hintText: "Address Line 1",
                                  isPassword: false,
                                  controller: addressLine1,
                                ),
                                SizedBox(height: 10),
                                CustomLabeltext(
                                  "Address Line 2",
                                  showStar: false,
                                ),
                                SizedBox(height: 10),
                                CustomTextField(
                                  controller: addressLine2,
                                  enableValidation: false,
                                  hintText: "Address Line 2",
                                  isPassword: false,
                                ),
                                SizedBox(height: 10),
                                CustomLabeltext("Contact Name"),
                                SizedBox(height: 10),
                                CustomTextField(
                                  hintText: "Contact Name",
                                  isPassword: false,
                                  controller: contactName,
                                ),
                                SizedBox(height: 10),
                                CustomLabeltext(
                                  "Email Address",
                                  showStar: false,
                                ),
                                SizedBox(height: 10),
                                CustomTextField(
                                  hintText: "Email Address",
                                  isPassword: false,
                                  controller: email,
                                  enableValidation: false,
                                  keyboardType: TextInputType.emailAddress,
                                ),
                                SizedBox(height: 10),
                                CustomLabeltext("Mobile Number"),
                                SizedBox(height: 10),
                                CustomTextField(
                                  hintText: "Mobile Number",
                                  isPassword: false,
                                  controller: phone,
                                  keyboardType: TextInputType.number,
                                ),
                                SizedBox(height: 10),
                                CustomLabeltext("Business Type"),
                                SizedBox(height: 10),
                                BlocBuilder<AuthBloc, AuthState>(
                                  builder: (context, state) {
                                    if (state is BusinessTypeLoading) {
                                      return const Center(
                                        child: CircularProgressIndicator(),
                                      );
                                    } else if (state is BusinessTypeLoaded) {
                                      return CustomDropdown<BusinessType>(
                                        hinText: "Select Business Type",
                                        items: state.businessTypes,
                                        value: _selectedBusinessType,
                                        onChanged: (val) {
                                          setState(
                                            () => _selectedBusinessType = val,
                                          );
                                        },
                                        itemAsString: (type) => type.name,
                                        selectedItem: _selectedBusinessType,
                                        validator: (val) => val == null
                                            ? "Please select a business type"
                                            : null,
                                      );
                                    } else if (state is BusinessTypeError) {
                                      return Text(
                                        state.message,
                                        style: TextStyle(color: Colors.red),
                                      );
                                    } else {
                                      return const SizedBox();
                                    }
                                  },
                                ),

                                SizedBox(height: 10),
                                if (_selectedBusinessType?.id == 1) ...[
                                  Text(
                                    "Organization",
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 15.50,
                                    ),
                                  ),
                                  SizedBox(height: 12),
                                  Autocomplete<String>(
                                    initialValue: TextEditingValue(
                                      text: organization.text,
                                    ),
                                    optionsBuilder:
                                        (TextEditingValue textEditingValue) {
                                          if (textEditingValue.text.isEmpty) {
                                            return _saveItems;
                                          }
                                          return _saveItems.where((
                                            String option,
                                          ) {
                                            return option
                                                .toLowerCase()
                                                .contains(
                                                  textEditingValue.text
                                                      .toLowerCase(),
                                                );
                                          });
                                        },
                                    onSelected: (String selection) {
                                      // _textEditingController.text = selection;
                                      setState(() {
                                        organization.text = selection;
                                      });
                                      _saveNewItem(selection);
                                      debugPrint(
                                        'You just selected $selection',
                                      );
                                      FocusScope.of(context).unfocus();
                                    },
                                    fieldViewBuilder:
                                        (
                                          BuildContext context,
                                          TextEditingController
                                          fieldTextEditingController,
                                          FocusNode focusNode,
                                          VoidCallback onFieldSubmitted,
                                        ) {
                                          if (organization.text.isNotEmpty &&
                                              fieldTextEditingController.text !=
                                                  organization.text) {
                                            fieldTextEditingController.text =
                                                organization.text;
                                          }

                                          return TextField(
                                            controller:
                                                fieldTextEditingController,
                                            focusNode: focusNode,
                                            cursorColor: Colors.grey.shade500,
                                            decoration: InputDecoration(
                                              contentPadding:
                                                  EdgeInsets.symmetric(
                                                    horizontal: 12,
                                                    vertical: 14,
                                                  ),
                                              isDense: true,
                                              focusedBorder: OutlineInputBorder(
                                                borderSide: BorderSide(
                                                  color: AppColor.primaryColor,
                                                  width: 2,
                                                ),
                                              ),
                                              hintText: "Organization",
                                              hintStyle: TextStyle(
                                                color: Colors.grey.shade400,
                                              ),
                                              enabledBorder: OutlineInputBorder(
                                                borderSide: BorderSide(
                                                  color: Colors.grey.shade400,
                                                ),
                                              ),
                                              border: OutlineInputBorder(),
                                            ),
                                            onSubmitted: (String value) {
                                              final trimmerValue = value.trim();
                                              if (trimmerValue.isNotEmpty) {
                                                _saveNewItem(value);

                                                fieldTextEditingController
                                                    .clear();

                                                setState(() {
                                                  organization.clear();
                                                  //Organization.text = value;
                                                });
                                              }
                                              onFieldSubmitted();
                                            },
                                            onChanged: (value) {
                                              // _textEditingController.text = value;
                                              organization.text = value;
                                            },
                                          );
                                        },
                                    optionsViewBuilder:
                                        (context, onSelected, options) {
                                          return Align(
                                            alignment: Alignment.topLeft,
                                            child: Material(
                                              elevation: 4.0,
                                              child: Container(
                                                height: 150,
                                                width:
                                                    MediaQuery.of(
                                                      context,
                                                    ).size.width *
                                                    0.86,
                                                constraints: BoxConstraints(
                                                  maxWidth: 600,
                                                ),
                                                child: Scrollbar(
                                                  thickness: 2,
                                                  controller:
                                                      ScrollController(),
                                                  radius: Radius.circular(50),
                                                  scrollbarOrientation:
                                                      ScrollbarOrientation.left,
                                                  thumbVisibility: true,
                                                  trackVisibility: true,
                                                  child: ListView.separated(
                                                    padding: EdgeInsets.zero,
                                                    //shrinkWrap: true,
                                                    itemCount: options.length,
                                                    itemBuilder: (context, index) {
                                                      final option = options
                                                          .elementAt(index);
                                                      return InkWell(
                                                        onTap: () =>
                                                            onSelected(option),
                                                        child: ListTile(
                                                          title: Padding(
                                                            padding:
                                                                const EdgeInsets.symmetric(
                                                                  horizontal:
                                                                      16.0,
                                                                ),
                                                            child: Text(option),
                                                          ),
                                                          hoverColor: Colors
                                                              .grey
                                                              .shade200,
                                                        ),
                                                      );
                                                    },
                                                    separatorBuilder:
                                                        (
                                                          BuildContext context,
                                                          int index,
                                                        ) {
                                                          return Divider(
                                                            height: 1,
                                                            thickness: 1,
                                                            color: Colors
                                                                .grey
                                                                .shade200,
                                                          );
                                                        },
                                                  ),
                                                ),
                                              ),
                                            ),
                                          );
                                        },
                                  ),
                                ],
                                SizedBox(height: 10),
                                CustomLabeltext("Login Name"),
                                SizedBox(height: 10),
                                CustomTextField(
                                  hintText: "Login name",
                                  isPassword: false,
                                  controller: loginName,
                                ),
                                SizedBox(height: 10),
                                CustomLabeltext("Password"),
                                SizedBox(height: 10),
                                CustomTextField(
                                  hintText: "Password",
                                  isPassword: true,
                                  controller: password,
                                ),
                                SizedBox(height: 10),
                                CustomLabeltext("Confirm Password"),
                                SizedBox(height: 10),
                                TextFormField(
                                  onChanged: (value) {
                                    setState(
                                      () => _autovalidateMode =
                                          AutovalidateMode.always,
                                    );
                                    _formKey.currentState?.validate();
                                  },
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return "Required";
                                    } else {
                                      if (value != password.text) {
                                        return "Passwords do not match";
                                      }
                                    }
                                    return null;
                                  },
                                  controller: confirmPassword,
                                  decoration: InputDecoration(
                                    contentPadding: const EdgeInsets.symmetric(
                                      horizontal: 14,
                                      vertical: 12,
                                    ),
                                    isDense: true,
                                    border: OutlineInputBorder(
                                      borderSide: BorderSide(
                                        color: AppColor.primaryColor,
                                        width: 2,
                                      ),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                        color: AppColor.primaryColor,
                                        width: 2,
                                      ),
                                    ),
                                    enabledBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                        color: Colors.grey.shade400,
                                      ),
                                    ),
                                    hintText: "Confirm password",
                                    hintStyle: TextStyle(
                                      color: Colors.grey.shade400,
                                      fontSize: 15,
                                    ),
                                    suffixIcon: IconButton(
                                      onPressed: () {
                                        setState(() {
                                          obscureIndex1 = !obscureIndex1;
                                          _formKey.currentState?.validate();
                                        });
                                      },
                                      icon: Icon(
                                        obscureIndex1
                                            ? Icons.visibility_off_outlined
                                            : Icons.visibility_off_outlined,
                                        color: Colors.grey.shade500,
                                      ),
                                    ),
                                  ),
                                  cursorColor: Colors.grey.shade500,
                                  obscureText: obscureIndex1,
                                  obscuringCharacter: "*",
                                ),
                                SizedBox(height: 20),
                                BlocBuilder<AuthBloc, AuthState>(
                                  builder: (context, state) {
                                    final isLoading = state is AuthLoading;

                                    return GestureDetector(
                                      onTap: isLoading
                                          ? null
                                          : _handleServiceCenterRegistration,
                                      child: Container(
                                        height: 43,
                                        width: double.infinity,
                                        decoration: BoxDecoration(
                                          color: AppColor.primaryColor,
                                          borderRadius: BorderRadius.circular(
                                            5,
                                          ),
                                        ),
                                        child: Center(
                                          child: Text(
                                            isLoading
                                                ? "Please Wait..."
                                                : "Register",
                                            style: const TextStyle(
                                              color: Colors.white,
                                              fontSize: 18,
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                        ),
                                      ),
                                    );
                                  },
                                ),
                              ],
                            ),
                          ),
                        ),

                        //Service Taker Option
                        Visibility(
                          visible: _SelectUserType == UserType.ServiceTaker,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 12,
                              vertical: 20,
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                CustomLabeltext("Name"),
                                SizedBox(height: 10),
                                CustomTextField(
                                  hintText: "Name",
                                  isPassword: false,
                                  controller: name,
                                ),
                                SizedBox(height: 10),
                                CustomLabeltext("Email"),
                                SizedBox(height: 10),
                                CustomTextField(
                                  controller: email,
                                  hintText: "Email",
                                  enableValidation: false,
                                  isPassword: false,
                                  keyboardType: TextInputType.emailAddress,
                                ),
                                SizedBox(height: 10),
                                CustomLabeltext("Mobile Number"),
                                SizedBox(height: 12),
                                CustomTextField(
                                  hintText: "Mobile Number",
                                  isPassword: false,
                                  controller: phone,
                                ),
                                SizedBox(height: 10),
                                CustomLabeltext("Gender"),
                                SizedBox(height: 12),
                                CustomDropdown<String>(
                                  selectedItem: _selectedGender,
                                  items: genderList,
                                  value: _selectedGender,
                                  itemAsString: (item) => item,
                                  // validator: (value) {
                                  //   if (value == null)
                                  //     return "Please select a Gender";
                                  //   return null;
                                  // },
                                  onChanged: (newValue) {
                                    setState(() {
                                      _selectedGender = newValue;
                                    });
                                  },
                                  child: Container(
                                    padding: EdgeInsets.symmetric(
                                      horizontal: 16,
                                      vertical: 12,
                                    ),
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                        color: Colors.grey.shade400,
                                      ),
                                      borderRadius: BorderRadius.circular(5.0),
                                    ),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          _selectedGender ?? "Select Gender",
                                          style: TextStyle(
                                            color: _selectedGender != null
                                                ? Colors.black
                                                : Colors.grey.shade600,
                                          ),
                                        ),
                                        Icon(
                                          Icons.arrow_drop_down,
                                          color: Colors.grey.shade600,
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                SizedBox(height: 10),
                                CustomLabeltext("Login Name"),
                                SizedBox(height: 12),
                                CustomTextField(
                                  hintText: "Login name",
                                  isPassword: false,
                                  controller: loginName,
                                ),
                                SizedBox(height: 10),
                                CustomLabeltext("Password"),
                                SizedBox(height: 12),
                                CustomTextField(
                                  hintText: "Passwrod",
                                  isPassword: true,
                                  controller: password,
                                ),
                                SizedBox(height: 10),
                                CustomLabeltext("Confirm Password"),
                                SizedBox(height: 12),
                                TextFormField(
                                  onChanged: (value) {
                                    setState(
                                      () => _autovalidateMode =
                                          AutovalidateMode.always,
                                    );
                                    _formKey.currentState?.validate();
                                  },
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return "Required";
                                    } else {
                                      if (value != password.text) {
                                        return "Passwords do not match";
                                      }
                                    }
                                    return null;
                                  },
                                  cursorColor: Colors.grey.shade500,
                                  controller: confirmPassword,
                                  decoration: InputDecoration(
                                    contentPadding: const EdgeInsets.symmetric(
                                      horizontal: 14,
                                      vertical: 12,
                                    ),
                                    isDense: true,
                                    border: OutlineInputBorder(
                                      borderSide: BorderSide(
                                        color: Colors.grey.shade400,
                                      ),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                        color: AppColor.primaryColor,
                                        width: 2,
                                      ),
                                    ),
                                    enabledBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                        color: Colors.grey.shade400,
                                      ),
                                    ),
                                    hintText: "Confirm password",
                                    hintStyle: TextStyle(
                                      color: Colors.grey.shade400,
                                      fontSize: 15,
                                    ),
                                    suffixIcon: IconButton(
                                      onPressed: () {
                                        setState(() {
                                          obscureIndex1 = !obscureIndex1;
                                        });
                                      },
                                      icon: Icon(
                                        obscureIndex1
                                            ? Icons.visibility_off_outlined
                                            : Icons.visibility_off_outlined,
                                        color: Colors.grey.shade500,
                                      ),
                                    ),
                                  ),
                                  obscureText: obscureIndex1,
                                  obscuringCharacter: "*",
                                ),
                                SizedBox(height: 20),
                                BlocBuilder<AuthBloc, AuthState>(
                                  builder: (context, state) {
                                    final isLoading = state is AuthLoading;

                                    return GestureDetector(
                                      onTap: isLoading
                                          ? null
                                          : _handleServiceTakerRegistration,
                                      child: Container(
                                        height: 43,
                                        width: double.infinity,
                                        decoration: BoxDecoration(
                                          color: AppColor.primaryColor,
                                          borderRadius: BorderRadius.circular(
                                            5,
                                          ),
                                        ),
                                        child: Center(
                                          child: Text(
                                            isLoading
                                                ? "Please Wait..."
                                                : "Register",
                                            style: const TextStyle(
                                              color: Colors.white,
                                              fontSize: 18,
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                        ),
                                      ),
                                    );
                                  },
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
