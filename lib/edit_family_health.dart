import 'package:flutter/material.dart';

class EditFamilyMemberScreen extends StatefulWidget {
  final String memberName;
  final String initialStatus; // Normal, Patient, or Pregnant

  const EditFamilyMemberScreen({
    super.key, 
    required this.memberName,
    this.initialStatus = 'Normal',
  });

  @override
  State<EditFamilyMemberScreen> createState() => _EditFamilyMemberScreenState();
}

class _EditFamilyMemberScreenState extends State<EditFamilyMemberScreen> {
  // Controllers
  late TextEditingController _nameController;
  final TextEditingController _ageController = TextEditingController(text: "24");
  final TextEditingController _heightController = TextEditingController(text: "170");
  final TextEditingController _weightController = TextEditingController(text: "65");
  
  String _selectedRelationship = 'Child';
  final List<String> _relationships = ['Spouse', 'Child', 'Parent', 'Sibling', 'Other', 'Me'];
  
  String _selectedGender = 'Male';
  final List<String> _genders = ['Male', 'Female', 'Other'];

  // BMI State
  double? _calculatedBmi;
  String _bmiCategory = 'Awaiting Input';
  Color _bmiColor = Colors.grey;

  // Health Status
  late String _healthStatus;
  
  final TextEditingController _conditionController = TextEditingController();
  final List<String> _selectedConditions = [];

  String _selectedMonth = 'Month 4';
  String _calculatedTrimester = '2nd Trimester';
  final TextEditingController _pregnancyIssuesController = TextEditingController();
  final List<String> _months = List.generate(9, (index) => 'Month ${index + 1}');

  final TextEditingController _allergyController = TextEditingController();
  final List<String> _selectedAllergies = [];

  @override
  void initState() {
    super.initState();
    // Pre-fill the form with the data passed from the previous screen
    _nameController = TextEditingController(text: widget.memberName);
    _healthStatus = widget.initialStatus;
    
    // Auto-calculate BMI on load since we provided mock height/weight
    _calculateBMI();
  }

  void _calculateBMI() {
    final double? heightCm = double.tryParse(_heightController.text);
    final double? weightKg = double.tryParse(_weightController.text);

    if (heightCm != null && weightKg != null && heightCm > 0) {
      final double heightM = heightCm / 100;
      final double bmi = weightKg / (heightM * heightM);

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
    } else {
      setState(() {
        _calculatedBmi = null;
        _bmiCategory = 'Awaiting Input';
        _bmiColor = Colors.grey;
      });
    }
  }

  void _updatePregnancyMonth(String monthStr) {
    setState(() {
      _selectedMonth = monthStr;
      int monthNum = int.tryParse(monthStr.replaceAll(RegExp(r'[^0-9]'), '')) ?? 1;
      if (monthNum <= 3) {
        _calculatedTrimester = '1st Trimester';
      } else if (monthNum <= 6) {
        _calculatedTrimester = '2nd Trimester';
      } else {
        _calculatedTrimester = '3rd Trimester';
      }
    });
  }

  void _addCondition() {
    final text = _conditionController.text.trim();
    if (text.isNotEmpty && !_selectedConditions.contains(text)) {
      setState(() => _selectedConditions.add(text));
      _conditionController.clear();
    }
  }

  void _addAllergy() {
    final text = _allergyController.text.trim();
    if (text.isNotEmpty && !_selectedAllergies.contains(text)) {
      setState(() => _selectedAllergies.add(text));
      _allergyController.clear();
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    _ageController.dispose();
    _heightController.dispose();
    _weightController.dispose();
    _conditionController.dispose();
    _pregnancyIssuesController.dispose();
    _allergyController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    const primarySkyBlue = Color(0xFF0284C7);
    const appBackgroundSky = Color(0xFFF0F9FF);
    const healthGreen = Color(0xFF249B62);

    return Scaffold(
      backgroundColor: appBackgroundSky,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new, color: primarySkyBlue, size: 20),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          "Edit Family Member",
          style: TextStyle(color: primarySkyBlue, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildCard(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text("Basic Information", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: primarySkyBlue)),
                    const SizedBox(height: 16),
                    _buildTextField(label: "Name", hint: "e.g. Sarah", controller: _nameController),
                    const SizedBox(height: 16),
                    Row(
                      children: [
                        Expanded(
                          child: _buildDropdown(
                            label: "Relationship", 
                            value: _selectedRelationship, 
                            items: _relationships, 
                            onChanged: (val) => setState(() => _selectedRelationship = val!)
                          ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: _buildTextField(label: "Age", hint: "Years", controller: _ageController, isNumber: true),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    _buildDropdown(
                      label: "Gender", 
                      value: _selectedGender, 
                      items: _genders, 
                      onChanged: (val) => setState(() => _selectedGender = val!)
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),

              _buildCard(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text("Body Metrics", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: primarySkyBlue)),
                    const SizedBox(height: 16),
                    Row(
                      children: [
                        Expanded(
                          child: _buildTextField(
                            label: "Height (cm)", hint: "e.g. 165", controller: _heightController, isNumber: true, onChanged: (_) => _calculateBMI(),
                          ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: _buildTextField(
                            label: "Weight (kg)", hint: "e.g. 60", controller: _weightController, isNumber: true, onChanged: (_) => _calculateBMI(),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 24),
                    Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: _calculatedBmi == null ? Colors.grey.shade50 : _bmiColor.withOpacity(0.08),
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(color: _calculatedBmi == null ? Colors.grey.shade200 : _bmiColor.withOpacity(0.3), width: 2),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("BMI Rate", style: TextStyle(fontSize: 14, color: _calculatedBmi == null ? Colors.grey : Colors.black87, fontWeight: FontWeight.bold)),
                              Text(
                                _calculatedBmi != null ? _calculatedBmi!.toStringAsFixed(1) : "--.-",
                                style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold, color: _bmiColor),
                              ),
                            ],
                          ),
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                            decoration: BoxDecoration(
                              color: _calculatedBmi == null ? Colors.grey.shade200 : _bmiColor.withOpacity(0.15), 
                              borderRadius: BorderRadius.circular(20)
                            ),
                            child: Text(
                              _bmiCategory, 
                              style: TextStyle(color: _calculatedBmi == null ? Colors.grey.shade600 : _bmiColor, fontWeight: FontWeight.bold)
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),

              const Text("Current Health Status", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.black87)),
              const SizedBox(height: 12),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: ['Normal', 'Patient', 'Pregnant'].map((status) {
                  final isSelected = _healthStatus == status;
                  return ChoiceChip(
                    label: Text(status, style: TextStyle(color: isSelected ? Colors.white : Colors.black87, fontWeight: FontWeight.bold)),
                    selected: isSelected,
                    selectedColor: primarySkyBlue,
                    backgroundColor: Colors.white,
                    showCheckmark: false,
                    onSelected: (selected) {
                      if (selected) {
                        setState(() {
                          _healthStatus = status;
                          if (status == 'Pregnant' && _selectedGender != 'Female') {
                            _selectedGender = 'Female'; 
                          }
                        });
                      }
                    },
                  );
                }).toList(),
              ),
              const SizedBox(height: 24),

              if (_healthStatus == 'Patient')
                _buildCard(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text("Patient Details", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.orange)),
                      const SizedBox(height: 8),
                      const Text("What health issues or problems are they facing?", style: TextStyle(fontSize: 12, color: Colors.black54)),
                      const SizedBox(height: 16),
                      if (_selectedConditions.isNotEmpty)
                        Wrap(
                          spacing: 8, runSpacing: 8,
                          children: _selectedConditions.map((condition) {
                            return InputChip(
                              label: Text(condition, style: const TextStyle(color: Colors.orange, fontWeight: FontWeight.bold)),
                              backgroundColor: Colors.orange.shade50,
                              deleteIconColor: Colors.orange,
                              onDeleted: () => setState(() => _selectedConditions.remove(condition)),
                            );
                          }).toList(),
                        ),
                      if (_selectedConditions.isNotEmpty) const SizedBox(height: 12),
                      Row(
                        children: [
                          Expanded(
                            child: _buildTextField(label: "", hint: "e.g. Diabetes, Ulcer...", controller: _conditionController),
                          ),
                          const SizedBox(width: 8),
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.orange,
                              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                            ),
                            onPressed: _addCondition,
                            child: const Text("Add", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),

              if (_healthStatus == 'Pregnant')
                _buildCard(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text("Pregnancy Details", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.purple)),
                      const SizedBox(height: 16),
                      Row(
                        children: [
                          Expanded(
                            child: _buildDropdown(
                              label: "Which Month?", 
                              value: _selectedMonth, 
                              items: _months, 
                              onChanged: (val) => _updatePregnancyMonth(val!)
                            ),
                          ),
                          const SizedBox(width: 16),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text("Trimester", style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: Colors.black87)),
                                const SizedBox(height: 8),
                                Container(
                                  width: double.infinity,
                                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                                  decoration: BoxDecoration(
                                    color: Colors.purple.shade50,
                                    borderRadius: BorderRadius.circular(12),
                                    border: Border.all(color: Colors.purple.shade200),
                                  ),
                                  child: Text(_calculatedTrimester, style: const TextStyle(color: Colors.purple, fontWeight: FontWeight.bold)),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                      _buildTextField(
                        label: "Do you have any pregnancy-related issues?", 
                        hint: "e.g. Gestational diabetes...", 
                        controller: _pregnancyIssuesController
                      ),
                    ],
                  ),
                ),

              if (_healthStatus != 'Normal') const SizedBox(height: 16),

              _buildCard(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text("Food Allergies", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.redAccent)),
                    const SizedBox(height: 16),
                    if (_selectedAllergies.isNotEmpty)
                      Wrap(
                        spacing: 8, runSpacing: 8,
                        children: _selectedAllergies.map((allergy) {
                          return InputChip(
                            label: Text(allergy, style: const TextStyle(color: Colors.redAccent, fontWeight: FontWeight.bold)),
                            backgroundColor: Colors.red.shade50,
                            deleteIconColor: Colors.redAccent,
                            onDeleted: () => setState(() => _selectedAllergies.remove(allergy)),
                          );
                        }).toList(),
                      ),
                    if (_selectedAllergies.isNotEmpty) const SizedBox(height: 12),
                    Row(
                      children: [
                        Expanded(child: _buildTextField(label: "", hint: "Type allergy...", controller: _allergyController)),
                        const SizedBox(width: 8),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.redAccent,
                            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                          ),
                          onPressed: _addAllergy,
                          child: const Text("Add", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 32),

              SizedBox(
                width: double.infinity,
                height: 56,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: healthGreen,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                  ),
                  onPressed: () {
                    Navigator.pop(context);
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Profile Updates Saved!')),
                    );
                  },
                  child: const Text("Save Changes", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCard({required Widget child}) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [BoxShadow(blurRadius: 12, color: Colors.black.withOpacity(0.03), offset: const Offset(0, 4))],
      ),
      child: child,
    );
  }

  Widget _buildTextField({required String label, required String hint, required TextEditingController controller, bool isNumber = false, Function(String)? onChanged}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (label.isNotEmpty) ...[Text(label, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: Colors.black87)), const SizedBox(height: 8)],
        TextField(
          controller: controller,
          keyboardType: isNumber ? TextInputType.number : TextInputType.text,
          onChanged: onChanged,
          decoration: InputDecoration(
            hintText: hint,
            hintStyle: TextStyle(color: Colors.grey.shade400, fontSize: 13),
            filled: true,
            fillColor: Colors.grey.shade50,
            contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide(color: Colors.grey.shade300)),
            enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide(color: Colors.grey.shade300)),
          ),
        ),
      ],
    );
  }

  Widget _buildDropdown({required String label, required String value, required List<String> items, required Function(String?) onChanged}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: Colors.black87)),
        const SizedBox(height: 8),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
          decoration: BoxDecoration(
            color: Colors.grey.shade50,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: Colors.grey.shade300),
          ),
          child: DropdownButtonHideUnderline(
            child: DropdownButton<String>(
              value: value,
              isExpanded: true,
              items: items.map((e) => DropdownMenuItem(value: e, child: Text(e))).toList(),
              onChanged: onChanged,
            ),
          ),
        ),
      ],
    );
  }
}