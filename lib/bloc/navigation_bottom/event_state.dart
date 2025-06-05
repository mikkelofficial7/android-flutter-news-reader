import 'package:equatable/equatable.dart';

// Event
class NavigationBottomEvent extends Equatable {
  final int index;
  const NavigationBottomEvent({required this.index});

  @override
  List<Object> get props => [index];
}

// State
class NavigationBottomState extends Equatable {
  final int index;

  const NavigationBottomState.defaultPosition() : index = 0;

  const NavigationBottomState({
    required this.index,
  });

  @override
  List<Object?> get props => [index];
}
