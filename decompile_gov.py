import sys
import os

# Add ljd_tool to sys.path so we can import ljd
sys.path.append(os.path.abspath("ljd_tool"))

from ljd.tools import set_luajit_version, process_file

import traceback

def try_decompile(input_file, output_file):
    versions = [21, 22, 20]
    for version in versions:
        try:
            print(f"Attempting decompilation of {input_file} with LuaJIT version {version}...")
            set_luajit_version(version)
            process_file(input_file, output_file)
            print(f"Decompilation finished. Check {output_file}")
            return True
        except Exception as e:
            print(f"Decompilation with version {version} failed:")
            traceback.print_exc()
    return False

if __name__ == "__main__":
    try_decompile('GovAssistant .luac', 'GovAssistant.lua')
