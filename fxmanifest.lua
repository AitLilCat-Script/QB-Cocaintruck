fx_version 'bodacious'
game 'gta5'

author 'QB-Cocaintruck'
version '1.0.0'

-- Shared scripts for both client and server use
shared_scripts { 
    'shared.lua',    -- Shared logic between client and server
    'config.lua'     -- Configuration file
}

-- Client-side scripts
client_scripts {
    'lang.lua',      -- Language settings
    'client.lua',    -- Client-side logic
}

-- Server-side scripts
server_scripts {
    'lang.lua',      -- Language settings (can be optimized by using a shared file if needed)
    'server.lua',    -- Server-side logic
}
