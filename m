Received: from mail-m127220.xmail.ntesmail.com (mail-m127220.xmail.ntesmail.com [115.236.127.220])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B69663A0
	for <linux-cxl@vger.kernel.org>; Wed, 10 Jan 2024 03:24:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=easystack.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=easystack.cn
Received: from [192.168.122.189] (unknown [218.94.118.90])
	by smtp.qiye.163.com (Hmail) with ESMTPA id 3519386017A;
	Wed, 10 Jan 2024 10:07:40 +0800 (CST)
From: Dongsheng Yang <dongsheng.yang@easystack.cn>
Subject: Re: [RFC PATCH 0/4] cxl: introduce CXL Virtualization module
To: Ira Weiny <ira.weiny@intel.com>, dave@stgolabs.net,
 jonathan.cameron@huawei.com, ave.jiang@intel.com,
 alison.schofield@intel.com, vishal.l.verma@intel.com,
 dan.j.williams@intel.com
Cc: linux-cxl@vger.kernel.org
References: <20231228060510.1178981-1-dongsheng.yang@easystack.cn>
 <659597dc1fb49_16f746294a1@iweiny-mobl.notmuch>
Message-ID: <2d66586f-b254-bc85-2358-9f752268cf11@easystack.cn>
Date: Wed, 10 Jan 2024 10:07:38 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <659597dc1fb49_16f746294a1@iweiny-mobl.notmuch>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFJQjdXWS1ZQUlXWQ8JGhUIEh9ZQVkZGU8eVhhKTEgfSR9OHU5DGlUZERMWGhIXJBQOD1
	lXWRgSC1lBWUlKQ1VCT1VKSkNVQktZV1kWGg8SFR0UWUFZT0tIVUpNT0lMTlVKS0tVSkJLS1kG
X-HM-Tid: 0a8cf1201499023ckunm3519386017a
X-HM-MType: 1
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6K0k6Mww6Ejc6ExZCMhQ6PBFM
	HSMwCk5VSlVKTEtPQ05JT01KSUpOVTMWGhIXVR8UFRwIEx4VHFUCGhUcOx4aCAIIDxoYEFUYFUVZ
	V1kSC1lBWUlKQ1VCT1VKSkNVQktZV1kIAVlBSklIQk83Bg++



在 2024/1/4 星期四 上午 1:22, Ira Weiny 写道:
> Dongsheng Yang wrote:
>> Hi all:
>> 	This patchset introduce cxlv module to allow user to
>> create virtual cxl device. it's based linux6.7-rc5, you can
>> get the code from https://github.com/DataTravelGuide/linux
>>
>> 	As the real CXL device is not widely available now, we need
>> some virtual cxl device to do uplayer software developing or
>> testing. Qemu is good for functional testing, but not good
>> for some performance testing.
> 
> Do you have more details on what performance is missing from Qemu and why
> this solution is better than a solution to fix Qemu?
> 
> Long term it seems better to fix Qemu for this type of work.
> 
> Are their other advantages to having this additional test infrastructure
> in the kernel?  We already have cxl_test.

Hi Ira,
	Let me explain more about what I mean by "qemu is not good for some 
performance testing". cxlv is not designed to test cxl driver itself, it 
is used to do performance testing for upper level layer software. I can 
give an example about the performance data:

(1) fio to test /dev/dax0.0 in qemu
qemu with memory-backend-ram, and create region and namespace with mod 
of devdax. and then run fio with ioengine dev-dax, fio file as below[1].

fio in qemu result detail in [2], the average iops is: avg=1919.26.

(2) fio to test /dev/dax0.0 in native host with cxlv
use cxlv to create cxl device and create region and namespace with mod 
of devdax. then run fio with the same fio file in [1].

fio in host result detail in [3], the average iops is: avg=1510391.68.


Now you can see the resule iops is about 1500K vs 1.9K.

I can explain more about why this matters, I am doing another project in 
block device layer, named cbd(cxl block device). It uses cxl memdev as a 
cache and a backing with other block device. it works similar with 
bcache, but is newly designed for cxl memory device which is byte 
addressable and latency very small. So I need a fast cxl device to 
verify my design in uppper layer is working well, E,g, indexing. qemu is 
too slow to this kind of performance testing. I dont think we can "fix" 
it, that's not what qemu need to do.

So when I say qemu is not good for performance testing, it's not saying 
I want some performance improvement of cxl implement in qemu, but I want 
to say the whole qemu-way is not suitable for latency sensitive testing.

Thanx




[1]:
[global]
bs=1K
ioengine=dev-dax
norandommap
time_based
runtime=10
group_reporting
disable_lat=1
disable_slat=1
disable_clat=1
clat_percentiles=0
cpus_allowed_policy=split

# For the dev-dax engine:
#
#   IOs always complete immediately
#   IOs are always direct
#
iodepth=1
direct=0
thread
numjobs=1
#
# The dev-dax engine does IO to DAX device that are special character
# devices exported by the kernel (e.g. /dev/dax0.0). The device is
# opened normally and then the region is accessible via mmap. We do
# not use the O_DIRECT flag because the device is naturally direct
# access. The O_DIRECT flags will result in failure. The engine
# access the underlying NVDIMM directly once the mmapping is setup.
#
# Check the alignment requirement of your DAX device. Currently the default
# should be 2M. Blocksize (bs) should meet alignment requirement.
#
# An example of creating a dev dax device node from pmem:
# ndctl create-namespace --reconfig=namespace0.0 --mode=dax --force
#
filename=/dev/dax0.0

[dev-dax-write]
rw=randwrite
stonewall

[2]:
# fio ./dax.fio
dev-dax-write: (g=0): rw=randwrite, bs=(R) 1024B-1024B, (W) 1024B-1024B, 
(T) 1024B-1024B, ioengine=dev-dax, iodepth=1
fio-3.36
Starting 1 thread
Jobs: 1 (f=1): [w(1)][100.0%][w=1929KiB/s][w=1929 IOPS][eta 00m:00s] 

dev-dax-write: (groupid=0, jobs=1): err= 0: pid=1198: Tue Jan  9 
10:17:21 2024
   write: IOPS=1917, BW=1918KiB/s (1964kB/s)(18.7MiB/10001msec); 0 zone 
resets
    bw (  KiB/s): min= 1700, max= 1944, per=100.00%, avg=1919.26, 
stdev=54.14, samples=19
    iops        : min= 1700, max= 1944, avg=1919.26, stdev=54.14, 
samples=19
   cpu          : usr=99.97%, sys=0.00%, ctx=12, majf=0, minf=126 

   IO depths    : 1=100.0%, 2=0.0%, 4=0.0%, 8=0.0%, 16=0.0%, 32=0.0%, 
 >=64=0.0%
      submit    : 0=0.0%, 4=100.0%, 8=0.0%, 16=0.0%, 32=0.0%, 64=0.0%, 
 >=64=0.0%
      complete  : 0=0.0%, 4=100.0%, 8=0.0%, 16=0.0%, 32=0.0%, 64=0.0%, 
 >=64=0.0%
      issued rwts: total=0,19181,0,0 short=0,0,0,0 dropped=0,0,0,0 

      latency   : target=0, window=0, percentile=100.00%, depth=1 


Run status group 0 (all jobs):
   WRITE: bw=1918KiB/s (1964kB/s), 1918KiB/s-1918KiB/s 
(1964kB/s-1964kB/s), io=18.7MiB (19.6MB), run=10001-10001msec

[3]:
# fio ./dax.fio 

dev-dax-write: (g=0): rw=randwrite, bs=(R) 1024B-1024B, (W) 1024B-1024B, 
(T) 1024B-1024B, ioengine=dev-dax, iodepth=1
fio-3.36 

Starting 1 thread
Jobs: 1 (f=1): [w(1)][100.0%][w=1480MiB/s][w=1515k IOPS][eta 00m:00s] 

dev-dax-write: (groupid=0, jobs=1): err= 0: pid=41999: Tue Jan  9 
18:11:18 2024
   write: IOPS=1510k, BW=1474MiB/s (1546MB/s)(14.4GiB/10000msec); 0 zone 
resets
    bw (  MiB/s): min= 1418, max= 1480, per=100.00%, avg=1474.99, 
stdev=13.83, samples=19
    iops        : min=1452406, max=1515908, avg=1510391.68, 
stdev=14156.58, samples=19 
 
                                                     cpu          : 
usr=99.82%, sys=0.00%, ctx=22, majf=0, minf=899 
 
 
                        IO depths    : 1=100.0%, 2=0.0%, 4=0.0%, 8=0.0%, 
16=0.0%, 32=0.0%, >=64=0.0% 
 
                                                                submit 
   : 0=0.0%, 4=100.0%, 8=0.0%, 16=0.0%, 32=0.0%, 64=0.0%, >=64=0.0% 

      complete  : 0=0.0%, 4=100.0%, 8=0.0%, 16=0.0%, 32=0.0%, 64=0.0%, 
 >=64=0.0%
      issued rwts: total=0,15096228,0,0 short=0,0,0,0 dropped=0,0,0,0 
 
 

      latency   : target=0, window=0, percentile=100.00%, depth=1 

 

Run status group 0 (all jobs): 

   WRITE: bw=1474MiB/s (1546MB/s), 1474MiB/s-1474MiB/s 
(1546MB/s-1546MB/s), io=14.4GiB (15.5GB), run=10000-10000msec
> 
> Ira
> 
>>
>> 	The new CXLV module allow user to use the reserved RAM[1], to
>> create virtual cxl device. When the cxlv module load, it will
>> create a directory named as "cxl_virt" under /sys/devices/virtual:
>>
>> 	"/sys/devices/virtual/cxl_virt/"
>>
>> that's the top level device for all cxlv devices.
>> At the same time, cxlv module will create a debugfs directory:
>>
>> /sys/kernel/debug/cxl/cxlv
>> ├── create
>> └── remove
>>
>> the create and remove debugfs file is the cxlv entry to create or remove
>> a cxlv device.
>>
>> 	Each cxlv device have its owned virtual pci related bridge and bus, cxlv
>> will create a new root_port for the new cxlv device, setup cxl ports for
>> dport and nvdimm-bridge. After that, we will add the virtual pci device,
>> that will go into the cxl_pci_probe to setup new memdev.
>>
>> 	Then we can see the cxl device with cxl list and use it as a real cxl
>> device.
>>
>>   $ echo "memstart=$((8*1024*1024*1024)),cxltype=3,pmem=1,memsize=$((2*1024*1024*1024))" > /sys/kernel/debug/cxl/cxlv/create
>>   $ cxl list
>> [
>>    {
>>      "memdev":"mem0",
>>      "pmem_size":1879048192,
>>      "serial":0,
>>      "numa_node":0,
>>      "host":"0010:01:00.0"
>>    }
>> ]
>>   $ cxl create-region -m mem0 -d decoder0.0 -t pmem
>> {
>>    "region":"region0",
>>    "resource":"0x210000000",
>>    "size":"1792.00 MiB (1879.05 MB)",
>>    "type":"pmem",
>>    "interleave_ways":1,
>>    "interleave_granularity":256,
>>    "decode_state":"commit",
>>    "mappings":[
>>      {
>>        "position":0,
>>        "memdev":"mem0",
>>        "decoder":"decoder2.0"
>>      }
>>    ]
>> }
>> cxl region: cmd_create_region: created 1 region
>>
>>   $ ndctl create-namespace -r region0 -m fsdax --map dev -t pmem -b 0
>> {
>>    "dev":"namespace0.0",
>>    "mode":"fsdax",
>>    "map":"dev",
>>    "size":"1762.00 MiB (1847.59 MB)",
>>    "uuid":"686fd289-a252-42cf-a3a5-95a39ed5c9d5",
>>    "sector_size":512,
>>    "align":2097152,
>>    "blockdev":"pmem0"
>> }
>>
>>   $ mkfs.xfs -f /dev/pmem0
>> meta-data=/dev/pmem0             isize=512    agcount=4, agsize=112768
>> blks
>>           =                       sectsz=4096  attr=2, projid32bit=1
>>           =                       crc=1        finobt=1, sparse=1,
>> rmapbt=0
>>           =                       reflink=1    bigtime=0 inobtcount=0
>> data     =                       bsize=4096   blocks=451072, imaxpct=25
>>           =                       sunit=0      swidth=0 blks
>> naming   =version 2              bsize=4096   ascii-ci=0, ftype=1
>> log      =internal log           bsize=4096   blocks=2560, version=2
>>           =                       sectsz=4096  sunit=1 blks, lazy-count=1
>> realtime =none                   extsz=4096   blocks=0, rtextents=0
>>
>> Any comment is welcome!
>>
>> TODO: implement cxlv command in ndctl to do cxlv device management.
>>
>> [1]: Add argument in kernel command line: "memmap=nn[KMG]$ss[KMG]",
>> detail in Documentation/driver-api/cxl/memory-devices.rst
>>
>> Thanx
>>
>> Dongsheng Yang (4):
>>    cxl: move some function from acpi module to core module
>>    cxl/port: allow dport host to be driver-less device
>>    cxl/port: introduce cxl_disable_port() function
>>    cxl: introduce CXL Virtualization module
>>
>>   MAINTAINERS                         |   6 +
>>   drivers/cxl/Kconfig                 |  11 +
>>   drivers/cxl/Makefile                |   1 +
>>   drivers/cxl/acpi.c                  | 143 +-----
>>   drivers/cxl/core/port.c             | 231 ++++++++-
>>   drivers/cxl/cxl.h                   |   6 +
>>   drivers/cxl/cxl_virt/Makefile       |   5 +
>>   drivers/cxl/cxl_virt/cxlv.h         |  87 ++++
>>   drivers/cxl/cxl_virt/cxlv_debugfs.c | 260 ++++++++++
>>   drivers/cxl/cxl_virt/cxlv_device.c  | 311 ++++++++++++
>>   drivers/cxl/cxl_virt/cxlv_main.c    |  67 +++
>>   drivers/cxl/cxl_virt/cxlv_pci.c     | 710 ++++++++++++++++++++++++++++
>>   drivers/cxl/cxl_virt/cxlv_pci.h     | 549 +++++++++++++++++++++
>>   drivers/cxl/cxl_virt/cxlv_port.c    | 149 ++++++
>>   14 files changed, 2388 insertions(+), 148 deletions(-)
>>   create mode 100644 drivers/cxl/cxl_virt/Makefile
>>   create mode 100644 drivers/cxl/cxl_virt/cxlv.h
>>   create mode 100644 drivers/cxl/cxl_virt/cxlv_debugfs.c
>>   create mode 100644 drivers/cxl/cxl_virt/cxlv_device.c
>>   create mode 100644 drivers/cxl/cxl_virt/cxlv_main.c
>>   create mode 100644 drivers/cxl/cxl_virt/cxlv_pci.c
>>   create mode 100644 drivers/cxl/cxl_virt/cxlv_pci.h
>>   create mode 100644 drivers/cxl/cxl_virt/cxlv_port.c
>>
>> -- 
>> 2.34.1
>>
> 
> 
