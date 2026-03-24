#!/bin/env bash
# df -h | grep /dev/nvme0n1 | head -n 1 | tail -n 1

# partition /
s1=$(df -h | grep /dev/nvme0n1 | tr -s ' ' | head -n 1 | tail -n 1 | cut -d ' ' -f 3)
s2=$(df -h | grep /dev/nvme0n1 | tr -s ' ' | head -n 1 | tail -n 1 | cut -d ' ' -f 2)
s3=$(df -h | grep /dev/nvme0n1 | tr -s ' ' | head -n 1 | tail -n 1 | cut -d ' ' -f 5)

s4=${s1}" / "${s2}" ("${s3}")"

echo ${s4}

# partition /home
s1=$(df -h | grep /dev/nvme0n1 | tr -s ' ' | head -n 3 | tail -n 1 | cut -d ' ' -f 3)
s2=$(df -h | grep /dev/nvme0n1 | tr -s ' ' | head -n 3 | tail -n 1 | cut -d ' ' -f 2)
s3=$(df -h | grep /dev/nvme0n1 | tr -s ' ' | head -n 3 | tail -n 1 | cut -d ' ' -f 5)

s4=${s1}" / "${s2}" ("${s3}")"

echo ${s4}
