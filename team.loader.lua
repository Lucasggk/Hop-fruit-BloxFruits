print(getgenv().team)

if getgenv().team == "Pirates" or getgenv().team == "Marines" then
  local args = {
    [1] = "SetTeam",
    [2] = tostring(getgenv().team)
}

game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer(unpack(args))

else 
  print("Pirates or Marines! you put: ".. getgenv().team )
end
