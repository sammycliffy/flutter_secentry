import 'package:flutter_secentry/helpers/providers/invitation.dart';
import 'package:flutter_secentry/helpers/providers/profile.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

final providers = <SingleChildWidget>[
  ChangeNotifierProvider(create: (_) => ProfileDataNotifier()),
  ChangeNotifierProvider(create: (_) => InvitationNotifier())
];
