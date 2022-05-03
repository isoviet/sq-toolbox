Est.addLoggerHandler(function(message) {
	var isIn = message.indexOf("Received server packet [object PacketRound") != -1;
	var isOut = message.indexOf("Sending packet with type") != -1 && message.indexOf(", ROUND_") != -1;
	if(!isIn && !isOut) {
		return;
	}

	var Gs = Game.self;
	var Est = Gs.est;

	var settings = Est.settings;
	if(settings == null) {
		return;
	}

	var Hs = Hero.self;
	if(Hs == null) {
		return;
	}

	if(settings.alwaysImmortal) {
		Hs.immortal = true;
	}
	if(settings.alwaysShaman) {
		Hs.shaman = true;
	}
	if(settings.alwaysDragon) {
		Hs.isDragon = true;
	}
	if(settings.alwaysHare) {
		Hs.isHare = true;
	}
	if(settings.ghostMode) {
		Hs.ghost = true;
	}
	if(settings.infiniteJumps) {
		while(Hs.maxInAirJumps < 1000) {
			Hs.maxInAirJumps++;
		}
	}

	var squirrelGame = Type.resolveClass("game.mainGame.SquirrelGame").instance;
	if(settings.infiniteRadius) {
		if(squirrelGame.cast.castRadius != 0) {
			Est.oldCastRadius = squirrelGame.cast.castRadius;
		}
		squirrelGame.cast.castRadius = 0;
	}
	if(settings.instantCast) {
		if(squirrelGame.cast.castTime != 0) {
			Est.oldCastTime = squirrelGame.cast.castTime;
		}
		squirrelGame.cast.castTime = 0;
	}

	var perkController = Hs.perkController;
	if(settings.infinitePerksClothes) {
		var i = 0;
		while(i < perkController.perksClothes.length)
		{
			var perk = perkController.perksClothes[i];
			try {
				perk.currentCooldown = 0;
			} catch(e:Dynamic) {};
			try {
				perk.activationCount = 0;
			} catch(e:Dynamic) {};
			i++;
		}
	}
	if(settings.infinitePerksHare) {
		var i = 0;
		while(i < perkController.perksHare.length)
		{
			var perk = perkController.perksHare[i];
			try {
				perk.currentCooldown = 0;
			} catch(e:Dynamic) {};
			try {
				perk.activationCount = 0;
			} catch(e:Dynamic) {};
			i++;
		}
	}
	if(settings.infinitePerksCharacter) {
		var i = 0;
		while(i < perkController.perksCharacter.length)
		{
			var perk = perkController.perksCharacter[i];
			try {
				perk.currentCooldown = 0;
			} catch(e:Dynamic) {};
			try {
				perk.activationCount = 0;
			} catch(e:Dynamic) {};
			i++;
		}
	}
	if(settings.infinitePerksDragon) {
		var i = 0;
		while(i < perkController.perksDragon.length)
		{
			var perk = perkController.perksDragon[i];
			try {
				perk.currentCooldown = 0;
			} catch(e:Dynamic) {};
			try {
				perk.activationCount = 0;
			} catch(e:Dynamic) {};
			i++;
		}
	}
	if(settings.infinitePerksTotem) {
		var i = 0;
		while(i < perkController.perksTotem.length)
		{
			var perk = perkController.perksTotem[i];
			try {
				perk.currentCooldown = 0;
			} catch(e:Dynamic) {};
			try {
				perk.activationCount = 0;
			} catch(e:Dynamic) {};
			i++;
		}
	}
	if(settings.infinitePerksShaman) {
		var i = 0;
		while(i < perkController.perksShaman.length)
		{
			var perk = perkController.perksShaman[i];
			try {
				perk.currentCooldown = 0;
			} catch(e:Dynamic) {};
			try {
				perk.activationCount = 0;
			} catch(e:Dynamic) {};
			i++;
		}
	}

	var ControllerHeroLocal = Type.resolveClass("controllers.ControllerHeroLocal");
	if(settings.disableKickTimer) {
		ControllerHeroLocal.resetKickTimer();
	}

	return true;
});

var Keyboard = Type.resolveClass("flash.ui.Keyboard");
var KeyboardEvent = Type.resolveClass("flash.events.KeyboardEvent");
Game.stage.addEventListener(KeyboardEvent.KEY_DOWN, function(e) {
	var settings = Game.self.est.settings;
	if(settings == null) {
		return;
	}
	if(!settings.hotkeys) {
		return;
	}
	if(!e.ctrlKey) {
		return;
	}
	var Hs = Hero.self;
	if(Hs != null) {
		if(e.keyCode == Keyboard.NUMBER_2) {
			var PacketClient = Type.resolveClass("protocol.PacketClient");
			if(Hs.hasNut) {
				Hs.setMode(Hero.NUDE_MOD);
				Game.self.est.sendData(PacketClient.ROUND_NUT, PacketClient.NUT_LOST);
			} else {
				Hs.setMode(Hero.NUT_MOD);
				Game.self.est.sendData(PacketClient.ROUND_NUT, PacketClient.NUT_PICK);
			}
		}
		if(e.keyCode == Keyboard.NUMBER_3) {
			var PacketClient = Type.resolveClass("protocol.PacketClient");
			Hs.onHollow(0);
			Game.self.est.sendData(PacketClient.ROUND_NUT, PacketClient.NUT_PICK);
			Game.self.est.sendData(PacketClient.ROUND_HOLLOW, 0);
		}
		if(e.keyCode == Keyboard.NUMBER_4) {
			Hs.dieReason = Hero.DIE_REPORT;
			Hs.dead = true;
		}
		if(e.keyCode == Keyboard.NUMBER_5) {
			var PacketClient = Type.resolveClass("protocol.PacketClient");
			Game.self.est.sendData(PacketClient.ROUND_RESPAWN);
		}
	}
});