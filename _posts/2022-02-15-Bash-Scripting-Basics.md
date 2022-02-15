---
layout: post
title:  "Very Basic Bash Scripting"
date:   2022-02-05 21:03:36 -0500
categories: Bash Scripting Basic
---

This is a very short basic description on Bash scripting - compiled from a book and various online sources. Refer to the reference section for a full reading/understanding.

- [VARIABLES AND QUOTING](#variables-and-quoting)
    - [Variable Expansion](#variable-expansion)
    - [Command Execution](#command-execution)
- [SHELL BUILT-IN VARIABLES](#shell-built-in-variables)
- [CONDITIONALS AND LOOPS](#conditionals-and-loops)
  - [IF condition](#if-condition)
  - [WHILE loop](#while-loop)
  - [FOR loop](#for-loop)
  - [Boolean Operators](#boolean-operators)
    - [Numeric and String Operators](#numeric-and-string-operators)
    - [File Evaluation Structure](#file-evaluation-structure)
- [PARENTHESES () and []](#parentheses--and-)
- [References](#references)
## VARIABLES AND QUOTING
In shell, variables are declared like `prompt> etcdir='/etc'`. Few things of note:
* Do NOT put *space* around **=** sign. Spaces are of big consequence in Shell Scripting.
  * `prompt> etcdir =/etc` interprets `etcdir` as a command
#### Variable Expansion
* Reference a variable prepending `$` sign to the variable (NO SPACES). Within **double quoted strings**, you need to use `${<varibleHere>}` format to expand the variable. **In single quoted strings**, the variable will NOT expand.
  * `prompt> echo $etcdir` echoes `/etc`
  * `prompt> echo "The etc directory is ${etcdir}"` echoes `The etc directory is /etc`
  * `prompt> echo 'This wont expand the variable ${etcdir}` echoes `This wont expand the variable ${etcdir}` because
#### Command Execution
* Back-quote or backticks (`) allow execution of commands within a string when they are surrounded by it.
```sh
prompt> echo 'I am `whoami`'
I am root 
```
* Varibles are **CaSe-SeNsItIvE**. ALLCAPS variables are often *environment variables* or global variables.

## SHELL BUILT-IN VARIABLES
* `$0`: command that is invoked to run the current program/process. eg. python, gcc, etc.
* `$1`, `$2`, `$3`,... : 1st, 2nd, 3rd, etc. argument provided to the current function. eg. helloWorld.py, -o a.out a.c, etc
* `$*`: **All arguments** provided at once excluding $0
* `$#`: **Number** of arguments provided excluding $0
* `$?`: Exit code given by *previous* command execution

## CONDITIONALS AND LOOPS
### IF condition
* If conditionals can be written in multilines or otherwise.
* Multiline `if` conditions can be written as below:
  ```sh
  if [ CONDITION1 ]; then
    SOME_ACTION
  elif [ CONDITION2 ]; then
    SOME_OTHER_ACTION
  else
    DEFAULT ACTION
  fi
  ```
### WHILE loop
* **While** loop uses `while ....; do ...... done` format
* Example script that counts lines in a file
```sh
counter = 0
while read line; do
    counter = $((counter + 1))
done
```
### FOR loop
* **For** loop has similar structure as while loop
* Some examples:
```bash
for script in *.sh; do
    cat $script > newfile.txt
done
```
```bash
#!/bin/sh
# Backup Script to backup all 

suffix=BACKUP--`date + %Y-%m-%d-%H%M`
for script in *.sh; do # *.sh wil automatically list all .sh files like ls does
    newname="$script.$suffix"
    echo "Copying $script to $newname"
    cp -p $script $newname
done
```
* `for x in Y` structure is not required if `Y` is a list
  * One can do `for Y; do ... done`

### Boolean Operators
#### Numeric and String Operators
|Numeric Condition| String Condition |Meaning|
|-|-|-|
|x -eq y |x = y |Equal |
|x -ne y | x != y| Not Equal|
|x -lt y | x < y |Less Than|
|x -le y | N/A | Less or Equal |
|x -gt y | x > y | Greater Than|
|x -ge y | N/A| Greater Or Eual|
|N/A | -n x | Is Not Null|
|N/A| -z x| Is Null|
#### File Evaluation Structure
|Operator|Meaning|
|-|-|
|-e file| file **e**xists|
|-d file| file exist & is a **d**ir|
|-f file | file exists & is a regular **f**ile|
|-s file| file exists and is not empty|
|-r file| user has **r**ead permission on file|
|-w file| user has **w**rite permission on file|
|file1 -nt file2| file1 is newer than file2|
|file1 -ot file2| file1 is older than file2|

## PARENTHESES () and []
  * `[]` act as a shorthand of test command
  ```sh
  $ [ -f /etc/rc.local ] && echo "real file"
  real file

  -and-

  $ test -f /etc/rc.local && echo "real file"
  real file
  ```
* No WordSplitting or glob expansion will be done for [[ (and therefore many arguments need not be quoted)[4]:
```sh
 file="file name"
 [[ -f $file ]] && echo "$file is a regular file"
```
will work even though $file is not quoted and contains whitespace. With [ the variable needs to be quoted:
```sh
 file="file name"
 [ -f "$file" ] && echo "$file is a regular file"
```
This makes [[ easier to use and less error-prone.

Parentheses in [[ do not need to be escaped:
```sh
 [[ -f $file1 && ( -d $dir1 || -d $dir2 ) ]]
 [ -f "$file1" -a \( -d "$dir1" -o -d "$dir2" \) ]
```
* Arithmetic **expansion** allows the evaluation of an arithmetic expression and the substitution of the result.
The format for arithmetic expansion is: `$(( expression ))`
* The format for a simple Arithmetic **Evaluation** is: `(( expression ))`
* The expression is treated as if it were within double quotes, but a double quote inside the parentheses is not treated specially. All tokens in the expression undergo parameter expansion, command substitution, and quote removal. Arithmetic substitutions can be nested. [5]

## References
1. Unix and System Administration Handboox, *Fifth Edition* 
2. https://unix.stackexchange.com/questions/99185/what-do-square-brackets-mean-without-the-if-on-the-left
3. https://stackoverflow.com/questions/2188199/how-to-use-double-or-single-brackets-parentheses-curly-braces
4. http://mywiki.wooledge.org/BashFAQ/031
5. https://ss64.com/bash/syntax-brackets.html