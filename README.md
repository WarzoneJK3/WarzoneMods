# Warzone mods by [JK_3](https://www.warzone.com/Profile?p=31105111944)

This repo contains my [Warzone](https://www.warzone.com) mods. Most of the mods listed below are just concepts, since I rarely have time to work on them, but I'll try to finish all of them eventually.

* Released: 3
* In progress: 2
* Abandoned: 1
* Backlog: 6

## Released mods

### [Press This Button](https://github.com/WarzoneJK3/WarzoneMods/tree/main/PressThisButton)

This mod adds a button that will reduce next turn's income of a player by X% if they do not press the button in their current turn. AI's will not be affected by this mod. Once the game started, you can find the button under Game > Press This Button.

**Concept** 2022-01-13<br>
**Started** 2022-01-13<br>
**Released** 2022-01-22

### [Force Vote to End](https://github.com/WarzoneJK3/WarzoneMods/tree/main/VoteToEnd)

This mod deals with players that refuse to Vote To End the game after a majority of players agreed to vote.
Refusing players will be given some turns to VTE, before being forcefully eliminated.
After a forceful elimination, all the territories a player owned will be reset to neutral.

**WARNING:** Since this mod eliminates players, it might cause other mods to crash! When using this mod with other mods, test for mod compatibility!

**Concept** 2022-11-29<br>
**Started** 2023-03-19<br>
**Released** 2023-03-20

### [No Income for odd/even number of territories](https://github.com/WarzoneJK3/WarzoneMods/tree/main/IncomeOnOddOrEvenTerritories)

This mod removes players/teams income if they own an odd or even number of territories.

Available settings:

* Trigger on odd or even turns
* Apply to team total or individual players (only has effect in team games)
* Remove income by a fixed number or by percentage
* Amount of income to be removed

**NOTICE:** Due to Warzone limitations, turn 1 income cannot be modified!

**Concept** 2023-06-03<br>
**Started** 2023-06-03<br>
**Released** 2023-06-17<br>
**Inspiration** https://www.warzone.com/Forum/696654-forbid-even-territories

### [Private Notes](https://github.com/WarzoneJK3/WarzoneMods/tree/main/PrivateNotes)

A simple mod that allows you to create private notes in games, labeled per turn. 

It's features include: 

* Store notes per turn
* Link to territories/bonuses with the [Link] button
* Change displayed turn order (new to old / old to new) with the [↑↓] button

See the [Private Notes mod forum](https://www.warzone.com/Forum/736269-new-private-notes-mod) for more info. 

**Concept** 2023-12-29<br>
**Started** 2023-12-29<br>
**Released** 2024-01-01

## Work in progress mods

### Lottery tickets

Players can buy raffle tickets for a chance to win sometimes big and usually small prices.
Mod is commerce only.

**Concept** 2022-10-27

### [Negative base income](https://github.com/WarzoneJK3/WarzoneMods/tree/main/NegativeBaseIncome)

Each turn, instead of +5 base income, players get -5 base income. (Or whatever the base income in the game might be.)

**Concept** 2022-11-01<br>
**Started** 2022-11-01<br>
**Released** Never (due to mods not being able to make changes to turn 1 income)

### Low morale bonusses

The neutrals in each bonus have such low morale that they will immediately surrender after the first loss. This translates to the player getting the full bonus as soon as a single territory is captured. The armies on the new  player terr are set to X armies.

Maybe make a setting for yes/no converting wastelands as well.

**Concept** 2023-11-01

### Evil spells mod

Spell ideas:

* tornado -> all territories connected to a target terr rotate 1 place to the right
* teleportation -> moves X% of the armies on a target terr to any random place on the board
* fireball -> kills X% of all units on the target terr
* poison -> kills X% of every unit on target terr, getting reduced by Y% each turn till 0
* darkness -> all orders to and from this territory will be skipped for X turns

Features:

* cooldown on spells (default cooldown 2 turns, so use once every 3 turns)
* variable cost per spell
* max number of times a spell can be bought (default : -1 for infinite)

**Concept** 2022-11-02

### King of the Hill V2

The [original King of the Hill](https://github.com/Derfellios/King-Of-The-Hills) mod has been taken offline by Fizzer due to game-breaking bugs.
his is a rerelease of the mod, with the necessary bug fixes to get it running again.
Due to [Derfellios](https://www.warzone.com/Profile?p=6146168723) no longer having a membership, they are unable to fix it themselves. 

**Concept** 2022-11-17<br>
**Inspiration** [Why did mods crash my game?](https://www.warzone.com/Forum/658643-mods-crash-game-details-inside) by [Alphazomgy](https://www.warzone.com/Profile?p=50141161968)

### Independent killrate per territory

Each territory to territory has a seperate attack/defend rate. If no killrate is available from the mod settings, default to game settings killrates.

This should probably be configured using a seperate mod which allows an export of the settings from a SP game (which allows setting the killrate per territory or for entire bonuses at once), which can then be loaded into the main game.

**Concept** 2022-12-15<br>
**Inspiration** Suggestion from [old yeller](https://www.warzone.com/Profile?p=80121463364)

### UFO Abductions

Each turn, Some UFOs appear that abduct X armies or % from a random territory.

**Concept** 2022-12-18

### Host powers

A mod that gives game host power to:

* eliminate players (either just set to neutral or make all their terr wastelands of size X)
* change owner of specific territory
* change army count of specific territory
* adjust player income
* adjust player gold count (if commerce game)

The territory modifications should probably remove any special units on them.

**Concept** 2022-12-21

### Dice rolls

A dice roller embedded into WZ. Like d20s, d6s, and such.

Let me give you some context: i am hosting a RP-laden diplo game
and i make a lot of events where players can compete with each other outside of the normal wars
now, i am using the Immersive system discord who has a roll-dice bot, but many players have difficulties or simply don't want to get in to roll a dice, and since i think that games might be getting in the path of being much more RP driven (yamada's character mods helps a lot), i was thinking that maybe it wouldn't be absurd to have it in game i was thinking about the chat because it's how the discord bot works, but anything is ok

**Concept** 2023-06-07<br>
**Started** 2023-06-07<br>
**Inspiration** Suggestion from [Coenquistatore](https://www.warzone.com/Profile?p=50135888788)