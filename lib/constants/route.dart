import 'package:flutter_secentry/Pages/Estate/emergency.dart';
import 'package:flutter_secentry/Pages/Estate/estate_code.dart';
import 'package:flutter_secentry/Pages/Estate/estate_dashboard.dart';
import 'package:flutter_secentry/Pages/Estate/guestentry.dart';
import 'package:flutter_secentry/Pages/Estate/invite_guest.dart';
import 'package:flutter_secentry/Pages/Estate/item_pass.dart';
import 'package:flutter_secentry/Pages/Estate/messages.dart';
import 'package:flutter_secentry/Pages/Estate/my_invitations.dart';
import 'package:flutter_secentry/Pages/Estate/news.dart';
import 'package:flutter_secentry/Pages/Estate/pending_request.dart';
import 'package:flutter_secentry/Pages/authpages/login.dart';
import 'package:flutter_secentry/Pages/authpages/new_password.dart';
import 'package:flutter_secentry/Pages/authpages/otp_page.dart';
import 'package:flutter_secentry/Pages/authpages/registration.dart';
import 'package:flutter_secentry/Pages/authpages/resetpassword.dart';
import 'package:flutter_secentry/Pages/Estate/no_facility.dart';
import 'package:flutter_secentry/Pages/Estate/no_facility_invitation.dart';
import 'package:flutter_secentry/Pages/guard/guard_estate_dashboard.dart';
import 'package:flutter_secentry/Pages/guard/visitor_entry.dart';

final route = {
  '/nofacility': (context) => const Nofacility(),
  '/registration': (context) => const Registration(),
  '/no_facility_invitation': (context) => const NoFacilityInvitation(),
  '/reset_password': (context) => const ResetPassword(),
  '/login': (context) => const Login(),
  '/estate_code': (context) => const EstateCode(),
  '/pending_request': (context) => const PendingRequest(),
  '/estate_dashboard': (context) => const EstateDashoard(),
  '/guest_entry': (context) => const GuestEntry(),
  '/invite_guest': (context) => const InviteGuest(),
  '/add_item_pass': (context) => const AddItemPass(),
  '/otp_page': (context) => OTPPage(),
  '/my_invitations': (context) => const MyInvitations(),
  '/new_password': (context) => const NewPassword(),
  '/emergency': (context) => const EmergencyContact(),
  '/news': (context) => const News(),
  '/messages': (context) => const Messages(),
  '/guard_dashboard': (context) => const GuardEstateDashboard(),
  '/visitor_entry': (context) => const VisitorEntryApproval(),
};
