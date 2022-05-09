vlib work
vlib activehdl

vlib activehdl/xil_defaultlib

vmap xil_defaultlib activehdl/xil_defaultlib

vlog -work xil_defaultlib  -v2k5 \
"../../../../../../subjects/计组/Lab02 CPU实验环境搭建/Lab02 CPU实验环境搭建（老师版）/OExp02-IP2SOC/OExp02-IP2SOC.srcs/sources_1/ip/SSeg7_Dev_0/HexTo8SEG.v" \
"../../../../../../subjects/计组/Lab02 CPU实验环境搭建/Lab02 CPU实验环境搭建（老师版）/OExp02-IP2SOC/OExp02-IP2SOC.srcs/sources_1/ip/SSeg7_Dev_0/MC14495_ZJU.v" \
"../../../../../../subjects/计组/Lab02 CPU实验环境搭建/Lab02 CPU实验环境搭建（老师版）/OExp02-IP2SOC/OExp02-IP2SOC.srcs/sources_1/ip/SSeg7_Dev_0/MUX2T1_64.v" \
"../../../../../../subjects/计组/Lab02 CPU实验环境搭建/Lab02 CPU实验环境搭建（老师版）/OExp02-IP2SOC/OExp02-IP2SOC.srcs/sources_1/ip/SSeg7_Dev_0/P2S.v" \
"../../../../../../subjects/计组/Lab02 CPU实验环境搭建/Lab02 CPU实验环境搭建（老师版）/OExp02-IP2SOC/OExp02-IP2SOC.srcs/sources_1/ip/SSeg7_Dev_0/SSeg_map.v" \
"../../../../../../subjects/计组/Lab02 CPU实验环境搭建/Lab02 CPU实验环境搭建（老师版）/OExp02-IP2SOC/OExp02-IP2SOC.srcs/sources_1/ip/SSeg7_Dev_0/SSeg7_Dev.v" \
"../../../../../../subjects/计组/Lab02 CPU实验环境搭建/Lab02 CPU实验环境搭建（老师版）/OExp02-IP2SOC/OExp02-IP2SOC.srcs/sources_1/ip/SSeg7_Dev_0/sim/SSeg7_Dev_0.v" \


vlog -work xil_defaultlib \
"glbl.v"

