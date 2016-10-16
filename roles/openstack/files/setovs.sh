#!/usr/bin/env sh

# Setting variables
EXT_IF=$1
EXT_IP=$2
EXT_NETMASK=$3
EXT_GW=$4

# Main configs
ovs-vsctl add-port br-ex ${EXT_IF}
ip addr flush dev ${EXT_IF}
ip addr add ${EXT_IP}/${EXT_NETMASK} dev br-ex
ip link set up dev ${EXT_IF}
ip link set up dev br-ex
ip route get 8.8.8.8 || ip route add default via ${EXT_GW} dev br-ex
