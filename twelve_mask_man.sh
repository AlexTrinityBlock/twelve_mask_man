#!/bin/bash

#隨機生成兩個16進位數字
random_char () {
    cat /dev/urandom | tr -dc 'a-f0-9' | fold -w 2 | head -n 1 
}
#隨機生成兩個偶數
random_even () {
    var_1=1
    var_2=1
    while [ $((var_1%2)) -eq 1  ]||[  $((var_2%2)) -eq 1 ]
    do
        var_1=$(($RANDOM % 10))
        var_2=$(($RANDOM % 10))
    done
    echo "$var_1$var_2"
}


echo "They are your network interface choice one! "
echo ""

ip link show #列出現有的網路界面

echo ""

echo "Input your interface:"

read interface

fake_mac="$(random_even):$(random_char):$(random_char):$(random_char):$(random_char):$(random_char)"

echo ""

ifconfig $interface down || exit
ifconfig $interface hw ether $fake_mac || exit
ifconfig $interface up || exit
sudo service network-manager restart || exit

echo "Done  $fake_mac is your new mac address!"
