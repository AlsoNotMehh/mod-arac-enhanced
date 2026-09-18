#include "ARACEnhanced.h"
#include "ScriptMgr.h"
#include "Config.h"
#include "Player.h"
#include "World.h"
#include "Log.h"
#include "AccountScript.h"

ARACEnhanced* ARACEnhanced::instance()
{
    static ARACEnhanced inst;
    return &inst;
}

bool ARACEnhanced::IsNativeCombination(uint8 race, uint8 playerClass) const
{
    switch (race)
    {
        case RACE_HUMAN:
            return (playerClass == CLASS_WARRIOR || playerClass == CLASS_PALADIN || playerClass == CLASS_ROGUE ||
                    playerClass == CLASS_PRIEST || playerClass == CLASS_DEATH_KNIGHT || playerClass == CLASS_MAGE ||
                    playerClass == CLASS_WARLOCK);
        case RACE_ORC:
            return (playerClass == CLASS_WARRIOR || playerClass == CLASS_HUNTER || playerClass == CLASS_ROGUE ||
                    playerClass == CLASS_DEATH_KNIGHT || playerClass == CLASS_SHAMAN || playerClass == CLASS_WARLOCK);
        case RACE_DWARF:
            return (playerClass == CLASS_WARRIOR || playerClass == CLASS_PALADIN || playerClass == CLASS_HUNTER ||
                    playerClass == CLASS_ROGUE || playerClass == CLASS_PRIEST || playerClass == CLASS_DEATH_KNIGHT);
        case RACE_NIGHTELF:
            return (playerClass == CLASS_WARRIOR || playerClass == CLASS_HUNTER || playerClass == CLASS_ROGUE ||
                    playerClass == CLASS_PRIEST || playerClass == CLASS_DEATH_KNIGHT || playerClass == CLASS_DRUID);
        case RACE_UNDEAD_PLAYER:
            return (playerClass == CLASS_WARRIOR || playerClass == CLASS_ROGUE || playerClass == CLASS_PRIEST ||
                    playerClass == CLASS_DEATH_KNIGHT || playerClass == CLASS_MAGE || playerClass == CLASS_WARLOCK);
        case RACE_TAUREN:
            return (playerClass == CLASS_WARRIOR || playerClass == CLASS_HUNTER || playerClass == CLASS_DEATH_KNIGHT ||
                    playerClass == CLASS_SHAMAN || playerClass == CLASS_DRUID);
        case RACE_GNOME:
            return (playerClass == CLASS_WARRIOR || playerClass == CLASS_ROGUE || playerClass == CLASS_DEATH_KNIGHT ||
                    playerClass == CLASS_MAGE || playerClass == CLASS_WARLOCK);
        case RACE_TROLL:
            return (playerClass == CLASS_WARRIOR || playerClass == CLASS_HUNTER || playerClass == CLASS_ROGUE ||
                    playerClass == CLASS_PRIEST || playerClass == CLASS_DEATH_KNIGHT || playerClass == CLASS_SHAMAN ||
                    playerClass == CLASS_MAGE);
        case RACE_BLOODELF:
            return (playerClass == CLASS_PALADIN || playerClass == CLASS_HUNTER || playerClass == CLASS_ROGUE ||
                    playerClass == CLASS_PRIEST || playerClass == CLASS_DEATH_KNIGHT || playerClass == CLASS_MAGE ||
                    playerClass == CLASS_WARLOCK);
        case RACE_DRAENEI:
            return (playerClass == CLASS_WARRIOR || playerClass == CLASS_PALADIN || playerClass == CLASS_HUNTER ||
                    playerClass == CLASS_PRIEST || playerClass == CLASS_DEATH_KNIGHT || playerClass == CLASS_SHAMAN ||
                    playerClass == CLASS_MAGE);
        default:
            return false;
    }
}

bool ARACEnhanced::IsCuratedCombination(uint8 race, uint8 playerClass) const
{
    switch (race)
    {
        case RACE_HUMAN:
            return (playerClass == CLASS_HUNTER);
        case RACE_DWARF:
            return (playerClass == CLASS_SHAMAN || playerClass == CLASS_MAGE || playerClass == CLASS_WARLOCK);
        case RACE_NIGHTELF:
            return (playerClass == CLASS_MAGE || playerClass == CLASS_WARLOCK);
        case RACE_GNOME:
            return (playerClass == CLASS_PRIEST || playerClass == CLASS_HUNTER);
        case RACE_DRAENEI:
            return (playerClass == CLASS_WARLOCK);
        case RACE_ORC:
            return (playerClass == CLASS_MAGE);
        case RACE_UNDEAD_PLAYER:
            return (playerClass == CLASS_HUNTER || playerClass == CLASS_PALADIN);
        case RACE_TAUREN:
            return (playerClass == CLASS_PALADIN || playerClass == CLASS_PRIEST);
        case RACE_TROLL:
            return (playerClass == CLASS_WARLOCK || playerClass == CLASS_DRUID);
        case RACE_BLOODELF:
            return (playerClass == CLASS_WARRIOR);
        default:
            return false;
    }
}

void ARACEnhanced::LoadConfig()
{
    _enabled = sConfigMgr->GetOption<bool>("ARAC.Enable", true, false);
    _allowAll = sConfigMgr->GetOption<bool>("ARAC.AllowAll", false, false);
    _allowedMatrix.clear();

    if (!_enabled)
        return;

    struct RaceClassMeta {
        uint8 id;
        std::string name;
    };

    static const RaceClassMeta races[] = {
        { RACE_HUMAN, "Human" },
        { RACE_ORC, "Orc" },
        { RACE_DWARF, "Dwarf" },
        { RACE_NIGHTELF, "NightElf" },
        { RACE_UNDEAD_PLAYER, "Undead" },
        { RACE_TAUREN, "Tauren" },
        { RACE_GNOME, "Gnome" },
        { RACE_TROLL, "Troll" },
        { RACE_BLOODELF, "BloodElf" },
        { RACE_DRAENEI, "Draenei" }
    };

    static const RaceClassMeta classes[] = {
        { CLASS_WARRIOR, "Warrior" },
        { CLASS_PALADIN, "Paladin" },
        { CLASS_HUNTER, "Hunter" },
        { CLASS_ROGUE, "Rogue" },
        { CLASS_PRIEST, "Priest" },
        { CLASS_DEATH_KNIGHT, "DeathKnight" },
        { CLASS_SHAMAN, "Shaman" },
        { CLASS_MAGE, "Mage" },
        { CLASS_WARLOCK, "Warlock" },
        { CLASS_DRUID, "Druid" }
    };

    uint32 activeCustomCount = 0;
    for (const auto& r : races)
    {
        for (const auto& c : classes)
        {
            bool isNative = IsNativeCombination(r.id, c.id);
            bool isCurated = IsCuratedCombination(r.id, c.id);
            bool defaultVal = isNative || isCurated;

            std::string configKey = "ARAC." + r.name + "." + c.name;
            bool allowed = _allowAll || sConfigMgr->GetOption<bool>(configKey, defaultVal, false);

            _allowedMatrix[MakeKey(r.id, c.id)] = allowed;

            if (allowed && !isNative)
                activeCustomCount++;
        }
    }

    LOG_INFO("module", "[ARAC-Enhanced] Config loaded. Active non-native combinations allowed: {}", activeCustomCount);
}

bool ARACEnhanced::IsCombinationAllowed(uint8 race, uint8 playerClass) const
{
    if (!_enabled)
        return IsNativeCombination(race, playerClass);

    if (_allowAll)
        return true;

    auto it = _allowedMatrix.find(MakeKey(race, playerClass));
    if (it != _allowedMatrix.end())
        return it->second;

    return IsNativeCombination(race, playerClass);
}

class ARACEnhanced_WorldScript : public WorldScript
{
public:
    ARACEnhanced_WorldScript() : WorldScript("ARACEnhanced_WorldScript") { }

    void OnAfterConfigLoad(bool /*reload*/) override
    {
        sARACEnhanced->LoadConfig();
    }
};

class ARACEnhanced_PlayerScript : public PlayerScript
{
public:
    ARACEnhanced_PlayerScript() : PlayerScript("ARACEnhanced_PlayerScript") { }

    void OnPlayerLogin(Player* player) override
    {
        if (!player)
            return;

        uint8 race = player->getRace();
        uint8 playerClass = player->getClass();

        if (!sARACEnhanced->IsCombinationAllowed(race, playerClass))
        {
            LOG_WARN("module", "[ARAC-Enhanced] Player {} logged in with disabled race/class combo ({}/{})",
                player->GetName(), race, playerClass);
        }
    }
};

class ARACEnhanced_AccountScript : public AccountScript
{
public:
    ARACEnhanced_AccountScript() : AccountScript("ARACEnhanced_AccountScript", { ACCOUNTHOOK_CAN_ACCOUNT_CREATE_CHARACTER }) { }

    bool CanAccountCreateCharacter(uint32 accountId, uint8 charRace, uint8 charClass) override
    {
        if (!sARACEnhanced->IsCombinationAllowed(charRace, charClass))
        {
            LOG_WARN("module", "[ARAC-Enhanced] Blocked character creation for Account {} with disabled combination: Race {}, Class {}",
                accountId, charRace, charClass);
            return false;
        }

        return true;
    }
};

void Addmod_arac_enhancedScripts()
{
    new ARACEnhanced_WorldScript();
    new ARACEnhanced_PlayerScript();
    new ARACEnhanced_AccountScript();
}
