import numpy                    # for data manipulation, storage  

# This is the array we will be altering. This can be any set of numbers. 
array = [83.33, 100.00, 116.67, 133.33, 150.00, 167.67, 183.34, 200.00, 216.67, 233.34, 250.00, 266.67, 283.34, 300.00, 316.67, 333.33, 350.00, 367.67, 383.34, 400.01, 416.67, 433.33, 450.01, 467.67, 483.34, 500.01, 516.68, 533.34, 550.01, 567.68, 583.34, 600.01, 616.68, 633.34, 650.01, 667.68, 683.34, 700.01, 716.67, 733.34, 750.01, 767.68, 783.34, 800.01, 816.68, 833.35, 850.02, 866.68, 883.35, 900.02, 916.68, 933.35, 950.02, 966.68, 983.35, 1000.00, 1016.70, 1033.40, 1050.00, 1066.70]

# Here we are declaring the variable "num". You can make it equal to whatever value you would like. 
num = 3

# This line tells us that for every "i" entry in the array called "array", multiply it by "num" -- which is declared above.
my_new_list = [i * num for i in array]

# These statements are used to print out the original "array" and the new array, which has been altered by "num".
print('This is the orginial array...')
print(array)
print('This is the array after it is multiplied...')
print(my_new_list)
