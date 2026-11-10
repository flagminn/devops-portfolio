#!/bin/bash

code_sort(){
    awk '{print $0}' "${logfile[@]}" | sort -k9,9n
    
}

ip_sort(){
    awk '{print $1}' "${logfile[@]}" | sort | uniq
    
}

error_sort() {
    awk '$9 >= 400' "${logfile[@]}"
    
}

ip_error_sort(){
     
    awk '$9 >= 400' "${logfile[@]}" | sort | uniq
    
}



