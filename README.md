# Game Analytics - Delivery 1

Group project (3 people) for the Game Analytics subject at CITM-UPC. A Unity simulator creates fake players, sessions and purchases and sends them to a PHP server, which stores them in a MySQL database. SQL queries then turn that data into KPIs, and an Excel file shows them as tables and charts.

My part: the Unity client and the PHP server scripts, the database schema, the KPI queries and the Excel charts.

## What is in the repository

| Folder | Contents |
|---|---|
| `Delivery1_Simulator/` | Unity 6000.2.9f1 project with the simulator. |
| `server/` | PHP scripts that receive the events and write them to the database. |
| `Database/schema.sql` | Tables `User`, `SessionUser`, `Purchases` and `Item`, with their foreign keys. |
| `Queries/` | One SQL file per KPI. |
| `Excel/KPIs_Delivery1.xlsx` | KPI tables and charts made from the query results. |

## How it works

- `Simulator.cs` creates up to 100 players with a random name, country, age and gender, starting on a random day of 2022. During each session a player has a 10% chance of buying one of five items, with the cheap ones much more likely. After a session the player comes back with a 70% chance before June and 95% from June on, until the end of 2022. Then the simulator moves on to the next player.
- `AnalyticsTracker.cs` listens to the simulator events and sends each one to the server with `UnityWebRequest`: `add_user.php`, `add_session.php`, `add_purchase.php` and `end_session.php`. The server answers with the new row ID, and the simulator uses it for the next event, so every session and purchase points to a real user and session in the database.
- `seed_items.php` fills the `Item` table with the five prices (0.99, 1.99, 9.99, 49.99 and 99.99).

## KPIs

DAU, MAU, stickiness, D1/D3/D7 retention, ARPU and ARPPU, sessions per user and session length, and players by age and gender.

## Running it

1. Create a MySQL or MariaDB database and import `Database/schema.sql`.
2. Copy the files in `server/` to a PHP server and write your database name, user and password in `db.php`.
3. Open `seed_items.php` in the browser once to fill the `Item` table.
4. Open `Delivery1_Simulator` with Unity 6000.2.9f1 and open `Assets/Scenes/SampleScene.unity`.
5. Select the `Simulator` object and set **Server Url** in the `AnalyticsTracker` component to the URL of the folder with the PHP files, ending in `/`.
6. Press Play. The simulator fills the database while it runs.
7. Run the files in `Queries/` against the database.

The names come from the Lexic name generator asset (`Assets/Lexic`).
