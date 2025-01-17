
# Makefile:


# Hello World: 

hello:
	@echo "This Makefile..."
	@echo "Hello, World"


# Targets: 

all: one two three

one: 
	@touch one.txt

two:
	@touch two.txt

three:
	@touch three.txt

clean:
	rm -rf one.txt two.txt three.txt



# Variables: 

## To assign variable store the value: 
VAR_NAME = "This Makefile..."
VAR_NAME1 := "Hello World"

run_hello:
	@echo "$(VAR_NAME)"
	@echo "${VAR_NAME1}"


## Variable:
file_name = file.txt

create_file:
	@touch "$(file_name)"

rm_file:
	@rm -rf "${file_name}"



# Multi-line:

multi_line:
	@echo This line is too long \
	it is broken up into multiple lines


## Store command output to a variable:

dir_name = data

create_dir:
	@mkdir "$(dir_name)"; \
	echo "Directory is created"


list_dir:
	@listDir=$$(ls -l); \
	echo "List of Directory: $$listDir"

### Or:
list_dir1:
	@listDir=$$(ls -l); echo "List of Directory: $$listDir"




path:
	@echo `pwd`	

path1:
	@full_path=`pwd`; echo "Path of: $$full_path"

### Or:
path2:
	@full_path=`pwd`; \
	echo "Path of: $$full_path"




# Show the current date:

print_date:
	@current_date=$$(date); \
	echo "Today date: $$current_date"

### Or:
print_date1:
	@current_date=$$(date); echo "Today date and time is: $$current_date"







# For loop:

## Define a list of items (Array of items):
LIST = one two three

for_loop:
	@echo "List of items: $(LIST)"
	@for i in $(LIST); do \
		echo $$i; \
	done


## Array of items:
names = m w1 w2

for_loop1:
	@for ec2_name in $(names); \
	do \
		echo $$ec2_name; \
	done;

	@echo "Created instances: $(names)"


# Array of items:
INSTANCE_NAMES = masterl worker-1 worker-2

create_ec2:
	@echo "Creating Multiple EC2 Instances..."

	@for instance_name in $(INSTANCE_NAMES); \
	do \
		awslocal ec2 run-instances \
		--image-id ami-0c7217cdde317cfec \
		--instance-type t2.micro \
		--count 1 \
		--associate-public-ip-address \
		--tag-specifications 'ResourceType=instance,Tags=[{Key=Name,Value='$$instance_name'}]'; \
	done;
	@echo "EC2 Instances created."
	@awslocal ec2 describe-instances | grep -i value



# Array of items:
vms=m2 w3 w4

delete_ec2:
	@echo "EC2 Deleteing..."

	@for name in $(vms); \
	do \
		if [ ! -z "$$name" ]; \
		then \
			echo "$$name is Delete"; \
			echo "$$name is terminated"; \
		else \
			echo "Not found: $$name"; \
		fi; \
	done

	@echo "EC2 Instances: $(vms) is Deleted"


# 



