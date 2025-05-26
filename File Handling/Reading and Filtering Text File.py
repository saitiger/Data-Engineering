import os 
from collections import defaultdict

# os.chdir("Logs/Entry File")
# print("Files in current directory:", os.listdir('.'))

# try:
#     file = open('entry.txt','r')
#     content = file.read()
#     print("File content:")
#     print(content)
#     file.close()
# except FileNotFoundError:
#     print("entry.txt not found")
# except Exception as e:
#     print(f"Error: {e}")

file = open('entry.txt','r')
read = file.readlines()

# print(read)

agg = defaultdict(int)

for line in read:
    num_cols = len(line.split(","))
    if num_cols<3:
        continue
    file_extension = line.split(",")[0].split(".")[1] if len(line.split(",")[0].split("."))>1 else "Not Specified"
    file_size = int(line.split(",")[1])

    # print(file_extension)
    # print(file_size)
    agg[file_extension]+=file_size

print(agg)
