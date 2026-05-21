import os

def find_log():
    search_path = os.path.expanduser("~")
    print(f"Searching home directory: {search_path}...")
    
    found_files = []
    exclude_dirs = {
        "Library/Caches", "Library/Logs", ".git", ".npm", ".nvm", "node_modules", 
        "Caches", "Cache", "cache", "google-cloud-sdk", ".gemini", ".docker"
    }
    
    for root, dirs, files in os.walk(search_path):
        # Exclude directories
        rel_path = os.path.relpath(root, search_path)
        if any(ex in rel_path for ex in exclude_dirs):
            dirs[:] = [] # Skip walking this directory
            continue
            
        if "moonloader.log" in files:
            full_path = os.path.join(root, "moonloader.log")
            found_files.append(full_path)
            print(f"Found: {full_path}")
            
    if not found_files:
        print("No moonloader.log found anywhere in home directory.")
        return
        
    # Sort by modification time to get the most recent log
    found_files.sort(key=os.path.getmtime, reverse=True)
    latest_log = found_files[0]
    print(f"\nReading latest log: {latest_log} (modified {os.path.getmtime(latest_log)})\n")
    
    with open(latest_log, "r", encoding="utf-8", errors="ignore") as f:
        lines = f.readlines()
        
    print("--- Last 40 lines of log ---")
    for line in lines[-40:]:
        print(line.strip())

if __name__ == "__main__":
    find_log()
