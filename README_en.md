- [English](README_en.md)
- [中文](README_zh.md)

---

This Bash script is primarily designed for querying DNS records and saving the results into a CSV file. Here's a brief overview of its various components:
1. **Environment Setup & Initialization**: The script kicks off by displaying "The script is starting" and checks whether a Name Server has been provided as a command-line argument.
2. **Parameter & File Initialization**: It sets the Name Server and the output CSV file name (`result.csv`). If `result.csv` does not exist, the script automatically creates it and adds a header.
3. **Preliminary Checks**: The script checks if `domain_list.txt` (a file that contains domains and record types to be queried) exists. If it does not, the script terminates.
4. **Reading & Processing**: Using a `while` loop, the script reads each line of `domain_list.txt` and performs a `dig` command to query for each domain and its corresponding DNS record type.
5. **Timestamp & Output**: Before each query, the script captures the current timestamp. The query results, along with the timestamp, domain, and record type, are written into the `result.csv` file.
This script could be highly useful for information gathering and monitoring, especially when you need to periodically query multiple domains' DNS records and keep historical records.

## How to use
```
./dns_ns_checker.sh [nameserver]
```