import 'package:drivers/connection/url_constants.dart';
import 'package:drivers/models/auth_model.dart';
import 'package:drivers/models/driver.dart';
import 'package:drivers/providers/auth_provider.dart';
import 'package:drivers/providers/drivers_provider.dart';
import 'package:drivers/widgets/custom_progress_indicator.dart';
import 'package:drivers/widgets/custom_textformfield.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AddDriver extends StatefulWidget {
  const AddDriver({Key? key}) : super(key: key);

  @override
  State<AddDriver> createState() => _AddDriverState();
}

class _AddDriverState extends State<AddDriver> {
  final GlobalKey<FormState> _formKey = GlobalKey();
  final _formData = {};
  bool _isLoading = false;

  Future _addDriver({required User user}) async {
    if (!_formKey.currentState!.validate()) {
      return;
    }
    _formKey.currentState!.save();
    try {
      setState(() {
        _isLoading = true;
      });
      final msg =
          await Provider.of<DriversProvider>(context, listen: false).addDrivers(
              addDriverReq: AddDriverReq(
        companyId: AppConstants.companyId,
        userId: user.userId ?? 'userID',
        name: _formData['name'],
        phone: _formData['phone'],
        email: _formData['email'],
        address: _formData['address'],
        city: _formData['city'],
        state: _formData['state'],
        roles: ['driver'],
        token: user.token ?? 'token',
      ));
      setState(() {
        _isLoading = false;
      });
      showDialog(
        context: context,
        builder: (ctx) => CupertinoAlertDialog(
          title: Text(msg),
          actions: [
            CupertinoDialogAction(
              onPressed: () async {
                Navigator.pop(context);
                Navigator.pop(context);
                await Provider.of<DriversProvider>(context, listen: false)
                    .getAllDrivers(token: user.token ?? 'token');
              },
              child: const Text('OK'),
            )
          ],
        ),
      );
    } catch (e) {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Driver'),
      ),
      body: CustomProgressIndicator(
        isLoading: _isLoading,
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.only(left: 24, right: 24, top: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  CustomTextFormField(
                    hintText: 'Driver Name',
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
                    onPressed: () => _addDriver(
                        user: Provider.of<AuthProvider>(context, listen: false)
                            .user!),
                    child: const Text('Add Driver'),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
