Config = {}

Config.Debug = false

Config.Locale = 'fr' -- en/fr

Config.teleport = {
    spawnloc = {
        ["teleportvehicle"] = {val = false},
        ["Exterior distillerie"] = {
            icon = "fa-solid fa-bottle-droplet",
            loc = vector3(vector3(-155.76, 6327.72, 30.58)) 
        },
        ["Interior distillerie"] = {
            icon = "fa-solid fa-bottle-droplet",
            loc = vector3(997.04, -3200.67, -37.39) 
        },
    },
    spawnloc2 = {
        ["teleportvehicle"] = {val = true},
        ["Basketball Ramps2"] = {
            icon = "person-skating",
            loc = vector3(-910.03, -724.75, 19.92)
        },
        ["Skate Ramps2"] = {
            icon = "basketball",
            loc = vector3(-942.12, -791.68, 15.95)
        },
    },
    
}

Config.menu ={
    position = "bottom-right",
    title = "Ascenseur"
}

