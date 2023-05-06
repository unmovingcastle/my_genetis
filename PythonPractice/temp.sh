#!/bin/bash

scale=10
sed "s/SCALE/$scale/g" temp.py > temp_runtime.py

python temp_runtime.py
rm temp_runtime.py
