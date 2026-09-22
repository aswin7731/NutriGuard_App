import 'package:flutter/material.dart';
import 'package:nutriguardapp/familydashboard.dart';
import 'package:nutriguardapp/profile_dashboard.dart';
// IMPORTANT: Verify these file names exactly match your project files!
import 'package:nutriguardapp/scanningpage.dart'; 
import 'package:nutriguardapp/chatbotscreen.dart';
import 'package:nutriguardapp/view_recently_scanned.dart';

// Your Profile screen file

class HomeDashboard extends StatefulWidget {
  const HomeDashboard({super.key});

  @override
  State<HomeDashboard> createState() => _HomeDashboardState();
}

class _HomeDashboardState extends State<HomeDashboard> {
  final int _selectedIndex = 0; // Home is always index 0

  @override
  Widget build(BuildContext context) {
    const primarySkyBlue = Color(0xFF0284C7); 
    const appBackgroundSky = Color(0xFFF0F9FF); 
    const cardAccentSky = Color(0xFFE0F2FE); 
    const healthGreen = Color(0xFF249B62); 

    return Scaffold(
      backgroundColor: appBackgroundSky,
      
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const ChatScreen()));
        },
        backgroundColor: primarySkyBlue,
        foregroundColor: Colors.white,
        child: const Icon(Icons.chat_bubble),
      ),

      // CONNECTED TO ALL PAGES
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed, 
        backgroundColor: Colors.white,
        selectedItemColor: primarySkyBlue,
        unselectedItemColor: Colors.grey,
        currentIndex: _selectedIndex,
        onTap: (index) {
          if (index == 1) {
            // Scan overlays on top (so you can swipe back)
            Navigator.push(context, MaterialPageRoute(builder: (context) => const ScanScreen()));
          } 
          else if (index == 2) {
            Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const FamilyMembersScreen()));
          }
          else if (index == 3) {
            Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const ChatScreen()));
          }
          else if (index == 4) {
            Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const ProfileScreen()));
          }
        },
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home_outlined), activeIcon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon : Icon(Icons.qr_code_scanner), label: 'Scan'),
          BottomNavigationBarItem(icon: Icon(Icons.family_restroom_outlined), activeIcon: Icon(Icons.family_restroom), label: 'Family'),
          BottomNavigationBarItem(icon: Icon(Icons.chat_bubble_outline), activeIcon: Icon(Icons.chat_bubble), label: 'Chat'),
          BottomNavigationBarItem(icon: Icon(Icons.person_outline), activeIcon: Icon(Icons.person), label: 'Profile'),
        ],
      ),

      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      const Icon(Icons.health_and_safety, color: healthGreen, size: 28),
                      const SizedBox(width: 8),
                      const Text(
                        'NutriGuard',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: primarySkyBlue,
                        ),
                      ),
                    ],
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => const FamilyMembersScreen()));
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(25),
                        boxShadow: [
                          BoxShadow(color: primarySkyBlue.withOpacity(0.05), blurRadius: 10, offset: const Offset(0, 4))
                        ],
                      ),
                      child: Row(
                        children: const [
                          CircleAvatar(
                            radius: 10,
                            backgroundColor: cardAccentSky,
                            child: Icon(Icons.person, size: 12, color: primarySkyBlue),
                          ),
                          SizedBox(width: 8),
                          Text('Me', style: TextStyle(fontWeight: FontWeight.bold, color: primarySkyBlue)),
                          SizedBox(width: 4),
                          Icon(Icons.keyboard_arrow_right, size: 18, color: Colors.grey),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),

              // Greeting
              const Text(
                'Hello, Aswin 👋', // Updated to match your personal context!
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: primarySkyBlue),
              ),
              const SizedBox(height: 4),
              const Text(
                "Let's make healthier choices together.",
                style: TextStyle(color: Colors.grey, fontSize: 14),
              ),
              const SizedBox(height: 20),

              // Search Bar
              TextField(
                decoration: InputDecoration(
                  hintText: 'Search food products, brands...',
                  hintStyle: TextStyle(color: Colors.grey.shade400),
                  prefixIcon: const Icon(Icons.search, color: Colors.grey),
                  filled: true,
                  fillColor: Colors.white, 
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
              const SizedBox(height: 24),

              // Main Scan Card
              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: cardAccentSky, 
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: const [
                              Icon(Icons.qr_code_scanner, color: primarySkyBlue, size: 20),
                              SizedBox(width: 8),
                              Text(
                                'Scan Packaged Food',
                                style: TextStyle(
                                  color: primarySkyBlue,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 8),
                          const Text(
                            'Get AI-powered analysis in seconds',
                            style: TextStyle(fontSize: 12, color: Colors.black54),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.all(12),
                      decoration: const BoxDecoration(
                        color: primarySkyBlue,
                        shape: BoxShape.circle,
                      ),
                      child: IconButton(
                        onPressed: () {
                          Navigator.push(context, MaterialPageRoute(builder: (context) => const ScanScreen()));
                        }, 
                        icon: const Icon(Icons.qr_code_scanner_outlined, color: Colors.white)
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 30),

              // Features List
              const Text(
                'What NutriGuard Helps You With',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: primarySkyBlue),
              ),
              const SizedBox(height: 16),
              SizedBox(
                height: 140, 
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: [
                    _buildFeatureCard('Nutrition\nAnalysis', Icons.fact_check, Colors.blue),
                    _buildFeatureCard('Ingredient\nCheck', Icons.science, Colors.orange),
                    _buildFeatureCard('Personalized\nAdvice', Icons.person_pin, primarySkyBlue),
                    _buildFeatureCard('Healthier\nAlternatives', Icons.star, Colors.purple),
                  ],
                ),
              ),
              const SizedBox(height: 30),

              // Health Tip
              const Text(
                "Today's Health Tip",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: primarySkyBlue),
              ),
              const SizedBox(height: 12),
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: cardAccentSky, width: 2), 
                ),
                child: Row(
                  children: [
                    const Icon(Icons.lightbulb_outline, color: Colors.orange, size: 32),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Text(
                        'Try to choose products with less than 5g of added sugar per serving for a healthier you!',
                        style: TextStyle(fontSize: 13, color: Colors.grey.shade800),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 30),

              // Recently Scanned
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Recently Scanned',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: primarySkyBlue),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => const ProductListScreen(pageTitle: 'Recently Scanned',)));
                    },
                    child: const Text('View All', style: TextStyle(color: healthGreen)),
                  ),
                ],
              ),
              
              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: 3, 
                itemBuilder: (context, index) {
                  List<String> titles = ["Oreo Original", "Maggi Noodles", "Coca-Cola"];
                  List<String> scores = ["65/100", "45/100", "20/100"];
                  List<Color> colors = [healthGreen, Colors.orange, Colors.red];
                  
                  return _buildRecentScanCard(titles[index], scores[index], colors[index]);
                },
              ),
              const SizedBox(height: 60), 
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildFeatureCard(String title, IconData icon, Color iconColor) {
    return Container(
      width: 130,
      margin: const EdgeInsets.only(right: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [BoxShadow(color: Colors.blue.withOpacity(0.05), blurRadius: 10, offset: const Offset(0, 4))],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: iconColor, size: 30),
          const Spacer(),
          Text(title, style: const TextStyle(fontSize: 13, fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }

  Widget _buildRecentScanCard(String title, String score, Color scoreColor) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [BoxShadow(color: Colors.blue.withOpacity(0.05), blurRadius: 10, offset: const Offset(0, 2))],
      ),
      child: Row(
        children: [
          Container(
            height: 40, width: 40,
            decoration: BoxDecoration(color: Colors.grey.shade100, borderRadius: BorderRadius.circular(8)),
            child: const Icon(Icons.image, color: Colors.grey),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
                const SizedBox(height: 4),
                Row(
                  children: [
                    const Text("Health Score  ", style: TextStyle(color: Colors.grey, fontSize: 12)),
                    Text(score, style: TextStyle(color: scoreColor, fontWeight: FontWeight.bold, fontSize: 12)),
                  ],
                ),
              ],
            ),
          ),
          const Icon(Icons.chevron_right, color: Colors.grey),
        ],
      ),
    );
  }
}