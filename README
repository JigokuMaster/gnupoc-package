This repo aims to show how to build and use gnupoc-package on modern Linux (debian-based distributions).

# Requirements

1. GCC is required (GCC 10 was tested) clang or other compiler probably won't work.

2. 32-bit libraries, you need them to run the pre-built tools (GCCE3, p7zip, unshield) used for extracting SDK packages, of course assuming your machine is 64bit.

```bash
sudo dpkg --add-architecture i386
sudo apt update
sudo apt install ia32-libs
sudo apt install libc6:i386
sudo apt install libstdc++6:i386
sudo apt install zlib1g:i386
```

3. wget used for downloading openssl.

4. an older version of perl5 is required by abd build-system (5.10.1 works fine) i tested an easy way to install it via perlbrew.

```bash
sudo apt install perlbrew
```

```bash
perlbrew init
```
Please read the Instructions... you will be asked to add "source ~/perl5/perlbrew/etc/bashrc" to ~/.profile
after doing so, type bash, then do:

```bash
perlbrew install 5.10.1 --force
```

# EKA2 Build Tools Installation

First clone the repo or download it manually to your home directory.

```bash
git clone https://github.com/JigokuMaster/gnupoc-package.git
```
Note: you can skip building the tools and use the static binaries including GCCE3 , see the release page. 

if you want to build then just like the original [guide](tools/README), download [gcce-3.4](https://www.martin.st/symbian/gnu-csl-arm-2005Q1C-arm-none-symbianelf-i686-pc-linux-gnu.tar.bz2) to your home directory

```bash
cd ~
mkdir csl-gcc
cd csl-gcc
tar -jxvf ../gnu-csl-arm-2005Q1C-arm-none-symbianelf-i686-pc-linux-gnu.tar.bz2
```
now build & install:

```bash
cd ~/gnupoc-package/tools
./install_eka2_tools ~/csl-gcc
```
to build static binaries run:

```bash
./install_eka2_statictools ~/csl-gcc
```

# SDKs Installation

again, just like the original [guide](sdks/README) ... example installing S60v3 FP 2 SDK:

```bash
cd ~/gnupoc-package/sdks
./install_gnupoc_s60_32 S60_SDK_3.2_v1.1.1_en.zip ~/symbian-sdks/s60_32 
./install_wrapper ~/gnupoc
```
# Usage

1. find the path of your perl5.10.1 installation and edit PERL5_PATH in ~/gnupoc/gnupoc-common.sh

example:

```bash
#!/bin/sh
EKA1TOOLS=~/symbian-gcc/bin
EKA2TOOLS=~/csl-gcc/bin
PERL5_PATH=~/perl5/perlbrew/perls/perl-5.10.1
```

2. if you have the static binaries extracted in ~/csl-gcc do:
```bash
ln -sf $(which true) ~/csl-gcc/bin/rem
```

3. using S60v3 FP2 SDK ... add this to your .bashrc

```bash
export PATH=~/gnupoc:${PATH}
export EPOCROOT=~/symbian-sdks/s60_32/
```

```bash
source ~/.bashrc
cd ~/symbian-sdks/s60_32/s60cppexamples/helloworldbasic/group
bldmake bldfiles
abld build -v gcce urel
cd ../sis
makesis helloworldbasic_gcce.pkg
```
# Qt Development

I will add the guide later.

