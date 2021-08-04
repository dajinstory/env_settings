# select access method
CONTAINERS=(ADMIN, $(docker ps -a --format '{{.Names}}' | grep $(whoami) ) )
while true; do
    # select access method
    echo "[*] Enter the number of mode you want to access"
    for i in "${!CONTAINERS[@]}"; do
      printf "%s\t%s\n" "$i" "${CONTAINERS[$i]}"
    done
    read -p 'access mode: ' IDX

    # check validity of response
    NUMBERS='^[0-9]+$'
    if [[ $IDX =~ $NUMBERS ]] ; then
        if [[ $IDX -eq 0 ]] ; then
            echo "access as admin"
            break
        elif [[ $IDX -gt 0 && $IDX -lt ${#CONTAINERS[@]} ]] ; then
            CONTAINER="${CONTAINERS[${IDX}]}"
            echo "run ${CONTAINER}"
            break
        fi
    fi

    # invalid response
    echo -e "invalid response\n"
done


# run container
if [[ $IDX -gt 0 ]] ; then
    while true; do
        if [ ! "$(docker ps -q -f name=$CONTAINER)" ]; then
            if [ "$(docker ps -aq -f status=exited -f name=$CONTAINER)" ]; then
                nvidia-docker start $CONTAINER
                echo "Wait until container response..."
            else
                echo "[*] Enter as a user $(whoami)"
                break
            fi
        else
            nvidia-docker exec -it $CONTAINER /bin/bash
            break
        fi
    done
fi


