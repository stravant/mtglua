
-- The definition of a card, to be used throughout
-- the program.
function CardDef.new(cardDefData)

end

-- Deck, representing several card lists. For example, the MainDeck and
-- SideBoard for a constructed deck. Or the MainDeck and Commander for a 
-- commander deck.
function Deck.new()
	local this = {}
	local mCardListSet = {}
	function this:AddCardList(ident, cardList)
		mCardListSet[ident] = cardList
	end
	function this:GetCardList(ident)
		return mCardListSet[ident]
	end
	return this
end

-- A participant in a magic game, with the role they are playing in that game
-- (for instance, used for archenemy), and their deck.
function Participant.new(player, role, deck)
	local this = {}
	function this:GetPlayer() return player end
	function this:GetRole() return role end
	function this:GetDeck() return deck end
	return this
end

-- A MagicPlayer, the wrapper around a player used by a MagicGame
function MagicPlayer.new(participant)
	local this = {}



	return this
end

function MagicGame.new(participantList)
	local this = {}

	-- List of MagicPlayers, in the game
	local mPlayerList = {}
	for _, participant in pairs(participantList) do
		mPlayerList[i] = MagicPlayer.new(participant)
	end

	--================================================

	-- History of all the BasicAction-s that the game has done
	-- BasicActions:
	--  ChangeZone(object, newZone)
	--  DealDamage(object, damage, source, isCombat)
	-- Format [ {BasicAction = <BasicAction>, Id = <int>} ]
	local mBasicActionId = 0
	local mBasicActionHistory = {}

	-- Effect tracking
	local mEffectId = 0
	local mEffectList = {}

	-- Turn Tracking
	local mTurnPhaseStep = TurnPhaseStep.new(playerList)

	-- Object tracking
	-- A server object ID is needed, as 
	local mServerObjectId = 0
	local mClientObjectId = 0
	local mObjectList = {}


	-- 

	return this
end