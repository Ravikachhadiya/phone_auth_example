import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

enum UserType {
  Member,
  HigherAuthority,
  SecurityGuard,
}

enum UserStatus {
  Owner,
  Renter,
}

enum OccupancyStatus {
  CurrentlyResiding,
  EmptyHouse,
}

class SignupScreen extends StatefulWidget {
  static const routeName = "gat-entry";

  @override
  _SignupScreenState createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
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
      child: Text('SAVE ENTRY'),
      onPressed: () {},
      elevation: 0,
      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
      color: Theme.of(context).accentColor,
    );
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
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
        child: Form(
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
                  // _editedPersonEntry = PersonEntry(
                  //   id: _editedPersonEntry.id,
                  //   name: _editedPersonEntry.name,
                  //   category: value,
                  //   time: _editedPersonEntry.time,
                  //   code: _editedPersonEntry.code,
                  //   dateTime: _editedPersonEntry.dateTime,
                  // );
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
                    // if (value.isEmpty) {
                    //   return 'Please provide a name.';
                    // } else if (_nameValidtion(value)) {
                    //   return 'Please provide correct name';
                    // }
                    return null;
                  },
                  onChanged: (value) {
                    setState(() {
                      _name = value;
                    });
                  },
                  onSaved: (value) {
                    // _editedPersonEntry = PersonEntry(
                    //   id: _editedPersonEntry.id,
                    //   name: value,
                    //   category: _editedPersonEntry.category,
                    //   time: _editedPersonEntry.time,
                    //   code: _editedPersonEntry.code,
                    //   dateTime: _editedPersonEntry.dateTime,
                    // );
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
                    // if (value.isEmpty) {
                    //   return 'Please provide a name.';
                    // } else if (_nameValidtion(value)) {
                    //   return 'Please provide correct name';
                    // }
                    return null;
                  },
                  onChanged: (value) {
                    setState(() {
                      _email = value;
                    });
                  },
                  onSaved: (value) {
                    // _editedPersonEntry = PersonEntry(
                    //   id: _editedPersonEntry.id,
                    //   name: value,
                    //   category: _editedPersonEntry.category,
                    //   time: _editedPersonEntry.time,
                    //   code: _editedPersonEntry.code,
                    //   dateTime: _editedPersonEntry.dateTime,
                    // );
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
                          decoration: InputDecoration(labelText: 'House No.'),
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
                        ),
                        if (_houseNumber != null) ...[
                          DropdownButtonFormField<UserStatus>(
                            //value: _value,
                            decoration: InputDecoration(labelText: 'You are'),
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
                              // _editedPersonEntry = PersonEntry(
                              //   id: _editedPersonEntry.id,
                              //   name: _editedPersonEntry.name,
                              //   category: value,
                              //   time: _editedPersonEntry.time,
                              //   code: _editedPersonEntry.code,
                              //   dateTime: _editedPersonEntry.dateTime,
                              // );
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
                                // _editedPersonEntry = PersonEntry(
                                //   id: _editedPersonEntry.id,
                                //   name: _editedPersonEntry.name,
                                //   category: value,
                                //   time: _editedPersonEntry.time,
                                //   code: _editedPersonEntry.code,
                                //   dateTime: _editedPersonEntry.dateTime,
                                // );
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
      ),
    );
  }
}
