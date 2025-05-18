print(tostring(getgenv().team))
if getgenv().team == "" or getgenv().team == " " then
getgenv().team = "Marines"
else
print("")
end

if tostring(getgenv().team) == "Pirates" or tostring(getgenv().team) == "Marines" then
local args = {
[1] = "SetTeam",
[2] = tostring(getgenv().team)
}

game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer(unpack(args))

else
print("Pirates or Marines! you put: ".. getgenv().team )
end

