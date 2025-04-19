import 'package:flame/components.dart';
import 'package:flame/events.dart';

/// A simple component to handle drag events
class CustomDragDetector extends Component with DragCallbacks {
  // Callbacks for drag events
  Function(DragStartEvent)? onStartDrag;
  Function(DragEndEvent)? onEndDrag;
  Function(DragUpdateEvent)? onUpdateDrag;
  
  CustomDragDetector({
    this.onStartDrag,
    this.onEndDrag,
    this.onUpdateDrag,
  });
  
  @override
  bool onDragStart(DragStartEvent event) {
    if (onStartDrag != null) {
      onStartDrag!(event);
      return true;
    }
    return false;
  }
  
  @override
  bool onDragEnd(DragEndEvent event) {
    if (onEndDrag != null) {
      onEndDrag!(event);
      return true;
    }
    return false;
  }
  
  @override
  bool onDragUpdate(DragUpdateEvent event) {
    if (onUpdateDrag != null) {
      onUpdateDrag!(event);
      return true;
    }
    return false;
  }
} 