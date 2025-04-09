🌟💊 Installation and Setup Instructions for QB-Cocaintruck Script 💊🌟

⚙️ Requirements
1. QBCore - You must have this framework running on your server. Find it here .
2. QB-Target - This script requires the QB-Target resource for better functionality. Get it from this link .
Install any additional dependencies that might be required like MySQL and Redis, if using QBCore.
3. QB-Cocaintruck Client Script - A client-side script is also available to add interactivity to the server-side resource.

📦 Installation Steps

1. Download and Setup Resources: Download this script as a ZIP file by clicking on the "Code" button, then select "Download ZIP". Extract the contents of the zip file into your qb-core/src/[esx]/resources folder. If you are using resource managers like Thunderstore or GTA FiveM, search for QB-Cocaintruck and install it there.
2. Setup server configuration: Add this line to your server configuration (.cfg) file:
start QBCore
start qb-target
start QB-Cocaintruck
3. Restart Server: After the installation process, remember to restart your server.
4. Configure Resources: Open the config.lua file inside this resource folder and adjust it according to the comments provided for each variable.
5. Setup additional files if using QBCore MySQL or Redis: Adjust any other configuration files like server.cfg, oxmysql_users.lua depending on your SQL server setup like database.cfg and redis.conf if you're using Redis or MySQL for save data.
6.Check Dependencies: Make sure that all required dependencies are installed correctly on your server.
If any issues occur, don't hesitate to ask for support in our qb-core Discord .


💊🎉 Usage 🎉💊

Starting the Script: To start the cocaintruck script, use a command like /cocainetruck or simply type it if you're using a targeting system.
Interact with Truck and Open Menu: Interact with your character and press E to open up the menu where you can select various options for the cocaine truck job (like Pickup Cocaine).
Configure Job Limits: Once you finish your shift, if you have earned any amount of cocaine, the script saves it to MySQL or Redis for later retrieval when needed.
Retrieve Earnings: To retrieve your earnings, simply type /cocaine in game while holding E. This will display the total amount of cocaine you have earned throughout your play time.
Remember Truck's Status: The truck's status (active/inactive) is saved to MySQL or Redis so it remembers its state even after a server restart.
