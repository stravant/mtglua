
--[[

Chain Interaction:
	- When anything is cast or triggers, chain is started
	- players other than the controller of the top item get a chance to respond 
	  in turn order whenever the chain begins or grows.
	- And end of each phase, each NAP gets a chance to respond

Simplified Phases:
	Beginning  : Untap, Draw ->             Priority
	Main1      :                            Priority
	DeclAttack : DeclAttack ->              Priority
	DeclBlock  : DeclBlock -> OrderBlock -> Priority
	Damage     : Damage ->                  Priority
	Main2      :                            Priority
	Cleanup    : Cleanup actions

Hand / Library / Battlefield:
	As normal.

Things in the game:
	There are two types of things in the game, "cards" and "objects". Every
	object is a a thing with a set of characteristics in a zone, which may or 
	may not have a card associated with it.
	If an object has an associated card, then it also has a "last object",
	which is the object it was when it was in the previous zone before it moved
	to the current one.

Type / Super / Sub system:
	Cards have a type, subtypes, and supertypes:
		Types: Creature, Spell, Artifact, Enchantment, Land
		Supertypes:
			All: Instant

Characteristics:
	Arbitrary, unlike MTG. Common ones are still:
	ManaCost, Color, Name, Power, Toughness, Type, SubType, SuperType



]]