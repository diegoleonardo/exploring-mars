# ExploringMars

This is a project to solve the problem called "Exploring Mars".
Basically, the problem consists of an API that receives input commands to control space probes.

The problem can be found, in a txt file called " exploring_mars", on the root of the project.

To use the API you just have to clone this project and run with the following instructions:
- Clone this project

- Go to the root of the project that you just cloned and run:
 
 iex -S mix

- Inside Interactive Elixir, to execute the api, just run the command:

 iex(1)> ExploringMars.issue_command("5 5\n 1 2 N LMLMLMLMM\n3 3 E\n MMRMMRMRRM")



## Improvements
1 - The input data of the problem:
The problem asks the following format:

Initial Coordination
Initial State
Commands
...

Currently, the API accepts in the following format:

Initial Coordination
Initial State Commands
Initial State Command
...

2 - Improvement of the tests:
Improve names, write more tests, doctests and remove possible duplicated tests.

3 - Improvement of Docs:
Improve of documentation of APIs

4 - Application of patterns:
Maybe implement some patterns that I unknown at the moment.

5 - Improvement of the structure:
Improve the name of modules and functions.

