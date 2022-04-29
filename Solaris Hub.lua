_G.Themes = "" --// insert a theme before Execute or else script won't load.
_G.UILoadingSongID = ""
repeat
wait();
until game:IsLoaded();
pcall(function()
loadstring(game:HttpGet('https://raw.githubusercontent.com/RealPainNonsense/Solaris-Hub-V2/main/Solaris%20HubV2.lua', true))()
end)
