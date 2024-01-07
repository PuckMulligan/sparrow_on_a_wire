# RulesManager Documentation

## Overview
`RulesManager` is a Godot singleton script responsible for managing game rules in our Baba is You inspired puzzle game. It dynamically evaluates, applies, and removes rules based on the game's current state, particularly focusing on the interactions and positions of various blocks within the game.

## Signals
- `rule_added(subject, rule)`
  - Emitted when a new rule is added to a game element.
- `rule_removed(subject, rule)`
  - Emitted when a rule is removed from a game element.

## Properties
- `directions`: An array of `Vector2`, representing the directions in which the script checks for rule sequences.
- `elements`: A dictionary holding the game elements and their associated rules.
- `global_id_counter`: An integer counter used for generating unique IDs for game elements.

## Methods

### Public Methods

#### `_init()`
Initializes the script and sets up the game elements.

#### `add_element(name: String, data: Dictionary)`
Adds a new element to the game with specified properties.

- `name`: The name of the element.
- `data`: A dictionary containing the element's properties.

#### `is_rule_active(element_name, rule)`
Checks if a specific rule is currently active for a given element.

- `element_name`: The name of the element to check.
- `rule`: The rule to check for.

#### `remove_rule(element_name, rule_to_remove)`
Removes a specific rule from an element.

- `element_name`: The name of the element from which to remove the rule.
- `rule_to_remove`: The rule to be removed.

### Private Methods

#### `_ready()`
Sets up necessary connections when the script is ready.

#### `initialize_elements()`
Initializes the game elements with their default properties and states.

#### `parse_rules()`
Parses and evaluates rules for all game elements.

#### `_on_Block_moved(block)`
Callback function triggered when a block is moved.

- `block`: The block instance that has been moved.

#### `evaluate_block_rules(block_instance)`
Evaluates and applies rules for a specific block instance.

- `block_instance`: The block instance to evaluate.

#### `get_unique_id()`
Generates a unique ID for each game element.

#### `apply_rule(rule_sequence)`
Applies a rule based on a given rule sequence.

- `rule_sequence`: A dictionary representing a rule sequence.

#### `find_rule_sequence(block_instance, direction)`
Finds a rule sequence for a block in a specific direction.

- `block_instance`: The block instance to check.
- `direction`: The direction in which to check for a rule sequence.

#### `is_verb(block)`
Checks if a given block is a verb.

- `block`: The block instance to check.

## Usage
The `RulesManager` script is designed to be attached to a singleton node in Godot. It can be accessed from various parts of the game to check, apply, or remove rules based on the game's logic and player interactions.

## Example
```gdscript
# Accessing the RulesManager singleton to check if a rule is active
if RulesManager.is_rule_active("baba", "you"):
    # Do something if the rule "baba is you" is active
```
