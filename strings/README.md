# Strings
This folder contains unicode strings from Blur exe v1.2 with vitality crack exported with Strings util. Will add strings exported with x64dbg later.

# Interesting findings:

### Mercury

`Z:\devroot\code\mercury\library\display\source\device\d3d9\PCD3D9CapsChecker%s.cpp`

`Z:\buildagent\workspace\Bizarre\Blur\Release_PC\Game\code\Mercury\Library\Common\System\source\XML\XmlBlockParser.cpp`

Blur in-dev codename was "Mercury", which is also a prefix for all important parts of the code.

```
mercury.display
mercury.Graphics.Dynamic.light.sorcery
mercury.render.postprocess
mercury.vehicle
mercury.lua
mercury.pakfs
mercury.security
```
And many, many others.

### Bikes.

`Z:\buildagent\workspace\Bizarre\Blur\Release_PC\Game\code\Mercury\Library\Physics\RacingPhysics\source\vehicles\motorbike\motorbikesettings.cpp`

This string references motorbikes, which aren't a part of a final game. But according to other strings:

```
RacingPhysics.Bikes.RiderPresent
RacingPhysics.Bikes.KneeRollTolerance
RacingPhysics.Bikes.MaxSteeringTorque
RacingPhysics.Bikes.SteeringPower
RacingPhysics.Bikes.NoLeanOnOddNumberedBikes
RacingPhysics.Bikes.Integration.EulerSpeed
RacingPhysics.Bikes.Integration.MidpointSpeed
RacingPhysics.Bikes.BikeLiftOnJump
RacingPhysics.Bikes.BikeLiftDamping
RacingPhysics.Bikes.BikeLiftOffset
```

Bikes at least in was play test stage. But since we didn't ever saw any screenshots featuring bikes, my guess is that they were cut long before final stages of development.

### Amax

`Z:\buildagent\workspace\Bizarre\Blur\Release_PC\Game\code\amax\game\GameLogic\ActorStudioActors\DynamicObjectActor.cpp`

Amax code is referenced as well, but I'm still not sure what is the difference between Amax and Mercury branches. Probably it's different parts of game.

### Debug mode

Inside Blur exe file there are tons of debug mode referencing strings. I'm fairly sure that debug mode can be reinplemented. Or can't. Blur checks for 'dbghelp.dll' in its folder on launch, which doesn't exists.

```
Screens\Debug\DebugEventScreen.lua
Screens\Debug\DebugScreen.lua
Screens\Debug\DebugCarScreen.lua
Screens\Debug\DebugContentServer.lua
Screens\Debug\DebugItemBase.lua
Screens\Debug\DebugLoadReplays.lua
Screens\Debug\DebugUI.lua
Screens\Debug\QuitandWin.lua
```

```
debug_frontend.xml
Amax.LinkCode
Amax.Messaging
Vehicle.LOD.DebugPlayerDetail
Vehicle.LOD.DebugAiDetail
GameMode.Debug
Cheats.Debug_PerkSlotOveride
Game.Debug.LoadLargestVehicles
Game.Debug.NumAdditionalCars
```




### To be updated.



