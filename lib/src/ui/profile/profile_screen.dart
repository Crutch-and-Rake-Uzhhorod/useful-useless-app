import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:useful_useless_app/src/core/provider/user_provider.dart';
import 'package:useful_useless_app/src/ui/global/rounded_button_widget.dart';

class Profile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(body: ProfileScreen());
  }
}

class ProfileScreen extends StatelessWidget {
  static const String id = 'profile_screen';

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    final textTheme = Theme.of(context).textTheme;

    return Padding(
      padding: EdgeInsets.fromLTRB(width * 0.07, 56.0, width * 0.07, 42.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          _getUserAvatar(context),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 36.0),
            child: Text(
              _getUserName(context),
              textAlign: TextAlign.center,
              style: textTheme.headline5,
            ),
          ),
          RoundedButtonWidget(
            height: 56.0,
            onTap: () {},
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 24.0,
                vertical: 6.0,
              ),
              child: Row(
                children: [
                  Icon(Icons.map),
                  const SizedBox(width: 16.0),
                  Text('Following locations (1)'),
                ],
              ),
            ),
          ),
          const SizedBox(height: 20.0),
          RoundedButtonWidget(
            height: 56.0,
            onTap: () {},
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 24.0,
                vertical: 6.0,
              ),
              child: Row(
                children: [
                  Icon(Icons.settings),
                  const SizedBox(width: 16.0),
                  Text('Preferences'),
                ],
              ),
            ),
          ),
          const SizedBox(height: 20.0),
          RoundedButtonWidget(
            height: 56.0,
            onTap: () {},
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 24.0,
                vertical: 6.0,
              ),
              child: Row(
                children: [
                  Icon(Icons.info),
                  const SizedBox(width: 16.0),
                  Text('Terms & conditions'),
                ],
              ),
            ),
          ),
          const Spacer(),
          Align(
            child: TextButton(
              style: ButtonStyle(
                overlayColor:
                    MaterialStateColor.resolveWith((_) => Colors.transparent),
                foregroundColor:
                    MaterialStateColor.resolveWith((_) => Colors.grey),
              ),
              onPressed: () {},
              child: Text('Change user'),
            ),
          ),
        ],
      ),
    );
  }

  Widget _getUserAvatar(BuildContext context) {
    //will be reworked to get user from UserProvider
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    final user = userProvider.user;
    Widget child;
    if (user?.photoURL != null) {
      child = Image(
        image: NetworkImage(user!.photoURL!),
      );
    } else {
      child = Icon(
        Icons.person,
        size: 72.0,
      );
    }

    return Container(
      height: 96.0,
      width: 96.0,
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(color: Colors.black12),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.15),
            offset: Offset(0, 9),
            blurRadius: 20,
            spreadRadius: 0.1,
          ),
        ],
      ),
      child: child,
    );
  }

  String _getUserName(BuildContext context) {
    //will be reworked to get user from UserProvider
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    final user = userProvider.user;
    if (user?.displayName?.isNotEmpty ?? false) {
      return user!.displayName!;
    } else {
      return 'Anonymous User';
    }
  }
}

// class ProfileScreen extends StatefulWidget {
//   static const String id = 'profile_screen';
//   @override
//   _ProfileScreenState createState() => _ProfileScreenState();
// }
//
// class _ProfileScreenState extends State<ProfileScreen> {
//   int regionsNumber = 0;
//   //TODO make variable interactive example
//   int trackRegionsNumber() {
//     return regionsNumber = regionsNumber + 1;
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: EdgeInsets.symmetric(vertical: 10.0),
//       child: Column(
//         children: [
//           Row(
//             children: [
//               //TODO: no set_state allowed with state management
//               //TODO it's need to be a TabBar Content?
//               Expanded(
//                 child: Row(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: [
//                     TextButton(
//                       onPressed: () {
//                         setState(
//                           () {
//                             trackRegionsNumber();
//                           },
//                         );
//                       },
//                       child: Icon(
//                         Icons.map,
//                         color: Colors.black,
//                         size: 50,
//                       ),
//                     ),
//                     Text(regionsNumber.toString()),
//                   ],
//                 ),
//               ),
//               Expanded(
//                 child: Column(
//                   children: [
//                     Container(
//                       decoration: BoxDecoration(
//                         color: Colors.black,
//                         borderRadius: BorderRadius.circular(50),
//                       ),
//                       child: _userAvatarPicker(),
//                     ),
//                     Text('UserModel().user_name'),
//
//                     /// '${UserModel().user_name}'
//                     //TODO also needed some checker, and what will write in default
//                   ],
//                 ),
//               ),
//               Expanded(
//                 child: TextButton(
//                   onPressed: () {
//                     Navigator.push(
//                       context,
//                       MaterialPageRoute(builder: (context) => SettingsScreen()),
//                     );
//                   },
//                   child: Icon(
//                     Icons.settings,
//                     color: Colors.black,
//                     size: 50,
//                   ),
//                 ),
//               ),
//             ],
//           ),
//           Divider(
//             thickness: 2,
//             color: Colors.black,
//           ),
//         ],
//       ),
//     );
//   }
//
//   Widget _userAvatarPicker() {
//     //TODO here need to be firebase.user.avatar, UserModel().user_name just for example
//     if (UserModel().user_name == null) {
//       return Icon(Icons.person, color: Colors.white, size: 50);
//     } else {
//       return Icon(Icons.person, color: Colors.red, size: 50);
//     }
//   }
// }
