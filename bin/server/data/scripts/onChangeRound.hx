function onChangeRound() {
	var Gs = Game.self;
	var Est = Gs.est;
	Est.gameObjectsNum = -1;
	Est.gameObjectsDeleted = [];
	Est.lastHighlightObjectId = -1;
	Est.gameObjectsFirstSyncId = 0;
}
Est.onChangeRound = onChangeRound;