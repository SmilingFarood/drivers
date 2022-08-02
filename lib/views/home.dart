import 'package:drivers/models/auth_model.dart';
import 'package:drivers/providers/auth_provider.dart';
import 'package:drivers/providers/drivers_provider.dart';
import 'package:drivers/views/add_driver.dart';
import 'package:drivers/views/driver_details.dart';
import 'package:drivers/widgets/custom_progress_indicator.dart';
import 'package:flutter/cupertino.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  bool _isLoading = false;
  bool _hasLoaded = false;
  @override
  void didChangeDependencies() async {
    if (!_hasLoaded) {
      setState(() {
        _isLoading = true;
      });
      final User? user = Provider.of<AuthProvider>(context, listen: false).user;
      await Provider.of<DriversProvider>(context, listen: false)
          .getAllDrivers(token: user!.token!);
    }
    setState(() {
      _isLoading = false;
      _hasLoaded = true;
    });
    super.didChangeDependencies();
  }

  Future _deleteDriver({required String driverId}) async {
    try {
      setState(() {
        _isLoading = true;
      });
      final User? user = Provider.of<AuthProvider>(context, listen: false).user;
      final msg = await Provider.of<DriversProvider>(context, listen: false)
          .deleteDriver(driverId: driverId, token: user!.token!);

      // ignore: use_build_context_synchronously
      await Provider.of<DriversProvider>(context, listen: false)
          .getAllDrivers(token: user.token!);
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
              onPressed: () => Navigator.pop(context),
            )
          ],
        ),
      );
    } catch (e) {
//
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: const Text('All Drivers'),
        actions: [
          IconButton(
            onPressed: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (ctx) => const AddDriver(),
                )),
            icon: const Icon(Icons.person_add),
          )
        ],
      ),
      body: CustomProgressIndicator(
        isLoading: _isLoading,
        child: Consumer<DriversProvider>(
          builder: (ctx, snap, _) {
            if (snap.drivers.isEmpty) {
              return const Center(
                child: Text('List Is Empty'),
              );
            } else {
              return ListView.builder(
                  itemCount: snap.drivers.length,
                  itemBuilder: (ctx, i) {
                    int count = 1;
                    return ListTile(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (ctx) => DriverDetails(
                                driver: snap.drivers[i],
                              ),
                            ));
                      },
                      title: Text(snap.drivers[i].name ?? 'name'),
                      subtitle: Text(snap.drivers[i].companyName ?? ''),
                      trailing: IconButton(
                        onPressed: () =>
                            _deleteDriver(driverId: snap.drivers[i].id ?? ''),
                        icon: const Icon(
                          Icons.delete,
                          color: Colors.red,
                        ),
                      ),
                      leading: CircleAvatar(
                        child: Text('${count + i}'),
                      ),
                    );
                  });
            }
          },
        ),
      ),
    );
  }
}
