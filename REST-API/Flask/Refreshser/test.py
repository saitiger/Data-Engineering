import requests

BASE = 'http://127.0.0.1:5000/'

# response = requests.get(BASE + 'helloworld') # Send get request to hello world enpoint

# print(response.json())

response = response.patch(BASE + "video/2", {"views":99, "likes":101})
