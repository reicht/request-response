# Request and Response Assignment

This program takes in a string, parses it for web browsing information, then
feeds back appropriate outputs.

# Explorer Mode Features

Given  <  `GET http://localhost:3000/users HTTP/1.1` > It should print all users
from the provided list.

Given < `GET http://localhost:3000/users/1 HTTP/1.1` > It should print the user
with the given index.

Given < `GET http://localhost:3000/users/9999999 HTTP/1.1` > It should return an
an error stating the user is not found.

# Testing bypass

Due to the nature of the program the initial prompt still comes up when running the test .rb, you can work around this with the 't' input, which will utilize a hidden testing bypass.
