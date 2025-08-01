#!/bin/bash

sec_to_min() {
    if [[ $# -ne 1 ]]; then
        echo "Error: Used more than one arg"
        exit 1;
    fi
    
    local minutes=$(($1 / 60))
    local seconds=$(($1 % 60 ))
    printf "%d:%02d" "$minutes" "$seconds"
}

main() {
    read -p "Enter timer length (min): " time
    (( time *= 60 ))
    
    for ((i = 0; i <= time; i++)); do
        printf "\r%s | %s" "$(sec_to_min $i)" "$(sec_to_min $time)"
        sleep 1 
    done

    printf "\nTimer is complete!"
    
    # send noti
    notify-send -a "jacobtimer" -i clock "Timer is complete!"

    # repeat 5 times as an "alarm"
    for i in {5..1}; do
        paplay ./alarm.ogg
    done
}

while true; do 
  main # call original program 
  printf "\nPress r to restart, or q to quit."
  read -n 1 -s key
    case "$key" in 
      r|R)
        printf "\n"
        #restarts automatically
        ;;
      q|Q)
        printf "\n"
        exit 1;
        ;;
    esac
done

