/// This Flutter component, built using Material3, integrates `CopperframeMessage`
/// and `CopperframeSlotBase` models to dynamically render different layouts based
/// on slot properties (`size` and `prominence`). It displays messages from
/// `CopperframeMessage` with configurable display rules and badges. The component
/// adapts to various sizes:
///
/// - `bar`: Displays an icon, title, description, and badges for message counts.
/// - `small`: Displays up to two messages and the `bar`.
/// - `medium`: Displays up to five messages and the `bar`.
/// - `large`: Displays all messages with scroll support if needed.
///
/// Visual prominence (`low`, `medium`, `high`) adjusts the component's styling to
/// blend in or draw more attention. Configuration options include badge visibility,
/// grouping messages by level, and controlling the number of displayed messages per size.
/// The component gracefully handles edge cases like the absence of messages and conflicting
/// configurations, ensuring appropriate visual behavior and user experience.

library message_slot_bubblegum;

export 'src/message_slot_material.dart';
export 'src/icon_collection.dart';
export 'src/message_slot_options.dart';
