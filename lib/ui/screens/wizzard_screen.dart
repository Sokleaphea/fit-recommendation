import 'package:flutter/material.dart';
import 'package:oshifit/data/mocks/outfits_data.dart';
import 'package:oshifit/data/services/outfit_filter_service.dart';
import 'package:oshifit/models/city_model.dart';
import 'package:oshifit/models/outfit.dart';
import 'package:oshifit/models/outfit_criteria.dart';
import 'package:oshifit/ui/screens/filter_result_screen.dart';

class WizzardScreen extends StatefulWidget {
  const WizzardScreen({super.key});

  @override
  State<WizzardScreen> createState() => _WizzardScreenState();
}

class _WizzardScreenState extends State<WizzardScreen> {
  final _service = OutfitFilterService();

  int _step = 0;
  Weather _selectedWeather = Weather.values.first;
  bool _weatherChosen = false;
  final List<Styles> _selectedStyles = [];
  LocationMode _locationMode = LocationMode.current;
  City? _selectedCity;

  List<Outfit> _filtered = [];

  @override
  void initState() {
    super.initState();
  }

  Future<void> _applyFilter() async {
    if (!_weatherChosen) {
      setState(() {
        _filtered = [];
      });
      return;
    }

    final criteria = OutfitCriteria(selectedWeather: _selectedWeather)
      ..selectedStyles = List.of(_selectedStyles)
      ..locationMode = _locationMode
      ..selectedCity = _selectedCity;

    final result = await _service.filterOutfits(outfits, criteria);

    setState(() {
      _filtered = result;
    });
  }

  void _next() {
    if (_step < 2) {
      setState(() {
        _step++;
      });
      return;
    }
    Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (_) => FilterResultScreen(outfits: _filtered)));
  }

  void _back() {
    if (_step == 0) {
      Navigator.of(context).maybePop();
      return;
    }
    setState(() => _step--);
  }

  void _selectWeather(Weather w) {
    _selectedWeather = w;
    _weatherChosen = true;
    _applyFilter();
  }

  void _toggleStyle(Styles s, bool enable) {
    if (enable) {
      if (_selectedStyles.length >= 3) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('You can select up to 3 styles'))
        );
        return;
      }
      _selectedStyles.add(s);
    } else {
      _selectedStyles.remove(s);
    }
    _applyFilter();
  }

  void _setLocationMode(LocationMode m, [City? city]) {
    _locationMode = m;
    _selectedCity = city;
    _applyFilter();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFFFFF4E6),
        leading: IconButton(
          onPressed: _back, 
          icon: const Icon(Icons.arrow_back_ios)
        ),
        elevation: 0,
        title: const Text(
          'Back', 
          style: TextStyle(fontWeight: FontWeight.w600, fontSize: 20)
        ),
        centerTitle: false,
        titleSpacing: 12,
      ),
      backgroundColor: const Color(0xFFFFF4E6),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(16, 8, 16, 16),
          child: Column(
            children: [
              Align(
                alignment: Alignment.centerLeft,
                child: const Text(
                  'What do you want to wear? Come find with us! 😁', 
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.w600)
                ),
              ),
              const SizedBox(height: 8),
              Expanded(
                child: IndexedStack(
                  index: _step,
                  children: [
                    _WeatherStep(
                      selectedweather: _selectedWeather,
                      selected: _weatherChosen,
                      onSelected: _selectWeather,
                      onNext: _next,
                    ),
                    _StyleStep(
                      selectedStyles: _selectedStyles,
                      onToggle: _toggleStyle,
                      onNext: _next,
                      enabled: _selectedStyles.isNotEmpty,
                    ),
                    _LocationStep(
                      mode: _locationMode,
                      selectedCity: _selectedCity,
                      onModeChanged: _setLocationMode,
                      onFinish: _next,
                      enabled: _locationMode == LocationMode.all || _locationMode == LocationMode.current || (_locationMode == LocationMode.selected && _selectedCity != null),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _WeatherStep extends StatelessWidget {
  final Weather selectedweather;
  final bool selected;
  final void Function(Weather) onSelected;
  final VoidCallback onNext;

  const _WeatherStep({required this.selectedweather, required this.selected, required this.onSelected, required this.onNext});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Choose weather'),
        const SizedBox(height: 12),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: Weather.values.map((w) {
            final isSelected = selected && w == selectedweather;
            return ChoiceChip(
              label: Text(
                w.toString().split('.').last,
                style: TextStyle(color: isSelected ? Colors.white : Colors.black),
              ),
              selected: isSelected,
              onSelected: (_) => onSelected(w),
              backgroundColor: const Color(0xFFB8D3DE),
              selectedColor: const Color(0xFF234C6A),
              showCheckmark: false,
            );
          }).toList(),
        ),
        const SizedBox(height: 12),
        SizedBox(
          width: double.infinity,
          child: Builder(builder: (context) {
            final enabled = selected;
            return TextButton(
              onPressed: enabled ? onNext : null,
              style: TextButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 14)
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    'Next', 
                    style: TextStyle(color: enabled ? Colors.black : Colors.grey)
                  ),
                  const SizedBox(width: 8),
                  Icon(Icons.arrow_forward_ios, color: enabled ? Colors.black : Colors.grey),
                ],
              ),
            );
          }),
        ),
      ],
    );
  }
}

class _StyleStep extends StatelessWidget {
  final List<Styles> selectedStyles;
  final void Function(Styles, bool) onToggle;
  final VoidCallback onNext;
  final bool enabled;

  const _StyleStep({required this.selectedStyles, required this.onToggle, required this.onNext, required this.enabled});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Select styles'),
        const SizedBox(height: 12),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: Styles.values.map((s) {
            final isSelected = selectedStyles.contains(s);
            return FilterChip(
              label: Text(
                s.toString().split('.').last,
                style: TextStyle(color: isSelected ? Colors.white : Colors.black),
              ),
              selected: isSelected,
              onSelected: (v) => onToggle(s, v),
              backgroundColor: const Color(0xFFB8D3DE),
              selectedColor: const Color(0xFF234C6A),
              showCheckmark: false,
            );
          }).toList(),
        ),
        const SizedBox(height: 12),
        SizedBox(
          width: double.infinity,
          child: Builder(builder: (context) {
            final en = enabled;
            return TextButton(
              onPressed: en ? onNext : null,
              style: TextButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 14)
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    'Next', 
                    style: TextStyle(color: en ? Colors.black : Colors.grey)
                  ),
                  const SizedBox(width: 8),
                  Icon(Icons.arrow_forward_ios, color: en ? Colors.black : Colors.grey),
                ],
              ),
            );
          }),
        ),
      ],
    );
  }
}

class _LocationStep extends StatelessWidget {
  final LocationMode mode;
  final City? selectedCity;
  final void Function(LocationMode, [City?]) onModeChanged;
  final VoidCallback onFinish;
  final bool enabled;

  const _LocationStep({required this.mode, required this.selectedCity, required this.onModeChanged, required this.onFinish, required this.enabled});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Select location'),
        const SizedBox(height: 12),
        Theme(
          data: Theme.of(context).copyWith(unselectedWidgetColor: const Color(0xFFB8D3DE)),
          child: RadioListTile<LocationMode>(
            title: Text(
              'All location', 
              style: TextStyle(color: mode == LocationMode.all ? Colors.black : Colors.grey)
            ),
            value: LocationMode.all,
            groupValue: mode,
            activeColor: const Color(0xFF234C6A),
            onChanged: (v) => onModeChanged(LocationMode.all),
          ),
        ),
        Theme(
          data: Theme.of(context).copyWith(unselectedWidgetColor: const Color(0xFFB8D3DE)),
          child: RadioListTile<LocationMode>(
            title: Text(
              'Use current location', 
              style: TextStyle(color: mode == LocationMode.current ? Colors.black : Colors.grey)
            ),
            value: LocationMode.current,
            groupValue: mode,
            activeColor: const Color(0xFF234C6A),
            onChanged: (v) => onModeChanged(LocationMode.current),
          ),
        ),
        Theme(
          data: Theme.of(context).copyWith(unselectedWidgetColor: const Color(0xFFB8D3DE)),
          child: RadioListTile<LocationMode>(
            title: Text(
              'Select city', 
              style: TextStyle(color: mode == LocationMode.selected ? Colors.black : Colors.grey)
            ),
            value: LocationMode.selected,
            groupValue: mode,
            activeColor: const Color(0xFF234C6A),
            onChanged: (v) => onModeChanged(LocationMode.selected, selectedCity ?? City.PhnomPenh),
          ),
        ),
        if (mode == LocationMode.selected) ...[
          const SizedBox(height: 8),
          DropdownButtonHideUnderline(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              decoration: BoxDecoration(
                color: Colors.transparent,
                border: Border.all(color: const Color(0xFF6A3AA8), width: 2),
                borderRadius: BorderRadius.circular(14),
              ),
              child: DropdownButton<City>(
                value: selectedCity ?? City.PhnomPenh,
                items: City.values
                    .map((c) => DropdownMenuItem(value: c, child: Text(c.displayName)))
                    .toList(),
                onChanged: (c) => onModeChanged(LocationMode.selected, c),
                isExpanded: true,
                icon: const Icon(Icons.arrow_drop_down),
                dropdownColor: const Color(0xFFFFF4E6),
                style: const TextStyle(color: Colors.black),
              ),
            ),
          ),
        ],
        const SizedBox(height: 12),
        SizedBox(
          width: double.infinity,
          child: Builder(builder: (context) {
            final en = enabled;
            return TextButton(
              onPressed: en ? onFinish : null,
              style: TextButton.styleFrom(padding: const EdgeInsets.symmetric(vertical: 14)),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    'Finish', 
                    style: TextStyle(color: en ? Colors.black : Colors.grey)
                  ),
                  const SizedBox(width: 8),
                  Icon(Icons.arrow_forward_ios, color: en ? Colors.black : Colors.grey),
                ],
              ),
            );
          }),
        ),
      ],
    );
  }
}
