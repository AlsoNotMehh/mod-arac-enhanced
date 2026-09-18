# ![logo](https://raw.githubusercontent.com/azerothcore/azerothcore.github.io/master/images/logo-github.png) AzerothCore Module: mod-arac-enhanced

[![AzerothCore Module](https://img.shields.io/badge/AzerothCore-Module-red?style=flat-square&logo=github)](https://github.com/azerothcore/azerothcore-wotlk)
[![C++20](https://img.shields.io/badge/Language-C++20-00599C?style=flat-square&logo=c%2B%2B)](https://isocpp.org/)
[![Branch 3.3.5a](https://img.shields.io/badge/Branch-3.3.5a-orange?style=flat-square)](https://github.com/azerothcore/azerothcore-wotlk)
[![License MIT](https://img.shields.io/badge/License-MIT-blue?style=flat-square)](LICENSE)
[![GitHub Stars](https://img.shields.io/github/stars/AlsoNotMehh/mod-arac-enhanced?style=flat-square&color=yellow&logo=github)](https://github.com/AlsoNotMehh/mod-arac-enhanced/stargazers)

An enhanced **All Races All Classes (ARAC)** system for **AzerothCore (WotLK 3.3.5a)** featuring granular combination control, lore-friendly default expansions, complete starter data seeding, and included client MPQ patch.

### 💡 Why this module? (The Main Difference)
The biggest limitation of the original / legacy ARAC module is that it is strictly **all-or-nothing**: installing it forces all 100 race/class combinations onto your realm simultaneously, with zero control to disable combinations that break your server's lore or vision (such as Gnome Druids or Tauren Rogues).

**`mod-arac-enhanced` completely fixes this:**
- **Granular Enable / Disable Control:** You have full control in `arac_enhanced.conf` to toggle **any individual combination on (`1`) or off (`0`)** without needing to edit DBC files or recompile code.
- **Curated Lore Defaults:** Comes pre-configured out of the box with natural, lore-aligned combinations enabled (like Human Hunters, Tauren Paladins/Priests, Dwarf Shamans, Undead Paladins, and Night Elf Mages), while keeping unconventional combinations disabled by default.
- **Server-Side Validation:** The server actively validates character creation requests against your active configuration matrix, instantly blocking any disabled combination.
- **Ready-to-Use Client Patch:** Includes pre-packaged `client-patch/Patch-A.MPQ` that unmasks class buttons and provides 3D preview models on the character creation screen.

## 📊 Feature Comparison

| Feature | Legacy ARAC | mod-arac-enhanced |
| :--- | :---: | :---: |
| **Combination Control** | ❌ All-or-nothing (forced 100 combos) | ✅ **Granular per-combination toggles (enable/disable any combo)** |
| **Default Balance** | ⚠️ Unfiltered chaos (all combos forced) | ✅ **Curated lore-friendly combinations enabled by default** |
| **Configuration Customization** | ❌ No config file (hardcoded) | ✅ **Clean `arac_enhanced.conf` with 1/0 switches for every combo** |
| **Starter Data Integration** | ⚠️ Often missing starter items/bars | ✅ **Complete starter gear, spells, stats, and action bars** |
| **Server-Side Security** | ❌ None (vulnerable to packet injection) | ✅ **Strict server validation prevents creating disabled combos** |
| **Client Patch Included** | ⚠️ Must build or search manually | ✅ **Included pre-compiled `Patch-A.MPQ` and raw DBC files** |

## 🚀 How It Works (Complete Workflow)

The module synchronizes both server validation and client display seamlessly:

1. **Configure Your Realm:** In `arac_enhanced.conf`, toggle any combination on (`1`) or off (`0`), or set `ARAC.AllowAll = 1` for everything.
2. **Build the Client Patch:** Run `tools/build_patch.bat` (or `node tools/build_dbc.js`). It reads your configuration, compiles `CharBaseInfo.dbc`, and generates `Patch-A.MPQ` matching your exact settings.
3. **Distribute to Players:** Place `Patch-A.MPQ` in the client `Data/` folder. The client character creation screen dynamically activates buttons and 3D preview models only for allowed combinations.
4. **Server Enforces Rules:** When a player clicks "Create Character", the server hook (`AccountScript::CanAccountCreateCharacter`) checks your configuration matrix. If a player attempts to create a disabled combination (using an old patch or packet injection), the server immediately blocks it and returns `CHAR_CREATE_DISABLED`.
5. **Clean Database:** SQL files run in order (`00_arac_cleanup_rogue_races.sql` -> `01_arac_starter_data.sql` -> `02_arac_totems_and_spells.sql`), ensuring zero console errors on server startup.


## 🌟 Curated Lore Defaults (Enabled Out of the Box)

These combinations are enabled by default (`= 1`) because they naturally align with Warcraft lore and expansion class progressions:

### 🛡️ Alliance
- **Humano:** Cazador *(Human Hunter)*
- **Enano:** Chamán, Mago, Brujo *(Dwarf Shaman, Mage, Warlock)*
- **Elfo de la Noche:** Mago, Brujo *(Night Elf Mage, Warlock)*
- **Gnomo:** Sacerdote, Cazador *(Gnome Priest, Hunter)*
- **Draenei:** Brujo *(Draenei Warlock)*

### ⚔️ Horde
- **Orco:** Mago *(Orc Mage)*
- **No-muerto:** Cazador, Paladín *(Undead Hunter, Paladin)*
- **Tauren:** Paladín *(Caminasol / Sunwalker)*, Sacerdote *(Vidente / Seer)*
- **Troll:** Brujo, Druida *(Troll Warlock, Druid)*
- **Elfo de Sangre:** Guerrero *(Blood Elf Warrior)*

*(Any combination can be individually enabled or disabled in `arac_enhanced.conf`)*.

## 💾 Client Patch & Server DBC Installation

### 1. Server Data Files (Important for Starter Gear)
For newly created characters to enter the world with their starter clothes, shirts, pants, boots, and starter weapons:
1. Copy the DBC files from `client-patch/patch-contents/DBFilesClient/` into your server's `data/dbc/` folder:
   - `CharStartOutfit.dbc`
   - `CharBaseInfo.dbc`
   - `SkillRaceClassInfo.dbc`
*(Note: running `node tools/build_dbc.js` will automatically sync these files into your server's `data/dbc/` folder if detected).*

### 2. Client Patch Installation
To see all race/class buttons and 3D preview models on the character creation screen:

1. Copy the generated patch into your **World of Warcraft 3.3.5a client directory**:
   - For standard or custom/HD clients, place it inside your locale folder at highest priority:
   ```text
   WoW-Directory/Data/enUS/patch-enUS-Z.MPQ
   ```
   *(Or your respective locale, e.g. `Data/esES/patch-esES-Z.MPQ`).*
   
   - Or place in base `Data/`:
   ```text
   WoW-Directory/Data/Patch-A.MPQ
   ```

2. **Why `patch-enUS-Z.MPQ`?** In WoW 3.3.5a, files in `Data/<locale>/` take precedence over base `Data/`, and patches load alphabetically. If you use HD repacks that contain patches like `patch-enUS-M.MPQ` or `patch-Z.MPQ`, naming your patch `patch-enUS-Z.MPQ` in the locale directory guarantees your custom combinations take highest priority.

3. Clear your client `Cache/WDB` folder if you previously opened character creation.

4. Start the game client. When creating characters, all enabled combinations will show proper 3D models and spawn with their full starter gear and weapons.

## 🔄 Rebuilding the Client Patch from Configuration

Whenever you modify `arac_enhanced.conf` to enable or disable specific combinations, you can sync the client patch:

1. Run the build tool from the module directory:
   - On Windows: double-click `tools/build_patch.bat` or run:
     ```bash
     node tools/build_dbc.js
     ```
   - With custom patch name or output directory:
     ```bash
     node tools/build_dbc.js --patch-name=patch-enUS-Z.MPQ --output="C:/Games/WoW 3.3.5a/Data/enUS"
     ```
2. The tool reads your active `arac_enhanced.conf`, compiles a clean binary `CharBaseInfo.dbc`, automatically syncs the server `data/dbc/` files, and generates a valid MPQ archive using StormLib.

## 📋 Configuration Reference (`arac_enhanced.conf`)

| Setting | Default | Description |
| :--- | :---: | :--- |
| `ARAC.Enable` | `1` | Master switch for the ARAC Enhanced module. |
| `ARAC.AllowAll` | `0` | Master toggle to force-unlock all 100 combinations if desired. |
| `ARAC.Human.Hunter` | `1` | Enable or disable Human Hunter. |
| `ARAC.Human.Druid` | `0` | Enable or disable Human Druid. |
| `ARAC.Dwarf.Shaman` | `1` | Enable or disable Dwarf Shaman. |
| `ARAC.Dwarf.Mage` | `1` | Enable or disable Dwarf Mage. |
| `ARAC.Dwarf.Warlock` | `1` | Enable or disable Dwarf Warlock. |
| `ARAC.NightElf.Mage` | `1` | Enable or disable Night Elf Mage. |
| `ARAC.NightElf.Warlock` | `1` | Enable or disable Night Elf Warlock. |
| `ARAC.Gnome.Priest` | `1` | Enable or disable Gnome Priest. |
| `ARAC.Gnome.Hunter` | `1` | Enable or disable Gnome Hunter. |
| `ARAC.Draenei.Warlock` | `1` | Enable or disable Draenei Warlock. |
| `ARAC.Orc.Mage` | `1` | Enable or disable Orc Mage. |
| `ARAC.Undead.Hunter` | `1` | Enable or disable Undead Hunter. |
| `ARAC.Undead.Paladin` | `1` | Enable or disable Undead Paladin. |
| `ARAC.Tauren.Paladin` | `1` | Enable or disable Tauren Paladin. |
| `ARAC.Tauren.Priest` | `1` | Enable or disable Tauren Priest. |
| `ARAC.Troll.Warlock` | `1` | Enable or disable Troll Warlock. |
| `ARAC.Troll.Druid` | `1` | Enable or disable Troll Druid. |
| `ARAC.BloodElf.Warrior` | `1` | Enable or disable Blood Elf Warrior. |

## 🛠️ Server Installation

1. Place the module in `azerothcore-wotlk/modules/`:
   ```bash
   cd azerothcore-wotlk/modules
   git clone https://github.com/AlsoNotMehh/mod-arac-enhanced.git
   ```
2. Re-run CMake and compile your server:
   ```bash
   cmake -B build
   cmake --build build --config Release
   ```
3. Import the SQL files from `data/sql/db-world/` into your `acore_world` database (executed automatically by AzerothCore database updater).
4. Copy `conf/arac_enhanced.conf.dist` to your `worldserver` configs directory as `arac_enhanced.conf` and customize which combinations you want active.

## ❓ Frequently Asked Questions

### Can I rename Patch-A.MPQ if I already have one?
Yes. If your client already has a large `patch-a.mpq`, simply rename this module's file to `Patch-B.MPQ` or `patch-5.mpq`. WoW 3.3.5a automatically loads patches alphabetically and numerically. Higher letters/numbers take precedence, so `Patch-B.MPQ` will apply on top of `patch-a.mpq` without needing to merge files.

### Fixing "Wrong race 13" or "Wrong race mask 4096" console warnings
If you see console warnings about race 13 or raceMask 4096 on startup, run `data/sql/db-world/00_arac_cleanup_rogue_races.sql` on your `acore_world` database. This cleans any leftover custom race data from previous imports.

## ⭐ Show your support

If you find this module helpful for your server, please consider giving it a star on GitHub! It helps more developers in the AzerothCore community discover the project.

## 🤝 Credits

- **Author & Enhancements:** [AlsoNotMehh](https://github.com/AlsoNotMehh) ([Discord](https://discord.com/users/1063304041419001966) / [Email](mailto:itsbrayanrodriguez@gmail.com))
- **Base ARAC Inspiration:** [heyitsbench](https://github.com/heyitsbench/mod-arac)
- **Framework:** [AzerothCore](https://www.azerothcore.org)

## 📜 License

This project is licensed under the [MIT License](LICENSE).
