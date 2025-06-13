import requests
import json

# Base URL for the bio.tools API
BASE_URL = "https://bio.tools/api/tool"

# Parameters for the search: filtering by EDAM topic ID for "Microbiology"
# AND explicitly requesting JSON format.
params = {
    "topicID": "topic_3301",  # EDAM ID for Microbiology
    "format": "json"          # <--- THIS IS THE KEY ADDITION
}
# Pagination settings
page_size = 100  # Number of tools per page (can be adjusted)
current_page = 1
microbiology_tools_info = [] # This list will store dictionaries of {'id': ..., 'name': ...}

print(f"Searching for tools with the topic 'Microbiology' (EDAM ID: topic_3300)...")

while True:
    print(f"Fetching page {current_page}...")
    current_params = {**params, "page": current_page, "page_size": page_size}
    response = requests.get(BASE_URL, params=current_params)

    if response.status_code == 200:
        data = response.json()
        tools_on_page = data.get("list", [])

        if not tools_on_page:
            print("No more tools to retrieve. Ending pagination.")
            break

        # Extract only the 'biotoolsID' and 'name' for each tool
        for tool in tools_on_page:
            tool_id = tool.get('biotoolsID')
            tool_name = tool.get('name')
            if tool_id and tool_name: # Ensure both fields exist
                microbiology_tools_info.append({'id': tool_id, 'name': tool_name})
        
        # Check if there are more pages
        total_pages = data.get("total_pages", 0)
        if current_page >= total_pages:
            print("All pages retrieved.")
            break
        
        current_page += 1
    else:
        print(f"Error during request: {response.status_code}")
        print(response.text)
        break

print(f"\nTotal number of 'Microbiology' tools found: {len(microbiology_tools_info)}")

# Display the extracted IDs and names
print("\nExtracted Tool IDs and Names:")
for tool_info in microbiology_tools_info:
    print(f"  - ID: {tool_info['id']}, Name: {tool_info['name']}")

# Optionally, save to a JSON file
output_filename = "microbiology_tools_ids_names.json"
with open(output_filename, "w", encoding="utf-8") as f:
    json.dump(microbiology_tools_info, f, ensure_ascii=False, indent=4)
print(f"\nData saved to '{output_filename}'")