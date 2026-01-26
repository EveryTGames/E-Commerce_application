import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'input_provider.dart';

class InputControllerNotifier extends Notifier<InputControl> {
  final ValidationConfig config;

  InputControllerNotifier(this.config);

  @override
  InputControl build() {
    return InputControl(config: config);
  }

  void update(String value) {
    state = state.copyWith(value: value);
  }

  bool validate() {
    state.update(state.value);
    return state.isValid;
  }

  // Force recompute error messages (call when locale changes)
  void recomputeError() {
    state.update(state.value); // triggers validation again
  }
}

final inputProvider =
    NotifierProvider.family<
      InputControllerNotifier,
      InputControl,
      ValidationConfig
    >((config) => InputControllerNotifier(config));




class SmartTextField extends ConsumerStatefulWidget {
  final String label;
  final ValidationConfig config;
  final Duration debounceDuration;

  const SmartTextField({
    super.key,
    required this.label,
    required this.config,
    this.debounceDuration = const Duration(milliseconds: 300),
  });

  @override
  ConsumerState<SmartTextField> createState() => _SmartTextFieldState();
}

class _SmartTextFieldState extends ConsumerState<SmartTextField> {
  late final TextEditingController controller;
  Timer? _debounce;
  bool _isListening = false; // ensure we listen only once
  bool obscure = true;

  @override
  void initState() {
    super.initState();
    final initialValue = ref.read(inputProvider(widget.config)).value;
    controller = TextEditingController(text: initialValue);
  }

  @override
  void dispose() {
    controller.dispose();
    _debounce?.cancel();
    super.dispose();
  }

  void _onChanged(String value) {
    _debounce?.cancel();
    _debounce = Timer(widget.debounceDuration, () {
      ref.read(inputProvider(widget.config).notifier).update(value);
    });
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(inputProvider(widget.config));

    // Listen to provider changes (once)
    if (!_isListening) {
      ref.listen<InputControl>(inputProvider(widget.config), (prev, next) {
        if (prev?.value != next.value && controller.text != next.value) {
          controller.value = controller.value.copyWith(
            text: next.value,
            selection: TextSelection.collapsed(offset: next.value.length),
          );
        }
      });
      _isListening = true;
    }

    return Material(
      color: Colors.transparent,
      child: TextField(
        controller: controller,
        onChanged: _onChanged,
        obscureText: widget.config.rules.contains(InputRule.password)
            ? obscure
            : false,
        decoration: InputDecoration(
          labelText: widget.label,
          errorText: state.error,
          suffixIcon: widget.config.rules.contains(InputRule.showhidebutton)
              ? IconButton(
            icon: Icon(
              obscure ? Icons.visibility_off : Icons.visibility,
              color: Colors.white70,
            ),
            onPressed: () {
              setState(() {
                obscure = !obscure;
              });
            },
          )
              : null,
        ),

      ),
    );
  }
}
