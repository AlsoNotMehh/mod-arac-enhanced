const fs = require('fs');
const path = require('path');

// Blizzard MPQ Crypt Table
const cryptTable = new Uint32Array(0x500);
let seed = 0x00100001;
for (let index1 = 0; index1 < 0x100; index1++) {
  let index2 = index1;
  for (let i = 0; i < 5; i++, index2 += 0x100) {
    seed = (seed * 125 + 3) % 0x2AAAAB;
    let temp1 = (seed & 0xFFFF) << 0x10;
    seed = (seed * 125 + 3) % 0x2AAAAB;
    let temp2 = (seed & 0xFFFF);
    cryptTable[index2] = (temp1 | temp2) >>> 0;
  }
}

function HashString(str, hashType) {
  let seed1 = 0x7FED7FED;
  let seed2 = 0xEEEEEEEE;
  str = str.toUpperCase();
  for (let i = 0; i < str.length; i++) {
    const ch = str.charCodeAt(i);
    const value = cryptTable[(hashType << 8) + ch];
    seed1 = (value ^ (seed1 + seed2)) >>> 0;
    seed2 = (ch + seed1 + seed2 + (seed2 << 5) + 3) >>> 0;
  }
  return seed1 >>> 0;
}

function EncryptBlock(buf, key) {
  let seed = 0xEEEEEEEE;
  for (let i = 0; i < buf.length; i += 4) {
    seed = (seed + cryptTable[0x400 + (key & 0xFF)]) >>> 0;
    let ch = buf.readUInt32LE(i);
    ch = (ch ^ (key + seed)) >>> 0;
    key = (((~key << 0x15) + 0x11111111) | (key >>> 0x0B)) >>> 0;
    seed = (ch + seed + (seed << 5) + 3) >>> 0;
    buf.writeUInt32LE(ch >>> 0, i);
  }
}

function createMpqArchive(fileEntries) {
  const listfileContent = fileEntries.map(e => e.filename).join('\r\n') + '\r\n';
  const allEntries = [
    ...fileEntries,
    { filename: '(listfile)', data: Buffer.from(listfileContent, 'utf8') }
  ];

  const headerSize = 32;
  const hashSize = 64;
  
  const fileBlocks = [];
  let currentFilePos = headerSize;

  for (const entry of allEntries) {
    const uncompressedSize = entry.data.length;
    const compressedData = entry.data;
    const flags = 0x80000200;

    fileBlocks.push({
      filename: entry.filename,
      filePos: currentFilePos,
      compressedSize: compressedData.length,
      uncompressedSize: uncompressedSize,
      flags: flags,
      data: compressedData
    });

    currentFilePos += compressedData.length;
  }

  const hashPos = currentFilePos;
  const hashBuf = Buffer.alloc(hashSize * 16);
  hashBuf.fill(0xFF);

  const blockPos = hashPos + (hashSize * 16);
  const blockBuf = Buffer.alloc(fileBlocks.length * 16);

  for (let blockIndex = 0; blockIndex < fileBlocks.length; blockIndex++) {
    const fb = fileBlocks[blockIndex];
    const hashIndex = HashString(fb.filename, 0) & (hashSize - 1);
    const hashA = HashString(fb.filename, 1);
    const hashB = HashString(fb.filename, 2);

    let targetIndex = hashIndex;
    while (hashBuf.readUInt32LE(targetIndex * 16 + 12) !== 0xFFFFFFFF) {
      targetIndex = (targetIndex + 1) & (hashSize - 1);
    }

    hashBuf.writeUInt32LE(hashA, targetIndex * 16);
    hashBuf.writeUInt32LE(hashB, targetIndex * 16 + 4);
    hashBuf.writeUInt16LE(0, targetIndex * 16 + 8);
    hashBuf.writeUInt16LE(0, targetIndex * 16 + 10);
    hashBuf.writeUInt32LE(blockIndex, targetIndex * 16 + 12);

    blockBuf.writeUInt32LE(fb.filePos, blockIndex * 16);
    blockBuf.writeUInt32LE(fb.compressedSize, blockIndex * 16 + 4);
    blockBuf.writeUInt32LE(fb.uncompressedSize, blockIndex * 16 + 8);
    blockBuf.writeUInt32LE(fb.flags, blockIndex * 16 + 12);
  }

  const hashKey = HashString('(hash table)', 3);
  const blockKey = HashString('(block table)', 3);

  EncryptBlock(hashBuf, hashKey);
  EncryptBlock(blockBuf, blockKey);

  const archiveSize = blockPos + (fileBlocks.length * 16);
  const headerBuf = Buffer.alloc(32);
  headerBuf.write('MPQ\x1A', 0, 4, 'ascii');
  headerBuf.writeUInt32LE(32, 4);
  headerBuf.writeUInt32LE(archiveSize, 8);
  headerBuf.writeUInt16LE(0, 12);
  headerBuf.writeUInt16LE(3, 14);
  headerBuf.writeUInt32LE(hashPos, 16);
  headerBuf.writeUInt32LE(blockPos, 20);
  headerBuf.writeUInt32LE(hashSize, 24);
  headerBuf.writeUInt32LE(fileBlocks.length, 28);

  return Buffer.concat([
    headerBuf,
    ...fileBlocks.map(f => f.data),
    hashBuf,
    blockBuf
  ]);
}

// Base standard WotLK combinations (62 combos)
const baseCombos = [
  // Human (1)
  { race: 1, cls: 1 }, { race: 1, cls: 2 }, { race: 1, cls: 4 }, { race: 1, cls: 5 }, { race: 1, cls: 6 }, { race: 1, cls: 8 }, { race: 1, cls: 9 },
  // Orc (2)
  { race: 2, cls: 1 }, { race: 2, cls: 3 }, { race: 2, cls: 4 }, { race: 2, cls: 6 }, { race: 2, cls: 7 }, { race: 2, cls: 9 },
  // Dwarf (3)
  { race: 3, cls: 1 }, { race: 3, cls: 2 }, { race: 3, cls: 3 }, { race: 3, cls: 4 }, { race: 3, cls: 5 }, { race: 3, cls: 6 },
  // NightElf (4)
  { race: 4, cls: 1 }, { race: 4, cls: 3 }, { race: 4, cls: 4 }, { race: 4, cls: 5 }, { race: 4, cls: 6 }, { race: 4, cls: 11 },
  // Undead (5)
  { race: 5, cls: 1 }, { race: 5, cls: 4 }, { race: 5, cls: 5 }, { race: 5, cls: 6 }, { race: 5, cls: 8 }, { race: 5, cls: 9 },
  // Tauren (6)
  { race: 6, cls: 1 }, { race: 6, cls: 3 }, { race: 6, cls: 6 }, { race: 6, cls: 7 }, { race: 6, cls: 11 },
  // Gnome (7)
  { race: 7, cls: 1 }, { race: 7, cls: 4 }, { race: 7, cls: 6 }, { race: 7, cls: 8 }, { race: 7, cls: 9 },
  // Troll (8)
  { race: 8, cls: 1 }, { race: 8, cls: 3 }, { race: 8, cls: 4 }, { race: 8, cls: 5 }, { race: 8, cls: 6 }, { race: 8, cls: 7 }, { race: 8, cls: 8 },
  // BloodElf (10)
  { race: 10, cls: 2 }, { race: 10, cls: 3 }, { race: 10, cls: 4 }, { race: 10, cls: 5 }, { race: 10, cls: 6 }, { race: 10, cls: 8 }, { race: 10, cls: 9 },
  // Draenei (11)
  { race: 11, cls: 1 }, { race: 11, cls: 2 }, { race: 11, cls: 3 }, { race: 11, cls: 5 }, { race: 11, cls: 6 }, { race: 11, cls: 7 }, { race: 11, cls: 8 }
];

const raceMap = {
  human: 1, orc: 2, dwarf: 3, nightelf: 4, undead: 5, tauren: 6, gnome: 7, troll: 8, bloodelf: 10, draenei: 11
};

const raceNames = {
  1: 'Human', 2: 'Orc', 3: 'Dwarf', 4: 'NightElf', 5: 'Undead', 6: 'Tauren', 7: 'Gnome', 8: 'Troll', 10: 'BloodElf', 11: 'Draenei'
};

const classMap = {
  warrior: 1, paladin: 2, hunter: 3, rogue: 4, priest: 5, deathknight: 6, shaman: 7, mage: 8, warlock: 9, druid: 11
};

const classNames = {
  1: 'Warrior', 2: 'Paladin', 3: 'Hunter', 4: 'Rogue', 5: 'Priest', 6: 'DeathKnight', 7: 'Shaman', 8: 'Mage', 9: 'Warlock', 11: 'Druid'
};

// Module root path relative to this script
const moduleRoot = path.resolve(__dirname, '..');

// Curated lore-friendly combinations (enabled by default)
const curatedCombos = [
  { race: 1, cls: 3 },  // Human Hunter
  { race: 3, cls: 7 },  // Dwarf Shaman
  { race: 3, cls: 8 },  // Dwarf Mage
  { race: 3, cls: 9 },  // Dwarf Warlock
  { race: 4, cls: 8 },  // NightElf Mage
  { race: 4, cls: 9 },  // NightElf Warlock
  { race: 7, cls: 5 },  // Gnome Priest
  { race: 7, cls: 3 },  // Gnome Hunter
  { race: 11, cls: 9 }, // Draenei Warlock
  { race: 2, cls: 8 },  // Orc Mage
  { race: 5, cls: 3 },  // Undead Hunter
  { race: 5, cls: 2 },  // Undead Paladin
  { race: 6, cls: 2 },  // Tauren Paladin
  { race: 6, cls: 5 },  // Tauren Priest
  { race: 8, cls: 9 },  // Troll Warlock
  { race: 8, cls: 11 }, // Troll Druid
  { race: 10, cls: 1 }  // BloodElf Warrior
];

// Parse CLI arguments
let customConfig = null;
let customOutputDir = null;
let patchName = 'patch-enUS-Z.MPQ';

for (let i = 2; i < process.argv.length; i++) {
  const arg = process.argv[i];
  if (arg.startsWith('--config=')) {
    customConfig = arg.split('=')[1];
  } else if (arg.startsWith('--output=') || arg.startsWith('--dest=')) {
    customOutputDir = arg.split('=')[1];
  } else if (arg.startsWith('--patch-name=') || arg.startsWith('--name=')) {
    patchName = arg.split('=')[1];
  } else if (!customConfig && (arg.endsWith('.conf') || arg.endsWith('.dist'))) {
    customConfig = arg;
  } else if (!customOutputDir && fs.existsSync(arg) && fs.statSync(arg).isDirectory()) {
    customOutputDir = arg;
  }
}

// Locate active configuration
const confCandidates = [
  customConfig,
  path.resolve(moduleRoot, '../../../build/bin/Release/configs/modules/arac_enhanced.conf'),
  path.resolve(moduleRoot, '../../../build/bin/RelWithDebInfo/configs/modules/arac_enhanced.conf'),
  path.resolve(moduleRoot, '../../../bin/Release/configs/modules/arac_enhanced.conf'),
  path.resolve(moduleRoot, '../../../bin/RelWithDebInfo/configs/modules/arac_enhanced.conf'),
  path.resolve(moduleRoot, '../../../configs/modules/arac_enhanced.conf'),
  path.resolve(moduleRoot, '../../build/bin/Release/configs/modules/arac_enhanced.conf'),
  path.resolve(moduleRoot, '../../build/bin/RelWithDebInfo/configs/modules/arac_enhanced.conf'),
  path.resolve(moduleRoot, '../../bin/Release/configs/modules/arac_enhanced.conf'),
  path.resolve(moduleRoot, '../../bin/RelWithDebInfo/configs/modules/arac_enhanced.conf'),
  path.resolve(moduleRoot, '../../configs/modules/arac_enhanced.conf'),
  path.resolve(moduleRoot, 'conf/arac_enhanced.conf'),
  path.resolve(moduleRoot, 'conf/arac_enhanced.conf.dist')
].filter(Boolean);

let confPath = confCandidates.find(p => fs.existsSync(p));
if (!confPath) {
  confPath = path.resolve(moduleRoot, 'conf/arac_enhanced.conf.dist');
}

console.log('Reading ARAC configuration from:', confPath);
const confContent = fs.existsSync(confPath) ? fs.readFileSync(confPath, 'utf8') : '';

const activeCombos = new Map();

// Insert standard base combos
for (const c of baseCombos) {
  activeCombos.set(`${c.race}-${c.cls}`, { race: c.race, cls: c.cls });
}

// Insert curated combos
for (const c of curatedCombos) {
  activeCombos.set(`${c.race}-${c.cls}`, { race: c.race, cls: c.cls });
}

// Parse config options
let allowAll = false;
const lines = confContent.split('\n');
for (const line of lines) {
  const clean = line.trim();
  if (!clean || clean.startsWith('#')) continue;

  const matchAllowAll = clean.match(/^ARAC\.AllowAll\s*=\s*(\d+)/i);
  if (matchAllowAll && matchAllowAll[1] === '1') {
    allowAll = true;
  }

  const match = clean.match(/^ARAC\.([A-Za-z]+)\.([A-Za-z]+)\s*=\s*(\d+)/i);
  if (match) {
    const raceName = match[1].toLowerCase();
    const className = match[2].toLowerCase();
    const enabled = match[3] === '1';

    const raceId = raceMap[raceName];
    const classId = classMap[className];

    if (raceId && classId) {
      const key = `${raceId}-${classId}`;
      if (enabled) {
        activeCombos.set(key, { race: raceId, cls: classId });
      } else {
        activeCombos.delete(key);
      }
    }
  }
}

if (allowAll) {
  console.log('ARAC.AllowAll = 1 (Enabling all 100 combinations)');
  for (const rId of Object.values(raceMap)) {
    for (const cId of Object.values(classMap)) {
      activeCombos.set(`${rId}-${cId}`, { race: rId, cls: cId });
    }
  }
}

const finalRecords = Array.from(activeCombos.values()).sort((a, b) => {
  if (a.race !== b.race) return a.race - b.race;
  return a.cls - b.cls;
});

console.log(`\nActive Configured Combinations (${finalRecords.length} enabled in client DBC):`);
let currentRace = 0;
for (const rec of finalRecords) {
  if (rec.race !== currentRace) {
    currentRace = rec.race;
    process.stdout.write(`\n  [${raceNames[rec.race]}]: `);
  }
  process.stdout.write(`${classNames[rec.cls]} `);
}
console.log('\n');

// Build CharBaseInfo.dbc
const recordCount = finalRecords.length;
const fieldCount = 2;
const recordSize = 2;
const stringBlockSize = 1;

const dbcSize = 20 + (recordCount * recordSize) + stringBlockSize;
const charBaseBuf = Buffer.alloc(dbcSize);

charBaseBuf.write('WDBC', 0, 4, 'utf8');
charBaseBuf.writeUInt32LE(recordCount, 4);
charBaseBuf.writeUInt32LE(fieldCount, 8);
charBaseBuf.writeUInt32LE(recordSize, 12);
charBaseBuf.writeUInt32LE(stringBlockSize, 16);

let offset = 20;
for (const rec of finalRecords) {
  charBaseBuf.writeUInt8(rec.race, offset);
  charBaseBuf.writeUInt8(rec.cls, offset + 1);
  offset += 2;
}
charBaseBuf.writeUInt8(0, offset);

// Locate template DBC files
function findDbc(fileName) {
  const dirs = [
    path.resolve(moduleRoot, 'client-patch/patch-contents/DBFilesClient'),
    path.resolve(moduleRoot, 'patch-contents/DBFilesContent'),
    path.resolve(moduleRoot, 'patch-contents/DBFilesClient')
  ];
  for (const d of dirs) {
    const full = path.join(d, fileName);
    if (fs.existsSync(full)) return full;
  }
  return null;
}

const charOutfitPath = findDbc('CharStartOutfit.dbc');
const skillRaceClassPath = findDbc('SkillRaceClassInfo.dbc');

if (!charOutfitPath || !skillRaceClassPath) {
  console.error('Error: Required DBC templates (CharStartOutfit.dbc or SkillRaceClassInfo.dbc) were not found.');
  process.exit(1);
}

const charOutfitBuf = fs.readFileSync(charOutfitPath);
const skillRaceClassBuf = fs.readFileSync(skillRaceClassPath);

// Save DBC files
const dbcTargets = [
  path.resolve(moduleRoot, 'client-patch/patch-contents/DBFilesClient/CharBaseInfo.dbc'),
  path.resolve(moduleRoot, 'patch-contents/DBFilesContent/CharBaseInfo.dbc')
];

if (customOutputDir) {
  dbcTargets.push(path.resolve(customOutputDir, 'DBFilesClient/CharBaseInfo.dbc'));
}

for (const t of dbcTargets) {
  try {
    const dir = path.dirname(t);
    if (!fs.existsSync(dir)) fs.mkdirSync(dir, { recursive: true });
    fs.writeFileSync(t, charBaseBuf);
    console.log('Updated CharBaseInfo.dbc:', t);
  } catch (err) {
    console.warn('Could not write DBC to', t, ':', err.message);
  }
}

// Automatically sync server data/dbc if present
const serverDbcDirs = [
  path.resolve(moduleRoot, '../../data/dbc'),
  path.resolve(moduleRoot, '../../../data/dbc')
];
for (const sDir of serverDbcDirs) {
  if (fs.existsSync(sDir)) {
    try {
      fs.writeFileSync(path.join(sDir, 'CharBaseInfo.dbc'), charBaseBuf);
      fs.writeFileSync(path.join(sDir, 'CharStartOutfit.dbc'), charOutfitBuf);
      fs.writeFileSync(path.join(sDir, 'SkillRaceClassInfo.dbc'), skillRaceClassBuf);
      console.log('Synced server DBCs into:', sDir);
    } catch (e) {
      console.warn('Could not sync server DBCs to', sDir, e.message);
    }
  }
}

// Build and deploy MPQs
console.log(`\nPacking MPQ archives matching active configuration...`);

const stagingFolder = path.resolve(moduleRoot, 'client-patch/patch-contents');
const psScript = path.resolve(__dirname, 'build_mpq.ps1');
const { execSync } = require('child_process');

const defaultTargets = [
  path.resolve(moduleRoot, 'client-patch/patch-enUS-Z.MPQ'),
  path.resolve(moduleRoot, 'client-patch/Patch-A.MPQ')
];

let lockedCount = 0;

for (const t of defaultTargets) {
  try {
    const dir = path.dirname(t);
    if (!fs.existsSync(dir)) fs.mkdirSync(dir, { recursive: true });
    if (fs.existsSync(psScript)) {
      execSync(`powershell -ExecutionPolicy Bypass -File "${psScript}" -MpqPath "${t}" -SourceFolder "${stagingFolder}"`, { stdio: 'pipe' });
      console.log('Generated MPQ:', t);
    }
  } catch (err) {
    if (err.code === 'EBUSY' || (err.message && err.message.includes('locked'))) {
      lockedCount++;
      console.warn('File currently locked by running Wow.exe:', t);
    } else {
      console.error('Error writing MPQ to', t, ':', err.message);
    }
  }
}

if (customOutputDir) {
  const customTarget = path.resolve(customOutputDir, patchName);
  try {
    const dir = path.dirname(customTarget);
    if (!fs.existsSync(dir)) fs.mkdirSync(dir, { recursive: true });
    if (fs.existsSync(psScript)) {
      execSync(`powershell -ExecutionPolicy Bypass -File "${psScript}" -MpqPath "${customTarget}" -SourceFolder "${stagingFolder}"`, { stdio: 'pipe' });
      console.log('Deployed custom MPQ to:', customTarget);
    }
  } catch (err) {
    if (err.code === 'EBUSY' || (err.message && err.message.includes('locked'))) {
      lockedCount++;
      console.warn('File currently locked by running Wow.exe:', customTarget);
    } else {
      console.error('Error writing MPQ to', customTarget, ':', err.message);
    }
  }
}

console.log('\n========================================================================');
console.log('  [SUCCESS] Client patch and server DBC files built successfully!');
console.log('========================================================================');
console.log('\nYour patch files are ready in:');
console.log('  ' + path.resolve(moduleRoot, 'client-patch'));
console.log('\nHow to install into your WoW client:');
console.log('  Option 1 (Recommended / HD / Modded clients):');
console.log('    Copy "client-patch/patch-enUS-Z.MPQ" into your WoW folder:');
console.log('    -> World of Warcraft/Data/enUS/patch-enUS-Z.MPQ');
console.log('       (or Data/esES/, Data/deDE/, etc. matching your client locale)');
console.log('\n  Option 2 (Clean / Unmodded clients):');
console.log('    Copy "client-patch/Patch-A.MPQ" into your WoW folder:');
console.log('    -> World of Warcraft/Data/Patch-A.MPQ');
if (customOutputDir) {
  console.log('\n  Directly deployed to: ' + customOutputDir);
}
console.log('========================================================================\n');


