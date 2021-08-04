while true; do
	IMAGES=( $(docker images hyuvilab/$(whoami) --format "{{.Tag}}") )
	CONTAINERS=( $(docker ps -a --format '{{.Names}}' | grep $(whoami) ) )

	# show images
	echo -e "\n[*] IMAGES for $(whoami)"
	for i in "${!IMAGES[@]}"; do
		printf "%s\t%s\n" "$i" "${IMAGES[$i]}"
	done

	# show containers
	echo -e "\n[*] CONTAINERS for $(whoami)"
	for i in "${!CONTAINERS[@]}"; do
		printf "%s\t%s\n" "$i" "${CONTAINERS[$i]}"
	done
	echo ""





	# get commands
	COMMANDS=( \
		"create image" \
		"pull image" \
		"push image" \
		"remove image" \
		"run container from image" \
		"stop container" \
		"restart container" \
		"remove container" \
		"commit container to image" \
		"exit"
	)
	for i in "${!COMMANDS[@]}"; do
      printf "%s\t%s\n" "$i" "${COMMANDS[$i]}"
    done
    read -p 'command : ' CMD


    # Create IMAGE
	if [[ "${CMD}" == "0" ]] ; then
		echo -e "\n[CREATE] Enter the number of IMAGE you want to copy"
		IMAGES=( $(docker images hyuvilab/cuda --format "{{.Tag}}") )
		IFS=$'\n' IMAGES=($(sort <<<"${IMAGES[*]}")); unset IFS
	    for i in "${!IMAGES[@]}"; do
	        printf "%s\t%s\n" "$i" "${IMAGES[$i]}"
	    done
	    read -p 'IMAGE number: ' IDX

	    # check validity of response
	    NUMBERS='^[0-9]+$'
	    if [[ $IDX =~ $NUMBERS && $IDX -ge 0 && $IDX -lt ${#IMAGES[@]} ]] ; then
	        echo "[CREATE] Image would be saved as hyuvilab/$(whoami):{NEW_TAG}"
	        read -p 'new tag : ' TAG
	        IMAGE="hyuvilab/cuda:${IMAGES[${IDX}]}"
	        NEWIMAGE="hyuvilab/$(whoami):${TAG}"
	        $(docker tag ${IMAGE} ${NEWIMAGE}) 
	        echo "copy ${IMAGE} to ${NEWIMAGE}"
	    else
		    # invalid response
		    echo -e "invalid response\n"
		fi
	fi


	# Pull IMAGE from HUB
	if [[ "${CMD}" == "1" ]] ; then
		echo -e "\n[PULL] Select IMAGE to pull"
		IMAGES=( $(wget -q https://registry.hub.docker.com/v1/repositories/hyuvilab/$(whoami)/tags -O -  | sed -e 's/[][]//g' -e 's/"//g' -e 's/ //g' | tr '}' '\n'  | awk -F: '{print $3}') )
		IFS=$'\n' IMAGES=($(sort <<<"${IMAGES[*]}")); unset IFS
		for i in "${!IMAGES[@]}"; do
			printf "%s\t%s\n" "$i" "${IMAGES[$i]}"
		done
		read -p 'IMAGE number: ' IDX

		# check validity of response
		NUMBERS='^[0-9]+$'
		if [[ $IDX =~ $NUMBERS && $IDX -ge 0 && $IDX -lt ${#IMAGES[@]} ]] ; then
			IMAGE="hyuvilab/$(whoami):${IMAGES[${IDX}]}"
			echo "[PULL] Image would be pulled as ${IMAGE}"
			$(docker pull ${IMAGE})
		else
		    # invalid response
		    echo -e "invalid response\n"
		fi
    fi


	# Push IMAGE to HUB
	if [[ "${CMD}" == "2" ]] ; then
		echo -e "\n[PUSH] Select IMAGE to push"
		IMAGES=( $(docker images hyuvilab/$(whoami)} --format "{{.Tag}}") )
		IFS=$'\n' IMAGES=($(sort <<<"${IMAGES[*]}")); unset IFS
		for i in "${!IMAGES[@]}"; do
			printf "%s\t%s\n" "$i" "${IMAGES[$i]}"
		done
		read -p 'IMAGE number: ' IDX

		# check validity of response
		NUMBERS='^[0-9]+$'
		if [[ $IDX =~ $NUMBERS && $IDX -ge 0 && $IDX -lt ${#IMAGES[@]} ]] ; then
			IMAGE="hyuvilab/$(whoami):${IMAGES[${IDX}]}"
			echo "[PUSH] Image would be pulled as ${IMAGE}"
			$(docker push ${IMAGE})
		else
		    # invalid response
		    echo -e "invalid response\n"
		fi
    fi


	# Remove IMAGE
	if [[ "${CMD}" == "3" ]] ; then
		echo -e "\n[REMOVE] Select IMAGE to remove"
		IMAGES=( $(docker images hyuvilab/$(whoami)} --format "{{.Tag}}") )
		IFS=$'\n' IMAGES=($(sort <<<"${IMAGES[*]}")); unset IFS
		for i in "${!IMAGES[@]}"; do
			printf "%s\t%s\n" "$i" "${IMAGES[$i]}"
		done
		read -p 'IMAGE number: ' IDX

		# check validity of response
		NUMBERS='^[0-9]+$'
		if [[ $IDX =~ $NUMBERS && $IDX -ge 0 && $IDX -lt ${#IMAGES[@]} ]] ; then
			IMAGE="hyuvilab/$(whoami):${IMAGES[${IDX}]}"
			echo "[REMOVE] Image would be pulled as ${IMAGE}"
			$(docker rmi ${IMAGE})
		else
		    # invalid response
		    echo -e "invalid response\n"
		fi
    fi


    # Start CONTAINER from IMAGE
	if [[ "${CMD}" == "4" ]] ; then
		echo -e "\n[START] Select IMAGE to run CONTAINER"
		IMAGES=( $(docker images hyuvilab/$(whoami) --format "{{.Tag}}") )
		for i in "${!IMAGES[@]}"; do
			printf "%s\t%s\n" "$i" "${IMAGES[$i]}"
		done
		read -p 'IMAGE number: ' IDX

		# check validity of response
		NUMBERS='^[0-9]+$'
		if [[ $IDX =~ $NUMBERS && $IDX -ge 0 && $IDX -lt ${#IMAGES[@]} ]] ; then
			IMAGE="hyuvilab/$(whoami):${IMAGES[${IDX}]}"
			echo "[START] Enter the name of container : $(whoami)-{CONTAINER_NAME}"
			read -p 'container name : ' CONTAINER_NAME
			$(nvidia-docker run -d -it --ipc=host --volume ~/workspace:/root/workspace --volume ~/datasets:/root/datasets --name "$(whoami)-${CONTAINER_NAME}" ${IMAGE} /bin/bash)
		else
		    # invalid response
		    echo -e "invalid response\n"
		fi
    fi

    # Stop CONTAINER
	if [[ "${CMD}" == "5" ]] ; then
		echo -e "\n[STOP] Select CONTAINER to stop"
		CONTAINERS=( $(docker ps -a --format '{{.Names}}' | grep $(whoami) ) )
		echo -e "\n[STOP] CONTAINERS for $(whoami)"
		for i in "${!CONTAINERS[@]}"; do
			printf "%s\t%s\n" "$i" "${CONTAINERS[$i]}"
		done
		read -p 'CONTAINER number: ' IDX

		# check validity of response
		NUMBERS='^[0-9]+$'
		if [[ $IDX =~ $NUMBERS && $IDX -ge 0 && $IDX -lt ${#CONTAINERS[@]} ]] ; then
			CONTAINER="${CONTAINERS[${IDX}]}"
			echo "[STOP] Stop ${CONTAINER}"
			$(docker stop "${CONTAINER}")
		else
		    # invalid response
		    echo -e "invalid response\n"
		fi
    fi


    # Restart CONTAINER
	if [[ "${CMD}" == "6" ]] ; then
		echo -e "\n[RESTART] Select CONTAINER to restart"
		CONTAINERS=( $(docker ps -a --format '{{.Names}}' | grep $(whoami) ) )
		echo -e "\n[RESTART] CONTAINERS for $(whoami)"
		for i in "${!CONTAINERS[@]}"; do
			printf "%s\t%s\n" "$i" "${CONTAINERS[$i]}"
		done
		read -p 'CONTAINER number: ' IDX

		# check validity of response
		NUMBERS='^[0-9]+$'
		if [[ $IDX =~ $NUMBERS && $IDX -ge 0 && $IDX -lt ${#CONTAINERS[@]} ]] ; then
			CONTAINER="${CONTAINERS[${IDX}]}"
			echo "[RESTART] Restart ${CONTAINER}"
			if [ "$(docker ps -aq -f status=exited -f name=$CONTAINER)" ]; then
                $(docker start "$CONTAINER")
            else
				$(docker restart "${CONTAINER}")
            fi
		else
		    # invalid response
		    echo -e "invalid response\n"
		fi
    fi


    # Remove CONTAINER
	if [[ "${CMD}" == "7" ]] ; then
		echo -e "\n[REMOVE] Select CONTAINER to remove"
		CONTAINERS=( $(docker ps -a --format '{{.Names}}' | grep $(whoami) ) )
		echo -e "\n[REMOVE] CONTAINERS for $(whoami)"
		for i in "${!CONTAINERS[@]}"; do
			printf "%s\t%s\n" "$i" "${CONTAINERS[$i]}"
		done
		read -p 'CONTAINER number: ' IDX

		# check validity of response
		NUMBERS='^[0-9]+$'
		if [[ $IDX =~ $NUMBERS && $IDX -ge 0 && $IDX -lt ${#CONTAINERS[@]} ]] ; then
			CONTAINER="${CONTAINERS[${IDX}]}"
			echo "[REMOVE] Remove ${CONTAINER}"
			$(docker rm "${CONTAINER}")
		else
		    # invalid response
		    echo -e "invalid response\n"
		fi
    fi

    if [[ "${CMD}" == "exit" ]] ; then
    	break
    fi


    # Commit CONTAINER to Image
	if [[ "${CMD}" == "8" ]] ; then
		echo -e "\n[COMMIT] Select CONTAINER to commit"
		CONTAINERS=( $(docker ps -a --format '{{.Names}}' | grep $(whoami) ) )
		echo -e "\n[COMMIT] CONTAINERS for $(whoami)"
		for i in "${!CONTAINERS[@]}"; do
			printf "%s\t%s\n" "$i" "${CONTAINERS[$i]}"
		done
		read -p 'CONTAINER number: ' IDX

		# check validity of response
		NUMBERS='^[0-9]+$'
		if [[ $IDX =~ $NUMBERS && $IDX -ge 0 && $IDX -lt ${#CONTAINERS[@]} ]] ; then
			CONTAINER="${CONTAINERS[${IDX}]}"
			echo "[COMMIT] Commit ${CONTAINER} to hyuvilab/$(whoami):{NEW_TAG"
			read -p 'new tag : ' TAG
	        IMAGE="hyuvilab/$(whoami):${TAG}"
			$(docker commit "${CONTAINER}" "${IMAGE}")
		else
		    # invalid response
		    echo -e "invalid response\n"
		fi
    fi

    # exit
    if [[ "${CMD}" == "9" ]] ; then
    	break
    fi

done
