require("ModCode");

function Server_AdvanceTurn_End(game, addOrder)

    function addOrderImpl(playerIds, orderMessage, incomeMods)
        addOrder(WL.GameOrderEvent.Create(WL.PlayerID.Neutral, orderMessage, playerIds, nil, nil, incomeMods));
    end

    applyIncomeModifiers(game, game.ServerGame.LatestTurnStanding, addOrderImpl)
end

