# Changelog

## 2.0.2

* **General**
	* Whenever you get some potions, show a summary of the potions you got.
	* Make it clearer when bonus objectives have been satisfied by striking them out in the objectives display.
* **Scenario 2** (Tracing the Goblins' Path):
	* Add a counter to the bonus objective description.
* **Scenario 3** (Battle at Port Lobur):
	* Fix merman warrior not joining your side if you beat the nagas before he dies.
	* On hard mode, add a few loyal troops and increase enemy gold a little.
	* Deshroud the map after searching the shipwreck.
	* Fix a naga sometimes spawning next to the lighthouse instead of the orc's castle.
	* Some minor map tweaks (rubble+damage in the orc's castle).
* **Scenario 4** (Descent into the Orcish Realm):
	* Some minor map tweaks, particularly in the lake area
	* On hard mode, give 2 more turns.
	* Give enemies a few loyal troops who stay near their castle.
	* Enemy limits on level 2 recruits are now less specific, so for example (on easy) it could choose to recruit 3 chocobones but then would not be able to recruit any more level 2 units. (Note that these limits also count any loyal level 2 units.) Previously, it was limited only per type.
	* Add a little more post-scenario dialogue, which varies depending on who you've killed.
	* Make the upper-right area of the map (where the river flows out of the lake) less hospitable to the undead, with an illuminated patch that they'll avoid.
* **Scenario 5** (Reinforcements from Analandoron):
	* Some refinements to the negotiation dialogue.
	* Reduce the number of chocobones (all difficulties) as they're especially devastating to the saurians.
	* Ensure the saurian leader will not die before the negotiations.
* **Scenario 6** (Hordes from the Marsh):
	* Add some bonus dialogue if you found the sea chart in the shipwreck. This is a sort-of hint towards the drakes.
* **Scenario 7** (Into the Dread Marsh):
	* Fix Graktar's son not showing up in the marsh if you kill his father.
	* Prevent frogs from triggering their own nests.
	* Add some bridges near the necromancer's castle, and an encampment hex between the nightgaunt and ghast castles.
	* Move the loyal, weak death knight to the aforementioned encampment hex, rather than starting him out in the necromancer's castle. This should reduce the chance that he's near the left side of the map when the orc leader decides to assassinate the necromancer. It also might make it more likely for the player to fight him.
	* Add a counter to the bonus objective description.
	* Fix incorrect reference to the relationship between Kaden Kreuz and Graktar's son.
	* Increase proportion of walking corpses recruited by the necromancer.
* **Scenario 10** (Reclaiming the Citadel):
	* Hide the UI for the end cutscene and don't enter linger mode afterwards.

## 2.0.1

* **General**:
	* Fix typos and grammar errors, and tweak some dialogue.
	* Fix double death event when Eovyniel dies.
	* Note turns over loss and gold carryover details in all objectives.
	* Allow the giant bat to get an AMLA.
	* Automatically remove useless units when you end a scenario. A unit is deemed useless if:
		* It is level 0.
		* It has not gained any experience.
		* It does not have anything special (initiates only), like an extra trait or ability.
	* Reduce the recall cost for the level 0 initiate and civilian.
	* Fix outdated description of the dominates ability.
	* Added descriptions for all custom units that didn't previously have them, including the rats (which had only duplicated the old mainline giant rat description).
	* Fix haste (sometimes? always?) not expiring at the end of a scenario.
* **Scenario 1** (The Goblin Sacking of Aleron Citadel):
	* Fix goblins not spawning when you land on a village. (This was supposed to happen on medium and hard with a little extra dialogue, but it didn't work in 2.0.)
	* Fix Amuwen attacking unreachable enemies in her death throes.
* **Scenario 7** (Into the Dread Marsh):
	* Prevent mosquitoes from triggering the frog events.
	* Reduce your carryover gold if you don't let the orcs get the kill.
	* Add a hint if you miss the tunnel but wonder what that trapdoor is.
* **Scenario 10** (Reclaiming the Citadel):
	* Fix Aphrophila missing her ellipse.
	* Fix Malcorn not showing up if you hadn't killed him earlier.

## v2.0

* **General**:
	* First release for Wesnoth 1.14!
	* Fix some cases where an enemy could take a village and give you potions.
	* Fixed tooltip for the haste status effect giving incorrect information.
	* Fix female Elvish Civilians having male hit sounds.
	* Dominates ability:
		* Now works on higher-level units as Ariandela gains levels.
		* Has a chance of working on units of level equal to or one less than her own (5% and 25% respectively).
		* You can no longer carry dominated units between scenarios.
		* You can no longer choose a dominated unit's advancement if it would be freed by advancing.
		* Can now be used by other units if Ariandela dies.
	* When you lose due to the death of a hero, you now get a brief narration of a bad ending resulting from that hero's death.
	* Add a death message for when a dwarf loyal dies.
	* The aged captain now has a fixed name (but is still expendable).
	* Items possessed by killed units are now consistently dropped on the ground, where they can then be retrieved by another qualified unit. Items covered by this are: the Ring of Domination, the Storm Trident, the Holy Necklace, and the Freezing Staff.
	* Much of the dialogue has been overhauled and improved.
* **Under the Hood**
	* Some refactoring to make the scenario WML less dependent on map layout.
* **Graphics**:
	* Custom portraits for the elf queen and the old captain.
* **Scenario 1** (The Goblin Sacking of Aleron Citadel):
	* Now more supportive of ignoring the objectives, allowing a bit less linear play without risk of breaking the campaign..In particular, it is now impossible to miss Erendor.
	* The scout who reports on the goblins is now properly chased by a wolf rider. Previously, sometimes the wolf rider who was supposed to chase him would instead wander off because he left their field of vision.
	* Add a small chance of goblins popping out of villages alongside the initiates. This only happens before you defeat the first leader, and never on easy mode.
* **Scenario 2** (Tracing the Goblins' Path):
	* The initial locations of the starting enemies (the bats) are now randomized and thus less predictable.
	* Attention is now drawn to the time limit via periodic tremors.
	* Ending your turn on the campfire now damages you.
* **Scenario 3** (Battle at Port Lobur):
	* Visiting windmills now allows you to enlist a few peasants to help you for the duration of the scenario. They will leave your party when the scenario ends.
	* The goblins that appear after giving Ariandela the ring are now fixated on her; the size of their group also depends on difficulty now. Their spawn locations are also randomized, and the impaler (on medium/hard - it's absent on easy) will always appear more or less at the front.
	* Ariandela no longer has the dominates ability when negotiating with her; she only gains it after you give her the ring. This is to support the dialogue which links the ability to the ring.
	* Some new easter-egg dialogue events. For example, try having the friendly orc archer kill the grunt who normally would've told on him.
	* Randomized watch tower guardian locations on non-hard difficulty (hard difficulty isn't random only because every watch tower is guarded).
* **Scenario 4** (Descent into the Orcish Realm):
	* Fix Halbern's introductory dialogue playing even if his pursuers manage to kill him.
	* Scroll to the whirlpool exit after being sucked in.
	* The whirlpool tunnel is now considered for unit vision, so it should be more clear that you can get back just by a regular move.
	* Additional dialogue with Halbern and potentially with the dwarf.
	* Fix not getting kill experience for the orc leader.
	* The water route has been widened a little but is no longer completely safe, and can no longer be traversed by even patient elves due to deep spots.
	* Added an ancient merfolk shrine which can grant wisdom if found. This doesn't give any items or units - it just reveals the enemy's location.
* **Scenario 5** (Reinforcements from Analandoron):
	* The saurians will now smack the undead with their spear butt.
	* The initial pair of saurians won't run away - they'll only attack Erendor.
	* Major AI (and gold) tweaks to prevent it from being unwinnable.
	* The queen is AI-controlled until she talks with the saurians. When controlled by the AI, she'll only use the faerie fire in defense, but she can also use it in offense against the undead.
	* The undead are less smart and ignore villages, even for healing. They can no longer recruit spirits.
	* The queen now has faerie fire and leadership, making her potentially useful after the negotiations.
	* After negotiations, you can recruit at the saurian keep.
	* Give more level 2 loyals on easy difficulty.
	* Keep objectives more consistent regarding the note on Galdar's units versus Ardalandwen's units.
* **Scenario 7** (Into the Dread Marsh):
	* The orc leader now takes some loyal nightblades along on his assassination mission (and, hopefully, is a little smarter about the mission).
	* Ensure the orc leader is not the one calling for vengeance after his death.
	* The necromancer now favours recruiting walking corpses of various types, though he still recruits some other units too.
	* If your loyal orc kills the enemy necromancer, you can avoid angering the orc leader (but only if you didn't kill him in scenario 4). However, in this event the archer must leave your party.
	* Use a different style for the popup messages when you slay the lesser enemy leaders.
	* The wolf pack leader now has a name and is red.
	* When the orc leader decides to charge forward, he now drinks a haste potion first.
	* The frog nests now function like a standard ambush.
	* Fix leader responding to Aphrophila even if she hadn't survived that long.
* **Scenario 8** (Descent into the Chasm):
	* Prevent possibility of enemy finding potion caches in villages.
	* Fix skeletal dragon announcing its own presence (wrong speaker).
* **Scenario 9** (The Journey Home):
	* Special dialogue if a dominated unit sights the ogres.
	* Make the father ogre stronger on hard mode.
	* Prevent frogs and wolves from straying too far from their normal area. For example, this means you can never encounter them before getting past the enemy castle.

## v1.3.7

* Fix ability to use potions on enemies
* Balance tweaks to scenario 5 - enemy no longer recruits chocobones, and saurians get more gold
* Dominated units no longer enter your recall list.

## v1.3.6

* Renamed campaign from "Besieged Druids" to "The Black Cross of Aleron". The first six scenarios were also renamed; the final four retained their original names.
* Plot and dialogue rehaul in all scenarios, including both events and storyscreens. The initial treewalker is now a hero (ie, can't die) and plays a role in the plot.
* New distribution for special initiate abilities. On the whole, this should make the special abilities more common.
* You can now find potions in multiple locations, not just in the second scenario. The total number is about the same; they're just spread out more, now.
* A bonus loyal specialist druid now appears in the game. On easy and medium, she appears in the first scenario. On hard, you meet her in the final scenario.
* Scenario 1 has had some minor overhauls to reduce what may have been "tomato surprises". The second enemy doesn't even start recruiting until you've officially been made aware of them, and because of that, the returning scout is now closely followed by one rider to reinforce thie idea of his pursuit. The presence of guards at the citadel is also alluded to much earlier than before.
* Scenario 2 now specifies a reason for the time limit. You also now get a little extra time if you're almost there when the time limit runs out.
* Scenario 3 no longer has the enemy recruiting nagas (though you will still encounter them since there's one loyal plus those at the merfolk village) and now also features human resistance fighters who will accept your help to retake their town.
* Scenario 4 doesn't really have any notable changes (other than dialogue and plot), but I did move the secret cave on the map to better fit with certain dialogue.
* Scenario 5 now has a second goal to attain after forming a truce with the saurians.
* Scenario 6 has a number of balance tweaks - thieves don't steal from undead (either dominated WCs or Halbern), the enemy no longer has orcish archers, gold and carryover have been tweaked (both for you and for Glamethkor), the undead avoid Kalg, and Kalg may even join you under the right circumstances.
* Scenario 9 has more stringent victory conditions, now takes place in early autumn and has a road. Also, if you encounter bandits rather than orcs, they are weaker than before, having lower-level loyals and only first-level recruits.
* Scenario 10 now ends with a cutscene, the contents of which can vary greatly depending on your earlier decisions and which of the loyals survived.
* Graphics: New staff for Elvish Archmage, new Orcish Necromancer unit for the final boss (currently unanimated, unfortunately), portraits for the elvish mage and priestess

## v1.3.5

* New graphics for Elvish Initiate and Elvish Mage
* Updated graphics for Elvish Zealot and Elvish Archmage
* New animations for Elvish Civilian and Elvish Wisp
* New attack icon for the giant rats
* Units with Faerie Glow have a visible illuminates halo which is smaller than the usual one
* All animations have been updated to newer syntax (this is mostly just an internal change, but in the unlikely event that an animation is broken, that would be why)
* Fix Earendil losing her magical special if she attacks the first leader on easy mode. (This issue was previously fixed only for normal and hard mode.)

## v1.3.4

* Fix recall list vanishing after scenario 5
* Fix end cutscene in scenario 6 not accounting for the possibility of the bandit leader's death
* Tent villages in scenario 6 start out owned by the player
* Two more great trees in scenario 7

## v1.3.3

* Fix incorrect recruits in scenario 5 ("Reinforcements")

## v1.3.2

* Fix misfire of "meet Galdar" event in scenario 5 ("Reinforcements")

## v1.3.1

* Fix several bugs in the new scenario 5 ("Reinforcements")

## v1.3

* Fix leader having shyde portrait even as a druid
* Completely new scenario 5: "Reinforcements"
* Redo the map for scenario 6 (Along the Coast) and some other tweaks: reduced turn limit, remove mine tunnels (except on hard mode), fewer undead
* Fixed the Lua error from [scatter_units] (almost certainly)
* Orc leader in scenario 7 (Into the Dread Marsh) will now take a turn to recruit before marching off to the enemy
* You now get two saurian spellcasters in scenario 7; I can understand they're unlikely to be super-useful, but they're there for the flavour (this relates to the new scenario 5)
* Fix Lua error that could occur in scenario 8 (Descent into the Chasm) if you didn't have the dwarves, orc, ghost, or other units that can move fast on cave terrain
* Fix cures overlay staying after upgrading to Zealot
* I think this should finally fix the undead in scenario 6 (Along the Coast) and the monsters in scenarios 7 and 9 (Into the Dread Marsh, The Journey Home) seizing villages for no good reason. (They'll still retreat to them if injured, of course.)

## v1.2

* Fix some issues with shamans who should have a third advancement option not having it
* Misc changes taking advantage of new 1.12 features (sighted events, scenario-global lua includes)
* Turn limit increased in scenario 2 (Dank Tunnels)
* Rabid rat bite and vapour rat breath animations are now faster
* Fix incorrect hardy trait description
* Fix some minor issues with music tracks that probably no-one ever noticed (certain tracks that were supposed to play were mispelled and thus didn't play)
* Add a hint that there's something hidden in scenario 2 (Dank Tunnels), hopefully making it less likely that newcomers will miss the secret area
* Widen the ford at the south edge of the druid citadel map (used in the first and final scenarios)
* Addressed the issue with the merman fighter sitting on the village if you manage to save him. It's no easier to save him than before, but if you do manage it, he moves off the village and also comes over to your side. (Saving him requires a lot of luck; in particular, you have to hope that a third naga does not show up during the attempt, and it depends on the nagas missing most of their attacks.)
* While in the entryway of scenario 4 (Watery Tunnels), units get an illuminated-like bonus. This probably won't actually have any effect on anything, and was done just for flavour. (I suppose you could lure undead out to the entrance if you really wanted to.)
* The agile trait now also makes units move slightly better in cave terrain. (It also applies to mountains, but that's less relevant to the situations in the campaign.)
* If there are already a large number of undead on the map in scenario 5 (Along the Coast), the spawning of more every 6 turns will be delayed until the number of undead falls below that maximum amount. (Actually, it applies to units of that side, not undead specifically, so bats are also included in the count, while the bonus ghost and any units currently dominated by Ariandela will be excluded.)
* Some attempts to use micro AIs to make the animals behave more animal-like in scenarios 6 (Into the Dread Marsh) and 8 (The Journey Home). Also to force the orc leader to head for the necromancer in scenario 6.
* Reduce the number of potions hidden in scenario 2 (Dank Tunnels)
* Reduce the gold carryover percentages; most scenarios are now around 50%. This is still up for more tweaking, of course.

## v1.1

* First release for Wesnoth 1.12
* Fix shaman special advancements sometimes becoming unavailable
* Tweak bat and mosquito stats
* Add some shallow water near the ford in the first scenario
* New attack icon for the mosquito

## v1.0

### Miscellaneous changes
* Implemented difficulty levels easy/normal/hard; see below for some details
* Recurring AI sides no longer get any carryover gold or show up in the carryover summary at the end of scenarios
* Remove the grass background from the campaign list icon (unfortunately I can't do this for the addon server icon); this was done so that the laurel would be visible
* Gold, income, and turn limits for player and enemy in most scenarios is now difficulty-dependent. There are exceptions, but I'm not going to list them all. Main one is that turn limit is not difficulty-dependent in Along the Coast.
* In many cases the limits on how many units of specific types the AI is allowed to recruit are dependent on difficulty. Some are still fixed, usually the lower-level ones.
* Change the potion mechanics. They now have a limited number of uses (currently about 100 uses each) and each use affects only one unit. Hasting also give half as many moves as before, and displays correctly in the sidebar. The menu item shows the number of uses remaining.
* Disallow merfolk recruits at the end of scenario 6.
* Carryover mechanics tweaked in some scenarios
* To recruit Ariandela, the unit who obtained the ring must step on her village. It can be identified by an overlay for this scenario only.
* The "give gold" option for Ariandela is improved, and since it's intended as a hint, there's now an alternate hint option if you don't have enough gold.
* Ariandela always appears in the same location on subsequent visits to her house, unless that location is occupied for some reason.
* Elvish encampment in Orcs in the Port moved to the edge of the hills
* Better dialogue handling for the revelation of the cave after killing the leader, for the unlikely event where you have no dwarves or ranger lines and have lost (or not recalled) your scout
* If you kill the orc leader in Orcs in the Port but elect to stay and search for Ariandela, you can change your mind by moving any unit onto the newly revealed cave entrance.
* Several unit names were changed, and a few who previously had random names no longer do.
* Add a shipwreck with some gold way up in the northeast of Orcs in the Port
* Drakes now live in a drake village (previously it was a swamp village, I think)
* Ruined keep at the south end of the swamp for recruiting/recalling later in the scenario without needing to hold your leader way back
* Giant frogs (step on a nest) and mosquitoes (every dusk) as an extra nuisance in Into the Dread Marsh; the former can be triggered by the AI
* Tried to increase the chance of the orc leader leaving his keep on a mission to assassinate the necromancer; untested.
* Fix the ogre's dialogue in The Journey Home and add an extra line (and going berserk) if you kill the young ogre first.
* Gryphon nest in The Journey Home (step on it to incur the mother's wrath)
* Bats and mosquitoes spawn at dusk in The Journey Home
* Extra dialogue line in the last scenario, and spearmen popping out of tent villages
### Changes that affect only easy difficulty
* Goblin knight in the first scenario recruits impalers instead of spearmen, but less of them since he has the same amount of gold; this is for better experience gains
* Leader starts already at level 3
### Changes that affect only normal difficulty
* Less recruitable fighters
* Less potential bonus initiates
* More bats at the start of Dank Tunnels
* Three loyal level 1 mudcrawlers instead of two
* Two loyal guards in the castle hexes in Orcs in the Port
* Ghast and nightgaunt leaders in Into the Dread Marsh are less weakened, and killing them doesn't weaken the necromancer as much
### Changes that affect only hard difficulty
* First scenario has two loyal impalers in the initial conflict
* Erendor starts at level 1 but halfway to levelling; he cannot become a marksman
* Cannot recruit archers or fighters
* Less potential bonus initiates
* More bats at the start of Dank Tunnels
* Two spiders instead of one in Dank Tunnels
* All loyal mudcrawlers are level 1
* Four loyal guards in the castle hexes in Orcs in the Port
* Ghast and nightgaunt leaders in Into the Dread Marsh are less weakened, and killing them doesn't weaken the necromancer as much

## v0.4

* When you kill the nightgaunt or ghast leaders in 6•Into the Dread Marsh, Kaden Kreuz's maximum hitpoints were reduced. This is still the case, but now his current hitpoints will also be reduced if this would put them over the max.
* Add appropriate icons for the narrator messages
* Fix outlaws in 8•The Journey Home being unable to recruit duelists (due to a typo in the ID).
* Add end credits
* Fix areas for scattering undead in 5•Along the Coast (previously it was accidentally restricted to a tiny portion of the swamp)
* Significant changes to the map in 7•Descent Into the Chasm; the player's encampment is now next to the abyss, and there are more defensive terrains (dead trees, rubble, mushrooms) as well as improved access to the lich (flagstones and mushrooms, plus two-hex entry-way instead of one-hex). Also some additional useless passages thrown in for flavour.
* In 7•Descent Into the Chasm, the lich's recruitment limitations were tightened, his castle size increased, and his gold and income tweaked. Malcorn's gold/income also tweaked.
* In 9•Reclaiming the Citadel (vs Malcorn), you can still take his freezing staff like in all the other scenarios where you get a chance to kill him. I did this because there's a chance it could be used to help mop up the rest of his units. Also, his hero units now have the loyal trait.
* Fix a bug that would have prevented redundant overlays being removed from shamans in some situations (for example, if a shaman with faerie fire advances to sorceress).
* Fix the loyal mermaid potentially appearing already injured in 9•Reclaiming the Citadel (vs Malcorn).
* Fix drake death event firing for only the first drake to die if they both die in the same scenario.
* Don't add a near nature icon to a shaman with cures when they level up to a druid; just leave the curing icon. That would allow distinguishing between those who had cures from level 0 and those who started with near nature. Remember: on a druid, the cures icon means the same as the butterfly, roughly speaking.
* New map for 4•Watery Tunnels, with a bit of marsh, a lot more mushrooms, some patches of dirt, and a wider pathway.

## v0.3

* Fixed holy necklace being impossible to obtain
* Tweak AI parameters in Dank Tunnels (leader value=1 and reduce mudcrawler leader aggression)
* Tweak rules for drawing stone outlines around the castles in Dank Tunnels; it now looks rather nicer
* When you get Ariandela, you no longer are faced with a Grunt; instead, there's an Impaler (maybe it'll be switched back to a Grunt on hard when that happens)
* In Along the Coast, the undead and misfits are no longer allied, though they won't attack each other until turn 22. If the undead manage to kill the misfit leader, you do not win and are forced to wait out the turn limit.
* Moved the drake island in Along the Coast so that merfolk can get to it without going on land more than seemingly necessary.
* Misfits in Along the Coast get more recruit options and a different leader (though I kept the troll shaman as a loyal)
* Thieves steal gold in Along the Coast (not much though)
* Fix a bug with the interaction between domination and plague which could result in every unit on the map being switched to the player's side.
* Expand the role of the merfolk a little, especially if you don't ever kill Sir Malcorn
* New world map for the story parts, made in the map editor with custom map-like terrains found on the forum
* Fix the dwarf in Along the Coast sometimes forgetting to deliver his line
* Death messages for a number of loyals, plus Ariandela
* Ariandela complains when resurrected
* If the cowardly orc archer happens to be the one to deliver the killing blow to the orc ruler, his lines are a little different than for any other unit (since the normal lines assume the speaker isn't an orc).
* Fix ending bug and tweak enemy gold in the last scenario
* Make the druid's responses to bonus initiates in the first scenario more contextual.
* Add turn limit to Dank Tunnels and slightly raise gold carryover
* Add a couple of frogs to Journey Home, make monsters not attack until you get close, and give the ogre a line
* Add a little more dialogue at the end of scenario 7 (the chasm)
* Clarify objectives in several scenarios, and include a few missing bonus objectives (such as Ariandela)
* Fix resurrected units being brought back poisoned if killed by a poison attack
* Improved campaign description for the add-on server

## v0.2.2

* Recoloured Elvish Archmage sprites
* Fixed dialogue when finding the ring, as suggested by TheScribe
* Fixed a situation in which the fifth scenario would kill your loyal ghost
* Add the correct Special Notes to all custom units, and fixed/removed erroneous descriptions
* Fixed Malcorn's squire being "more scary than the necromancer", as Faerie_Storm noted (though more work is needed on this issue still)
* Mother rats get more gold; giant frogs no longer leap into the caves to assassinate the first mother rat
* Elvish Wisp can now move over unwalkable terrain (30% defense, movement cost 2)
* Spruced up the map for the first scenario (and last, since it's the same map); furthermore, the map is appropriately altered for the last scenario
* Fixed bug where Ariandela's dominate ability wouldn't work in the last scenario
* Add Elvish Civilian portrait; also, Civilians are now always male

## v0.2.1

* Make Giant Toad neutral, change name to Giant Frog (because it looks more like a frog than a toad to me)
* If you opt not to immediately open the secret passage in Watery Tunnels, there's some dialog when you later choose to do so. It now scrolls back to the berserker after this dialogue is finished, so you can see the new tunnel.
* Changed the graphics for the following units: Elvish Wisp, Elvish Mage, Elvish Archmage, Elvish Priestess.
* Improved some dialogue in the first scenario
* When Eärendil levels to shyde, she uses a different portrait; instead of the core Shyde portrait, I've taken the Cleodil portrait from Legend of Wesmere, which looks to me as though it could be the same person as the default druid portrait and thus makes the level-up feel less "jarring".
* You get bonus initiates for the first five villages you capture in the first scenario (that's roughly every village on your side of the river); this is complete with a different line of dialogue for each one which is used in random order. How many initiates is random and will probably be somewhat scaled with difficulty once I implement that.
* Initiates can no longer get the resurrect ability; however there is now a new ability added to replace it. Of course, the resurrect ability is still available to the level 3 Elvish Priestess.

## v0.2

* Second scenario ("Dank Tunnels") has a brand-new map with an altered focus. Instead of "cave with splotches of dirt", it's "dirt with splotches of cave". The general concept of the scenario, along with all events and so forth, remains the same; only the layout and terrain quality is changed.
* Castles in the second scenario are now outlined with little stones to make their function more obvious. Some other changes were made to this scenario too, such as clarifying the objective, tweaking AI parameters, reducing gold carried out, giving one of the dwarves a different portrait, and increasing the proportion of level 1 monsters faced.
* Elvish Zealot sprite is now green. Its sprite remains the same in every other respect.
* Elvish Initiate iceball attack icon is now a smaller iceball.
* Third scenario (Orc Port) gives the enemy more gold and raises shroud a little on sighting the merman.
* In the fourth scenario (Watery Tunnels), the turn limit was reduced and the ankh necklace moved closer to the main path.
* The "tomato surprise" in Watery Tunnels is changed so that the newly-appearing enemies do not attack that turn.
* The player gets to choose when to open the secret tunnel in Watery Tunnels.
* Add overlays for the Initiate traits and the cures ability; give the daggers backstab
* All scenarios now have music, including a few track changes triggered by events.

## v0.1.2

* Hardy trait now gives +15% resistance to all damage instead of +20 hitpoints (considering reducing it to +10%)
* Fixed a glitch in the initiate's healing animation
* Inverted the swarm ability in the "thorny" feature of initiates: now it gives more strikes with lower HP, instead of less (still maxing at 4 extra). It's also retained in the whole druid line.

## v0.1.1

* Changed a leader name (using the original name as a surname)
* Added skeletal end credits
* Add sprites for treewalker (created by ShadowMaster for IftU, but discarded) and changed its portrait from shaman to druid

## v0.1

* Now on add-on server.
* Hasted and dominated are now shown as status icons rather than unit overlays.
* Added several of Eleazar's attack icons, mainly to the Treewalker and Mage lines.
* Fixed the double-fade glitch when a recruited Initiate ends up with one of the mighty, speedy, hardy, or agile traits.
* Besides the aesthetic changes, there are two little mechanical changes:
* Entangle attack for Zealot line reduced to be worse than the Druid line ensnare.
* Initiates with swarm retain it when levelling to Shaman (but still lose it at level 2).

## v0.0

* Initial release!