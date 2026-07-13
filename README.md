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