# Architecture decision records

An [architecture
decision](https://cloud.google.com/architecture/architecture-decision-records)
is a software design choice that evaluates:

-   a functional requirement (features).
-   a non-functional requirement (technologies, methodologies, libraries).

The purpose is to understand the reasons behind the current architecture, so
they can be carried-on or re-visited in the future.

## Idea

### Problem Description:

The Flutter component using Material3 must integrate two models:
`CopperframeMessage` and `CopperframeSlotBase`. The component should
dynamically render different layouts and content based on the `size` and
`prominence` values from the slot model, as well as display messages from the
`CopperframeMessage` list. It must also support configuration options for
message display rules and badges.

### Use Cases:

1.  **Size: `bar`**

    -   Displays an icon, the title, and the description (as a tooltip).
    -   Shows badges indicating the number of errors, warnings, and other
        messages.
    -   Should be configurable to show/hide badges when message count is zero.

2.  **Size: `small`**

    -   Displays the same bar as in the `bar` size.
    -   Shows up to two messages (can be less if there are fewer messages).
    -   Should be configurable to show messages by level (grouping by error,
        warning, etc.) or all merged together.

3.  **Size: `medium`**

    -   Displays the same bar.
    -   Shows up to five messages.
    -   Allows configuration of message display rules and the number of
        messages for medium size.

4.  **Size: `large`**

    -   Displays all available messages.
    -   Adds a scrollbar if the messages exceed the viewable area.
    -   Configurable to decide whether to display messages by levels or merged.

5.  **Prominence: `low`**

    -   The component should be visually subdued, making it less prominent
        (using softer colors, less contrast).

6.  **Prominence: `medium`**

    -   The component should appear with normal visibility, using the default
        Flutter theme.

7.  **Prominence: `high`**
    -   The component should be visually stronger (with increased contrast or
        different colors), ensuring that it draws attention.

### Configuration:

-   The number of messages displayed per size should be configurable for
    each size (`bar`, `small`, `medium`, `large`).
-   The option to show or hide badges when there are no messages for each
    type.
-   An option to group and display messages by their level (e.g., errors
    grouped together, warnings grouped together) or display all messages in
    a merged view without grouping.

### Edge Cases:

-   No messages are available:
    -   Should handle the absence of messages gracefully.
    -   If configured, badges for errors, warnings, and other messages should
        still display (even if their count is zero).
-   Fewer messages than the configured display limit:
    -   The component should adapt to show the available messages without empty
        space or errors.
-   Conflicting configuration options:
    -   For example, if prominence is set to `high` but the configuration
        suppresses message visibility (e.g., hide all badges), ensure the
        prominence rules still make the panel visible but without forcing
        unnecessary badges.

### Limitations:

-   The `status` and `secondaryStatus` from `CopperframeSlotBase` should be
    ignored. They are redundant and not relevant for this component's
    behavior.
-   The component should not handle message content formatting, such as
    turning URLs into clickable links or interpreting Markdown. The focus
    is on message display and layout.
-   Do not implement any business logic for processing messages (e.g.,
    deduplication or filtering by category). The component simply displays
    whatever is passed in the `CopperframeMessage` list.

## About Circular Parameter List

This should eventually be moved to its own library.

### Specs for `CircularParameterList` Class

**Purpose**:
The `CircularParameterList` class manages a collection of labeled parameters,
enabling cyclic iteration through the list. Each parameter has a label (a
string) and a value (generic). The class provides methods to move through the
list, access the current parameter, reset the iteration, and retrieve
meta-information about the list.

***

### Problem Description:

The `CircularParameterList` must store a list of parameters, each with a
label and a generic value. The iteration over this list should be
circular—when the end is reached, it should loop back to the beginning and
trigger a callback. The class should offer the ability to retrieve the
current parameter, reset the index to the start, and provide utility
functions for managing and accessing list data.

### Attributes:

-   **label** (String): A unique string identifier for each parameter.
-   **value** (generic): A value of any type associated with the parameter.

### Fields:

-   **\_parameters**: Internal list holding the parameters, where each
    parameter is an object with a label and value.
-   **\_index**: Internal index (int?) pointing to the current position in
    the list.
-   **onCycleRestart**: Callback function that is triggered when the
    iteration reaches the end of the list and wraps back to the start.

### Methods:

1.  **next()**:

    -   Moves the internal index to the next parameter in the list.
    -   If the end of the list is reached, it wraps back to the first element
        and triggers `onCycleRestart`.
    -   If the list is empty, it does nothing.

2.  **current()**:

    -   Returns the current parameter (label and value) based on the internal
        index.
    -   If the list is empty or the index is null, it returns `null`.

3.  **reset()**:

    -   Resets the internal index to the first element in the list.
    -   Does nothing if the list is empty.

4.  **length()**:

    -   Returns the total number of parameters in the list.

5.  **currentIndex()**:

    -   Returns the current internal index. If the index is null, it returns
        `-1` to indicate no valid index (e.g., list is empty or iteration has
        not started).

6.  **toList()**:
    -   Returns the entire list of parameters (label and value pairs) as a
        standard Dart list.

### Use Cases:

1.  **Basic Circular Iteration**:

    -   User creates a `CircularParameterList` with three parameters.
    -   `next()` is called three times, advancing through each parameter in
        sequence.
    -   On the fourth call, the list wraps back to the first parameter and
        triggers the `onCycleRestart` callback.

2.  **Resetting the List**:

    -   User calls `reset()` to return the index to the first parameter at any
        time.
    -   After resetting, the next call to `next()` retrieves the first
        parameter again.

3.  **Accessing Current Parameter**:

    -   After moving to a certain position with `next()`, the user can retrieve
        the current parameter with `current()`.

4.  **Handling Empty List**:

    -   If the parameter list is empty, `next()`, `reset()`, and `current()`
        will perform no operations.
    -   `current()` returns `null`, and `currentIndex()` returns `-1`.

5.  **Callback on Restart**:
    -   If a user sets an `onCycleRestart` callback, it is triggered each time
        the list cycles back to the beginning after reaching the last
        parameter.

### Edge Cases:

1.  **Empty Parameter List**:

    -   If the list is initialized empty, methods like `next()`, `reset()`, and
        `current()` should handle this gracefully.
    -   `next()` should not trigger the `onCycleRestart` callback in this case.

2.  **Null Index**:

    -   If the internal index is `null` (e.g., before any `next()` or after
        resetting an empty list), `current()` should return `null`, and
        `currentIndex()` should return `-1`.

3.  **Single Element List**:

    -   If the list contains only one parameter, `next()` should repeatedly
        return that parameter and trigger `onCycleRestart` every time it loops.

4.  **Callback Error Handling**:
    -   Ensure that if the `onCycleRestart` callback is not set, it does not
        raise an error when cycling through the list.

### Out of Scope:

-   No need to handle the modification of parameters mid-iteration. The
    class assumes the list is static once initialized.
-   No automatic insertion, removal, or sorting of parameters; the list is
    static after setup.
-   No advanced data validation or transformations on the parameter values
    themselves; values are treated as opaque data types.

### Summary of Method Names:

-   Class: `CircularParameterList`
-   Methods: `next()`, `current()`, `reset()`, `length()`,
    `currentIndex()`, `toList()`
-   Callback: `onCycleRestart`

These names and methods align with Dart’s best practices, offering clear
functionality while maintaining concise, idiomatic naming.
