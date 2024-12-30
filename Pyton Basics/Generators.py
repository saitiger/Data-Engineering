# Generators don't hold the entire result in memory and compute only the current value. 
# Implemented using yield.

# **Generators with List Comprehension**
# Normal List Comprehension:
nums = [1,2,3,8,10]
result = [x**3 for x in nums] 

# Generator 
result = (x**3 for x in nums)

# With list comprehension generator we convert it to list 
print(list(result))

# To yield next number use next keyword or use a loop
def triple(nums):
  for n in nums:
    yield n**3

result = triple([1,2,3,8,10])

next_num = next(result)

for r in result:
  print(r)

# Generators are used when the dataset is large to loop through as it has efficient memory and time wise.
