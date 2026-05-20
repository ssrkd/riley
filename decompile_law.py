import sys
import os

# Add ljd_tool to sys.path so we can import ljd
sys.path.append(os.path.abspath("ljd_tool"))

from ljd.tools import set_luajit_version, process_file

in_file = 'Law Enforcer Assistant Manager.luac'
out_file = 'Law Enforcer Assistant Manager.lua'

print(f"Starting decompilation for {in_file}")

try:
    print("Attempting decompilation with LuaJIT version 21...")
    set_luajit_version(21)
    process_file(in_file, out_file)
    print(f"Decompilation finished successfully. Check {out_file}")
except Exception as e:
    print(f"Decompilation failed with version 21: {e}")
    try:
        print("Attempting decompilation with LuaJIT version 22...")
        set_luajit_version(22)
        process_file(in_file, out_file)
        print(f"Decompilation finished successfully. Check {out_file}")
    except Exception as e2:
         print(f"Decompilation failed with version 22: {e2}")
