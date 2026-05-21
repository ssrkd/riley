import os
import subprocess

def check_syntax(file_path):
    try:
        js_code = f"""
const fs = require('fs');
const luaparse = require('luaparse');
try {{
    const code = fs.readFileSync({repr(file_path)}, 'utf8');
    luaparse.parse(code);
    console.log("OK");
}} catch (e) {{
    console.log("ERROR: " + e.message);
}}
"""
        res = subprocess.run(["node", "-e", js_code], capture_output=True, text=True)
        return res.stdout.strip()
    except Exception as e:
        return f"Checker error: {str(e)}"

def find_riley_global():
    search_paths = [
        "/Applications",
        "/Users/Shared",
        "/Volumes"
    ]
    
    found_files = []
    exclude_dirs = {
        "Library/Caches", "Library/Logs", ".git", ".npm", ".nvm", "node_modules", 
        "Caches", "Cache", "cache", "google-cloud-sdk", ".gemini", ".docker"
    }
    
    for base_path in search_paths:
        if not os.path.exists(base_path):
            continue
        print(f"Searching: {base_path}...")
        for root, dirs, files in os.walk(base_path):
            # Prune directories
            dirs[:] = [d for d in dirs if d not in exclude_dirs]
            if "Riley.lua" in files:
                full_path = os.path.join(root, "Riley.lua")
                found_files.append(full_path)
                print(f"Found: {full_path}")
                
    if not found_files:
        print("No Riley.lua found in global directories.")
        return
        
    print("\nGlobal search results:")
    for path in found_files:
        size = os.path.getsize(path)
        mtime = os.path.getmtime(path)
        syntax_status = check_syntax(path)
        print(f"- {path}")
        print(f"  Size: {size} bytes | Modified: {mtime} | Syntax: {syntax_status}")

if __name__ == "__main__":
    find_riley_global()
