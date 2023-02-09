#!/bin/bash

PSQL="psql -X --username=freecodecamp --dbname=periodic_table --tuples-only -c"

# if no input provided
if [[ -z $1 ]]
then
  echo Please provide an element as an argument.
else
  # if input is an int
  if [[ $1 =~ ^[0-9]+$ ]]
  then
    # get info
    SELECT_ELEMENT=$($PSQL "SELECT * FROM elements NATURAL JOIN properties NATURAL JOIN types WHERE elements.atomic_number = $1")
  # if input is a string
  else
    # get info
    SELECT_ELEMENT=$($PSQL "SELECT * FROM elements NATURAL JOIN properties NATURAL JOIN types WHERE elements.symbol = '$1' OR elements.name = '$1'")
  fi
  # if not found in database
  if [[ -z $SELECT_ELEMENT ]]
  then
    echo "I could not find that element in the database."
  else
    echo "$SELECT_ELEMENT" | while read TYPE_ID BAR ATOMIC_NUMBER BAR ELEMENT_SYMBOL BAR ELEMENT_NAME BAR ATOMIC_MASS BAR MELTING_POINT BAR BOILING_POINT BAR ELEMENT_TYPE
    do 
      echo -e "The element with atomic number $ATOMIC_NUMBER is $ELEMENT_NAME ($ELEMENT_SYMBOL). It's a $ELEMENT_TYPE, with a mass of $ATOMIC_MASS amu. $ELEMENT_NAME has a melting point of $MELTING_POINT celsius and a boiling point of $BOILING_POINT celsius."
    done
  fi
fi
