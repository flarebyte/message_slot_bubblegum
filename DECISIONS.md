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
