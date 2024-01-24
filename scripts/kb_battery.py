#!/bin/env python3
import subprocess

all_statuses = subprocess.run(["upower", "-d"], capture_output=True).stdout.decode("utf-8").split("\n\n")

for s in all_statuses:
	if "leko pona 1" in s:
		for line in s.split("\n"):
			if "percentage:" in line:
				print(line.split(":")[1].strip())
				exit(0)

print("conputer bad")
