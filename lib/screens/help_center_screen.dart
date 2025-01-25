import 'package:flutter/material.dart';

class HelpCenterScreen extends StatelessWidget {
  const HelpCenterScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: const Text(
          'Help Center',
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.all(16.0),
            child: TextField(
              decoration: InputDecoration(
                prefixIcon: Icon(Icons.search, color: Colors.orange),
                hintText: 'Search',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10.0)),
                ),
              ),
            ),
          ),
          Expanded(
            child: const TabBarSection(),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 3, // Active index for "Profile"
        onTap: (index) {
          switch (index) {
            case 0:
              Navigator.pushNamed(context, '/'); // Navigate to Home
              break;
            case 1:
              Navigator.pushNamed(context, '/rewards'); // Navigate to Rewards
              break;
            case 2:
              Navigator.pushNamed(context, '/notifications'); // Navigate to Notifications
              break;
            case 3:
            // Stay on the Profile screen
              break;
          }
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.map),
            label: 'Map',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.card_giftcard),
            label: 'Rewards',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.notifications),
            label: 'Notifications',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}

class TabBarSection extends StatelessWidget {
  const TabBarSection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Column(
        children: [
          const TabBar(
            tabs: [
              Tab(child: Text('FAQ', style: TextStyle(color: Colors.black))),
              Tab(child: Text('Contact Us', style: TextStyle(color: Colors.black))),
            ],
          ),
          Expanded(
            child: TabBarView(
              children: [
                FAQSection(),
                const ContactUsSection(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class FAQSection extends StatelessWidget {
  const FAQSection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        ExpansionTile(
          title: const Text('What is Circl Up?'),
          children: const [
            Padding(
              padding: EdgeInsets.all(16.0),
              child: Text(
                'Circl Up is an innovative app designed to connect people through events, '
                    'rewards, and social interactions. Join circles, participate in activities, '
                    'and make the most of your time!',
                style: TextStyle(fontSize: 16),
              ),
            ),
          ],
        ),
        ExpansionTile(
          title: const Text('How do I earn circles?'),
          children: const [
            Padding(
              padding: EdgeInsets.all(16.0),
              child: Text(
                'Earn circles by participating in events, completing challenges, and engaging '
                    'with friends. Circles can be redeemed for exciting rewards!',
                style: TextStyle(fontSize: 16),
              ),
            ),
          ],
        ),
        ExpansionTile(
          title: const Text('How can I redeem rewards?'),
          children: const [
            Padding(
              padding: EdgeInsets.all(16.0),
              child: Text(
                'Go to the Rewards section and browse the available coupons. Redeem your circles '
                    'for rewards like gift cards, discounts, and more!',
                style: TextStyle(fontSize: 16),
              ),
            ),
          ],
        ),
        ExpansionTile(
          title: const Text('How do I update my profile?'),
          children: const [
            Padding(
              padding: EdgeInsets.all(16.0),
              child: Text(
                'Navigate to the Profile section, click on the Edit option, and update your details '
                    'like name, bio, and profile picture easily.',
                style: TextStyle(fontSize: 16),
              ),
            ),
          ],
        ),
        ExpansionTile(
          title: const Text('How do I contact support?'),
          children: const [
            Padding(
              padding: EdgeInsets.all(16.0),
              child: Text(
                'If you need help, visit the Contact Us tab in the Help Center. You can send us a '
                    'message and our support team will assist you promptly!',
                style: TextStyle(fontSize: 16),
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class ContactUsSection extends StatelessWidget {
  const ContactUsSection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        ExpansionTile(
          leading: const Icon(Icons.language, size: 30, color: Colors.grey),
          title: const Text('Website', style: TextStyle(fontWeight: FontWeight.bold)),
          subtitle: const Text('Visit our official site', style: TextStyle(color: Colors.grey)),
          children: const [
            Padding(
              padding: EdgeInsets.all(16.0),
              child: Text(
                'Visit us at: www.circlup.com',
                style: TextStyle(fontSize: 16, color: Colors.black),
              ),
            ),
          ],
        ),
        ExpansionTile(
          leading: const Icon(Icons.headset_mic, size: 30, color: Colors.grey),
          title: const Text('Customer Service', style: TextStyle(fontWeight: FontWeight.bold)),
          subtitle: const Text('Call us if you need any help!', style: TextStyle(color: Colors.grey)),
          children: const [
            Padding(
              padding: EdgeInsets.all(16.0),
              child: Text(
                'Call us at +38970123123 for any assistance!',
                style: TextStyle(fontSize: 16, color: Colors.black),
              ),
            ),
          ],
        ),
        ExpansionTile(
          leading: const Icon(Icons.facebook, size: 30, color: Colors.grey),
          title: const Text('Facebook', style: TextStyle(fontWeight: FontWeight.bold)),
          subtitle: const Text('Follow us on Facebook', style: TextStyle(color: Colors.grey)),
          children: const [
            Padding(
              padding: EdgeInsets.all(16.0),
              child: Text(
                'Connect with us on Facebook at: facebook.com/circlup',
                style: TextStyle(fontSize: 16, color: Colors.black),
              ),
            ),
          ],
        ),
        ExpansionTile(
          leading: const Icon(Icons.camera_alt_outlined, size: 30, color: Colors.grey),
          title: const Text('Instagram', style: TextStyle(fontWeight: FontWeight.bold)),
          subtitle: const Text('Follow us on Instagram', style: TextStyle(color: Colors.grey)),
          children: const [
            Padding(
              padding: EdgeInsets.all(16.0),
              child: Text(
                'Follow us on Instagram: @circlupapp',
                style: TextStyle(fontSize: 16, color: Colors.black),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
