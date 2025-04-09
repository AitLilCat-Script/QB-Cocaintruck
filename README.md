
# 💊🎉 QB-Cocaintruck Script - Installation and Setup Instructions 💊🎉

## ⚙️ Requirements

Before installing **QB-Cocaintruck**, make sure you have the following:

- **QBCore Framework**: This script requires the **QBCore** framework. Ensure QBCore is set up and running on your server. [Get QBCore here](https://github.com/qbcore-framework).
- **QB-Target**: For improved interaction with NPCs and objects, you will need the **QB-Target** resource. [Install QB-Target here](https://github.com/qbcore-framework/qb-target).
- **Database**: Set up **MySQL** or **Redis** for saving data (player stats, truck status, job progress). Choose based on your preference.
- **Client Script**: A client-side script is included for interactivity on the player's side.

---

## 📦 Installation Steps

Follow these steps to get **QB-Cocaintruck** installed and running:

1. **Download and Setup Resources**:
   - Download the script as a **ZIP** file by clicking the **"Code"** button and selecting **"Download ZIP"**.
   - Extract the contents of the ZIP file to your server's `qb-core/src/[esx]/resources` folder. Alternatively, if using resource managers like **Thunderstore** or **FiveM**, search for **QB-Cocaintruck** and install it there.

2. **Update Server Configuration**:
   - Open your **server.cfg** file and add the following lines to start the necessary resources:
     ```plaintext
     start QBCore
     start qb-target
     start QB-Cocaintruck
     ```

3. **Restart Server**:
   - After making the configuration changes, restart your server to load the new script properly.

4. **Configure the Script**:
   - Open the `config.lua` file inside the `QB-Cocaintruck` resource folder. Adjust the settings according to your server's needs. Comments in the file will guide you on configuring each variable.

5. **Set Up MySQL or Redis (if applicable)**:
   - If you're using **MySQL** or **Redis** to persist player data, make sure to adjust configuration files like `server.cfg`, `oxmysql_users.lua`, or `redis.conf` to match your database setup.

6. **Check Dependencies**:
   - Ensure that all required dependencies (like **QB-Target**, **MySQL**, and **Redis**) are correctly installed and running. If you encounter any issues, feel free to ask for help in the **QB-Core Discord**.

---

## 💊🎉 Features and Functionality 🎉💊

The **QB-Cocaintruck** script offers a dynamic and engaging drug delivery job, where players participate in a **cocaine truck operation**. Here’s what you can expect:

### 📦 Job System
- **Truck Delivery Job**: Players can start and quit the **Cocaine Truck** job, involving finding, delivering, and maintaining the truck.
- **NPC Interaction**: Interact with an NPC at a designated location to start the job. The NPC will provide instructions and updates throughout the process.

### 🚚 Vehicle System
- **Vehicle Options**: Trucks are assigned dynamically based on the player’s rank in the job system. Higher ranks unlock more advanced truck variants.
- **Vehicle Interaction**: Players can choose whether to keep the truck or destroy it after a set time.

### 🔐 Progression and XP System
- **Level-Based Progression**: Players earn **XP** as they complete jobs, leveling up and unlocking better trucks and features.
- **XP Penalties**: Players lose XP if they fail the job, such as by destroying the truck or quitting prematurely.

### 🚓 Cop Chase System
- **Cop Interactions**: Cops may spawn during deliveries, creating a risk factor where players must evade law enforcement.
- **Dynamic Cop Spawn**: Cop vehicles spawn based on a configurable chance, adding difficulty and excitement to the delivery.

### 🛠️ Server Persistence
- **Data Persistence**: Player data such as XP, truck status, and job progress is stored in a **MySQL** or **Redis** database. This ensures that progress is saved even after a server restart.

### 📍 Delivery System
- **Delivery Locations**: Players can deliver the stolen truck to various locations, such as **Police Station**, **Hotel**, **Fire Station**, and **Train Yard**.
- **Randomized Earnings**: Delivery locations have random payouts, keeping the job rewarding and unpredictable.

---

## 🎮 Usage Instructions

### 🛣️ Starting the Job
- To begin the **Cocaintruck** job, players can either use a command (e.g., `/cocainetruck`) or interact with an NPC (press **E** near the NPC).

### 🚚 Truck Interaction
- After starting the job, players will be prompted to interact with the truck and choose the option to **Pickup Cocaine** and start the delivery.

### 🔄 Job Status and Timer
- The truck's status (active/inactive) is saved to the database, allowing players to resume the job even after a restart.
- Players must complete the job within a set time. Failing to do so will result in penalties, such as losing XP.

### 💵 Retrieve Earnings
- Upon completing the delivery, players can retrieve their earnings by typing the `/cocaine` command. This will display the total cocaine collected and the player's earned XP.

---

## 🎮 Example Commands
- **/cocainetruck**: Start the **Cocaintruck** delivery job.
- **/cocaine**: View your earnings and stats related to the delivery job.

---

## 🚀 Contributors

- **AitLilCat**: Lead developer and maintainer of the **QB-Cocaintruck** script.
- **Contributors**: Thanks to the community for their feedback and suggestions!
