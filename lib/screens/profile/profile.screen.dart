import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 20),
            decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.surface,
                boxShadow: [
                  BoxShadow(
                      color:
                          Theme.of(context).colorScheme.shadow.withOpacity(0.2),
                      spreadRadius: 3,
                      blurRadius: 5)
                ]),
            child: Center(
                child: Column(
              children: [
                _buildAvatar(),
                const SizedBox(
                  height: 10,
                ),
                Text(
                  "Victoria Dian",
                  style: Theme.of(context)
                      .textTheme
                      .titleLarge
                      ?.copyWith(fontWeight: FontWeight.bold),
                ),
                Text(
                  "Member",
                  style: TextStyle(fontSize: 12.sp),
                )
              ],
            )),
          ),
          Container(
            padding: const EdgeInsets.all(10.0),
            margin: const EdgeInsets.all(10.0),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.0),
                color: Theme.of(context).colorScheme.surface,
                boxShadow: [
                  BoxShadow(
                      color:
                          Theme.of(context).colorScheme.shadow.withOpacity(0.2),
                      spreadRadius: 3,
                      blurRadius: 5)
                ]),
            child: ListView(
              shrinkWrap: true,
              children: [
                _buildListTile("My Address Book", Icons.library_books,
                    const Color.fromARGB(255, 0, 83, 161)),
                const Divider(),
                _buildListTile("My Wallet", Icons.attach_money_rounded,
                    const Color.fromARGB(255, 171, 33, 143)),
                const Divider(),
                _buildListTile("Edit My Profile", Icons.person_outline_rounded,
                    const Color.fromARGB(255, 207, 168, 11)),
                const Divider(),
                _buildListTile("Change My Password", Icons.key_rounded,
                    const Color.fromARGB(255, 0, 191, 118)),
                const Divider(),
                _buildListTile("Logout", Icons.phone_outlined,
                    const Color.fromARGB(255, 78, 0, 223)),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget _buildAvatar() {
    return SizedBox(
      width: 20.w,
      height: 20.w,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(8.0),
        child: Container(
          color: Theme.of(context).colorScheme.inversePrimary,
          child: CachedNetworkImage(
            fit: BoxFit.cover,
            imageUrl: "https://placeimg.com/640/480/food?i=3",
            placeholder: (context, url) => const Center(
              child: Icon(Icons.image),
            ),
            errorWidget: (context, url, error) => const Icon(Icons.error),
          ),
        ),
      ),
    );
  }

  Widget _buildListTile(String label, IconData icon, Color color) {
    return ListTile(
      leading: Container(
          padding: const EdgeInsets.all(5.0),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5.0), color: color),
          child: Icon(
            icon,
            color: Colors.white,
          )),
      title: Text(
        label,
        style: Theme.of(context)
            .textTheme
            .bodyLarge
            ?.copyWith(fontWeight: FontWeight.w500),
      ),
      trailing: Icon(
        Icons.arrow_forward_ios_rounded,
        size: 16,
        color: Theme.of(context).disabledColor,
      ),
    );
  }
}
