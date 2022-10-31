import json
import csv
import os
#creating dictionary
with open (r"C:/Users/andre/OneDrive/Desktop/2022-10-DSI-WD/Andrew.Champion/PowerBIPerformanceData.json") as json_file:
    json_text = json_file.read()
    data = json.loads(json_text[json_text.find("{"):])

# Extract all queries
metrics = [event['metrics'] for event in data['events'] if 'metrics' in event]
query_texts = [metric['QueryText'] for metric in metrics if 'QueryText' in metric]

# Create CSV file and Writer object to record fields and tables
csvfile = open("data_dictionary.csv", "w+", newline="")
writer = csv.DictWriter(csvfile,
                        fieldnames=["table", "field"])
writer.writerow({"table": "Table",
                 "field": "Field"})

recorded_fields = [] # Track the fields that have been recorded to avoid duplicates

# Record fields and tables
for query in query_texts:
	query_split = query.split("'[")

	for i in range(len(query_split)-1):
		newrow = {"table": query_split[i].split("'")[-1], # Extract table name
                  "field": query_split[i+1].split("]")[0]} # Extract field name
		
		if newrow not in recorded_fields:
			recorded_fields.append(newrow)
			writer.writerow(newrow)

csvfile.close()
