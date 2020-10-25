import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:provider/provider.dart';

import './user.dart';

class SignupScreen extends StatefulWidget {
  static const routeName = "gat-entry";

  @override
  _SignupScreenState createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final _form = GlobalKey<FormState>();

  // Validation of Name in  the form
  bool _nameValidtion(String name) {
    const Pattern patternNameOnlyChar = r"(\w+)";
    RegExp regexName = new RegExp(patternNameOnlyChar);
    print(!regexName.hasMatch(name) ? false : true);
    return !regexName.hasMatch(name) ? false : true;
  }

  // Validation of email in  the form
  bool _emailValidtion(String email) {
    const Pattern patternEmail =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regexName = new RegExp(patternEmail);
    print(!regexName.hasMatch(email) ? false : true);
    return !regexName.hasMatch(email) ? false : true;
  }

  var _newUser = User(
    id: null,
    userType: null,
    mobileNumber: null,
    name: null,
    email: null,
    password: null,
    houseNumberId: null,
    userStatus: null,
    occupancyStatus: null,
  );

  var _isInit = true;
  var _isLoading = false;

  @override
  void initState() {
    super.initState();
    _newUser = User(
      id: _newUser.id,
      userType: _newUser.userType,
      mobileNumber: _newUser.mobileNumber,
      name: _newUser.name,
      email: _newUser.email,
      password: _newUser.password,
      houseNumberId: _newUser.houseNumberId,
      userStatus: _newUser.userStatus,
      occupancyStatus: _newUser.occupancyStatus,
    );
  }

  List<String> city = [
    "Suart",
    "vadodara",
    "Ahmedabad",
    "Jaypur",
    "Mumbai",
    "Chennai",
    "Bharuch",
  ];

  List<String> society = [
    "Radhika Homes",
    "Shubh Vatika",
  ];

  List<String> building = [
    "A",
    "B",
    "C",
    "D",
    "E",
    "F",
    "H",
    "I",
    "J",
  ];

  List<String> flat = [
    "101",
    "102",
    "201",
    "202",
    "301",
    "302",
    "401",
    "402",
    "501",
    "502",
  ];

  String _name = null;
  String _email = null;
  String _city = null;
  String _society = null;
  String _building = null;
  String _houseNumber = null;
  UserType _userType = null;
  UserStatus _userStatus = null;
  OccupancyStatus _occupancyStatus = null;

  Widget cityDropDown() {
    return DropdownButtonFormField<String>(
      decoration: InputDecoration(labelText: 'City'),
      items: city.map((String value) {
        return new DropdownMenuItem<String>(
          value: value,
          child: new Text(value),
        );
      }).toList(),
      onChanged: (value) {
        setState(
          () {
            _city = value;
          },
        );
      },
    );
  }

  Widget societyDropDown() {
    return DropdownButtonFormField<String>(
      decoration: InputDecoration(labelText: 'Society'),
      items: society.map((String value) {
        return new DropdownMenuItem<String>(
          value: value,
          child: new Text(value),
        );
      }).toList(),
      onChanged: (value) {
        setState(
          () {
            _society = value;
          },
        );
      },
    );
  }

  Widget signupButton() {
    return RaisedButton(
      child: Text('SUBMIT'),
      onPressed: _saveForm,
      elevation: 0,
      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
      color: Theme.of(context).accentColor,
    );
  }

  Future<void> _saveForm() async {
    final isValid = _form.currentState.validate();
    if (!isValid) {
      return;
    }
    _form.currentState.save();
    setState(() {
      _isLoading = true;
    });

    _newUser = User(
      id: _newUser.id,
      userType: _newUser.userType,
      mobileNumber: _newUser.mobileNumber,
      name: _newUser.name,
      email: _newUser.email,
      password: "123456",
      houseNumberId: _newUser.houseNumberId,
      userStatus: _newUser.userStatus,
      occupancyStatus: _newUser.occupancyStatus,
    );
    print("....");
    print("User Id : " + _newUser.id);
    print(_newUser.userType.toString());
    print(_newUser.mobileNumber);
    print(_newUser.name);
    print(_newUser.email);
    print(_newUser.password);
    print(_newUser.houseNumberId);
    print(_newUser.userStatus.toString());
    print(_newUser.occupancyStatus.toString());
    try {
      await Provider.of<User>(context, listen: false).addNewUser(_newUser);
    } catch (error) {
      print(error);
      await showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
          title: Text('An error occurred!'),
          content: Text('Something went wrong.'),
          actions: <Widget>[
            FlatButton(
              child: Text('Okay'),
              onPressed: () {
                Navigator.of(ctx).pop();
              },
            )
          ],
        ),
      );
    }
    // finally {
    //   setState(() {
    //     _isLoading = false;
    //   });
    //   Navigator.of(context).pop();
    // }

    setState(() {
      _isLoading = false;
    });
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Signup',
          textAlign: TextAlign.center,
        ),
      ),
      body: FutureBuilder(
        future: FirebaseAuth.instance.currentUser(),
        builder: (context, snapshot) {
          FirebaseUser firebaseUser = snapshot.data;
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
            child: Form(
              key: _form,
              child: ListView(
                children: <Widget>[
                  DropdownButtonFormField<UserType>(
                    //value: _value,
                    decoration: InputDecoration(labelText: 'User Type'),
                    items: [
                      DropdownMenuItem(
                        child: Text("Resident"),
                        value: UserType.Member,
                      ),
                      DropdownMenuItem(
                        child: Text("Higher Authority"),
                        value: UserType.HigherAuthority,
                      ),
                      DropdownMenuItem(
                        child: Text("Security Guard"),
                        value: UserType.SecurityGuard,
                      ),
                    ],
                    onChanged: (UserType value) {
                      setState(
                        () {
                          _userType = value;
                          _city = null;
                          _society = null;
                        },
                      );
                    },
                    onSaved: (UserType value) {
                      _newUser = User(
                        id: firebaseUser.uid,
                        userType: value,
                        mobileNumber: firebaseUser.phoneNumber,
                        name: _newUser.name,
                        email: _newUser.email,
                        password: _newUser.password,
                        houseNumberId: _newUser.houseNumberId,
                        userStatus: _newUser.userStatus,
                        occupancyStatus: _newUser.occupancyStatus,
                      );
                    },
                    elevation: 2,
                  ),
                  if (_userType == UserType.SecurityGuard) ...[
                    cityDropDown(),
                    if (_city != null) ...[
                      societyDropDown(),
                      if (_society != null) ...[
                        signupButton(),
                      ],
                    ],
                  ],
                  if ((_userType != null) &&
                      (_userType == UserType.Member ||
                          _userType == UserType.HigherAuthority)) ...[
                    TextFormField(
                      //initialValue: _initValues['name'],
                      decoration: InputDecoration(labelText: 'Name'),
                      textInputAction: TextInputAction.next,
                      onFieldSubmitted: (_) {
                        //FocusScope.of(context).requestFocus(_categoryFocusNode);
                      },
                      validator: (value) {
                        print(value);
                        if (value.isEmpty) {
                          return 'Please provide a name.';
                        } else if (!_nameValidtion(value)) {
                          return 'Please provide correct name';
                        }
                        return null;
                      },
                      onChanged: (value) {
                        setState(() {
                          _name = value;
                        });
                      },
                      onSaved: (value) {
                        _newUser = User(
                          id: _newUser.id,
                          userType: _newUser.userType,
                          mobileNumber: _newUser.mobileNumber,
                          name: value,
                          email: _newUser.email,
                          password: _newUser.password,
                          houseNumberId: _newUser.houseNumberId,
                          userStatus: _newUser.userStatus,
                          occupancyStatus: _newUser.occupancyStatus,
                        );
                      },
                    ),
                    TextFormField(
                      //initialValue: _initValues['name'],
                      decoration: InputDecoration(
                        labelText: 'Email',
                        hintText: 'Email (Optional)',
                      ),
                      textInputAction: TextInputAction.next,
                      onFieldSubmitted: (_) {
                        //FocusScope.of(context).requestFocus(_categoryFocusNode);
                      },
                      validator: (value) {
                        print(value);
                        if (!_emailValidtion(value)) {
                          return 'Please provide correct email';
                        }
                        return null;
                      },
                      onChanged: (value) {
                        setState(() {
                          _email = value;
                        });
                      },
                      onSaved: (value) {
                        _newUser = User(
                          id: _newUser.id,
                          userType: _newUser.userType,
                          mobileNumber: _newUser.mobileNumber,
                          name: _newUser.name,
                          email: value,
                          password: _newUser.password,
                          houseNumberId: _newUser.houseNumberId,
                          userStatus: _newUser.userStatus,
                          occupancyStatus: _newUser.occupancyStatus,
                        );
                      },
                    ),
                    if (_name != null) ...[
                      cityDropDown(),
                      if (_city != null) ...[
                        societyDropDown(),
                        if (_society != null) ...[
                          new DropdownButtonFormField<String>(
                            decoration:
                                InputDecoration(labelText: 'Building/Street'),
                            items: building.map((String value) {
                              return new DropdownMenuItem<String>(
                                value: value,
                                child: new Text(value),
                              );
                            }).toList(),
                            onChanged: (value) {
                              setState(() {
                                _building = value;
                              });
                            },
                          ),
                          if (_building != null) ...[
                            new DropdownButtonFormField<String>(
                              decoration:
                                  InputDecoration(labelText: 'House No.'),
                              items: flat.map((String value) {
                                return new DropdownMenuItem<String>(
                                  value: value,
                                  child: new Text(value),
                                );
                              }).toList(),
                              onChanged: (value) {
                                setState(() {
                                  _houseNumber = value;
                                });
                              },
                              onSaved: (value) {
                                _newUser = User(
                                  id: _newUser.id,
                                  userType: _newUser.userType,
                                  mobileNumber: _newUser.mobileNumber,
                                  name: _newUser.name,
                                  email: _newUser.email,
                                  password: _newUser.password,
                                  houseNumberId: value,
                                  userStatus: _newUser.userStatus,
                                  occupancyStatus: _newUser.occupancyStatus,
                                );
                              },
                            ),
                            if (_houseNumber != null) ...[
                              DropdownButtonFormField<UserStatus>(
                                //value: _value,
                                decoration:
                                    InputDecoration(labelText: 'You are'),
                                items: [
                                  DropdownMenuItem(
                                    child: Text("Owner"),
                                    value: UserStatus.Owner,
                                  ),
                                  DropdownMenuItem(
                                    child: Text("Renter"),
                                    value: UserStatus.Renter,
                                  ),
                                ],
                                onChanged: (UserStatus value) {
                                  setState(
                                    () {
                                      _userStatus = value;
                                    },
                                  );
                                },
                                onSaved: (UserStatus value) {
                                  _newUser = User(
                                    id: _newUser.id,
                                    userType: _newUser.userType,
                                    mobileNumber: _newUser.mobileNumber,
                                    name: _newUser.name,
                                    email: _newUser.email,
                                    password: _newUser.password,
                                    houseNumberId: _newUser.houseNumberId,
                                    userStatus: value,
                                    occupancyStatus: _newUser.occupancyStatus,
                                  );
                                },
                                elevation: 2,
                              ),
                              if (_userStatus != null) ...[
                                DropdownButtonFormField<OccupancyStatus>(
                                  //value: _value,
                                  decoration: InputDecoration(
                                      labelText: 'Occupancy Status'),
                                  items: [
                                    DropdownMenuItem(
                                      child: Text("Currently Residing"),
                                      value: OccupancyStatus.CurrentlyResiding,
                                    ),
                                    DropdownMenuItem(
                                      child: Text("Empty House"),
                                      value: OccupancyStatus.EmptyHouse,
                                    ),
                                  ],
                                  onChanged: (OccupancyStatus value) {
                                    setState(
                                      () {
                                        _occupancyStatus = value;
                                      },
                                    );
                                  },
                                  onSaved: (OccupancyStatus value) {
                                    _newUser = User(
                                      id: _newUser.id,
                                      userType: _newUser.userType,
                                      mobileNumber: _newUser.mobileNumber,
                                      name: _newUser.name,
                                      email: _newUser.email,
                                      password: _newUser.password,
                                      houseNumberId: _newUser.houseNumberId,
                                      userStatus: _newUser.userStatus,
                                      occupancyStatus: value,
                                    );
                                  },
                                  elevation: 2,
                                ),
                                if (_occupancyStatus != null) ...[
                                  signupButton(),
                                ],
                              ],
                            ],
                          ],
                        ],
                      ],
                    ],
                  ],
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
