svcinfo lshost -nohdr|while read -a host
do  
  printf "\n%-20s\n" ${host[1]}
  svcinfo lshost ${host[1]} |while read -a wwpn
  do
    if [[ ${wwpn[0]} == WWPN ]]
    then
      printf "${wwpn[1]} "
   
      for node in `svcinfo lsnode -nohdr |while read -a node ; do echo $node; done`
      do
        for port in 1 2 3 4
        do
          printf "-"
          svcinfo lsfabric -nohdr -wwpn ${wwpn[1]} |while read -a fabric
          do
            [[ ${fabric[2]} == $node && ${fabric[5]} == $port ]] && printf "\b\033[01;3%dm$port\033[0m" $((${#fabric[7]}/2-1))
          done
        done
      printf " "
      done
    printf "\n"
    fi
  done
done