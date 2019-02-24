#!/usr/bin/env bash

required_packages=($(cat ./required-packages | sort))
declare -a missing_packages

prev_ifs=$IFS
IFS=$'\n'
installed_packages=($(cat ./test-list))
IFS=${prev_ifs}
# echo ${echo ${installed_packages[0]} | cut -d' ' -f1}
# echo $(echo ${installed_packages[0]} | cut -d' ' -f1)
# exit

num_installed=${#installed_packages[@]}
end_i=$((${#required_packages[@]} - 1))
i=0
j=0

while [[ $i -lt ${end_i} ]]; do
    package_name=$(echo ${installed_packges[j]} | cut -d' ' -f1)
    while [[ $j -lt ${num_installed} ]] \
        && [[ $(echo ${installed_packages[j]} | cut -d' ' -f1) != ${required_packages[i]} ]]; do
        echo "installed: " $(echo ${installed_packages[j]} | cut -d' ' -f1)
        echo "required:" ${required_packages[i]}
        j=$(($j+1))
    done
    if [[ $j -eq ${num_installed} ]]; then
        missing_packages+=(${required_packages[i]})
    fi
    
    i=$(($i+1))
done

echo ${missing_packages[@]}
