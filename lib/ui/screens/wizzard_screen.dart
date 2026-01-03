import 'package:flutter/material.dart';
import 'package:oshifit/data/mocks/outfits_data.dart';
import 'package:oshifit/data/services/outfit_filter_service.dart';
import 'package:oshifit/data/services/location_service.dart';
import 'package:oshifit/data/repositories/city_repositories.dart';
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
  final List<Styles> _selectedStyles = [];
  LocationMode _locationMode = LocationMode.current;
  City? _selectedCity;
  City? _currentCity;
  String? _currentLocationText;
  bool _resolvingLocation = false;
  List<Outfit> _filtered = [];

  @override
  void initState() {
    super.initState();
    _applyFilter();
    _resolveCurrentLocation();
  }

  Future<void> _resolveCurrentLocation() async {
    setState(() => _resolvingLocation = true);
    try {
      final pos = await LocationService().getCurrentLocation();
      final matched = CityRepositories().matchCity(pos.latitude, pos.longitude);
      setState(() {
        _currentCity = matched;
        _currentLocationText = '${pos.latitude.toStringAsFixed(5)}, ${pos.longitude.toStringAsFixed(5)}' + (matched != null ? ' — ${matched.displayName}' : ' — unknown');
      });
      await _applyFilter();
    } catch (e) {
      setState(() {
        _currentLocationText = 'Unable to get location';
      });
    } finally {
      setState(() => _resolvingLocation = false);
    }
  }

  Future<void> _applyFilter() async {
    final criteria = OutfitCriteria(selectedWeather: _selectedWeather)
      ..selectedStyles = List.of(_selectedStyles)
      ..locationMode = _locationMode
      ..selectedCity = _selectedCity;

    final result = await _service.filterOutfits(outfits, criteria, currentCity: _currentCity, locationService: LocationService());

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
    _applyFilter();
  }

  void _toggleStyle(Styles s, bool enable) {
    if (enable) {
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
    if (m == LocationMode.current) {
      _resolveCurrentLocation();
    }
  }

  @override
  Widget build(BuildContext context) {
    final titles = ['Weather', 'Style', 'Location'];
    return Scaffold(
      appBar: AppBar(
        title: Text(titles[_step], style: const TextStyle(fontWeight: FontWeight.w600)),
        leading: IconButton(onPressed: _back, icon: const Icon(Icons.arrow_back)),
        backgroundColor: const Color(0xFFFFF4E6),
        elevation: 0,
        centerTitle: true,
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      backgroundColor: const Color(0xFFFFF4E6),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: IndexedStack(
            index: _step,
            children: [
              _WeatherStep(
                selectedweather: _selectedWeather, 
                onSelected: _selectWeather, 
                onNext: _next
              ),
              _StyleStep(
                selectedStyles: _selectedStyles, 
                onToggle: _toggleStyle, 
                onNext: _next, 
                onBack: _back
              ),
              _LocationStep(
                mode: _locationMode,
                selectedCity: _selectedCity,
                onModeChanged: _setLocationMode,
                onFinish: _next,
                onBack: _back,
                currentLocationText: _currentLocationText,
                resolving: _resolvingLocation,
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
  final void Function(Weather) onSelected;
  final VoidCallback onNext;

  const _WeatherStep({required this.selectedweather, required this.onSelected, required this.onNext});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Choose weather'),
        const SizedBox(height: 12),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: Weather.values.map((w) {
            final isSelected = w == selectedweather;
            return ChoiceChip(
              label: Text(w.toString().split('.').last), 
              selected: isSelected, 
              onSelected: (_) => onSelected(w)
            );
          }).toList(),
        ),
        const Spacer(),
        SizedBox(
          width: double.infinity,
          child: ElevatedButton(onPressed: onNext, child: const Text('Next')),
        ),
      ],
    );
  }
}

class _StyleStep extends StatelessWidget {
  final List<Styles> selectedStyles;
  final void Function(Styles, bool) onToggle;
  final VoidCallback onNext;
  final VoidCallback onBack;

  const _StyleStep({required this.selectedStyles, required this.onToggle, required this.onNext, required this.onBack});

  @override
  Widget build(BuildContext context) {
    return Column(
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
              label: Text(s.toString().split('.').last), 
              selected: isSelected, 
              onSelected: (v) => onToggle(s, v)
            );
          }).toList(),
        ),
        const Spacer(),
        Row(
          children: [
            Expanded(
              child: OutlinedButton(onPressed: onBack, child: Text('Back')),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: ElevatedButton(onPressed: onNext, child: Text('Next')),
            ),
          ],
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
  final VoidCallback onBack;
  final String? currentLocationText;
  final bool resolving;

  const _LocationStep({
    required this.mode,
    required this.selectedCity,
    required this.onModeChanged,
    required this.onFinish,
    required this.onBack,
    this.currentLocationText,
    this.resolving = false,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Select location'),
        const SizedBox(height: 12),
        RadioListTile<LocationMode>(
          title: const Text('All location'), 
          value: LocationMode.all, 
          groupValue: mode, 
          onChanged: (v) => onModeChanged(LocationMode.all)
        ),
        RadioListTile<LocationMode>(
          title: const Text('Use current location'),
          value: LocationMode.current,
          groupValue: mode,
          onChanged: (v) => onModeChanged(LocationMode.current),
        ),
        RadioListTile<LocationMode>(
          title: const Text('Select city'),
          value: LocationMode.selected,
          groupValue: mode,
          onChanged: (v) => onModeChanged(LocationMode.selected, selectedCity ?? City.PhnomPenh),
        ),
        if (mode == LocationMode.selected) ...[
          const SizedBox(height: 8),
          DropdownButton<City>(
            value: selectedCity ?? City.PhnomPenh,
            items: City.values.map((c) => DropdownMenuItem(value: c, child: Text(c.displayName))).toList(),
            onChanged: (c) => onModeChanged(LocationMode.selected, c),
          ),
        ],
        const SizedBox(height: 12),
        if (mode == LocationMode.current) ...[
          resolving
              ? Row(children: const [CircularProgressIndicator(), SizedBox(width: 8), Text('Resolving location...')])
              : Text('Current location: ${currentLocationText ?? 'unknown'}'),
        ],
        const Spacer(),
        Row(
          children: [
            Expanded(
              child: OutlinedButton(onPressed: onBack, child: const Text('Back')),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: ElevatedButton(onPressed: onFinish, child: const Text('Finish')),
            ),
          ],
        ),
      ],
    );
  }
}
