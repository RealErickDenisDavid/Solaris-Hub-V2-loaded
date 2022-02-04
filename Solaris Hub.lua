-- Prison Life

local LocalizationService = game:GetService("LocalizationService")
local Players = game:GetService("Players")
if game.PlaceId == 155615604 then
    local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/xHeptc/Kavo-UI-Library/main/source.lua"))()
    local Window = Library.CreateLib("Prison Life (Solaris Hub)", "DarkTheme")
 
    -- Main

    local Main = Window:NewTab("Main")
    local MainSection = Main:NewSection("Main")

    MainSection:NewDropdown("Give Gun", "Gives the localplayer a gun", {"M9", "Remington 870", "AK-47"}, function(v)
        local A_1 = game:GetService("Workspace")["Prison_ITEMS"].giver[v].ITEMPICKUP
        local Event = game:GetService("Workspace").Remote.ItemHandler
        Event:InvokeServer(A_1)
    end)
 
    MainSection:NewDropdown("Gun Mod", "Makes the gun op", {"M9", "Remington 870", "AK-47"}, function(v)
        local module = nil
        if game:GetService("Players").LocalPlayer.Backpack:FindFirstChild(v) then
            module = require(game:GetService("Players").LocalPlayer.Backpack[v].GunStates)
        elseif game:GetService("Players").LocalPlayer.Character:FindFirstChild(v) then
            module = require(game:GetService("Players").LocalPlayer.Character[v].GunStates)
        end
        if module ~= nil then
            module["MaxAmmo"] = math.huge
            module["CurrentAmmo"] = math.huge
            module["StoredAmmo"] = math.huge
            module["FireRate"] = 0.000001
            module["Spread"] = 0
            module["Range"] = math.huge
            module["Bullets"] = 10
            module["ReloadTime"] = 0.000001
            module["AutoFire"] = true
        end
    end)
    
    MainSection:NewButton("Arrest Criminal", "Arrest all criminal", function()
        local Player = game.Players.LocalPlayer
        local cpos = Player.Character.HumanoidRootPart.CFrame
        for i,v in pairs(game.Teams.Criminals:GetPlayers()) do
        if v.Name ~= Player.Name then
         local i = 10
            repeat
            wait()
            i = i-1
            game.Workspace.Remote.arrest:InvokeServer(v.Character.HumanoidRootPart)
            Player.Character.HumanoidRootPart.CFrame = v.Character.HumanoidRootPart.CFrame * CFrame.new(0, 0, 1)
            until i == 0
         end
    end
end)

    MainSection:NewButton("Arrest", "Click arrest", function()
        local mouse = game.Players.LocalPlayer:GetMouse()
        local arrestEvent = game.Workspace.Remote.arrest
        mouse.Button1Down:connect(function()
         local obj = mouse.Target
        local response = arrestEvent:InvokeServer(obj)
    end)
end)

MainSection:NewButton("Super Punch", "One hit", function()
    mainRemotes = game.ReplicatedStorage meleeRemote = mainRemotes['meleeEvent'] mouse = game.Players.LocalPlayer:GetMouse() punching = false cooldown = false function punch() cooldown = true local part = Instance.new("Part", game.Players.LocalPlayer.Character) part.Transparency = 1 part.Size = Vector3.new(5, 2, 3) part.CanCollide = false local w1 = Instance.new("Weld", part) w1.Part0 = game.Players.LocalPlayer.Character.Torso w1.Part1 = part w1.C1 = CFrame.new(0,0,2) part.Touched:connect(function(hit) if game.Players:FindFirstChild(hit.Parent.Name) then local plr = game.Players:FindFirstChild(hit.Parent.Name) if plr.Name ~= game.Players.LocalPlayer.Name then part:Destroy() for i = 1,100 do meleeRemote:FireServer(plr) end end end end) wait(1) cooldown = false part:Destroy() end mouse.KeyDown:connect(function(key) if cooldown == false then if key:lower() == "f" then punch() end end end)
end)

    MainSection:NewButton("BaseBallBat", "Give Localplayer baseballbat", function()
        local LocalPlayer = game.Players.LocalPlayer
        local Character = LocalPlayer.Character
            local Backpack = LocalPlayer.Backpack
            local Humanoid = Character.Humanoid
            if not Backpack:FindFirstChild("Bat") and not Character:FindFirstChild("Bat") then
                local BaseBallBat = Instance.new("Tool", Backpack)
                local Handle = Instance.new("Part", BaseBallBat)
                BaseBallBat.GripPos = Vector3.new(0, -1.15, 0)
                BaseBallBat.Name = "Bat"
                Handle.Name = "Handle"
                Handle.Size = Vector3.new(0.4, 5, 0.4)
                local Animation =Instance.new("Animation", BaseBallBat)
                Animation.AnimationId = "rbxassetid://218504594"
                local Track = Humanoid:LoadAnimation(Animation)
                local Cooldown = false
                local Attacked = false
                local Attacking = false
                BaseBallBat.Equipped:Connect(function()
                    BaseBallBat.Activated:Connect(function()
                        if not Cooldown then
                            Cooldown = true
                            Attacking = true
                            Track:Play()
                            Handle.Touched:Connect(function(Hit)
                                if Hit.Parent and Hit.Parent ~= game.Players.LocalPlayer and not Attacked and Attacking then
                                    Attacked = true
                                    for i = 1,15 do
                                        game.ReplicatedStorage.meleeEvent:FireServer(game.Players[Hit.Parent.Name])
    
                                    end
                                end
                            end)
                            wait(0.25)
                            Cooldown = false
                            Attacked = false
                            Attacking = false
                        end  
                 end)
            end)
        end
    end)

    -- Player

    local Player = Window:NewTab("Player")
    local PlayerSection = Player:NewSection("Player")
 
    PlayerSection:NewSlider("WalkSpeed", "Changes the walkspeed", 250, 16, function(v)
        game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = v
    end)
 
    PlayerSection:NewSlider("JumpPower", "Changes the jumppower", 250, 50, function(v)
        game.Players.LocalPlayer.Character.Humanoid.JumpPower = v
    end)

    PlayerSection:NewButton("Btools", "Give localplayer btools", function()
        local tool1   = Instance.new("HopperBin",game.Players.LocalPlayer.Backpack)
	    tool1.BinType = "Hammer"
    end)

    local InfiniteJumpEnabled;
    PlayerSection:NewToggle("Infinite Jump", "By toggling this you can jump infinitely", function(State)
    InfiniteJumpEnabled = State

    local Player = game:GetService("Players").LocalPlayer
    game:GetService("UserInputService").JumpRequest:Connect(function()
        if InfiniteJumpEnabled then
            Player.Character:WaitForChild("Humanoid"):ChangeState("Jumping")
        end
    end)
end)

    PlayerSection:NewButton("Reset", "Fast respawn", function()
        local A_1 = "\66\114\111\121\111\117\98\97\100\100"
	    local Event = game:GetService("Workspace").Remote.loadchar
	    Event:InvokeServer(A_1)
    end)

    PlayerSection:NewButton("Rejoin", "Rejoin the server", function()
        local tpservice= game:GetService("TeleportService")
	    local plr = game.Players.LocalPlayer
	    tpservice:Teleport(game.PlaceId, plr)
    end)

       -- Remove Function

       local RemoveFunction = Window:NewTab("Remove Function")
       local RemoveFunctionSelection = RemoveFunction:NewSection("Remove Function")
   
   
       RemoveFunctionSelection:NewToggle("Remove Prison Guard Outpost", "Remove prison guard outpost", function()
           if workspace:FindFirstChild("Prison_Guard_Outpost") then
               workspace.Prison_Guard_Outpost.Parent = game.Lighting
               else game.Lighting.Prison_Guard_Outpost.Parent = game.Workspace
           end
       end)
       
       RemoveFunctionSelection:NewToggle("Remove Prison Cellblock", "Remove prison cellblock", function()
           if workspace:FindFirstChild("Prison_Cellblock") then
               workspace.Prison_Cellblock.Parent = game.Lighting
               else game.Lighting.Prison_Cellblock.Parent = game.Workspace
           end
       end)
   
       RemoveFunctionSelection:NewToggle("Remove Prison Administration", "Remove prison administration", function()
           if workspace:FindFirstChild("Prison_Administration") then
               workspace.Prison_Administration.Parent = game.Lighting
               else game.Lighting.Prison_Administration.Parent = game.Workspace
           end
       end)
   
       RemoveFunctionSelection:NewToggle("Remove Prison OuterWall", "Remove prison outerWall", function()
           if workspace:FindFirstChild("Prison_OuterWall") then
               workspace.Prison_OuterWall.Parent = game.Lighting
               else game.Lighting.Prison_OuterWall.Parent = game.Workspace
           end
       end)

       RemoveFunctionSelection:NewToggle("Remove Prison Cafeteria", "Remove prison cafeteria", function()
        if workspace:FindFirstChild("Prison_Cafeteria") then
            workspace.Prison_Cafeteria.Parent = game.Lighting
            else game.Lighting.Prison_Cafeteria.Parent = game.Workspace
        end
    end)

    RemoveFunctionSelection:NewToggle("Remove Doors", "Remove all doors", function()
        if workspace:FindFirstChild("Doors") then
            workspace.Doors.Parent = game.Lighting
            else if game.Lighting:FindFirstChild("Doors") then
                game.Lighting.Doors.Parent = workspace
            end
        end
    end)

    RemoveFunctionSelection:NewToggle("Remove Fences", "Remove all Fences", function()
        if workspace:FindFirstChild("Prison_Fences") then
            workspace.Prison_Fences.Parent = game.Lighting
            else game.Lighting.Prison_Fences.Parent = workspace
        end
    end)
   

    -- Function

    local Function = Window:NewTab("Function")
    local FunctionSelection = Function:NewSection("function")

    FunctionSelection:NewButton("Open Gate", "Gate open", function()
        workspace.Remote.ItemHandler:InvokeServer(workspace.Prison_ITEMS.buttons["Prison Gate"]["Prison Gate"])
    end)

    FunctionSelection:NewButton("Crash Server", "Make server crash", function()
        local Player = game.Players.LocalPlayer.Name
        game.Workspace.Remote.ItemHandler:InvokeServer(workspace.Prison_ITEMS.giver["Remington 870"].ITEMPICKUP)

        for i,v in pairs(game.Players[Player].Backpack:GetChildren()) do
            if v.name == "Remington 870" then
                v.Parent = game.Players.LocalPlayer.Character
            end
        end
            local Gun = "Remington 870"
            Gun = game.Players[Player].Character[Gun]
            game.Players.LocalPlayer.Character:FindFirstChildOfClass("Humanoid"):UnequipTools()
                function FireGun(target)
                coroutine.resume(coroutine.create(function()
                local bulletTable = {}
                table.insert(bulletTable, {
                Hit = target,
                Distance = 100,
                Cframe = CFrame.new(0,1,1),
                RayObject = Ray.new(Vector3.new(0.1,0.2), Vector3.new(0.3,0.4))
                })
                game.ReplicatedStorage.ShootEvent:FireServer(bulletTable, Gun)
                wait()
            end))
        end
                while game:GetService("RunService").Stepped:wait() do
                for count = 0, 10, 10 do
                FireGun()
            end
        end
    end)


    -- Change Team

    local ChangeTeam = Window:NewTab("Change Team")
    local ChangeTeamSection = ChangeTeam:NewSection("Change Team")

    ChangeTeamSection:NewButton("Guards", "Become guards team", function()
        workspace.Remote.TeamEvent:FireServer("Bright blue")
    end)

    ChangeTeamSection:NewButton("Inmate", "Become inmate team", function()
        workspace.Remote.TeamEvent:FireServer("Bright orange")
    end)

    ChangeTeamSection:NewButton("Neutral", "Become neutral team", function()
        workspace.Remote.TeamEvent:FireServer("Medium stone grey")
    end)

    ChangeTeamSection:NewButton("Criminal", "Become Criminal team", function()
        wait(0.3)
        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-976.125183, 109.123924, 2059.99536)
    end)

    -- Teleport

    local TeleportSection = Window:NewTab("Teleport")
    local TeleportSection = TeleportSection:NewSection("Teleport")

    TeleportSection:NewButton("Prison", "Teleport to prison", function()
        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(918.77,100,2379.07)
    end)

    TeleportSection:NewButton("Yard", "Teleport to yard", function()
        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(781.6845703125, 97.999946594238, 2462.8779296875)
     end)

    TeleportSection:NewButton("Criminal Base", "Teleport to criminal base", function()
        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-859.15161132813, 94.476051330566, 2058.5427246094)
    end)

    TeleportSection:NewButton("Hallway", "Teleport to hallway", function()
        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(860.78448486328, 99.990005493164, 2362.9597167969)
    end)

    TeleportSection:NewButton("Entrance Gate", "Teleport to entrancegate", function()
        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(491.27182006836, 98.039939880371, 2216.3107910156)
    end)

    TeleportSection:NewButton("Entrance", "Teleport to entrance", function()
        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(653.81713867188, 99.990005493164, 2272.083984375)
    end)

    TeleportSection:NewButton("CellBlock", "Teleport to cellblock", function()
        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(918.43115234375, 99.989990234375, 2440.3828125)
    end)

    TeleportSection:NewButton("Cafeteria", "Teleport to cafeteria", function()
        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(932.06213378906, 99.989959716797, 2290.4250488281)
    end)

    TeleportSection:NewButton("Armory", "Teleport to armory", function()
        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(835.28918457031, 99.990005493164, 2285.4909667969)
    end)

    TeleportSection:NewButton("Gaurds Only", "Teleport to gaurds only.", function()
        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(830.04302978516, 99.990005493164, 2327.0859375)
     end)

     TeleportSection:NewButton("Car Spawn", "Teleport to car spawn", function()
        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-200, 55, 1880)
     end)

     TeleportSection:NewButton("Shops", "Teleport to shops", function()
        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-415, 55, 1750)
     end)

     TeleportSection:NewButton("Gas Station", "Teleport to gas station", function()
        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-520, 55, 1660)
     end)

     TeleportSection:NewButton("Secret Spot", "Teleport to secret spot", function()
        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-920, 95, 1990)
     end)

     TeleportSection:NewButton("Police Cars", "Teleport to police cars", function()
        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(615, 100, 2515)
     end)

     TeleportSection:NewButton("Police Area", "Teleport to police area", function()
        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(855, 100, 2297)
     end)

     TeleportSection:NewButton("Grocery Shop", "Teleport to grocery shop", function()
        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-415, 55, 1750)
     end)
     
     --  Settings

     local Settings = Window:NewTab("Settings")
     local SettingsSelection = Settings:NewSection("Settings")

     SettingsSelection:NewKeybind("KeybindText", "Change keybind", Enum.KeyCode.V, function()
         Library:ToggleUI()
     end)

     -- Credits

     local Credits = Window:NewTab("Credits")
     CreditsSection = Credits:NewSection("Credits")

     CreditsSection:NewLabel("Made by PainNonsense#")

     -- Flood Escape Classic

     elseif game.PlaceId == 32990482 then
        local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/xHeptc/Kavo-UI-Library/main/source.lua"))()
        local Window = Library.CreateLib("Flood Escape Classic (Solaris Hub)", "DarkTheme")
     
        -- Main

        local Main = Window:NewTab("Main")
        local MainSection = Main:NewSection("Main")

        local InfiniteJumpEnabled;
        MainSection:NewToggle("Infinite Jump", "By toggling this you can jump infinitely", function(State)
            InfiniteJumpEnabled = State

            local Player = game:GetService("Players").LocalPlayer
            game:GetService("UserInputService").JumpRequest:Connect(function()
                if InfiniteJumpEnabled then
                    Player.Character:WaitForChild("Humanoid"):ChangeState("Jumping")
                end
            end)
        end)

        -- Settings

        local Settings = Window:NewTab("Settings")
        SettingsSelection = Settings:NewSection("Settings")
    
        SettingsSelection:NewKeybind("KeybindText", "Change the Keybind", Enum.KeyCode.V, function()
            Library:ToggleUI()
        end)

     -- Credits

     local Credits = Window:NewTab("Credits")
     CreditsSection = Credits:NewSection("Credits")

     CreditsSection:NewLabel("Made by PainNonsense#")
        

     -- Work at a Pizza Place

    elseif game.PlaceId == 192800 then
     local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/xHeptc/Kavo-UI-Library/main/source.lua"))()
    local Window = Library.CreateLib("Work at a Pizza Place (Solaris Hub)", "DarkTheme")
      
    -- LocalPlayer

    local LocalPlayer = Window:NewTab("LocalPlayer")
    local LocalPlayerSelection = LocalPlayer:NewSection("LocalPlayer")

    LocalPlayerSelection:NewSlider("Walkspeed", "Changes the walkspeed", 250, 16, function(v)
        game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = v
    end)
 
    LocalPlayerSelection:NewSlider("Jumppower", "Changes the jumppower", 250, 50, function(v)
        game.Players.LocalPlayer.Character.Humanoid.JumpPower = v
    end)

    -- Teleport Area

    local TeleportArea = Window:NewTab("Teleport Area")
    TeleportAreaSelection = TeleportArea:NewSection("Teleport Area")

    TeleportAreaSelection:NewButton("Cashier Area", "Teleport to cashier area", function()
        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(48, 4, 80)
    end)

    TeleportAreaSelection:NewButton("Cook Area", "Teleport to cook area", function()
        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(42, 4, 61)
    end)

    TeleportAreaSelection:NewButton("Manager Area", "Teleport to manager area", function()
        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(37, 4, 3)
    end)

    TeleportAreaSelection:NewButton("Boxer Area", "Teleport to boxer area", function()
        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(42, 4, 61)
    end)

    TeleportAreaSelection:NewButton("Manager Area", "Teleport to manager area", function()
        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(37, 4, 3)
    end)

    TeleportAreaSelection:NewButton("Delivery Area", "Teleport to delivery area", function()
        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(64, 4, -17)
    end)

    TeleportAreaSelection:NewButton("Supplier Area", "Teleport to supplier area", function()
        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(8, 13, -1020)
    end)

    -- Scripts

    local Scripts = Window:NewTab("Scripts")
    local ScriptsSelection = Scripts:NewSection("Scripts")

    ScriptsSelection:NewButton("Become Manager", "Become manager", function()
        --vars
local Players = game:GetService("Players")
local player = Players.LocalPlayer
local humanoid = player.Character.Humanoid
local mteam = game:GetService("Teams").Manager
local man = mteam:GetPlayers()[1]
--deletes a glitchy chair in the office (optional)
if workspace:FindFirstChild("ExtraChair") and workspace.ExtraChair:FindFirstChild("Seat") then
	workspace.ExtraChair.Seat:Destroy()
end

if man then
	--check if he's respawning or sitting
	local htxt
	if man.Character==nil or man.Character:FindFirstChild("HumanoidRootPart")==nil or man.Character:FindFirstChild("Humanoid")==nil then
		htxt = "Failed because manager is respawning"
	end
	local target = man.Character.HumanoidRootPart
	if man.Character.Humanoid.Sit then
		htxt = "Failed because manager is sitting"
	end
	if htxt then
		local h = Instance.new("Hint",workspace)
		h.Text = htxt
		wait(3)
		h:Destroy()
		return
	end
	--get in a car
	if not workspace.Cars:IsAncestorOf(humanoid.SeatPart) then
		humanoid.Jump=true
		wait(0.1)
		for _,car in ipairs(workspace.Cars:GetChildren()) do
			if car:FindFirstChild("Driver") and car.Driver.Occupant==nil and car:FindFirstChild("Owner") and car.Owner.Value==nil then
				car.Driver:Sit(humanoid)
				wait(0.3)
				if humanoid.SeatPart then
					break
				end
			end
		end
	end
	local seat = humanoid.SeatPart
	local car = seat.Parent
	local returncf = CFrame.new(14,-4.5,21)*CFrame.Angles(0,math.pi/2,0)
	for j=1,4 do
		--attempt to sit manager
		seat.Anchored=false
		local e = 0
		while car.HoodSeat.Occupant==nil and mteam:GetPlayers()[1] and target.Parent and e<5 do
			local newpos = target.Position+Vector3.new(0,-3,0)+target.CFrame.lookVector*5.5+target.Velocity*.7
			local flatdir = (target.CFrame.lookVector*Vector3.new(1,0,1)).Unit --target's looking direction, flattened
			if not (flatdir.x < 2) then --inf
				flatdir = Vector3.new(1,0,0)
			end
			car:SetPrimaryPartCFrame(CFrame.new(newpos,newpos-flatdir))
			seat.Velocity=Vector3.new()
			local e2=0
			while car.HoodSeat.Occupant==nil and mteam:GetPlayers()[1] and target.Parent and e2<0.7 do
				e2=e2+wait()
			end
			e=e+e2
		end
		--attempt to move manager
		car:SetPrimaryPartCFrame(returncf)
		wait(.1)
		car:SetPrimaryPartCFrame(returncf)
		seat.Anchored=true
		e = 0
		while mteam:GetPlayers()[1] and target.Parent and e<1 do
			e=e+wait()
		end
		car.HoodSeat:ClearAllChildren() --unsits anyone
		e = 0
		while mteam:GetPlayers()[1] and target.Parent and e<0.5 do
			e=e+wait()
		end
		if mteam:GetPlayers()[1]==nil or target.Parent==nil then
			break
		end
	end
	--reset car
	seat.Anchored=false
	wait()
	car:SetPrimaryPartCFrame(CFrame.new(120,10,-75))
	wait()
end

    --become manager
    humanoid.Jump=true
    wait(0.1)
    pcall(function() workspace.ManagerChair.Seat:Sit(humanoid) end)
    wait(0.3)
    humanoid.Jump=true
    wait(0.1)
    player.Character.HumanoidRootPart.CFrame = player.Character.HumanoidRootPart.CFrame+Vector3.new(5,5,6)
    end)

    ScriptsSelection:NewButton("0 Gravity Unanchored Things", "Unanchored Things", function()
        spawn(function()
            while true do
                game.Players.LocalPlayer.MaximumSimulationRadius = math.pow(math.huge,math.huge)*math.huge
                game.Players.LocalPlayer.SimulationRadius = math.pow(math.huge,math.huge)*math.huge
                game:GetService("RunService").Stepped:wait()
            end
        end)
        local function zeroGrav(part)
            if part:FindFirstChild("BodyForce") then return end
            local temp = Instance.new("BodyForce")
            temp.Force = part:GetMass() * Vector3.new(0,workspace.Gravity,0)
            temp.Parent = part
        end
        for i,v in ipairs(workspace:GetDescendants()) do
            if v:IsA("Part") and v.Anchored == false then
                if not (v:IsDescendantOf(game.Players.LocalPlayer.Character)) then
                    zeroGrav(v)
                end
            end
            workspace.DescendantAdded:Connect(function(part)
                if part:IsA("Part") and part.Anchored == false then
                    if not (part:IsDescendantOf(game.Players.LocalPlayer.Character)) then
                        zeroGrav(part)
                    end
                end
            end)
        end
    end)

    ScriptsSelection:NewButton("Bring Unanchored Bricks [E]", "Bring Unanchored", function()
        local UserInputService = game:GetService("UserInputService")
        local Mouse = game:GetService("Players").LocalPlayer:GetMouse()
        local Folder = Instance.new("Folder", game:GetService("Workspace"))
        local Part = Instance.new("Part", Folder)
        local Attachment1 = Instance.new("Attachment", Part)
        Part.Anchored = true
        Part.CanCollide = false
        Part.Transparency = 1
        local Updated = Mouse.Hit + Vector3.new(0, 5, 0)
        local NetworkAccess = coroutine.create(function()
            settings().Physics.AllowSleep = false
            while game:GetService("RunService").RenderStepped:Wait() do
                for _, Players in next, game:GetService("Players"):GetPlayers() do
                    if Players ~= game:GetService("Players").LocalPlayer then
                        Players.MaximumSimulationRadius = 0 
                        sethiddenproperty(Players, "SimulationRadius", 0) 
                    end 
                end
                game:GetService("Players").LocalPlayer.MaximumSimulationRadius = math.pow(math.huge,math.huge)
                setsimulationradius(math.huge) 
            end 
        end) 
        coroutine.resume(NetworkAccess)
        local function ForcePart(v)
            if v:IsA("Part") and v.Anchored == false and v.Parent:FindFirstChild("Humanoid") == nil and v.Parent:FindFirstChild("Head") == nil and v.Name ~= "Handle" then
                Mouse.TargetFilter = v
                for _, x in next, v:GetChildren() do
                    if x:IsA("BodyAngularVelocity") or x:IsA("BodyForce") or x:IsA("BodyGyro") or x:IsA("BodyPosition") or x:IsA("BodyThrust") or x:IsA("BodyVelocity") or x:IsA("RocketPropulsion") then
                        x:Destroy()
                    end
                end
                if v:FindFirstChild("Attachment") then
                    v:FindFirstChild("Attachment"):Destroy()
                end
                if v:FindFirstChild("AlignPosition") then
                    v:FindFirstChild("AlignPosition"):Destroy()
                end
                if v:FindFirstChild("Torque") then
                    v:FindFirstChild("Torque"):Destroy()
                end
                v.CanCollide = false
                local Torque = Instance.new("Torque", v)
                Torque.Torque = Vector3.new(100000, 100000, 100000)
                local AlignPosition = Instance.new("AlignPosition", v)
                local Attachment2 = Instance.new("Attachment", v)
                Torque.Attachment0 = Attachment2
                AlignPosition.MaxForce = 9999999999999999
                AlignPosition.MaxVelocity = math.huge
                AlignPosition.Responsiveness = 200
                AlignPosition.Attachment0 = Attachment2 
                AlignPosition.Attachment1 = Attachment1
            end
        end
        for _, v in next, game:GetService("Workspace"):GetDescendants() do
            ForcePart(v)
        end
        game:GetService("Workspace").DescendantAdded:Connect(function(v)
            ForcePart(v)
        end)
        UserInputService.InputBegan:Connect(function(Key, Chat)
            if Key.KeyCode == Enum.KeyCode.E and not Chat then
               Updated = Mouse.Hit + Vector3.new(0, 5, 0)
            end
        end)
        spawn(function()
            while game:GetService("RunService").RenderStepped:Wait() do
                Attachment1.WorldCFrame = Updated
            end
            end)
        end)        

    local Autofarm = Window:NewTab('Autofarm')
    AutofarmSelection = Autofarm:NewSection("Autofarm")

    AutofarmSelection:NewButton("Autofarm gui", "Open Autofarm gui",function()
        loadstring(game:HttpGet("https://gist.githubusercontent.com/TurkOyuncu99/9b9d62e9068d795f708c51551d439d21/raw/84a28a8d1fc501b9d200e8a2bd7cc831df0fbacf/gistfile1.txt", true))()
    end)

    local Settings = Window:NewTab("Settings")
    SettingsSelection = Settings:NewSection("Settings")

    SettingsSelection:NewKeybind("KeybindText", "Change the Keybind", Enum.KeyCode.V, function()
        Library:ToggleUI()
    end)

     -- Credits

     local Credits = Window:NewTab("Credits")
     CreditsSection = Credits:NewSection("Credits")

     CreditsSection:NewLabel("Made by PainNonsense#")

-- In Another Time

elseif game.PlaceId == 5864786637 then
    local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/xHeptc/Kavo-UI-Library/main/source.lua"))()
   local Window = Library.CreateLib("In Another Time (Solaris Hub)", "DarkTheme")

   -- Items

   local Items = Window:NewTab("Items")
   local ItemsSection = Items:NewSection("Give Arrow")

    ItemsSection:NewButton("Get Arrow", "Gives you a normal arrow from the shop", function()
        local Event = game:GetService("ReplicatedStorage").ItemGiver.GiveArrow
        Event:FireServer()
    end)

    -- Main (TP locations)

   local Main = Window:NewTab("Main")
   local MainSection = Main:NewSection("TP locations")

   MainSection:NewButton("Next to shop", "Teleport to next to shop",function()
    game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-677.057922, -5.10002708, 1510.17517, 0.942098975, 1.15333529e-08, 0.335335076, -5.88316018e-09, 1, -1.78652169e-08, -0.335335076, 1.485797e-08, 0.942098975)
   end)

   MainSection:NewButton("inside shop", "Teleport to inside shop", function()
        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-686.478821, -3.22996569, 1510.57935, 0.98889941, 2.06599839e-08, -0.148586676, -1.92457801e-08, 1, 1.09555529e-08, 0.148586676, -7.97427369e-09, 0.98889941)
   end)

    MainSection:NewButton("At rocks", "Teleport to at rocks", function()
        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-419.359131, -5.10004139, 1681.87634, 0.507609725, -1.22854743e-07, 0.861587107, 3.74974007e-08, 1, 1.20499365e-07, -0.861587107, -2.88593736e-08, 0.507609725)
    end)

    MainSection:NewButton("Arrow Shop", "Teleport to arrow shop", function()
        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-634.588196, -4.6000061, 1703.26404, -0.994130433, -4.80428959e-08, 0.10818705, -5.23901384e-08, 1, -3.73403353e-08, -0.10818705, -4.27891003e-08, -0.994130433)
    end)

    MainSection:NewButton("Mountain", "Teleport to mountain", function()
        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-904.078003, 31.5853634, 1437.31506, -0.931494713, -4.99696995e-08, 0.363754839, -5.96830887e-08, 1, -1.54631081e-08, -0.363754839, -3.61138142e-08, -0.931494713)
    end)

    MainSection:NewButton("Near Chair", "Teleport to near chair", function()
        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-610.969238, -5.10001755, 1826.43823, 0.999164641, -5.63880427e-08, -0.0408678912, 5.88935976e-08, 1, 6.01049166e-08, 0.0408678912, -6.24616021e-08, 0.999164641)
    end)

    MainSection:NewButton("Dummy test", "Teleport to dummy test", function()
    game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-807.189697, -4.85914183, 1621.38416, 0.99414742, -1.26825057e-08, -0.108030282, 1.98882724e-08, 1, 6.56239152e-08, 0.108030282, -6.73883491e-08, 0.99414742)
end)

    MainSection:NewButton("1v1 Arena", "Teleport to 1v1 arena", function()
    game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-474.922791, -4.71304703, 1376.32361, 0.148592025, 1.02405728e-08, 0.988898575, -1.21302918e-07, 1, 7.87145815e-09, -0.988898575, -1.21125922e-07, 0.148592025)
end)

-- Player

local Player = Window:NewTab("Player")
local PlayerSection = Player:NewSection("Player")

PlayerSection:NewSlider("WalkSpeed", "Changes the walkspeed", 250, 16, function(v)
    game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = v
end)

PlayerSection:NewSlider("JumpPower", "Changes the jumppower", 250, 50, function(v)
    game.Players.LocalPlayer.Character.Humanoid.JumpPower = v
end)

PlayerSection:NewButton("Reset", "Resets", function()
    game.Players.LocalPlayer.Character.Humanoid.Health = 0
end)

-- Settings

local Settings = Window:NewTab("Settings")
local SettingsSelection = Settings:NewSection("Settings")

SettingsSelection:NewKeybind("KeybindText", "Change keybind", Enum.KeyCode.V, function()
    Library:ToggleUI()
end)

     -- Credits

     local Credits = Window:NewTab("Credits")
     CreditsSection = Credits:NewSection("Credits")

     CreditsSection:NewLabel("Made by PainNonsense#")

end
