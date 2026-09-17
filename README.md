# tower-defense-deckbuilder
Godot Tower Defense Game with Deck-building Mechanics

## Scene
You are a ruler, trying to defend your kingdom and the surrounding land from hostile forces, whilst improving your relations with local villages and extending the reach of your kingdom.

## Mechanics
Tower Defense: the main game loop is waves of hostile forces trying to reach an area that you're trying to protect. You defend from them by building "towers" - sites where you can station troops to shoot at the enemies
Deck-building: between waves you buy cards into your deck. at the start of a wave you draw cards from your deck, allowing you to collect resources/money and to man the towers.
Merging: you can combine identical cards to create a single card of higher value. This is a key part of the deck-building mechanic, as it replaces the common "trash" mechanic.
Carried experience: after completing a village, some buff will be carried to the next (tbd) (maybe some loyal cards come with you to the next location? Into the breach style)

## Gameplay
You play tower defense games in villages across the kingdom. A global map allows you to choose between villages for where you'll play the next game. When playing a game, you will be trying to defend a particular village from hostile forces local to that region. Each village will have a location the forces are trying to reach, and the local terrain will shape the landscape of the map and the resources and people available to you (see theme ideas).

Before each wave begins, you will draw cards from your deck. The cards represent local people. The cards can be used for various effects, which you determine before the wave begins. E.g. you could use money cards to buy new cards into your deck, or builder cards to build new towers, or assign combat cards to towers ready to defend in the upcoming wave. When you have finished using the cards, you begin the wave.

During a wave, the towers automatically defend as much as they can against the hostiles. you may have some cards you can use during the wave to help with particular problems. There will be a variety of towers that produce different effects and are more or less effective against different types of enemies. (see tower ideas) . You have some control over determining how the towers attack. Hostiles that get through your defenses damage your reputation (score) and decrease how much this village will contribute to your kingdom in the future. Hostiles which are defeated have a chance of dropping loot.

## Concepts
- Call to arms: equivalent to "draw", how many cards you can draw each turn. As you defeat more enemies, your reputation grows and your call to arms increases, i.e. more local people are willing to join the fight each wave.
- Loyalty: cards can be come loyal, meaning they are permanently in play (or stay in play for more rounds at a time) rather than circulating in your deck.
- Reach: each new person you acquire into your deck represents an increased reach of your kingdom into the surrounding lands. this is a modifier for how many hostiles will spawn per wave, as further reach means provoking more nearby hostiles.
- Reputation: in general, your score. When your reputation in a given location grows large enough, the hostiles either give up trying to attack you there, or the locals become self-sustaining and loyal enough to keep up the fight in your absence. In any case, enough reputation = completing that location.

## Style
low-bit pixelart, bold bright colours. 2D/2.5D.

## Card ideas

### Types
- standard: each location will have a set of standard cards, piles of identical (unlimited?) cards providing basic effects, e.g. peasants to produce money/materials, squires to increase call-to-arms, mages, builders, etc.
- visiting: one-off unique cards. each wave, you can be hosting one or more visiting people, which you can buy the effects from. typically they grant one-time effects, but some could be bought into the deck. you can "entertain" the visiting cards by spending money to keep them here if you want their effect later but not now.
- loot: dropped by hostiles, at the end of a wave you can choose to keep the loot cards in your deck or throw them out. they will have various effects but can typically be attached to other cards to increase their stats (e.g. armour to make fighters tougher).

### Standard cards
Basics common to all villages. Specials only in some villages
- villager: cheap basic card, can be tasked to generate money or materials. With merging can generate more of these things and can also generate valuables. With experience they can specialise in one of the types, making them even more effective at that
- builder: cheap basic card, can be tasked to build towers and defenses. With merging can build more things at a time. With experience they use fewer materials when building.
- soldier: cheap basic card, is deployed into towers and is what enables the towers to fight, so it will be a big part of the deck. With merging becomes more powerful. With experience can specialise into a particular tower/combat type (e.g. archery, melee).
- squire: moderate cost basic card, increases call-to-arms value. With merging increases CTA value further (e.g. +3 instead of +2). With experience can quickly become loyal / make visitor costs cheaper
- mage: expensive basic card, can perform a variety of special effects on the battlefield when deployed. With experience can specialise in different schools of magic, e.g. fire (hurts enemies a lot but speeds them up), ice (hurts enemies a bit and slows them down), herbs (heals allied troops and poisons enemies), psychic (controls enemies or turns them against each other). With merging becomes more powerful in general.
- miner: moderate cost special card, can generate materials or valuables
- hunter: cheap special card, can generate money or be deployed for combat.

### Visitor cards
- Cleric: Blesses all your troops for one round, making them more effective against undead enemies
- Huntsman: places lasting traps on random locations on the path
- Knight: big CTA for one turn
- Merchant: gives money income for rest of the game
- Princess: reputation boost

## Theme ideas
- Mountain village: narrow restricted paths for hostiles to move in, so easy to defend. hard to get food/wood resources, easy to get valuables. hostiles are strong, resistant to cold
- Swamp village: lots of winding channels for hostiles to traverse. you are defending a church, which the undead hostiles rising from the swamp are trying to reach
- Plains village: few direct paths for hostiles, towards a village centre with pub/mayors house which you are trying to defend. easy to generate food/wood, hard to get valuables, metal. hostiles are goblins, bandits, etc.

## Tower Ideas
- Arrow tower: standard basic tower, allows stationed troops to shoot at enemies. Effective against living soft hostiles.
- Guard house: troops stationed here will move out from the tower into the hostile's path, effectively slowing hostiles whilst also attacking them.
- Mage tower: casts spells at enemies, such as slowing them down (ice), setting them on fire (but speeding them up), turning them against each other.
- Barricades: doesn't house troops, but blocks path, forcing hostiles to take a longer route or spend time breaking down barricade. Cheap to build if have excess builders and no relevant tower to make
- The Palace/Townhouse/vicarage: you can upgrade it to increase how many visiting cards are present each wave, the cost to entertain visitors, etc.
