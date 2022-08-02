import 'package:drivers/providers/auth_provider.dart';
import 'package:drivers/providers/drivers_provider.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

final providers = <SingleChildWidget>[
  ChangeNotifierProvider<AuthProvider>(
    create: (ctx) => AuthProvider(),
  ),
  ChangeNotifierProvider<DriversProvider>(
    create: (ctx) => DriversProvider(),
  )
];
