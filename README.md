\# Quest for Valor



## Design Philosphy
The engine should expose fundamental events.

Examples:
- Turn started
- Unit moved
- Combat started
- HP changed
- Terrain entered
- Item equipped

More complex behaviors are built by writing custom listeners that combine these events and emit new, higher-level events if needed.

The engine provides the building blocks.
Game logic composes them.

Systems own truth.
The EventBus broadcasts truth.
Gameplay objects react to truth.


## Definitions:

Bus: Owns the signals.
System: controls and owns the ultimate state of a thing, or controls the obj that owns the state. emits signals(event) based on that state.
Condition: state obj that knows whether its true or false and can signal accordingly. evaluates state from received information to determine wether its condition is met.
Trigger: an obj with a condition that executes a func when the condition is true.
Event: a state obj emitted by a system through a signal. it contains relevant info from the system representing what has happened. Its purpose it to wrap the information, sometimes process its own internal state, but always to serve as a container holding the announced state.
InviteEvent: Subclass of an event that is architecturally the same as an event but with a separate class name to specify this event invites mutation as opposed to simply being announced.


Object:
- own value durability
- signal_durability_chnaged(DUrabilityChnaged.new(durability))

