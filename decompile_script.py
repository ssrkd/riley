import sys
import os

# Add ljd_tool to sys.path so we can import ljd
sys.path.append(os.path.abspath("ljd_tool"))

from ljd.tools import set_luajit_version, process_file

# Version 21 is for LuaJIT-2.0.1+
# If this fails, we can try version 20
try:
    print("Attempting decompilation with LuaJIT version 21...")
    set_luajit_version(21)
    process_file('FBIhelper.luac', 'FBIhelper.lua')
    print("Decompilation finished. Check FBIhelper.lua")
except Exception as e:
    print(f"Decompilation failed with version 21: {e}")
    try:
        print("Attempting decompilation with LuaJIT version 22...")
        set_luajit_version(22)
        process_file('FBIhelper.luac', 'FBIhelper.lua')
        print("Decompilation finished. Check FBIhelper.lua")
    except Exception as e2:
         print(f"Decompilation failed with version 22: {e2}")
