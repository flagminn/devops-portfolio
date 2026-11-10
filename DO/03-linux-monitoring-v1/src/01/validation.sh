#!/bin/bash

validate_input(){

 if [ "$#" -ne 1 ]; then
     echo "Error: Exactly one parametr is required."
     exit 1
 fi

 if [[ $1 =~ ^-?[0-9]+(\.[0-9]+)?$ ]]; then
     echo "Error: Numeric input is not allowed. Please provide a text string."
     exit 1
 fi
}
