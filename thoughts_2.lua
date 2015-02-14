
--[[

Main game state:

{
	Players {
		Owned Zones {
			HandZone
			LibraryZone
			GraveyardZone
		}
		Counters
		Life Total
	}

	Chrono {
		Sequence of turns in this game
	}

	Objects {
		All objects in the game, cards & tokens, spells & abilities
	}

	Global Zones {
		Battlefield
		Exile
		Stack
		Command
	}
}

]]

local CardPart = Enum.new{
	'Name', 'ManaCost', 'Illustration', 'ColorIndicator', 'TypeLine', 
	'ExpansionSymbol', 'TextBox', 'Power', 'Toughness', 'Loyalty', 
	'HandModifier', 'LifeModifier', 
	'IllustrationCredit', 'LegalText', 'CollectorNumber'
}

local CardType = Enum.new{
	'Normal', 'Flip', 'DoubleFaced', 'Split'
}

-- Definition of a card
function CardDef.new(data)
end

-- Types of object
local ObjectType = Enum.new{
	'Card'; 'Copy'; 'Token'; 'Permanent'; 'Emblem'; 'Ability';
}

-- Characteristics of an object
local Characteristic = Enum.new{
	'Name', 'ManaCost', 'Color', 'ColorIndicator', 'CardType', 'Subtype', 
	'Supertype', 'RulesText', 'Abilities', 'Power', 'Toughness', 'Loyalty', 
	'HandModifier', 'LifeModifier'
}

-- Statuses of an object
local Status = Enum.new{
	'Tapped', 'Flipped', 'FaceDown', 'PhasedOut'
}

-- An object in the game
function GameObject.new()
	local this = {}
	this.ObjectType = ObjectType.Card
	this.ObjectData = nil
	this.ClientId = nil
	this.ServerId = nil
	this.CopyingDef = {}
	this.Characteristics = {}
	this.Statuses = {}
	this.Controller = nil
	this.Owner = nil
	return this
end

-- Steps of a turn
local Step = Enum.new{
	'Untap',
	'Upkeep',
	'Draw',
	'CombatBegin',
	'DeclareAttack',
	'DeclareBlock',
	'CombatDamage',
	'CombatEnd',
	'End',
	'Cleanup',
}

Step.Untap.Next         = Step.Upkeep
Step.Upkeep.Next        = Step.Draw
Step.CombatBegin.Next   = Step.DeclareAttack
Step.DeclareAttack.Next = Step.DeclareBlock
Step.DeclareBlock.Next  = Step.CombatDamage
Step.CombatDamage.Next  = Step.CombatEnd
Step.End.Next           = Step.Cleanup

-- Phases of a turn
local Phase = Enum.new{
	Beginning = {First = Step.Untap},
	Main      = {First = nil},
	Combat    = {First = Step.CombatBegin},
	Ending    = {First = Step.End},
}

-- An object recording the current turn, phase & step sequence for the game
function Chrono.new(magicPlayerList)
	args('array', magicPlayerList)
	local this = {}

	this.CurrentPlayer = magicPlayerList[1]

	this.SequenceIndex = 0
	this.Sequence = {}

	this.TurnIdGenerator  = 0
	this.PhaseIdGenerator = 0
	this.StepIdGenerator  = 0
	
	this.Turn = nil
	this.Phase = nil
	this.Step = nil

	-- Go to next turn phase or step
	function this:Next()
		if this.Phase and this.Phase.Type.Next then
			-- To next phase
			this.Phase = 
		end
	end

	return this
end

-- Zone type
local ZoneType = Enum.new{
	Hand        = {Owned = true , Ordered = false}, 
	Library     = {Owned = true , Ordered = true }, 
	Graveyard   = {Owned = true , Ordered = true }, 
	Exile       = {Owned = false, Ordered = false}, 
	Battlefield = {Owned = false, Ordered = false}, 
	Stack       = {Owned = false, Ordered = true },
	Command     = {Owned = false, Ordered = false},
}

-- Zone object, used by players and the game
function Zone.new(zoneType, owner)
	args('object', zoneType)
	if zoneType.Owned then
		assert(owner)
	else
		assert(not owner)
	end
	--
	local this = {}
	this.ZoneType = zoneType
	this.Owner = nil
	this.ObjectList = {}
	return this
end

-- Deck, representing several card lists. For example, the MainDeck and
-- SideBoard for a constructed deck. Or the MainDeck and Commander for a 
-- commander deck.
function Deck.new()
	local this = {}
	local mCardListSet = {}
	function this:AddCardList(ident, cardList)
		args('string', ident, 'array', cardList)
		mCardListSet[ident] = cardList
	end
	function this:GetCardList(ident)
		return mCardListSet[ident]
	end
	return this
end

-- A participant in a magic game, with the role they are playing in that game
-- (for instance, used for archenemy), and their deck.
function Participant.new()
	local this = {}
	this.Player = nil
	this.Deck = nil
	this.Role = nil
	return this
end

-- A MagicPlayer, the wrapper around a player used by a MagicGame
function MagicPlayer.new()
	local this = {}

	-- 
	this.Participant = nil

	-- Are they still in the game?
	this.InGame = true

	-- Zones
	this.ZoneMap = {}
	this.ZoneMap[ZoneType.Hand] = Zone.new(ZoneType.Hand)
	this.ZoneMap[ZoneType.Graveyard] = Zone.new(ZoneType.Graveyard)
	this.ZoneMap[ZoneType.Library] = Zone.new(ZoneType.Library)

	return this
end

-- Make a new magic game
-- If client is true, then we are a client connecting to a game
-- otherwise, we are the server serving a game.
function MagicGame.new(client)
	args('boolean', client)
	local this = {}

	-- Zones
	this.ZoneMap = {}
	this.ZoneMap[ZoneType.Battlefield] = Zone.new(ZoneType.Battlefield)
	this.ZoneMap[ZoneType.Stack] = Zone.new(ZoneType.Stack)
	this.ZoneMap[ZoneType.Exile] = Zone.new(ZoneType.Exile)
	this.ZoneMap[ZoneType.Command] = Zone.new(ZoneType.Command)

	-- Objects
	this.ObjectList = {}

	-- Players
	this.ParticipantList = {}
	this.PlayerList = {}

	-- Main entry point
	function this:StartGame(participantList)
		args('array', participantList)

		-- Create the players
		for participant in values(participantList) do
			this.ParticipantList = participantList
			local player = MagicPlayer.new()
			player.Participant = participant
			table.insert(this.PlayerList, player)
		end

		-- 
	end

	-- Save / load a game
	function this:SerializeForServer()

	end
	function this:SerializeForClient(magicPlayer)

	end
	function this:ServerDeserialize(data)

	end
	function this:ClientDeserialize(data)

	end

	--

end

