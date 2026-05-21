const fs = require('fs');
const luaparse = require('luaparse');

try {
    const code = fs.readFileSync('/Users/serik08/Documents/GitHub/riley/Riley.lua', 'utf8');
    luaparse.parse(code);
    console.log("SUCCESS: Riley.lua has valid Lua syntax.");
} catch (e) {
    console.error("SYNTAX ERROR in Riley.lua:");
    console.error(e.message);
    if (e.line) {
        console.error(`Line: ${e.line}, Column: ${e.column}, Index: ${e.index}`);
    }
}
