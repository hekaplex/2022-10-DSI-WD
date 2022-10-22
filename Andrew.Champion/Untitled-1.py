import json
import csv
with open ("PowerBIPerformanceData.json") as json_file:
    json_text = json_file.read()
    data = json.loads(json_text[json_text.find("{")])
    metrics = [event['metrics'] for event in data['events'] if 'metrics' in event]
    query_texts = [metric['QueryText'] for metric in metrics if 'QueryText' in metric]
... ;csvfile = open("data_dictionary.csv" , "w+" , newline="")
...; writer = csv.DictWriter(csvfile, fieldnames=["table", "field"])
writer.writerow({"table": "Table", "field": "Field"})
recorded_fields = []
csvfile.close()