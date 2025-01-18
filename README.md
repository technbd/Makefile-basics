## Makefile:

A `Makefile` is a special file used by the make build automation tool to manage the build process of a project. It defines rules, dependencies, and commands to compile or generate targets such as executables, object files, or any other output needed for your project.


```
apt install make
yum install make
```


```
make -v
```


#### Makefile Syntax:

- The **targets** are nothing but file names, separated by spaces. Mostly, there is only one per rule.
- The **prerequisites** are also file names, separated by spaces. These files need to exist before the commands for the target are run. These are also called dependencies.
- The **commands** are a set of actions or a series of steps typically used to make the target(s). You must always bear in mind that commands always start with a tab character and not spaces. If at all you give spaces instead of a tab, make will fail.


```
targets: prerequisites
	command
	command
	command
```



### Hello World: 

Let's start with the simplest of Makefiles:


#### Example-1:

- We have one target called hello
- This target has two commands
- This target has no prerequisites

```
hello:
	@echo "This Makefile..."
	@echo "Hello, World"
```


_To Run Makefile:_

```
make hello
```



### Targets: 

If you want **to make multiple target and run all of them**, you can simply make an all target:


#### Example-1:

```
# Aggregate target to run all:
all: one two three

## Individual targets:
one: 
	@touch one.txt

two:
	@touch two.txt

three:
	@touch three.txt

clean:
	rm -rf one.txt two.txt three.txt
```


_To Run:_

```
make all
make clean
```



### Variables:

Variables can only be strings. You'll typically want to use `:=`, but `=` also works. 

- The `=` or `:=` is used for simple variable assignment.
	- Recursive assignment: `VAR = value` (evaluated when used)
	- Immediate assignment: `VAR := value` (evaluated when defined)
- The` @` symbol before the echoing of the command itself, only printing the result of the command execution.


_The syntax to declare a variable in a Makefile:_

```
variable = value
```


#### Example-1:

```
## To assign variable store the value: 

VAR_NAME = "This Makefile..."
VAR_NAME1 := "Hello World"

run_hello:
	@echo "$(VAR_NAME)"
	@echo "${VAR_NAME1}"
```


_To Run Makefile:_

```
make run_hello
```


#### Example-2:

```
## Variable:
file_name = file.txt

create_file:
	@touch "$(file_name)"

rm_file:
	@rm -rf "${file_name}"
```


_To Run Makefile:_

```
make create_file
make rm_file
```



### Multi-line:

The backslash `\` character gives us the ability to use multiple lines when the commands are too long.

- `$$` : The double dollar sign (`$$`) is used to escape the dollar sign in the context of Makefiles. In Makefiles, a single dollar sign (`$`) typically denotes the beginning of a variable, and using `$$` allows you to use a literal dollar sign.

- `; \` : The semicolon (`;`) separates multiple shell commands on a single line. The backslash (`\`) at the end indicates that the command continues on the next line. It's used here to improve readability, especially when dealing with longer or multiline shell commands within a Makefile.



#### Example-1:

```
multi_line:
	@echo This line is too long \
	it is broken up into multiple lines
```


_To Run Makefile:_

```
make multi_line
```


#### Example-2: (Store command output to a variable:)

```
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
```


_To Run Makefile:_

```
make create_dir
make list_dir
```



#### Example-3:

```
path:
	@echo `pwd`	

path1:
	@full_path=`pwd`; echo "Path of: $$full_path"

## Or:

path2:
	@full_path=`pwd`; \
	echo "Path of: $$full_path"
```


```
make path
make path1
make path2
```



### Show the current date:

- The double dollar sign `$$` is used to escape the `$` character because make interprets a single `$` as the beginning of a variable.


```
print_date:
	@current_date=$$(date); \
	echo "Today date: $$current_date"

## Or:

print_date1:
	@current_date=$$(date); echo "Today date and time is: $$current_date"
```


_To Run:_

```
make print_date

make print_date1
```







### For loop:


#### Example-1:

```
## Define a list of items (Array of items):
LIST = one two three

for_loop:
	@echo "List of items: $(LIST)"
	@for i in $(LIST); do \
		echo $$i; \
	done

```



_To Run:_

```
make for_loop
```


#### Example-2:

```
## Array of items:
names = m w1 w2

for_loop1:
	@for ec2_name in $(names); \
	do \
		echo $$ec2_name; \
	done;

	@echo "Created instances: $(names)"
```


```
make for_loop1
```


#### Example-3:

```
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
```



```
make create_ec2
```



#### Example-4: For Loop with If-else conditions:

```
# Array of items:
vms=m2 w3 w4

delete_ec2:
	@echo "EC2 Deleteing..."

	@for name in $(vms); \
	do \
		if [ ! -z "$$name" ]; \
		then \
			echo "Delete: $$name"; \
			echo "$$name is terminated"; \
		else \
			echo "Not found: $$name"; \
		fi; \
	done

	@echo "EC2 Instances: $(vms) is Deleted"
```


```
make delete_ec2
```









### Links:

- [Makefile in linux](https://data-flair.training/blogs/makefile-in-linux/)
- [Learn Makefiles](https://makefiletutorial.com/#string-substitution)
- [GNU make | gnu.org](https://www.gnu.org/software/make/manual/html_node/)






