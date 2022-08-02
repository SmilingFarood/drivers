import 'package:drivers/models/driver.dart';
import 'package:drivers/views/edit_driver.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DriverDetails extends StatelessWidget {
  final Driver driver;
  const DriverDetails({Key? key, required this.driver}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(driver.name ?? 'Driver Name'),
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 20, right: 20, top: 20),
        child: Column(
          children: [
            _tile(title: 'Name', content: driver.name ?? 'Name'),
            _tile(title: 'Phone', content: driver.phone ?? 'Phone'),
            _tile(title: 'Email', content: driver.email ?? 'email'),
            _tile(title: 'Code', content: driver.code ?? 'Code'),
            _tile(title: 'Address', content: driver.address ?? 'Address'),
            _tile(title: 'City', content: driver.city ?? 'City'),
            _tile(title: 'State', content: driver.state ?? 'State'),
            _tile(title: 'User ID', content: driver.userId ?? 'User ID'),
            _tile(
                title: 'Driver License',
                content: driver.driverLicense ?? 'No Driver License'),
            _tile(
                title: 'Company ID', content: driver.companyId ?? 'Company ID'),
            _tile(
                title: 'Date Added',
                content: DateFormat('yyyy-MM-dd').format(driver.dateAdded!)),
            _tile(
                title: 'Company Namme',
                content: driver.companyName ?? 'Company Name'),
            const SizedBox(height: 100),
            ElevatedButton(
              onPressed: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (ctx) => EditDriver(driver: driver))),
              child: const Text('Edit Driver'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _tile({required String title, required String content}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w300,
          ),
        ),
        Expanded(
          child: Text(
            content,
            textAlign: TextAlign.right,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ],
    );
  }
}
