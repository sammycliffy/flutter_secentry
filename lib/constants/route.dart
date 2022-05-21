import 'package:flutter_secentry/Pages/Estate/badge.dart';
import 'package:flutter_secentry/Pages/Estate/compose_message.dart';
import 'package:flutter_secentry/Pages/Estate/emergency.dart';
import 'package:flutter_secentry/Pages/Estate/estate_code.dart';
import 'package:flutter_secentry/Pages/Estate/estate_dashboard.dart';
import 'package:flutter_secentry/Pages/Estate/estate_info.dart';
import 'package:flutter_secentry/Pages/Estate/estate_pending.dart';
import 'package:flutter_secentry/Pages/Estate/guestentry.dart';
import 'package:flutter_secentry/Pages/Estate/invite_guest.dart';
import 'package:flutter_secentry/Pages/Estate/item_pass.dart';
import 'package:flutter_secentry/Pages/Estate/messages.dart';
import 'package:flutter_secentry/Pages/Estate/my_invitations.dart';
import 'package:flutter_secentry/Pages/Estate/news.dart';
import 'package:flutter_secentry/Pages/Estate/pending_request.dart';
import 'package:flutter_secentry/Pages/Estate/visitor_information.dart';
import 'package:flutter_secentry/Pages/authpages/email_verification.dart';
import 'package:flutter_secentry/Pages/authpages/login.dart';
import 'package:flutter_secentry/Pages/authpages/new_password.dart';
import 'package:flutter_secentry/Pages/authpages/otp_page.dart';
import 'package:flutter_secentry/Pages/authpages/registration.dart';
import 'package:flutter_secentry/Pages/authpages/resetpassword.dart';
import 'package:flutter_secentry/Pages/Estate/estate_join_facility.dart';
import 'package:flutter_secentry/Pages/Estate/no_facility_invitation.dart';
import 'package:flutter_secentry/Pages/company/company_badge.dart';
import 'package:flutter_secentry/Pages/company/company_code.dart';
import 'package:flutter_secentry/Pages/company/company_compose_message.dart';
import 'package:flutter_secentry/Pages/company/company_dashboard.dart';
import 'package:flutter_secentry/Pages/company/company_emergency.dart';
import 'package:flutter_secentry/Pages/company/company_guest_entry.dart';
import 'package:flutter_secentry/Pages/company/company_info.dart';
import 'package:flutter_secentry/Pages/company/company_invite_guest.dart';
import 'package:flutter_secentry/Pages/company/company_item_pass.dart';
import 'package:flutter_secentry/Pages/company/company_join_facility.dart';
import 'package:flutter_secentry/Pages/company/company_message.dart';
import 'package:flutter_secentry/Pages/company/company_news.dart';
import 'package:flutter_secentry/Pages/company/company_pending.dart';
import 'package:flutter_secentry/Pages/company/company_visitor_info.dart';
import 'package:flutter_secentry/Pages/guard/company_user_entry.dart';
import 'package:flutter_secentry/Pages/guard/company_user_exit.dart';
import 'package:flutter_secentry/Pages/guard/company_visitor_entry.dart';
import 'package:flutter_secentry/Pages/guard/company_visitor_exit.dart';
import 'package:flutter_secentry/Pages/guard/entry_approved_page.dart';
import 'package:flutter_secentry/Pages/guard/entry_info.dart';
import 'package:flutter_secentry/Pages/guard/estatecompany_user_entry.dart';
import 'package:flutter_secentry/Pages/guard/estatecompany_user_exit.dart';
import 'package:flutter_secentry/Pages/guard/estatecompany_visitor_entry.dart';
import 'package:flutter_secentry/Pages/guard/estatecompany_visitor_exit.dart';
import 'package:flutter_secentry/Pages/guard/exit_approved_page.dart';
import 'package:flutter_secentry/Pages/guard/guard_company_dashboard.dart';
import 'package:flutter_secentry/Pages/guard/guard_estate_dashboard.dart';
import 'package:flutter_secentry/Pages/guard/guard_join_company.dart';
import 'package:flutter_secentry/Pages/guard/guard_join_facility.dart';
import 'package:flutter_secentry/Pages/guard/no_guard_facility.dart';
import 'package:flutter_secentry/Pages/guard/user_entry.dart';
import 'package:flutter_secentry/Pages/guard/user_exit.dart';
import 'package:flutter_secentry/Pages/guard/visitor_entry.dart';
import 'package:flutter_secentry/Pages/guard/visitor_exit.dart';
import 'package:flutter_secentry/Pages/helpers/coming_soon.dart';
import 'package:flutter_secentry/Pages/onboarding/onboarding.dart';
import 'package:flutter_secentry/Pages/settings/account_page.dart';

final route = {
  '/onboarding': (context) => const Onboarding(),
  '/estatejoinfacility': (context) => const EsateJoinFacility(),
  '/companyjoinfacility': (context) => const CompanyJoinFacility(),
  '/registration': (context) => const Registration(),
  '/no_facility_invitation': (context) => const NoFacilityInvitation(),
  '/reset_password': (context) => const ResetPassword(),
  '/login': (context) => const Login(),
  '/estate_code': (context) => const EstateCode(),
  '/pending_request': (context) => const PendingRequest(),
  '/my_account': (context) => const MyAccount(),
  //estate
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
  '/compose_message': (context) => const ComposeMessage(),
  '/user_badge': (context) => const UserBadge(),
  '/email_verification': (context) => const EmailVerification(),
  '/entry_info': (context) => EntryInfo(),
  '/visitor_info': (context) => const VisitorInfo(),
  '/estate_pending': (context) => const EstatePending(),
  '/estate_information': (context) => const EstateInfo(),

  //company
  '/company_dashboard': (context) => const CompanyDashoard(),
  '/company_pending': (context) => const CompanyPending(),
  '/company_code': (context) => const CompanyCode(),
  '/company_messages': (context) => const CompanyMessages(),
  '/company_compose_message': (context) => const CompanyComposeMessage(),
  '/company_news': (context) => const CompanyNews(),
  '/company_badge': (context) => const CompanyUserBadge(),
  '/company_emergency': (context) => const CompanyEmergencyContact(),
  '/company_guest_entry': (context) => const CompanyGuestEntry(),
  '/company_item_pass': (context) => const CompanyAddItemPass(),
  '/company_invite_guest': (context) => const CompanyInviteGuest(),
  '/company_visitor_info': (context) => const CompanyVisitorInfo(),
  '/company_information': (context) => const CompanyInfo(),

  //guard
  '/guard_join_facility': (context) => const GuardJoinFacility(),
  '/guard_dashboard': (context) => const GuardCompanyDashboard(),
  '/guard_join_company': (context) => const GuardJoinCompany(),
  '/guard_estate_dashboard': (context) => const GuardEstateDashboard(),
  '/guard_company_dashboard': (context) => const GuardCompanyDashboard(),
  '/no_guard_facility': (context) => const NoGuardFacility(),
  '/user_entry': (context) => const UserEntry(),
  '/company_user_entry': (context) => const CompanyUserEntry(),
  '/company_user_exit': (context) => const CompanyUserExit(),
  '/user_exit': (context) => const UserExit(),
  '/visitor_entry': (context) => const VisitorEntryApproval(),
  '/visitor_exit': (context) => const VisitorExitApproval(),
  '/company_visitor_entry': (context) => const CompanyVisitorEntryApproval(),
  '/company_visitor_exit': (context) => const CompanyVisitorExitApproval(),
  '/entry_approved': (context) => const EntryApproved(),
  '/exit_approved': (context) => const ExitApproved(),
  '/coming_soon': (context) => ComingSoon(),
  '/estate_company_user_entry': (context) => const EstateCompanyUserEntry(),
  '/estate_company_user_exit': (context) => const EstateCompanyUserExit(),
  '/estate_company_visitor_entry': (context) =>
      const EstateCompanyVisitorEntryApproval(),
  '/estate_company_visitor_exit': (context) =>
      const EstateCompanyVisitorExitApproval()
};
