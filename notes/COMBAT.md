# Combat & upgrades

Rough notes. Not final. Build in small slices.

## Philosophy

- Abilities, enemies, and tower own behavior.
- Upgrades and auras change numbers (and temp effects later).
- One modifier system for all scopes. Do not hardcode upgrades inside ability scripts.

## Upgrade scopes

- Global ability: all abilities (e.g. cooldown reduction)
- Specific ability: one ability id (e.g. pistol damage)
- Tower: player tower stats
- Enemy: run-wide enemy stats (debuffs on the horde)

Each upgrade is one modifier:

- scope
- target (ability id if needed)
- stat
- op: flat or mult (separate upgrades, never both in one)
- amount
- name / description / icon

Chosen upgrades live on the run (Gamestate). Reset on abandon / restart.

Effective stat = base, then flats, then mults (buffs and debuffs).

## When players pick upgrades

1. Run start: pick starter ability (current cards)
2. Later: end of level, pick 1 of 3 upgrades
3. Filter pool (no pistol upgrades without pistol, etc.)

## Damage model

Two damage classes:

- Attack: mitigated by armor (+ armor penetration)
- Magic: mitigated by magic resist (+ magic penetration), then optional element resist

Elements (also resist / pen keys):

- fire
- cold
- lightning
- poison
- nature
- water
- shadow
- arcane
- chaos

Every hit/tick declares: class (attack or magic), optional element, amount.

## Stats worth supporting eventually

### Defensive / sustain (tower, enemies, maybe both)

- max hp
- hp regen (per second)
- life steal (hp per damage dealt)
- armor
- magic resist
- elemental resists
- energy shield (absorbs all damage before hp; starts at 0 on a new run)
- energy regen

### Offensive / ability

- damage (attack or magic + element)
- cooldown reduction (cast speed)
- duration reduction (same total damage, shorter channel, denser ticks)
- projectile speed
- multicast chance
- crit chance
- crit damage
- chain chance
- chain count (bounce or channel retarget count; targeted abilities only)
- armor penetration
- magic penetration

## Abilities vs auras

- Rename the current `aura` ability later. It is not the aura system.
- Auras / status effects (future): buffs/debuffs on any entity (bleed, burn, chill, etc.)
  - duration, stack limit, tick rate, stat mods or DoT
  - from abilities, upgrades, or environment

Do not build full aura stacking before basic upgrades and attack/magic damage.

## Suggested build order

1. Upgrade resource = scope + stat + flat|mult + amount
2. Run modifier list + stat helper
3. Wire ability damage + cooldown through helper
4. Level-end upgrade draft (reuse card UI)
5. Tower hp / armor basics
6. Attack vs magic on hits
7. Enemy-scoped upgrades
8. Elements, pen, crit, chain, etc. as needed
9. Status effects / auras
