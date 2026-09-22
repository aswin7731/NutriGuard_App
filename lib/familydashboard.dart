import 'package:flutter/material.dart';
import 'package:nutriguardapp/edit_family_health.dart';

// IMPORTANT: Verify these match your actual files!
import 'package:nutriguardapp/homepage.dart'; 
import 'package:nutriguardapp/scanningpage.dart'; 
import 'package:nutriguardapp/chatbotscreen.dart'; 
import 'package:nutriguardapp/profile_dashboard.dart'; // Changed to match your profile import


class FamilyMember {
  final String id;
  final String title;
  final String subtitle;
  final IconData avatarIcon;
  final Color avatarBgColor;
  final Color avatarIconColor;

  FamilyMember({
    required this.id,
    required this.title,
    required this.subtitle,
    required this.avatarIcon,
    required this.avatarBgColor,
    required this.avatarIconColor,
  });
}

class FamilyMembersScreen extends StatefulWidget {
  const FamilyMembersScreen({super.key});

  @override
  State<FamilyMembersScreen> createState() => _FamilyMembersScreenState();
}

class _FamilyMembersScreenState extends State<FamilyMembersScreen> {
  String selectedMemberId = '1';
  final int _currentNavIndex = 2; // Active tab: Family

  final List<FamilyMember> members = [
    FamilyMember(
      id: '1',
      title: 'Me (Personal)',
      subtitle: 'Age 24 • Male',
      avatarIcon: Icons.person,
      avatarBgColor: const Color(0xFFE0F2FE),
      avatarIconColor: const Color(0xFF0284C7),
    ),
    FamilyMember(
      id: '2',
      title: 'Wife (Pregnancy)',
      subtitle: '2nd Trimester • 26 years',
      avatarIcon: Icons.pregnant_woman_rounded,
      avatarBgColor: const Color(0xFFFCE4EC),
      avatarIconColor: const Color(0xFFD81B60),
    ),
    FamilyMember(
      id: '3',
      title: 'Son (Child)',
      subtitle: '10 years • Male',
      avatarIcon: Icons.face_retouching_natural_outlined,
      avatarBgColor: const Color(0xFFE8F5E9),
      avatarIconColor: const Color(0xFF2E7D32),
    ),
    FamilyMember(
      id: '4',
      title: 'Father',
      subtitle: '58 years • Male',
      avatarIcon: Icons.escalator_warning_outlined,
      avatarBgColor: const Color(0xFFFFF3E0),
      avatarIconColor: const Color(0xFFEF6C00),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    const primarySkyBlue = Color(0xFF0284C7);
    const appBackgroundSky = Color(0xFFF0F9FF);
    const cardAccentSky = Color(0xFFE0F2FE);

    return Scaffold(
      backgroundColor: appBackgroundSky,
      
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new, color: primarySkyBlue, size: 20),
          onPressed: () {
            Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const HomeDashboard()));
          },
        ),
        title: const Text(
          'Family Members',
          style: TextStyle(color: primarySkyBlue, fontWeight: FontWeight.bold, fontSize: 18),
        ),
        centerTitle: true,
      ),
      
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        backgroundColor: Colors.white,
        selectedItemColor: primarySkyBlue,
        unselectedItemColor: Colors.grey,
        currentIndex: _currentNavIndex,
        onTap: (index) {
          if (index == 0) {
            Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const HomeDashboard()));
          } else if (index == 1) {
            Navigator.push(context, MaterialPageRoute(builder: (context) => const ScanScreen()));
          } else if (index == 3) {
            Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const ChatScreen()));
          } else if (index == 4) {
            Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const ProfileScreen()));
          }
        },
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home_outlined), activeIcon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.qr_code_scanner), label: 'Scan'),
          BottomNavigationBarItem(icon: Icon(Icons.family_restroom_outlined), activeIcon: Icon(Icons.family_restroom), label: 'Family'),
          BottomNavigationBarItem(icon: Icon(Icons.chat_bubble_outline), activeIcon: Icon(Icons.chat_bubble), label: 'Chat'),
          BottomNavigationBarItem(icon: Icon(Icons.person_outline), activeIcon: Icon(Icons.person), label: 'Profile'),
        ],
      ),

      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: ListView.separated(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
                itemCount: members.length,
                separatorBuilder: (context, index) => const SizedBox(height: 16),
                itemBuilder: (context, index) {
                  final member = members[index];
                  final isSelected = selectedMemberId == member.id;

                  // FULLY CONNECTED GESTURE DETECTOR
                  return GestureDetector(
                    onTap: () {
                      // 1. Highlight the card
                      setState(() {
                        selectedMemberId = member.id;
                      });

                      // 2. Open the edit screen for this specific person
                      String startingStatus = 'Normal';
                      if (member.title.contains('Pregnancy')) startingStatus = 'Pregnant';
                      if (member.title.contains('Father')) startingStatus = 'Patient';

                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => EditFamilyMemberScreen(
                            memberName: member.title.replaceAll(RegExp(r'\(.*?\)'), '').trim(), 
                            initialStatus: startingStatus,
                          ),
                        ),
                      );
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                      decoration: BoxDecoration(
                        color: isSelected ? cardAccentSky : Colors.white,
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: [
                          BoxShadow(color: primarySkyBlue.withOpacity(0.05), blurRadius: 10, offset: const Offset(0, 4))
                        ],
                        border: Border.all(color: isSelected ? primarySkyBlue : Colors.transparent, width: 2.0),
                      ),
                      child: Row(
                        children: [
                          CircleAvatar(
                            radius: 26,
                            backgroundColor: member.avatarBgColor,
                            child: Icon(member.avatarIcon, color: member.avatarIconColor, size: 28),
                          ),
                          const SizedBox(width: 16),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  member.title,
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: isSelected ? primarySkyBlue : Colors.black87,
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  member.subtitle,
                                  style: TextStyle(
                                    fontSize: 13,
                                    color: isSelected ? primarySkyBlue.withOpacity(0.7) : Colors.grey.shade600,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Icon(isSelected ? Icons.check_circle : Icons.chevron_right, color: isSelected ? primarySkyBlue : Colors.grey.shade400, size: 24),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
            
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: SizedBox(
                width: double.infinity,
                height: 60,
                child: ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: primarySkyBlue,
                    foregroundColor: Colors.white,
                    elevation: 2,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                  ),
                  onPressed: () {
                    // This opens a blank edit page to add a NEW member
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const EditFamilyMemberScreen(memberName: '', initialStatus: 'Normal'),
                      ),
                    );
                  },
                  icon: const Icon(Icons.add, size: 24),
                  label: const Text('Add New Member', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}