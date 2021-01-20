新建riscv文件夹，把pulp-sdk、riscv-toolchain、pulp-rt-examples都clone这个文件夹下

1：需要安装的依赖和软件：

	版本为5的gcc（需要将gcc默认版本更改为5：https://askubuntu.com/questions/26498/how-to-choose-the-default-gcc-and-g-version）
	
	以下安装过程，若出现错误，可先忽略。把能安装的安装完后，再安装之前出错的。
	sudo apt-get install tcl
	sudo apt install git python3-pip gawk texinfo libgmp-dev libmpfr-dev libmpc-dev
	sudo pip3 install pyelftools
	sudo apt-get install autoconf automake autotools-dev curl libmpc-dev libmpfr-dev libgmp-dev gawk build-essential bison flex texinfo gperf libtool patchutils bc zlib1g-dev
	sudo apt install git python3-pip gawk texinfo libgmp-dev libmpfr-dev libmpc-dev swig3.0 libjpeg-dev lsb-core doxygen python-sphinx sox graphicsmagick-libmagick-dev-compat libsdl2-dev libswitch-perl libftdi1-dev cmake scons libsndfile1-dev
	sudo pip3 install twisted prettytable pyelftools openpyxl xlsxwriter pyyaml numpy configparser pyvcd
	sudo pip2 install configparser，如果提示没有pip，执行：sudo apt-get install python-pip

2：环境变量设置

	export PATH=/opt/riscv/bin:$PATH
	export VSIM_PATH=pulp的安装路径/sim
	export PULP_RISCV_GCC_TOOLCHAIN=toolchain所在路径


3：建立工具链RISC-V GNU Compiler Toolchain

	在riscv-toolchain文件夹下操作
	git clone --recursive https://github.com/pulp-platform/pulp-riscv-gnu-toolchain
	./configure --prefix=riscv-toolchain所在路径 --with-arch=rv32imc --with-cmodel=medlow --enable-multilib
	sudo make

4：PULP-SDK

	在riscv文件夹下操作
	git clone https://github.com/pulp-platform/pulp-sdk.git -b v1     （新版本已经更新，选择v1分支）
	
	进入pulp-sdk文件夹
	make pulp-tools
	然后打开pulp-tools/bin文件夹下的plpflags.py
	在644行  flags.add_arch_lib('rtio')  下添加  flags.add_arch_lib('m')
	添加的  flags.add_arch_lib('m')  必须与655行的  flags.add_lib('gcc')  左对齐
	
	回到pulp-sdk文件夹下
	注释掉Makefile中的：
	pulp-tools:
		git submodule update --init
	再执行
	source configs/pulp.sh
	make all
	若make all出现no module named “xxxx”的错误，可以尝试执行pip3 install xxxx


遇到的错误：
	若出现	FATAL ERROR: the command 'build' has failed
	          	cannot find lgcc

	尝试安装下列以来或者重新编译工具链再make all
	sudo apt remove libc6-dev-i386 --purge
	sudo apt install libc6-dev-i386
	
	gcc的支持库libgcc.a或对应的lib没有安装或symbolic link不正确
	
	/usr/lib/gcc/x86_64-linux-gnu/5/libgcc.a(静态连接libgcc库)
	
	错误：No CMAKE_CXX_COMPILER could be found(installed)
	sudo apt-get update
	sudo apt-get install -y build-essential
	
	错误：src/trace/lxt2_write.h:40:10: fatal error: zlib.h: No such file or directory

 	#include <zlib.h>
          	^~~~~~~~
	缺少zlib的头文件，需安装zlib:(installed)
	wget http://prdownloads.sourceforge.net/libpng/zlib-1.2.11.tar.gz
	tar -zxf zlib-1.2.11.tar.gz
	sudo ./configure
	sudo make && make install

	错误：ModuleNotFoundError: No module named 'xxx'
	pip install xxx
	
	错误：from sphinx import main
	ImportError: cannot import name 'main'
	使用pip3安装sphinx，不要使用pip安装
	
	sudo pip3 install sphinx
	错误：Import Error:cannot import name main
	https://blog.csdn.net/zong596568821xp/article/details/80410416

以上所有环境安装完成之后，开始安装questasim

questasim：
备注：踩过的坑
1、执行某些命令，如果出现无法找到该文件或者目录，很有可能是文件损坏了，需要重新安装，或者拷贝
2、不要热插拔U盘，里面的文件会损坏，你可能察觉不到，必须弹出U盘，不管是在windows还是linux下
3、实在安装不成功可以加我qq:361647892交流
4、questasim10.7c linux 64 版本链接: https://pan.baidu.com/s/1ZR6awUwJnnh-2V2m53SNtQ 提取码: ccsc

我使用的系统是ubuntu20.4，安装的questasim10.7c的linux版本,请按照下面的步骤来
1:目录设置，以及文件建立，文件在最后在使用lmgrd时会用到
	sudo mkdir /usr/tmp
	sudo touch /usr/tmp/.flexlm
2:修改权限，然后安装，里面有一步选择：全平台安装，其他就没啥了，都是下一步
	sudo chmod 755 install.linux64
3：license文件产生（这里产生的license文件名为mentor.dat，如果修改了名字，下面要相应修改）
	第1、2步在windows环境下进行操作
	（1）修改license.src文件
     		 - 第一行：修改成自己主机名和mac地址 //用hostname查主机名，用ifconfig查mac地址
    		 - 第二行：mgcld <安装目录>/questasim/linux_x86_64
	（2）运行 run_me.bat 文件
	（3）将生成的mentor.dat文件拷贝到linux 的home目录，或者其他你准备放license的目录
	（4）执行dos2unix ./mentor.dat  //目的是修改文件格式
4：环境变量设置,在bashrc文件里设置（ubuntu ：vim ~/.bashrc）
	export LM_LICENSE_FILE=/home/soft/mentor.dat  //设置license的环境变量，也可以把文件名修改为license.dat
	export PATH=$PATH:<安装目录>/linux_x86_64
	设置完后，source ~/.bashrc，再输入env查看设置成功没有
5:crack文件执行
	（1）将sfk文件拷贝到<安装目录>/linux_x86_64/mgls/lib下
	（2）将libstdc++.so.5文件拷贝到/usr/lib下  //有的可能不需要拷贝也能成功
	（3）修改权限 sudo chmod 755 sfk
	  (4) 执行：sudo ./sfk rep -yes -pat -bin /5589E557565381ECD00000008B5508/31C0C357565381ECD00000008B5508/ -bin /5589E557565381ECD8000000E8000000005B81C3/33C0C357565381ECD8000000E8000000005B81C3/ -bin /41574989FF415641554154554889CD534489C3/33C0C389FF415641554154554889CD534489C3/ -dir .
6：在<安装目录>/linux_x86_64下执行：lmgrd -c mentor的路径/mentor.dat //开启license的关键步骤
7：执行vsim,如果能弹出界面，说明你成功了




运行hello world

	先进入pulp文件夹
	
		source setup/vsim.sh
		cd sim
		make clean lib build opt
	
	然后进入pulp-sdk文件夹
	
		source configs/pulp.sh
		source configs/platform-rtl.sh
		source pkg/sdk/dev/sourceme.sh
	
	然后进入pulp-rt-examples/hello
		make clean all run




pulpissimo部分，安装pulp可忽略此部分

	在pulpissimo目录下的ips_list.yml中添加以下内容，再执行update-ips
	hwpe-ctrl:

  	commit: ec068eb
	hwpe-stream:
  	commit: 1a9b04f
	hwpe-mac-engine:
  	commit: v1.3
  	domain: [cluster, soc]
	执行update-ips时，要使用http，不能使用ssh，否则，后面的make build会出错，且./update-ips只能执行一次，否则也可能会出错
