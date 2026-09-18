#ifndef _ARAC_ENHANCED_H_
#define _ARAC_ENHANCED_H_

#include "Common.h"
#include "SharedDefines.h"
#include <unordered_map>

class ARACEnhanced
{
public:
    static ARACEnhanced* instance();

    void LoadConfig();
    bool IsCombinationAllowed(uint8 race, uint8 playerClass) const;
    bool IsNativeCombination(uint8 race, uint8 playerClass) const;
    bool IsCuratedCombination(uint8 race, uint8 playerClass) const;

private:
    ARACEnhanced() = default;

    bool _enabled = true;
    bool _allowAll = false;
    std::unordered_map<uint32, bool> _allowedMatrix;

    static uint32 MakeKey(uint8 race, uint8 playerClass)
    {
        return (uint32(race) << 8) | uint32(playerClass);
    }
};

#define sARACEnhanced ARACEnhanced::instance()

#endif // _ARAC_ENHANCED_H_
