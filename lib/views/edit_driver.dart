import 'package:drivers/connection/url_constants.dart';
import 'package:drivers/models/auth_model.dart';
import 'package:drivers/providers/drivers_provider.dart';
import 'package:drivers/widgets/custom_progress_indicator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/driver.dart';
import '../providers/auth_provider.dart';
import '../widgets/custom_textformfield.dart';

class EditDriver extends StatefulWidget {
  final Driver driver;
  const EditDriver({Key? key, required this.driver}) : super(key: key);

  @override
  State<EditDriver> createState() => _EditDriverState();
}

class _EditDriverState extends State<EditDriver> {
  final GlobalKey<FormState> _formKey = GlobalKey();
  final _formData = {};
  bool _isLoading = false;
  Future _editDriver({required User user}) async {
    if (!_formKey.currentState!.validate()) {
      return;
    }
    _formKey.currentState!.save();

    try {
      setState(() {
        _isLoading = true;
      });
      final msg =
          await Provider.of<DriversProvider>(context, listen: false).editDriver(
        editDriverReq: EditDriverReq(
          companyId: AppConstants.companyId,
          userId: widget.driver.userId ?? '',
          name: _formData['name'],
          phone: _formData['phone'],
          email: _formData['email'],
          address: _formData['address'],
          city: _formData['city'],
          state: _formData['state'],
          roles: ['driver'],
          token: user.token ?? '',
          driverId: widget.driver.id ?? '',
        ),
      );
      setState(() {
        _isLoading = false;
      });
      showDialog(
          context: context,
          builder: (ctx) => CupertinoAlertDialog(
                title: Text(msg),
                actions: [
                  CupertinoDialogAction(
                    child: const Text('Continue'),
                    onPressed: () async {
                      Navigator.pop(context);
                      Navigator.pop(context);
                      await Provider.of<DriversProvider>(context, listen: false)
                          .getAllDrivers(token: user.token!);
                    },
                  )
                ],
              ));
    } catch (e) {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final User? user = Provider.of<AuthProvider>(context, listen: false).user;
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Driver:  ${widget.driver.name}'),
      ),
      body: CustomProgressIndicator(
        isLoading: _isLoading,
        child: Form(
          key: _formKey,
          child: Padding(
            padding: const EdgeInsets.only(left: 24, right: 24, top: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                CustomTextFormField(
                  hintText: 'Driver Name',
                  controller: TextEditingController(text: widget.driver.name),
                  validator: (val) {
                    if (val!.isEmpty) {
                      return 'Enter driver name';
                    }
                    return null;
                  },
                  onSaved: (val) {
                    _formData['name'] = val;
                  },
                ),
                CustomTextFormField(
                  hintText: 'Driver Phone',
                  controller: TextEditingController(text: widget.driver.phone),
                  validator: (val) {
                    if (val!.isEmpty) {
                      return 'Enter driver phone';
                    }
                    return null;
                  },
                  onSaved: (val) {
                    _formData['phone'] = val;
                  },
                ),
                CustomTextFormField(
                  hintText: 'Driver Email',
                  controller: TextEditingController(text: widget.driver.email),
                  validator: (val) {
                    if (val!.isEmpty) {
                      return 'Enter driver email';
                    }
                    return null;
                  },
                  onSaved: (val) {
                    _formData['email'] = val;
                  },
                ),
                CustomTextFormField(
                  hintText: 'Driver Address',
                  controller:
                      TextEditingController(text: widget.driver.address),
                  validator: (val) {
                    if (val!.isEmpty) {
                      return 'Enter driver address';
                    }
                    return null;
                  },
                  onSaved: (val) {
                    _formData['address'] = val;
                  },
                ),
                CustomTextFormField(
                  hintText: 'Driver City',
                  controller: TextEditingController(text: widget.driver.city),
                  validator: (val) {
                    if (val!.isEmpty) {
                      return 'Enter driver city';
                    }
                    return null;
                  },
                  onSaved: (val) {
                    _formData['city'] = val;
                  },
                ),
                CustomTextFormField(
                  hintText: 'Driver State',
                  controller: TextEditingController(text: widget.driver.state),
                  validator: (val) {
                    if (val!.isEmpty) {
                      return 'Enter driver state';
                    }
                    return null;
                  },
                  onSaved: (val) {
                    _formData['state'] = val;
                  },
                ),
                const SizedBox(height: 30),
                ElevatedButton(
                  onPressed: () => _editDriver(user: user!),
                  child: const Text('Edit Driver'),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
