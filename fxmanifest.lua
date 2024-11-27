fx_version 'adamant'
games { 'gta5' }
lua54 'yes'
author ''
version 'Naujausia'

description 'narkata'

server_scripts {
    'server.lua'
}

client_scripts {
    'client.lua'
}

dependencies {
    'es_extended',
    'ox_lib'
}


shared_script '@ox_lib/init.lua'