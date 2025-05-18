local team = tostring(getgenv().team)

if team == "" or team == " " then
    team = "Marines"
    getgenv().team = team
end

if team == "Pirates" or team == "Marines" then
    local args = {
        [1] = "SetTeam",
        [2] = team
    }
    game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer(unpack(args))
else
    print("Pirates or Marines! you put: " .. team)
end
