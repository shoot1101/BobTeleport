fx_version "adamant"
game "gta5"
lua54 "yes"
author "Bobs & Co"

client_scripts {
    "client/*.lua"
}

server_scripts {
	'server/*.lua'
}

shared_scripts {
    "config.lua",
    'locales/*.lua',
    "@ox_lib/init.lua",
    "@es_extended/imports.lua"
}