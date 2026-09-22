import 'package:flutter/material.dart';
import 'package:nutriguardapp/appsettings.dart';
import 'package:nutriguardapp/health.dart';

// IMPORTANT: Verify these match your actual files!
import 'package:nutriguardapp/homepage.dart';
import 'package:nutriguardapp/saved_product_page.dart'; 
import 'package:nutriguardapp/scanningpage.dart'; 
import 'package:nutriguardapp/familydashboard.dart'; // Make sure this matches your family page file
import 'package:nutriguardapp/chatbotscreen.dart'; 
import 'package:nutriguardapp/view_recently_scanned.dart'; // YOUR RECENTLY VIEWED SCREEN IMPORT

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  int _currentNavIndex = 4; // Active tab: Profile
  bool _hasProfilePhoto = true; 

  // Body Metrics State
  double _height = 178;
  double _weight = 72;
  double? _calculatedBmi;
  String _bmiCategory = '';
  Color _bmiColor = Colors.grey;

  @override
  void initState() {
    super.initState();
    _calculateBMI(); 
  }

  void _calculateBMI() {
    if (_height > 0 && _weight > 0) {
      final double heightM = _height / 100;
      final double bmi = _weight / (heightM * heightM);

      setState(() {
        _calculatedBmi = bmi;
        if (bmi < 18.5) {
          _bmiCategory = 'Underweight';
          _bmiColor = const Color(0xFFF59E0B);
        } else if (bmi < 25.0) {
          _bmiCategory = 'Healthy';
          _bmiColor = const Color(0xFF249B62);
        } else if (bmi < 30.0) {
          _bmiCategory = 'Overweight';
          _bmiColor = const Color(0xFFF59E0B);
        } else {
          _bmiCategory = 'Obese';
          _bmiColor = const Color(0xFFEF4444);
        }
      });
    }
  }

  void _showEditMetricsSheet() {
    final TextEditingController heightCtrl = TextEditingController(text: _height.toStringAsFixed(0));
    final TextEditingController weightCtrl = TextEditingController(text: _weight.toStringAsFixed(0));
    const primarySkyBlue = Color(0xFF0284C7);

    showModalBottomSheet(
      context: context,
      isScrollControlled: true, 
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
      builder: (BuildContext context) {
        return Padding(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom, 
            left: 20, right: 20, top: 20,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Container(
                  width: 40, height: 4, margin: const EdgeInsets.only(bottom: 20),
                  decoration: BoxDecoration(color: Colors.black12, borderRadius: BorderRadius.circular(2)),
                ),
              ),
              const Text("Update Body Metrics", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: primarySkyBlue)),
              const SizedBox(height: 20),
              
              Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: heightCtrl,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        labelText: "Height (cm)",
                        filled: true, fillColor: Colors.grey.shade50,
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                      ),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: TextField(
                      controller: weightCtrl,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        labelText: "Weight (kg)",
                        filled: true, fillColor: Colors.grey.shade50,
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 24),
              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: primarySkyBlue,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                  ),
                  onPressed: () {
                    final newHeight = double.tryParse(heightCtrl.text);
                    final newWeight = double.tryParse(weightCtrl.text);
                    
                    if (newHeight != null && newWeight != null) {
                      setState(() {
                        _height = newHeight;
                        _weight = newWeight;
                      });
                      _calculateBMI(); 
                      Navigator.pop(context);
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('BMI Updated Successfully!')));
                    }
                  },
                  child: const Text("Save & Calculate BMI", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white)),
                ),
              ),
              const SizedBox(height: 20),
            ],
          ),
        );
      },
    );
  }

  void _showImagePickerOptions(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
      builder: (BuildContext context) {
        return SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 8.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(width: 40, height: 4, margin: const EdgeInsets.only(bottom: 16), decoration: BoxDecoration(color: Colors.black12, borderRadius: BorderRadius.circular(2))),
                const Text('Profile Photo', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black87)),
                const SizedBox(height: 16),
                ListTile(
                  leading: const Icon(Icons.photo_library_outlined, color: Color(0xFF0284C7)),
                  title: const Text('Choose from Gallery', style: TextStyle(fontWeight: FontWeight.w600)),
                  onTap: () {
                    Navigator.pop(context);
                    setState(() => _hasProfilePhoto = true);
                  },
                ),
                ListTile(
                  leading: const Icon(Icons.camera_alt_outlined, color: Color(0xFF0284C7)),
                  title: const Text('Take a New Photo', style: TextStyle(fontWeight: FontWeight.w600)),
                  onTap: () {
                    Navigator.pop(context);
                    setState(() => _hasProfilePhoto = true);
                  },
                ),
                if (_hasProfilePhoto)
                  ListTile(
                    leading: const Icon(Icons.delete_outline, color: Colors.redAccent),
                    title: const Text('Delete Profile Photo', style: TextStyle(color: Colors.redAccent, fontWeight: FontWeight.w600)),
                    onTap: () {
                      Navigator.pop(context);
                      setState(() => _hasProfilePhoto = false);
                    },
                  ),
              ],
            ),
          ),
        );
      },
    );
  }

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
        title: const Text('My Profile', style: TextStyle(color: primarySkyBlue, fontWeight: FontWeight.bold, fontSize: 18)),
        actions: [
          IconButton(
            icon: const Icon(Icons.edit_outlined, color: primarySkyBlue),
            onPressed: _showEditMetricsSheet,
          ),
        ],
        centerTitle: true,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 12.0),
          child: Column(
            children: [
              // User Header Card
              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [BoxShadow(color: primarySkyBlue.withOpacity(0.05), blurRadius: 10, offset: const Offset(0, 4))],
                ),
                child: Column(
                  children: [
                    GestureDetector(
                      onTap: () => _showImagePickerOptions(context),
                      child: Stack(
                        alignment: Alignment.bottomRight,
                        children: [
                          CircleAvatar(
                            radius: 45,
                            backgroundColor: cardAccentSky,
                            child: Icon(_hasProfilePhoto ? Icons.person : Icons.person_outline, size: 55, color: primarySkyBlue),
                          ),
                          Container(
                            padding: const EdgeInsets.all(8),
                            decoration: const BoxDecoration(color: primarySkyBlue, shape: BoxShape.circle),
                            child: Icon(_hasProfilePhoto ? Icons.edit : Icons.add_a_photo, color: Colors.white, size: 14),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 12),
                    const Text('Aswin', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black87)),
                    const SizedBox(height: 4),
                    Text('aswin@example.com', style: TextStyle(fontSize: 14, color: Colors.black.withOpacity(0.55))),
                    const SizedBox(height: 12),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                      decoration: BoxDecoration(color: cardAccentSky, borderRadius: BorderRadius.circular(20)),
                      child: const Text('Primary Account Holder', style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: primarySkyBlue)),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 20),

              // DYNAMIC BMI DISPLAY CARD
              if (_calculatedBmi != null)
                Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(color: _bmiColor.withOpacity(0.3), width: 2),
                    boxShadow: [BoxShadow(color: _bmiColor.withOpacity(0.1), blurRadius: 10, offset: const Offset(0, 4))],
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text("Your BMI", style: TextStyle(fontSize: 14, color: Colors.black54, fontWeight: FontWeight.bold)),
                          Text(
                            _calculatedBmi!.toStringAsFixed(1),
                            style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold, color: _bmiColor),
                          ),
                        ],
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                        decoration: BoxDecoration(color: _bmiColor.withOpacity(0.1), borderRadius: BorderRadius.circular(20)),
                        child: Text(_bmiCategory, style: TextStyle(color: _bmiColor, fontWeight: FontWeight.bold)),
                      ),
                    ],
                  ),
                ),

              const SizedBox(height: 20),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text('Personal Info', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: primarySkyBlue)),
                  TextButton.icon(
                    onPressed: _showEditMetricsSheet, 
                    icon: const Icon(Icons.edit, size: 16, color: primarySkyBlue),
                    label: const Text("Edit", style: TextStyle(color: primarySkyBlue)),
                  ),
                ],
              ),

              const SizedBox(height: 8),

              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [BoxShadow(color: primarySkyBlue.withOpacity(0.05), blurRadius: 10, offset: const Offset(0, 4))],
                ),
                child: Column(
                  children: [
                    _buildInfoRow(icon: Icons.cake_outlined, label: 'Age', value: '24 years'),
                    const Divider(height: 1, indent: 50, color: Color(0xFFF0F9FF)),
                    _buildInfoRow(icon: Icons.male, label: 'Gender', value: 'Male'),
                    const Divider(height: 1, indent: 50, color: Color(0xFFF0F9FF)),
                    _buildInfoRow(icon: Icons.height, label: 'Height', value: '${_height.toStringAsFixed(0)} cm'),
                    const Divider(height: 1, indent: 50, color: Color(0xFFF0F9FF)),
                    _buildInfoRow(icon: Icons.monitor_weight_outlined, label: 'Weight', value: '${_weight.toStringAsFixed(0)} kg'),
                  ],
                ),
              ),

              const SizedBox(height: 24),

              // 🌟 NEW: MY FOOD ACTIVITY SECTION 🌟
              const Align(
                alignment: Alignment.centerLeft,
                child: Text('My Food Activity', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: primarySkyBlue)),
              ),
              const SizedBox(height: 12),
              
              _buildActionTile(
                icon: Icons.history,
                title: 'Recently Scanned',
                onTap: () {
                  // Connects to ProductListScreen!
                  Navigator.push(
                    context, 
                    MaterialPageRoute(builder: (context) => const ProductListScreen(pageTitle: "Recently Scanned"))
                  );
                },
              ),
              const SizedBox(height: 10),
              _buildActionTile(
                icon: Icons.bookmark_border,
                title: 'Saved Products',
                onTap: () {
                  // Connects to ProductListScreen but changes the title!
                  Navigator.push(
                    context, 
                    MaterialPageRoute(builder: (context) => const SavedProductsScreen())
                  );
                },
              ),

              const SizedBox(height: 24),

              const Align(
                alignment: Alignment.centerLeft,
                child: Text('Quick Actions', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: primarySkyBlue)),
              ),

              const SizedBox(height: 12),

              _buildActionTile(
                icon: Icons.favorite_outline,
                title: 'Health Profile & Allergies',
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => const HealthProfileScreen()));
                },
              ),
              const SizedBox(height: 10),
              _buildActionTile(
                icon: Icons.groups_outlined,
                title: 'Manage Family Members',
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => const FamilyMembersScreen()));
                },
              ),
              const SizedBox(height: 10),
              _buildActionTile(
                icon: Icons.settings_outlined,
                title: 'App Settings',
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => const AppSettingsScreen()));
                },
              ),
              const SizedBox(height: 30),
            ],
          ),
        ),
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
          } else if (index == 2) {
            Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const FamilyMembersScreen()));
          } else if (index == 3) {
            Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const ChatScreen()));
          } else {
            setState(() {
              _currentNavIndex = index;
            });
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
    );
  }

  Widget _buildInfoRow({required IconData icon, required String label, required String value}) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      child: Row(
        children: [
          Icon(icon, color: const Color(0xFF0284C7), size: 22),
          const SizedBox(width: 14),
          Text(label, style: const TextStyle(fontSize: 14, color: Colors.black54, fontWeight: FontWeight.w500)),
          const Spacer(),
          Text(value, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: Colors.black87)),
        ],
      ),
    );
  }

  Widget _buildActionTile({required IconData icon, required String title, required VoidCallback onTap}) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [BoxShadow(color: const Color(0xFF0284C7).withOpacity(0.05), blurRadius: 10, offset: const Offset(0, 4))],
      ),
      child: ListTile(
        onTap: onTap,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
        leading: Container(
          padding: const EdgeInsets.all(10),
          decoration: const BoxDecoration(color: Color(0xFFE0F2FE), shape: BoxShape.circle),
          child: Icon(icon, color: const Color(0xFF0284C7), size: 20),
        ),
        title: Text(title, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: Colors.black87)),
        trailing: const Icon(Icons.chevron_right, color: Colors.black26, size: 20),
      ),
    );
  }
}