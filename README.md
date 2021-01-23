Author : Scriabing   
conntect: 1403154226@qq.com
description: simulation src 


## 1.Summary Description:
PDLA stable src  
DLA mac:64  
L2 64M  

## 2.pulp modify
Hardware UPDATE: add "199.232.96.133 raw.githubusercontent.com" to /etc/hosts
### 2.1 memory expansion
L2 memory model in soc_interconnect.sv

### 2.2 add DLA
soc open an AXI master port for dla's data channel and an apb slaver port for dla csb control


### 2.3 interrupt
TODO


## 3.sdk modify
V1 VERSION  for simulation  
If need,source configs/platform-fpga.sh for fpga version ,and init "__rt_fpga_fc_frequency&__rt_fpga_periph_frequency" in user c code.
### 3.1 support for memory expansion
According to the modifing pulp ，modify the following documents：  
pulp-sdk/pulp-configs/configs/chips/pulp/pulp.json 193  
pulp-sdk/runtime/archi/include/archi/chips/pulp/memory_map.h 34  
runtime/pulp-rt/rules/pulp/link.ld 6  

### 3.2 new ld flags
put .cluster.text into .text section  
add customsized section at the last of link.ld(if modifiy the runtime's ld , need to recompile the sdk env,otherwize using  pkd/dev/..../link.ld without remaking sdk)


## 4.test modify
### 4.1 Makefile
open O0 to prevent gcc from killing customized section

### 4.2 fc c code
add " __atttibute__(section("xxxx")) " for code and data(array&struct)
