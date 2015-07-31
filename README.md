# menu_challenge


The goal of this challenge is to create a program to read a menu from a given data file, and to then find any combination of dishes on said menu that have prices that add up exactly to the target price specified on the first line of the file. In this case, then, the program is looking for any items that add up to $15.05.

pseudo code:

1) Using nokogiri parse a given url and isolate the data. 
1) format data file into hash with items as keys and prices as values.  
2) Collect the values of the hash.
3) Find the totals of every possible combination of those values.
4) Determine if any of those totals equals the target price.

This ruby based program runs entirely on the command line. Open up the terminal and when prompted insert the url in which the menu is posted. This program is written to work for any menu formatted similarly to the one given for the challenge. 

**1)** open terminal. 

**2)** in the command line type:

```
ruby menu_exercise.rb
```

**3)** follow  prompts.
