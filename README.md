\# Quest for Valor



# Design Philosphy
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


# Definitions:

Bus: Owns the signals.
System: controls and owns the ultimate state of a thing, or controls the obj that owns the state. emits signals(event) based on that state.
Condition: state obj that knows whether its true or false and can signal accordingly. evaluates state from received information to determine wether its condition is met.
Trigger: an obj with a condition that executes a func when the condition is true.
Event: a state obj emitted by a system through a signal. it contains relevant info from the system representing what has happened. Its purpose it to wrap the information, sometimes process its own internal state, but always to serve as a container holding the announced state.
InviteEvent: Subclass of an event that is architecturally the same as an event but with a separate class name to specify this event invites mutation as opposed to simply being announced.


Object:
- own value durability
- signal_durability_chnaged(DUrabilityChnaged.new(durability))

# Characters

## Relationships

- Small stat boosts depednig on rank of relationship, much higher limit on relationships then GBA games.
  - Combat:
    - relatioship growth:
      - small boost for standing near each other.
      - larger bost for completign an atack near each other
      - even larger boost for both attackign the same enemy.
  - boosts:
    - having som one you care for gives you a boost when attackign that enemy, but can drop your skill.

## Skills

- Profeciency: how good you are at a skill.
- Ability: A skill without profeciency, just soemthing you can do, ofte with a condiiton attached.

# Weapons

- Duarbility exits buts its large, you can buy weapons but you spend money to keep the ones you ahve in good shape, now you use good weapons but theres still a cost
- skill is tied to a character, not a weapon, but whe using a different wepaon their skills are weakened significantly.
- focus more on range, speed, armor types rather thns weapon tringle.
- combat arts are cool

## Bows

- long range, less accuracy further away (skill dependent) need more strength to use bows that can pierce armor, agility lets you get more shots off dependign on the strength cost.


## Magic

- mana is an aspect fo health, you regenerate if over tiem and magic draws from there first, if you overdraw on mana it costs health.

## Armor

- anyone can wear it, it adds to stats but cna limit movement,
- only soem classes can wear armor of a given grade and they experience a movement penalty to their speed, maybe less of oen abse don strength.

# Combat

## Charging

the way you get to a place matter just as much as gettign to it, cavalry and mounted units can build speed if they travel relatively straight and deal extra damage, units on foot don't really get this but also aren't penalized for standign still like mounted units. Mounted units ideally shoudl always move a bit to attack. maybe

## Fatiuge

The longer a battle goes on and the more one attacks or si attacked your overal rate of recovery decreases, consistently pushign a character causes their stamina to grow as cna their rate of overall recovery (combien into asingle function? logarithmic, more you push yourself the longer you can go before experince greater loss?)

## Strength, Agility, Recovery: Stamina

A character has a set amout of stamina, you can exhaust it from differnt areas, strength is doing somethind instantly demanding on your body, agility relates to how fast you cna do things, recovery is how quickly you recover your stamina after a given choice.

- your recovery in an area relates to how you train it, soem classes astart with higher recovery on certain actions

## Camping

- passes time, allows for interaction and dialogue scenes.
- can choose to train

# Thoughts

- is agility a measure of how much stamina can you use in a set time (a turn?) or is it how fast you are? Are those dieas differnt?
- is strength how much stamian you can spend on a move?
- recovery stays the idea of much much you regain, makes sense that is a function of rate of stmaina used or function over time
- is movemnt stamign dependent? Or strength determines how much movent consumes and agility determiens how fast youca do it ti in ?
  - mana is an element of stamina but only counts for use of magic.
  - shoudl their bee differnt energy suplies to dedicate to differnt task? that may obfiscate thinsg to where th eplayer doesn't even think about energy in abttle for the most part in terms of how much a move costs unless they decide to go ovre their limit.

  


- Central idea, a turn takes a certain amount of time, actiosna re done all at the same time, thats a differnt type of strategdy I tihnk, not one im sure i want. You have a given amout nof energy on a turn and ideally a certianstaic amout of "time" not an actual numbe rof second as much as it ho much a character cna do on their turn. I don't want characters sweatign their energy too much, I want it to eb a resource they rally only consdier as a character grows tired or whe they use excess stamina to do more on an attack, is that solved by balancing or mechines?


Stamina: [ Attack Energy / or Mana Energy (depends on weapon equipped)   ][Movement Energy             ][Extra Store (consumable doesn't regen)]

  - attack energy: determined by strength, using same amoutn as your strength stat is normal. decreases overtime with fatigue but that can eb slowed by your recovery profeciency in that area.
    - mana energy: determiend by mag power, same as strength except goig over the limit can draw from health or extra store, drawing from ehalth does damage whiel drawing from extra store slows mana regen.
  - movment energy: determiend by agility / weight, usinf same amoutn as your speed altered by weight / terrain is normal. decreases overtime with fatigue but that can eb slowed by your recovery profeciency in that area.
  - exrta store: Cutting into it pushes you into fatigeu fater affectign recovery rates each turn. Start with soem every match, can be supplemented by itesm spells, etc.

  * Recovery rates are specific to energy stores and affected by the way you draw on them. Movemnt recovery, attack recovery, health recovery (if suffecienyl profecient / magical?)?